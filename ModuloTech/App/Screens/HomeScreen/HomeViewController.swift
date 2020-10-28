//
//  HomeViewController.swift
//  ModuloTech
//
//  Created by Ahmed K. on 11/10/2020.
//

import UIKit

final class HomeViewController: MainViewController {

    var viewModel = HomeViewModel()


    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewModel.getData()

    }

    override func setupStyle() {
        super.setupStyle()

        self.tabBarItem = UITabBarItem(title: "Devices", image: UIImage(named: "home"), tag: 0)
        self.tabBarItem.imageInsets.top = 2
        self.tabBarItem.imageInsets.bottom = 2

    }
}
