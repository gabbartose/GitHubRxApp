//
//  LoginAPI.swift
//  GitHubRxApp
//
//  Created by Gabrijel Bartosek on 27.07.2023..
//

import Foundation

struct LoginManager {
    
    struct Constants {
        static let callbackURLScheme = "com.beer.GitHubRxApp"
        static let clientID = "Iv1.03eda0e0b6c3100b"
        static let clientSecret = "370d1b2a85339484e0bb76c26a214ffbac09a388"
    }
    
    enum RequestError: Error {
        case invalidResponse
        case networkCreationError
        case otherError
        case sessionExpired
    }
    
    private enum Paths: String {
        case codeExchange = "/login/oauth/access_token"
        case getUser = "/user"
        case signIn = "/login/oauth/authorize"
    }
    
    enum RequestType: Equatable {
        case codeExchange(code: String)
        case getUser
        case signIn
        
        func networkRequest() -> LoginManager? {
            guard let url = url() else {
                return nil
            }
            return LoginManager(method: httpMethod(), url: url)
        }
        
        private func httpMethod() -> RequestMethod {
            switch self {
            case .codeExchange:
                return .post
            case .getUser:
                return .get
            case .signIn:
                return .get
            }
        }
        
        private func url() -> URL? {
            switch self {
            case .codeExchange(let code):
                let queryItems = [
                    URLQueryItem(name: "client_id", value: LoginManager.Constants.clientID),
                    URLQueryItem(name: "client_secret", value: LoginManager.Constants.clientSecret),
                    URLQueryItem(name: "code", value: code)
                ]
                return urlComponents(host: "github.com", path: "/login/oauth/access_token", queryItems: queryItems).url
            case .getUser:
                return urlComponents(path: "/user", queryItems: nil).url
            case .signIn:
                let queryItems = [
                    URLQueryItem(name: "client_id", value: LoginManager.Constants.clientID)
                ]
                
                return urlComponents(host: "github.com", path: "/login/oauth/authorize", queryItems: queryItems).url
            }
        }
        
        private func urlComponents(host: String = "api.github.com", path: String, queryItems: [URLQueryItem]?) -> URLComponents {
            switch self {
            default:
                var urlComponents = URLComponents()
                urlComponents.scheme = "https"
                urlComponents.host = host
                urlComponents.path = path
                urlComponents.queryItems = queryItems
                return urlComponents
            }
        }
    }
    
    typealias NetworkResult<T: Decodable> = (response: HTTPURLResponse, object: T)
    
    // MARK: Properties
    var method: RequestMethod
    var url: URL
    
    // MARK: Static Methods
    static func signOut() {
        accessToken = ""
        refreshToken = ""
        username = ""
    }
    
    func start<T: Decodable>(responseType: T.Type, completionHandler: @escaping ((Result<NetworkResult<T>, Error>) -> Void)) {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        if let accessToken = LoginManager.accessToken {
            request.setValue("token \(accessToken)", forHTTPHeaderField: "Authorization")
        }
        let session = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    completionHandler(.failure(RequestError.invalidResponse))
                }
                return
            }
            guard error == nil,
                  let data = data else {
                DispatchQueue.main.async {
                    let error = error ?? RequestError.otherError
                    completionHandler(.failure(error))
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
                    LoginManager.accessToken = dictionary["access_token"]
                    LoginManager.refreshToken = dictionary["refresh_token"]
                    // swiftlint:disable:next force_cast
                    completionHandler(.success((response, "Success" as! T)))
                }
                return
            } else if let object = try? JSONDecoder().decode(T.self, from: data) {
                DispatchQueue.main.async {
                    if let user = object as? User {
                        LoginManager.username = user.login
                        NetworkManager.username = user.login
                    }
                    completionHandler(.success((response, object)))
                }
                return
            } else {
                DispatchQueue.main.async {
                    completionHandler(.failure(RequestError.otherError))
                }
            }
        }
        session.resume()
    }
}
