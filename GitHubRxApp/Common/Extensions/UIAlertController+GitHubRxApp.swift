//
//  UIAlertController+GitHubRxApp.swift
//  GitHubRxApp
//
//  Created by Gabrijel Bartosek on 17.07.2023..
//

import UIKit

public typealias Handler = () -> Void

extension UIAlertController {
    convenience init(alertModel: AlertModel, buttonTitle: String? = nil, handler: Handler? = nil) {
        self.init(title: alertModel.title, message: alertModel.message, preferredStyle: .alert)
        self.addAction(
            UIAlertAction(title: buttonTitle ?? "OK", style: .default) { _ in
                handler?()
            }
        )
    }

    static func notifyUser(message: String, viewcontroller: UIViewController) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: UIAlertController.Style.alert)
        viewcontroller.present(alert, animated: true) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                viewcontroller.dismiss(animated: true, completion: nil)
            }
        }
    }
}
