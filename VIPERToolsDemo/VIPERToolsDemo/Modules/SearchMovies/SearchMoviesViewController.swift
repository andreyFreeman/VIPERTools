//
//  SearchMoviesViewController.swift
//  VIPERToolsDemo
//
//  Created ANDREY KLADOV on 10/06/2017.
//  Copyright © 2017 Budgeteer. All rights reserved.
//
//

import UIKit

final class SearchMoviesViewController: UIViewController, SearchMoviesViewProtocol {

	var presenter: SearchMoviesViewPresenter!

	override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewLoaded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
}
