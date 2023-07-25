//
//  ErrorHandler.swift
//  GitHubRxApp
//
//  Created by Gabrijel Bartosek on 19.07.2023..
//

import UIKit

public typealias ErrorAction = (ErrorReport) -> Void

class ErrorHandler {
    weak var rootViewController: UIViewController?
    
    private var defaultHandlerMap: [Cause: ErrorAction]?
    
    init(rootViewController: UIViewController?) {
        self.rootViewController = rootViewController
    }
    
    /// Handles error as default, which is predefined for every 'Cause'
    func handle(_ errorReport: ErrorReport) {
        handle(errorReport, handlerMap: getDefaultHandlerMap())
    }
    
    /// Handles error with custom map
    func handle(_ errorReport: ErrorReport, handlerMap: [Cause: ErrorAction]) {
        let performAction = handlerMap[errorReport.cause]
        performAction?(errorReport)
    }
    
    func assign(errorAction: @escaping ErrorAction, for causes: [Cause]) -> [Cause: ErrorAction] {
        var map: [Cause: ErrorAction] = [:]
        causes.forEach { map[$0] = errorAction }
        return map
    }
    
    func showAlert(with alertModel: AlertModel, buttonTitle: String? = nil, handler: Handler?) {
        DispatchQueue.main.async {
            let alert = UIAlertController(alertModel: alertModel, buttonTitle: buttonTitle, handler: handler)
            self.rootViewController?.present(alert, animated: true, completion: nil)
        }
    }
    
    func getDefaultHandlerMap() -> [Cause: ErrorAction] {
        guard let defaultHandlerMap = defaultHandlerMap else {
            var map: [Cause: ErrorAction] = [:]
            map.merge(assign(errorAction: { [weak self] in self?.showAlert(with: $0.alertable(), buttonTitle: "OK", handler: nil) },
                             for: [.invalidCredentials,
                                   .other]),
                      uniquingKeysWith: firstErrorAction(_:_:))
            
            self.defaultHandlerMap = map
            return map
        }
        return defaultHandlerMap
    }
    
    private func firstErrorAction(_ errorAction1: @escaping ErrorAction, _ errorAction2: @escaping ErrorAction) -> ErrorAction {
        return errorAction1
    }
}
