//
//  Application.swift
//  MovComXIB
//
//  Created by Ivan on 22/04/20.
//  Copyright © 2020 ivan. All rights reserved.
//

import UIKit

extension UIApplication{
    class func topViewController(viewController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController?{
        if let nav = viewController as? UINavigationController{
            return topViewController(viewController: nav.visibleViewController)
        }
        if let presented = viewController?.presentedViewController{
            return topViewController(viewController: presented)
        }
        return viewController
    }
}
