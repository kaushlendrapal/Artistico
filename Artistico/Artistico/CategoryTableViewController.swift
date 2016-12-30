//
//  CategoryTableViewController.swift
//  Artistico
//
//  Created by kaushal on 12/19/16.
//  Copyright © 2016 kaushal. All rights reserved.
//

import UIKit
import Firebase

fileprivate struct RegisteredCellClassIdentifier {
    
    static let tableViewCategoryCell:String = "TableViewCategoryCell"
    static let tableViewSectionHeaderTitleCell:String = "TableViewSectionHeaderTitleCell"
    static let collectionViewProductCell:String = "CollectionViewProductCell"
    
}

class CategoryTableViewController: UITableViewController {
    
    var ref: FIRDatabaseReference!
    var productRef: FIRDatabaseReference!
    var messages: [FIRDataSnapshot]! = []
    var productList : [Dictionary<String, Any>]?
    fileprivate var _refHandle: FIRDatabaseHandle!
    fileprivate var _productRefHandle: FIRDatabaseHandle!
    var storageRef: FIRStorageReference!
    
    deinit {
        self.ref.child("categories").removeObserver(withHandle: _refHandle)
        self.productRef.child("products").removeObserver(withHandle: _refHandle)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(style: UITableViewStyle){
        super.init(style: style)
        // update custom init
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureDatabase()
        configureStorage()
        setUpView()
       
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.setNavigationBarItem()
        navigationController?.navigationBar.isHidden = false;
         productList = self.getProductList("1000")
        tableView.reloadData()
    }
    
    func setUpView() -> Void {
        
        self.clearsSelectionOnViewWillAppear = true
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.estimatedRowHeight = 210.0
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.sectionHeaderHeight = UITableViewAutomaticDimension
        tableView.estimatedSectionHeaderHeight = 65
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(TableViewCategoryCell.self, forCellReuseIdentifier: RegisteredCellClassIdentifier.tableViewCategoryCell)
        //table section cell
        tableView.register(TableViewSectionHeaderTitleCell.self, forCellReuseIdentifier: RegisteredCellClassIdentifier.tableViewSectionHeaderTitleCell)
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.messages.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var tableViewCategoryCell:TableViewCategoryCell!
        
            tableViewCategoryCell = tableView.dequeueReusableCell(withIdentifier: RegisteredCellClassIdentifier.tableViewCategoryCell, for: indexPath) as! TableViewCategoryCell
        
        tableViewCategoryCell.setCollectionViewDataSourceAndDelegate(dataSourceDelegate:self, forRow: indexPath.row)
            tableViewCategoryCell.configureCategoryCell()
            return tableViewCategoryCell
            
}
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        var tableViewSectionHeaderTitleCell:TableViewSectionHeaderTitleCell!
        
        tableViewSectionHeaderTitleCell = tableView.dequeueReusableCell(withIdentifier: RegisteredCellClassIdentifier.tableViewSectionHeaderTitleCell) as! TableViewSectionHeaderTitleCell
        
        tableViewSectionHeaderTitleCell.tag = section
        let messageSnapshot: FIRDataSnapshot! = self.messages[section]
        let message = messageSnapshot.value as! Dictionary<String, Any>
        if let title =  message["title"] as? String {
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
    
    
    
}

extension CategoryTableViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    
     func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var collectionViewProductCell:CollectionViewProductCell!
        
        collectionViewProductCell = collectionView.dequeueReusableCell(withReuseIdentifier: RegisteredCellClassIdentifier.collectionViewProductCell, for: indexPath) as! CollectionViewProductCell
        collectionViewProductCell.configureProductCell()
        
        return collectionViewProductCell
    }
}

extension CategoryTableViewController {
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    func TapGestureRecognizer(gestureRecognizer: UIGestureRecognizer) {
        //do your stuff here
        if let headerView = gestureRecognizer.view {
            let _ :Int = headerView.tag
            let flowLayout = ProductCollectionViewLayout.init(flowType: .productLayouy)
            let productViewController = ProductCollectionViewController.init(keyPath: "test.category.mango", collectionViewLayout: flowLayout)
            show(productViewController, sender:nil)
            
        }
    }
}

extension CategoryTableViewController {
    
    func configureDatabase() {
        ref = FIRDatabase.database().reference()
        // Listen for new messages in the Firebase database
        _refHandle = self.ref.child("categories").observe(.childAdded, with: { [weak self] (snapshot) -> Void in
            guard let strongSelf = self else {
                return
            }
            strongSelf.messages.append(snapshot)
        })
    }
    
    func configureStorage() {
        let storageUrl = FIRApp.defaultApp()?.options.storageBucket
        storageRef = FIRStorage.storage().reference(forURL: "gs://" + storageUrl!)
    }
    //queryOrdered(byChild:"title)").queryEqual(toValue: "iPhone4s")
    func getProductList(_ subCategory:String) -> [Dictionary<String, Any>] {
        var productList = [Dictionary<String, Any>]()
        productRef = FIRDatabase.database().reference()
        _productRefHandle = FIRDatabase.database().reference().child("products").observe(.value, with: { (snapshot) -> Void in
            
            print("snap \(snapshot)")
            if let productDict = snapshot.value as? Dictionary<String, Any> {
                for (_, value) in productDict {
                    productList.append(value as! [String : Any])
                }
            }
        })
        
        return productList;
    }
    
}
