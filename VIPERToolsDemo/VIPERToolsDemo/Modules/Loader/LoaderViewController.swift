//
//  LoaderViewController.swift
//  VIPERToolsDemo
//
//  Created ANDREY KLADOV on 09/06/2017.
//  Copyright © 2017 Budgeteer. All rights reserved.
//
//

import UIKit

final class LoaderViewController: UIViewController, LoaderViewProtocol {

	var presenter: LoaderViewPresenter!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

	override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewLoaded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    func showLoading() {
        activityIndicator.startAnimating()
    }
    
    func hideLoading() {
        activityIndicator.stopAnimating()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
