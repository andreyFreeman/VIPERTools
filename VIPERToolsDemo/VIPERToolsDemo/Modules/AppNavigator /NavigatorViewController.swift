//
//  NavigatorViewController.swift
//  VIPERToolsDemo
//
//  Created ANDREY KLADOV on 09/06/2017.
//  Copyright © 2017 Budgeteer. All rights reserved.
//
//

import UIKit

final class NavigatorViewController: UINavigationController, NavigatorViewProtocol {

	var presenter: NavigatorViewPresenter!

	override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
}

extension NavigatorViewController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        
    }
}
