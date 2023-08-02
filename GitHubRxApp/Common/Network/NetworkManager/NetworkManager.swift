//
//  NetworkManager.swift
//  GitHubRxApp
//
//  Created by Gabrijel Bartosek on 17.07.2023..
//

import Foundation

class NetworkManager {
    
    static let callbackURLScheme = "com.beer.GitHubRxApp"
    static let clientID = "Iv1.03eda0e0b6c3100b"
    static let clientSecret = "370d1b2a85339484e0bb76c26a214ffbac09a388"
    
    // MARK: Static Methods
    static func signOut() {
        Self.accessToken = ""
        Self.refreshToken = ""
        Self.username = ""
    }
    
    typealias Failure = (ErrorReport) -> Void

    private(set) var configuration: NetworkConfiguration

    init(configuration: NetworkConfiguration = NetworkConfiguration()) {
        self.configuration = configuration
    }
    
    // typealias NetworkResult<T: Codable> = (response: HTTPURLResponse, object: T)

    func apiCall<T: Codable>(for resource: Resource<T>, basePath: URL, completion: @escaping (Result<T, ErrorReport>) -> ()) {
        guard let endpoint = createEndpoint(for: resource, basePath: basePath) else { return }
        print("Endpoint: \(endpoint)")
        var request = createURLRequest(from: resource, endpoint)
        
        if let accessToken = NetworkManager.accessToken {
            request.setValue("token \(accessToken)", forHTTPHeaderField: "Authorization")
        }

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
                
                print("Response result: \(responseResult)")

                DispatchQueue.main.async {
                    switch responseResult {
                    case .failure(let cause):
                        completion(.failure(cause))
                    case .success(let decodedObject):
                        completion(.success(decodedObject))
                    }
                }
            }
            
            guard let data = data else {
                print("Neki error se desio!")
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
                    NetworkManager.accessToken = dictionary["access_token"]
                    NetworkManager.refreshToken = dictionary["refresh_token"]
                    // swiftlint:disable:next force_cast
                    completion(.success((response, "Success") as! T))
                }
                return
            } else if let object = try? JSONDecoder().decode(T.self, from: data) {
                DispatchQueue.main.async {
                    if let user = object as? User {
                        NetworkManager.username = user.login
                    }
                    completion(.success((response, object) as! T))
                }
                return
            } else {
                DispatchQueue.main.async {
                    completion(.failure(ErrorReport(cause: .other, data: data)))
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

extension NetworkManager {
    
    // MARK: Private Constants
    private static let accessTokenKey = "accessToken"
    private static let refreshTokenKey = "refreshToken"
    private static let usernameKey = "username"
    
    // MARK: Properties
    static var accessToken: String? {
        get {
            UserDefaults.standard.string(forKey: accessTokenKey)
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: accessTokenKey)
        }
    }
    
    static var refreshToken: String? {
        get {
            UserDefaults.standard.string(forKey: refreshTokenKey)
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: refreshTokenKey)
        }
    }
    
    static var username: String? {
        get {
            UserDefaults.standard.string(forKey: usernameKey)
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: usernameKey)
        }
    }
    
    static func printTokens() {
        print("accessToken: \(accessToken ?? "")")
        print("refreshToken: \(refreshToken ?? "")")
        print("username: \(username ?? "")")
    }
}
