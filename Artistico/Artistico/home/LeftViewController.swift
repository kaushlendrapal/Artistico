//
//  LeftViewController.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 12/3/14.
//

import UIKit

enum LeftMenu: Int {
    case main = 0
    case electronics
    case appliance
    case man
    case women
}

protocol LeftMenuProtocol : class {
    func changeViewController(_ menu: LeftMenu)
}

class LeftViewController : UIViewController, LeftMenuProtocol {
    
    @IBOutlet weak var tableView: UITableView!
    var menus = ["Main", "Electronics", "Appliace", "Man", "Women"]
    var mainViewController: UIViewController!
    var electronicViewController: UIViewController!
    var applianceViewController: UIViewController!
    var manViewController: UIViewController!
    var womenViewController: UIViewController!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.separatorColor = UIColor.white
        
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let electronicCategoryVC:CategoryTableViewController = CategoryTableViewController.init(style: .plain, title: "electronics")
        self.electronicViewController = UINavigationController(rootViewController: electronicCategoryVC)
        let applianceCategoryVC:CategoryTableViewController = CategoryTableViewController.init(style: .plain, title: "Appliance")

//        let javaViewController = storyboard.instantiateViewController(withIdentifier: "ProfileSettingViewController") as! ProfileSettingViewController
        
        self.applianceViewController = UINavigationController(rootViewController: applianceCategoryVC)
        
//        let goViewController = storyboard.instantiateViewController(withIdentifier: "HelpViewController") as! HelpViewController
        let manCategoryVC:CategoryTableViewController = CategoryTableViewController.init(style: .plain, title: "Man")
        self.manViewController = UINavigationController(rootViewController: manCategoryVC)
        
//        let nonMenuController = storyboard.instantiateViewController(withIdentifier: "NonMenuController") as! NonMenuController
//        nonMenuController.delegate = self
        let womanCategoryVC:CategoryTableViewController = CategoryTableViewController.init(style: .plain, title: "woman")
        self.womenViewController = UINavigationController(rootViewController: womanCategoryVC)
        
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
        case .electronics:
            self.slideMenuController()?.changeMainViewController(self.electronicViewController, close: true)
        case .appliance:
            self.slideMenuController()?.changeMainViewController(self.applianceViewController, close: true)
        case .man:
            self.slideMenuController()?.changeMainViewController(self.manViewController, close: true)
        case .women:
            self.slideMenuController()?.changeMainViewController(self.womenViewController, close: true)
        }
    }
}

extension LeftViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let menu = LeftMenu(rawValue: indexPath.row) {
            switch menu {
            case .main, .electronics, .appliance, .man, .women:
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
            case .main, .electronics, .appliance, .man, .women:
                let cell = BaseTableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: BaseTableViewCell.identifier)
                cell.setData(menus[indexPath.row])
                return cell
            }
        }
        return UITableViewCell()
    }
    
    
}
