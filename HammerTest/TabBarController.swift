//
//  TabBarController.swift
//  HammerTest
//
//  Created by Andrei Kovryzhenko on 24.06.2023.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let color = UIColor(red: 253/255, green: 58/255, blue: 105/255, alpha: 1)
        let selectedAttributes = [NSAttributedString.Key.foregroundColor: color]

        
        let mainViewController = ViewController()
        mainViewController.tabBarItem = UITabBarItem(
            title: "Меню",
            image: UIImage(named: "BarItemMenu"),
            selectedImage: UIImage(named: "BarItemMenu")?.withTintColor(color, renderingMode: .alwaysOriginal)
        )
        mainViewController.tabBarItem.setTitleTextAttributes(selectedAttributes, for: .selected)

        let secondViewController = ViewController()
               secondViewController.tabBarItem = UITabBarItem(
                   title: "Контакты",
                   image: UIImage(named: "BarItemMap"),
                   selectedImage: UIImage(named: "BarItemMap")?.withTintColor(color, renderingMode: .alwaysOriginal)
               )
        secondViewController.tabBarItem.setTitleTextAttributes(selectedAttributes, for: .selected)

        let thirdViewController = ViewController()
               thirdViewController.tabBarItem = UITabBarItem(
                   title: "Профиль",
                   image: UIImage(named: "BarItemContacts"),
                   selectedImage: UIImage(named: "BarItemContacts")?.withTintColor(color, renderingMode: .alwaysOriginal)
               )
        thirdViewController.tabBarItem.setTitleTextAttributes(selectedAttributes, for: .selected)

        let fourthViewController = ViewController()
               fourthViewController.tabBarItem = UITabBarItem(
                   title: "Корзина",
                   image: UIImage(named: "BarItemOrder"),
                   selectedImage: UIImage(named: "BarItemOrder")?.withTintColor(color, renderingMode: .alwaysOriginal)
               )
        fourthViewController.tabBarItem.setTitleTextAttributes(selectedAttributes, for: .selected)
        
        self.viewControllers = [mainViewController, secondViewController, thirdViewController, fourthViewController]
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
