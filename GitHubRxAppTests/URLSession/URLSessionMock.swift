//
//  URLSessionMock.swift
//  GitHubRxAppTests
//
//  Created by Gabrijel Bartosek on 08.08.2023..
//

import Foundation

class URLSessionMock: URLSession {
    
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> ()
    
    // Properties that enable us to set exactly what data or error we want our mocked URLSession to return for any request.
    var data: Data?
    var errorCode: Int?
    
    override func dataTask(with request: URLRequest, completionHandler: @escaping CompletionHandler) -> URLSessionDataTask {
        let data = self.data
        var urlResponse: HTTPURLResponse?
        
        if let url = request.url {
            urlResponse = HTTPURLResponse(url: url, statusCode: errorCode ?? 200, httpVersion: nil, headerFields: nil)
        }
        
        return URLSessionDataTaskMock {
            completionHandler(data, urlResponse, nil)
        }
    }
}
