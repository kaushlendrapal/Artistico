//
//  ViewController.swift
//  Artistico
//
//  Created by kaushal on 11/14/16.
//  Copyright © 2016 kaushal. All rights reserved.
//

import UIKit
import Firebase

fileprivate struct RegisteredCellClassIdentifier {
    
    static let tableViewCell:String = "UITableViewCell"
    static let tableViewSectionHeaderTitleCell:String = "TableViewSectionHeaderTitleCell"
    
}

class RootViewController: UIViewController {
    
    var ref: FIRDatabaseReference!
    var messages: [FIRDataSnapshot]! = []
    var categoryList : [Dictionary<String, Any>]?
    var subCategoryIndexDetail :Dictionary<String, Any>?
    fileprivate var _refHandle: FIRDatabaseHandle!
    fileprivate var _subCategoryRefHandle: FIRDatabaseHandle!
    var storageRef: FIRStorageReference!
    @IBOutlet weak var clientTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setUpView()
        self.subCategoryIndexDetail = Dictionary<String, Any>()
        
    }
    
    func setUpView() -> Void {
        
        self.clientTable.tableFooterView = UIView(frame: CGRect.zero)
        self.clientTable.estimatedRowHeight = 100.0
        self.clientTable.rowHeight = UITableViewAutomaticDimension
        self.clientTable.sectionHeaderHeight = UITableViewAutomaticDimension
        self.clientTable.estimatedSectionHeaderHeight = 65
        self.clientTable.allowsSelection = false
        self.clientTable.separatorStyle = .none
        self.clientTable.delegate = self
        self.clientTable.dataSource = self
        
        self.clientTable.register(UITableViewCell.self, forCellReuseIdentifier:RegisteredCellClassIdentifier.tableViewCell)
        self.clientTable.register(TableViewSectionHeaderTitleCell.self, forCellReuseIdentifier: RegisteredCellClassIdentifier.tableViewSectionHeaderTitleCell)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.setNavigationBarItem()
       navigationController?.navigationBar.isHidden = false;
        self.title = "All Categories"
        configureStorage()
        configureDatabase()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        self.ref.child("categories").removeObserver(withHandle: _refHandle)
    }

}

extension RootViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if let categoryList = self.categoryList {
            return categoryList.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let categoryInfo = self.categoryList?[section] else {
            return 0
        }
        let categoryId:String = categoryInfo["id"] as! String
        guard let categories:[Dictionary<String, Any>] = self.subCategoryIndexDetail?[categoryId] as! [Dictionary<String, Any>]? else {
            return 0
        }
        
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Dequeue cell
        let cell = self.clientTable .dequeueReusableCell(withIdentifier:RegisteredCellClassIdentifier.tableViewCell, for: indexPath)
       
         let categoryInfo = self.categoryList![indexPath.section]
        
        let categoryId:String = categoryInfo["id"] as! String
        guard let subCategories:[Dictionary<String, Any>] = self.subCategoryIndexDetail?[categoryId] as! [Dictionary<String, Any>]? else {
            return UITableViewCell()
        }
        let subCategoryInfo = subCategories[indexPath.row]
        
        cell.textLabel?.text = subCategoryInfo["title"] as? String
        cell.imageView?.image = UIImage(named: "guest_user")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        var tableViewSectionHeaderTitleCell:TableViewSectionHeaderTitleCell!
    
        tableViewSectionHeaderTitleCell = tableView.dequeueReusableCell(withIdentifier: RegisteredCellClassIdentifier.tableViewSectionHeaderTitleCell) as! TableViewSectionHeaderTitleCell
        
        tableViewSectionHeaderTitleCell.tag = section
        let category = self.categoryList![section]
        
        if let title =  category["title"] as? String {
            tableViewSectionHeaderTitleCell.label.text = title
        } else {
            tableViewSectionHeaderTitleCell.label.text = Global.kEmptyString
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(TapGestureRecognizer(gestureRecognizer:)))
        tapGesture.numberOfTouchesRequired = 1;
        tapGesture.numberOfTapsRequired = 1;
        tableViewSectionHeaderTitleCell.addGestureRecognizer(tapGesture)
        
        tableViewSectionHeaderTitleCell.configureSectionHeaderTitleCell()
        
        return tableViewSectionHeaderTitleCell
    }
    
    func TapGestureRecognizer(gestureRecognizer: UIGestureRecognizer) {
        //do your stuff here
        if let headerView = gestureRecognizer.view {
            let _ :Int = headerView.tag
            
        }
    }

}

extension RootViewController {
    
    func configureDatabase() {
        
        self.getCategyDetails(completionHandler:{[unowned self] (categories) in
            
            self.categoryList = categories
            
            
            for categoryDict:Dictionary<String, Any> in categories {
                let titleValue = categoryDict["id"] as! String
                
                self.getSubCategoriesList(titleValue, completionHandler: { (subCategorys) in
                    self.subCategoryIndexDetail?[titleValue] = subCategorys
                })
            }
            
            DispatchQueue.main.asyncAfter(deadline:.now() + 2.0){ () in
                self.clientTable.reloadData()
            }
        })
        
    }
    
    func getCategyDetails(completionHandler:@escaping ((_ category:[Dictionary<String, Any>])->())) {
        ref = FIRDatabase.database().reference()
        // Listen for new messages in the Firebase database
        _refHandle = self.ref.child("categories").observe(.value, with: { (snapshot) -> Void in
            print("snap \(snapshot)")
            if let categoryList = snapshot.value as? [Dictionary<String, Any>] {
                completionHandler(categoryList)
            }
        }, withCancel: { (error) in
            print(error)
        })
    }
    
    func getSubCategoriesList(_ category:String, completionHandler:@escaping ((_ subCatogaries:[Dictionary<String, Any>])->())) -> () {
        
        var subCategories : [Dictionary<String, Any>] = [Dictionary<String, Any>]()
        _subCategoryRefHandle = FIRDatabase.database().reference().child("subCategories").queryOrdered(byChild: "categories/\(category)").queryEqual(toValue:true).observe(.value, with: { (snapshot) -> Void in
            
            print("snap \(snapshot)")
            if let subCategoryDict = snapshot.value as? Dictionary<String, Any> {
                for (_, value) in subCategoryDict {
                    subCategories.append(value as! [String : Any])
                }
                completionHandler(subCategories)
            }
            
        }, withCancel: { (error) in
            print(error)
        })
    }
    
    func configureStorage() {
        let storageUrl = FIRApp.defaultApp()?.options.storageBucket
        storageRef = FIRStorage.storage().reference(forURL: "gs://" + storageUrl!)
    }
}

extension RootViewController : SlideMenuControllerDelegate {
    
    func leftWillOpen() {
        print("SlideMenuControllerDelegate: leftWillOpen")
    }
    
    func leftDidOpen() {
        print("SlideMenuControllerDelegate: leftDidOpen")
    }
    
    func leftWillClose() {
        print("SlideMenuControllerDelegate: leftWillClose")
    }
    
    func leftDidClose() {
        print("SlideMenuControllerDelegate: leftDidClose")
    }
    
    func rightWillOpen() {
        print("SlideMenuControllerDelegate: rightWillOpen")
    }
    
    func rightDidOpen() {
        print("SlideMenuControllerDelegate: rightDidOpen")
    }
    
    func rightWillClose() {
        print("SlideMenuControllerDelegate: rightWillClose")
    }
    
    func rightDidClose() {
        print("SlideMenuControllerDelegate: rightDidClose")
    }
}


