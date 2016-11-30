//
//  LeftViewController.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 12/3/14.
//

import UIKit

enum LeftMenu: Int {
    case main = 0
    case help1
    case setting
    case help
    case nonMenu
}

protocol LeftMenuProtocol : class {
    func changeViewController(_ menu: LeftMenu)
}

class LeftViewController : UIViewController, LeftMenuProtocol {
    
    @IBOutlet weak var tableView: UITableView!
    var menus = ["Main", "Help1", "Setting", "Help", "NonMenu"]
    var mainViewController: UIViewController!
    var swiftViewController: UIViewController!
    var javaViewController: UIViewController!
    var goViewController: UIViewController!
    var nonMenuViewController: UIViewController!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.separatorColor = UIColor.white
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let swiftViewController = storyboard.instantiateViewController(withIdentifier: "HelpViewController") as! HelpViewController
        self.swiftViewController = UINavigationController(rootViewController: swiftViewController)
        
        let javaViewController = storyboard.instantiateViewController(withIdentifier: "ProfileSettingViewController") as! ProfileSettingViewController
        self.javaViewController = UINavigationController(rootViewController: javaViewController)
        
        let goViewController = storyboard.instantiateViewController(withIdentifier: "HelpViewController") as! HelpViewController
        self.goViewController = UINavigationController(rootViewController: goViewController)
        
        let nonMenuController = storyboard.instantiateViewController(withIdentifier: "NonMenuController") as! NonMenuController
        nonMenuController.delegate = self
        self.nonMenuViewController = UINavigationController(rootViewController: nonMenuController)
        
        self.tableView.registerCellClass(BaseTableViewCell.self)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func changeViewController(_ menu: LeftMenu) {
        switch menu {
        case .main:
            self.slideMenuController()?.changeMainViewController(self.mainViewController, close: true)
        case .help1:
            self.slideMenuController()?.changeMainViewController(self.swiftViewController, close: true)
        case .setting:
            self.slideMenuController()?.changeMainViewController(self.javaViewController, close: true)
        case .help:
            self.slideMenuController()?.changeMainViewController(self.goViewController, close: true)
        case .nonMenu:
            self.slideMenuController()?.changeMainViewController(self.nonMenuViewController, close: true)
        }
    }
}

extension LeftViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let menu = LeftMenu(rawValue: indexPath.row) {
            switch menu {
            case .main, .help1, .setting, .help, .nonMenu:
                return BaseTableViewCell.height()
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let menu = LeftMenu(rawValue: indexPath.row) {
            self.changeViewController(menu)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.tableView == scrollView {
            
        }
    }
}

extension LeftViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let menu = LeftMenu(rawValue: indexPath.row) {
            switch menu {
            case .main, .help1, .setting, .help, .nonMenu:
                let cell = BaseTableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: BaseTableViewCell.identifier)
                cell.setData(menus[indexPath.row])
                return cell
            }
        }
        return UITableViewCell()
    }
    
    
}
