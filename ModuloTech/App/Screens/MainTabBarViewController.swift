//
//  MainTabBarViewController.swift
//  ModuloTech
//
//  Created by Ahmed K. on 30/10/2020.
//

import UIKit

final class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.generateTabs()
    }

    private func generateTabs() {

        let devicesVC = DevicesListViewController()
        devicesVC.tabBarItem = self.generateTabItem("devices".localized, imageName: "home")

        let profileVC = ProfileViewController(nibName: "ProfileViewController", bundle: nil)
        profileVC.tabBarItem = self.generateTabItem("profile".localized, imageName: "profile")

        self.viewControllers = [devicesVC, profileVC]


    }

    private func generateTabItem(_ name: String, imageName: String) -> UITabBarItem {
        let tabBarItem = UITabBarItem(title: name, image: UIImage(named: imageName), tag: 0)
        tabBarItem.imageInsets.top = 2
        tabBarItem.imageInsets.bottom = 2
        return tabBarItem
    }
}
