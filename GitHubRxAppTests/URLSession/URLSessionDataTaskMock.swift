//
//  URLSessionDataTaskMock.swift
//  GitHubRxAppTests
//
//  Created by Gabrijel Bartosek on 08.08.2023..
//

import Foundation

class URLSessionDataTaskMock: URLSessionDataTask {
    
    private let closure: () -> ()
    
    init(closure: @escaping () -> ()) {
        self.closure = closure
    }
    
    // We override the resume() method and simply call our closure instead of actually resuming any task
    override func resume() {
        closure()
    }
}
