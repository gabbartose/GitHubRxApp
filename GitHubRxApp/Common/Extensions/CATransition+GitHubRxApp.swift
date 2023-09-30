//
//  CATransition+GitHubRxApp.swift
//  GitHubRxApp
//
//  Created by Gabrijel Bartosek on 11.08.2023..
//

import UIKit

extension CATransition {
    static func setTransition(transitionType: CATransitionType = .fade) -> CATransition {
        let transition = CATransition()
        transition.duration = 0.7
        transition.type = transitionType
        return transition
    }
}
