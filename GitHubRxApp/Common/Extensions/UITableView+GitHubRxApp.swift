//
//  UITableView+GitHubRxApp.swift
//  GitHubRxApp
//
//  Created by Gabrijel Bartosek on 17.07.2023..
//

import UIKit

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(_ type: T.Type, for indexPath: IndexPath) -> T {
        let identifier = String(describing: type.self)
        guard let cell = self.dequeueReusableCell(withIdentifier: String(describing: type.self), for: indexPath) as? T else {
            fatalError("Unable to dequeue cell with identifier: \(identifier)")
        }
        return cell
    }

    func registerUINib<T>(ofType type: T.Type) {
        let identifier = String(describing: type.self)
        self.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }

    func registerCell<T: UITableViewCell>(ofType type: T.Type) {
        let identifier = String(describing: type.self)
        self.register(T.self, forCellReuseIdentifier: identifier)
    }

    func registerHeaderFooterNib<T>(ofType type: T.Type) {
        let identifier = String(describing: type.self)
        self.register(UINib(nibName: identifier, bundle: nil), forHeaderFooterViewReuseIdentifier: identifier)
    }

    func registerHeaderFooter<T: UIView>(ofType type: T.Type) {
        let identifier = String(describing: type.self)
        self.register(T.self, forHeaderFooterViewReuseIdentifier: identifier)
    }

    func dequeueHeaderFooter<T>(_ type: T.Type) -> T {
        let identifier = String(describing: type.self)
        guard let view = self.dequeueReusableHeaderFooterView(withIdentifier: identifier) as? T else {
            fatalError("Unable to dequeue header/footer view with identifier: \(identifier)")
        }
        return view
    }
}
