//
//  UIViewControllerExtension.swift
//  MapView
//
//  Created by Renato on 4/18/21.
//  Copyright © 2021 Stant. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        tap.delegate = self as? UIGestureRecognizerDelegate
        view.addGestureRecognizer(tap)
    }
    
    func remove() {
        guard parent != nil else {
            return
        }
        willMove(toParent: nil)
        removeFromParent()
        view.removeFromSuperview()
    }
    
    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func presentFullScreen(_ viewControllerToPresent: UIViewController,
                           animated flag:             Bool,
                           completion:                (() -> Swift.Void)? = nil) {
        viewControllerToPresent.modalPresentationStyle = .fullScreen
        self.present(viewControllerToPresent,
                     animated:   flag,
                     completion: completion)
    }
}

