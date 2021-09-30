//
//  AlertController.swift
//  TestApp
//
//  Created by Артем Ропавка on 28.09.2021.
//

import UIKit

class AlertService {
    
    static func showAlert(withTitle title: String, message: String, buttonTitle: String, handler: ((UIAlertAction) -> Void)?) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: buttonTitle, style: .default, handler: handler)
        alertController.addAction(okAction)
        return alertController
    }
}
