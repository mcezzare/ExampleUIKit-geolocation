//
//  Utils.swift
//  ExampleUIKitLocation
//
//  Created by Mario Chiodi on 27/05/24.
//



import UIKit

extension UIViewController  {
    /// Show an confirmation  dialog using the actionSheet Style
    /// - Parameters:
    ///   - viewController: viewController caller
    ///   - title: the title for dialog
    ///   - message: a message, normaly a question
    ///   - actions: array of actions, buttons or options
    ///   - completion: completion description
    func showActionsheet(title: String, message: String, actions: [(String, UIAlertAction.Style)], completion: @escaping (_ index: Int) -> Void) {
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        for (index, (title, style)) in actions.enumerated() {
            let alertAction = UIAlertAction(title: title, style: style) { (_) in
                completion(index)
            }
            alertViewController.addAction(alertAction)
        }
        self.present(alertViewController, animated: true, completion: nil)
    }
    
    
    /// Show an alert dialog
    ///
    /// - Parameters:
    ///   - theTitle: Title from alert message
    ///   - theMessage: text message to appear
    ///   - action: here only OK option
    func showInfoAlert(theTitle: String = "Info", theMessage: String, action: (() -> Void)? = nil) {
        ensureMainThread {
            let alertViewControler = UIAlertController(title: theTitle, message: theMessage, preferredStyle: .alert)
            alertViewControler.addAction(UIAlertAction(title: "OK", style: .default, handler: {(_) in
                action?()
            }))
            self.present(alertViewControler, animated: true, completion: nil)
        }
    }
    
    /// Ensures the closure is executed on main thread.
    /// - Parameter closure: The closure to be executed on main thread.
    internal func ensureMainThread(closure: @escaping () -> Void) {
        if Thread.current.isMainThread {
            closure()
        }
        else {
            DispatchQueue.main.async(execute: closure)
        }
    }
}

