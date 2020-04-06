//
//  UINavigationControllerExtensions.swift
//  WhichFlower
//
//  Created by aisenur on 3.04.2020.
//  Copyright © 2020 aisenur. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationController {
    func navBarCustomization(nav: UINavigationController) {
        nav.navigationBar.barTintColor = #colorLiteral(red: 0.9137254902, green: 0.9117759928, blue: 1, alpha: 1)
        nav.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: K.NavigationBar.titleTextColor]
        
        let backButton = UIBarButtonItem()
        backButton.title = K.NavigationBar.backTitle
        nav.navigationBar.topItem?.backBarButtonItem = backButton
    }

}
