//
//  MainTabBarViewController.swift
//  HD Video Player
//
//  Created by macOS on 29/10/21.
//

import UIKit
import SideMenu
class MainTabBarViewController: UITabBarController {
    
    var menu:SideMenuNavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menu = SideMenuNavigationController(rootViewController: menulistcontroller())
        menu?.leftSide = true
        menu?.setNavigationBarHidden(true, animated: false)
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
    }
    @IBAction func menu(_ sender: UIBarButtonItem) {
        present(menu!, animated: true)
    }
}

class menulistcontroller: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "MenuItemController", bundle: nil).self, forCellReuseIdentifier: "menuCell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as! MenuItemController
      
        tableView.separatorStyle = .none
        return cell
    }
}
