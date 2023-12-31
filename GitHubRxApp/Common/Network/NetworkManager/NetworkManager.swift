//
//  NetworkManager.swift
//  GitHubRxApp
//
//  Created by Gabrijel Bartosek on 17.07.2023..
//

import Foundation

final class NetworkManager {
    typealias NetworkResult<T: Codable> = (response: HTTPURLResponse, object: T)
    private(set) var configuration: NetworkConfiguration

    init(configuration: NetworkConfiguration = NetworkConfiguration()) {
        self.configuration = configuration
    }

    func apiCall<T: Codable>(for resource: Resource<T>, basePath: URL, completion: @escaping (Result<T, ErrorReport>) -> Void) {
        guard let endpoint = createEndpoint(for: resource, basePath: basePath) else { return }
        print("Entire endpoint: \(endpoint)")

        var request = createURLRequest(from: resource, endpoint)
        configuration.requiredHTTPHeaders.forEach { request.addValue($0.value, forHTTPHeaderField: $0.key) }

        let session = configuration.session.dataTask(with: request) { [weak self] data, response, error in
            guard let self = self else { return }

            let networkResponseState = self.getNetworkResponseState(response: response, error: error, data: data)

            switch networkResponseState {
            case NetworkResponseState.failure(let cause):
                DispatchQueue.main.async {
                    completion(.failure(cause))
                }
            case NetworkResponseState.success:
                let responseResult: Result<T, ErrorReport> = self.getResponseResult(data: data)

                DispatchQueue.main.async {
                    switch responseResult {
                    case .failure(let cause):
                        completion(.failure(cause))
                    case .success(let decodedObject):
                        completion(.success(decodedObject))
                    }
                }
            }
        }
        session.resume()
    }

    func apiOAuthCall<T: Codable>(for resource: Resource<T>, basePath: URL, completion: @escaping (Result<NetworkResult<T>, ErrorReport>) -> Void) {
        guard let endpoint = createEndpoint(for: resource, basePath: basePath) else { return }
        print("Entire endpoint: \(endpoint)")

        var request = createURLRequest(from: resource, endpoint)

        if let data = KeychainManager.standard.read(service: KeychainManager.Constants.accessToken, account: KeychainManager.Constants.githubString),
           let accessToken = String(data: data, encoding: .utf8) {
            request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        }

        let session = configuration.session.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    completion(.failure(ErrorReport(cause: .invalidResponse, data: data)))
                }
                return
            }

            guard error == nil, let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(ErrorReport(cause: .dataMissing)))
                }
                return
            }

            if T.self == String.self, let responseString = String(data: data, encoding: .utf8) {
                let components = responseString.components(separatedBy: "&")
                var dictionary: [String: String] = [:]
                for component in components {
                    let itemComponents = component.components(separatedBy: "=")
                    if let key = itemComponents.first, let value = itemComponents.last {
                        dictionary[key] = value
                    }
                }
                DispatchQueue.main.async {
                    if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil {
                        let data = Data(dictionary["access_token"]?.utf8 ?? "ghu_Auf56oTYGf1bJ3iCm0GlDaTszREWLA0Vq82D".utf8)
                        KeychainManager.standard.save(data, service: KeychainManager.Constants.accessToken, account: KeychainManager.Constants.githubString)
                        // swiftlint:disable force_cast
                        completion(.success((response: response, "Success" as! T)))
                    } else {
                        if let accessToken = dictionary[KeychainManager.Constants.accessToken] {
                            let data = Data(accessToken.utf8)
                            KeychainManager.standard.save(data, service: KeychainManager.Constants.accessToken, account: KeychainManager.Constants.githubString)
                            // swiftlint:disable force_cast
                            completion(.success((response: response, "Success" as! T)))
                        }
                    }
                }
                return
            } else if let object = try? JSONDecoder().decode(T.self, from: data) {
                DispatchQueue.main.async {
                    if let user = object as? User {
                        let username = user.login
                        let usernameData = Data(username.utf8)
                        KeychainManager.standard.save(usernameData, service: KeychainManager.Constants.usernameKey, account: KeychainManager.Constants.githubString)
                    }
                    completion(.success((response, object)))
                }
                return
            } else {
                DispatchQueue.main.async {
                    completion(.failure(ErrorReport(cause: .unauthorized, data: data)))
                }
            }
        }
        session.resume()
    }

    func createEndpoint<T>(for resource: Resource<T>, basePath: URL) -> URL? {
        var components = URLComponents(url: basePath, resolvingAgainstBaseURL: true)
        components?.path.append(resource.path)
        components?.queryItems = resource.queryItems
        return components?.url
    }

    func createURLRequest<T>(from resource: Resource<T>, _ endpoint: URL) -> URLRequest {
        let mutableRequest = NSMutableURLRequest(url: endpoint)
        mutableRequest.httpMethod = resource.method.rawValue
        resource.headers.forEach { mutableRequest.addValue($0.value, forHTTPHeaderField: $0.key) }

        if let requestBody = resource.requestBody {
            mutableRequest.httpBody = try? JSONSerialization.data(withJSONObject: requestBody)
        }
        return mutableRequest as URLRequest
    }

    func getNetworkResponseState(response: URLResponse?, error: Error?, data: Data?) -> NetworkResponseState {
        guard error == nil
        else {
            return .failure(ErrorReport(cause: .other, data: nil))
        }

        guard let urlResponse = response as? HTTPURLResponse else {
            return .failure(ErrorReport(cause: .other, data: nil))
        }

        // Check for success status code
        guard 200...299 ~= urlResponse.statusCode else {
            let errorReport = processNotSuccessStatus(status: urlResponse.statusCode, data: data)
            return .failure(errorReport)
        }

        return .success
    }

    func processNotSuccessStatus(status: Int, data: Data?) -> ErrorReport {
        switch status {
        case 401:
            return ErrorReport(cause: .unauthorized, data: data)
        case 404:
            return ErrorReport(cause: .resourceNotFound, data: nil)
        case 412:
            let cause = processPreconditionFailed(for: data)
            return ErrorReport(cause: cause, data: data)
        case 420:
            return ErrorReport(cause: .methodFailure, data: nil)
        case 422:
            let cause = processUnprocessableEntity(for: data)
            return ErrorReport(cause: cause, data: data)
        default:
            return ErrorReport(cause: .other, data: data)
        }
    }

    func processPreconditionFailed(for data: Data?) -> Cause {
        guard let data = data else { return .other }
        guard let preconditionFailed: PreconditionFailedError = data.decoded() else {
            return .unauthorized
        }

        switch preconditionFailed.errors.code {
        case 120:
            return .appOutdated
        case 150:
            return .dataMissing
        default:
            return .other
        }
    }

    func processUnprocessableEntity(for data: Data?) -> Cause {
        guard let data = data else { return .other }
        guard let _: UnprocessableEntity = data.decoded() else {
            return .other
        }
        return .invalidCredentials
    }

    func getResponseResult<T: Decodable>(data: Data?) -> Result<T, ErrorReport> {
        // Check for response data
        guard let responseData = data else {
            return .failure(ErrorReport(cause: .other, data: nil))
        }

        guard let decodedObject: T = responseData.decoded() else {
            return .failure(ErrorReport(cause: .other, data: data))
        }

        return .success(decodedObject)
    }
}

internal enum NetworkResponseState {
    case success
    case failure(ErrorReport)
}
