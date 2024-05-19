//
//  ScreenNavigation.swift
//  Fintech
//
//  Created by Joel Martin Chuco Marrufo on 18/05/24.
//

import Foundation
import SwiftUI

struct ScreenNavigation<Content> where Content : View{
    
    func redirectToScreen(to view: Content, direction: CATransitionSubtype) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else {
            return
        }

        let hostingController = UIHostingController(rootView: view)
        let previousRootViewController = window.rootViewController

        let transition = CATransition()
        transition.type = CATransitionType.push
        transition.subtype = direction
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        window.layer.add(transition, forKey: kCATransition)

        window.rootViewController = hostingController
        previousRootViewController?.dismiss(animated: false, completion: nil)
    }
}
