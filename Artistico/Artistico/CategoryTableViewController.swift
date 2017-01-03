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
    
    var categoryTitle:String = "electronics"
    
    fileprivate var ref: FIRDatabaseReference!
    fileprivate var productRef: FIRDatabaseReference!
    fileprivate var category:Dictionary<String, Any>?
    var subCategoryList : [Dictionary<String, Any>]?
    var catogariedProductList : Dictionary<String, Any>?
    fileprivate var _refHandle: FIRDatabaseHandle!
    fileprivate var _subCategoryRefHandle: FIRDatabaseHandle!
    fileprivate var _productRefHandle: FIRDatabaseHandle!
    var storageRef: FIRStorageReference!
    
    deinit {
        self.ref.child("categories").removeObserver(withHandle: _refHandle)
        self.productRef.child("products").removeObserver(withHandle: _refHandle)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
   required override init(style: UITableViewStyle){
        super.init(style: style)
        // update custom init
    }
    
   convenience init(style: UITableViewStyle, title:String) {
        self.init(style: style)
        self.categoryTitle = title
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        catogariedProductList = Dictionary<String, Any>()
        setUpView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.isHidden = false;
        configureDatabase()
        configureStorage()
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
    
    func configureDatabase() -> () {
        
        self.getCategyDetails(title:categoryTitle, completionHandler:{[unowned self] (categoryDict) in
            
            self.category = categoryDict
            let titleValue = self.category!["id"] as! String
            
            if let subCategory = categoryDict["subCategories"] as? Dictionary<String, Bool> {
                for (key, _) in subCategory {
                    self.getProductList(key, completionHandler: { (productList) in
                        self.catogariedProductList?[key] = productList
                    })
                }
            }
            self.getSubCategoriesList(titleValue, completionHandler: { (subCategorys) in
                
                self.subCategoryList = subCategorys
                DispatchQueue.main.asyncAfter(deadline:.now() + 2.0){ () in
                    self.tableView.reloadData()
                }
            })
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        if let subCategoryList = self.subCategoryList {
            return subCategoryList.count
        } else {
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var tableViewCategoryCell:TableViewCategoryCell!
        
            tableViewCategoryCell = tableView.dequeueReusableCell(withIdentifier: RegisteredCellClassIdentifier.tableViewCategoryCell, for: indexPath) as! TableViewCategoryCell
        
        tableViewCategoryCell.setCollectionViewDataSourceAndDelegate(dataSourceDelegate:self, forRow: indexPath.section)
            tableViewCategoryCell.configureCategoryCell()
            return tableViewCategoryCell
            
}
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        var tableViewSectionHeaderTitleCell:TableViewSectionHeaderTitleCell!
        
        tableViewSectionHeaderTitleCell = tableView.dequeueReusableCell(withIdentifier: RegisteredCellClassIdentifier.tableViewSectionHeaderTitleCell) as! TableViewSectionHeaderTitleCell
        
        tableViewSectionHeaderTitleCell.tag = section
        let subCategory = self.subCategoryList![section]
        
        if let title =  subCategory["title"] as? String {
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
        
        let subCategory = self.subCategoryList![collectionView.tag]
        let categoryId:String = (subCategory["id"] as? String)!
        if let productList:[Dictionary<String, Any>] = catogariedProductList?[categoryId] as! [Dictionary<String, Any>]?  {
            return productList.count
        } else {
            return 0
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var collectionViewProductCell:CollectionViewProductCell!
        
        collectionViewProductCell = collectionView.dequeueReusableCell(withReuseIdentifier: RegisteredCellClassIdentifier.collectionViewProductCell, for: indexPath) as! CollectionViewProductCell
        let subCategory = self.subCategoryList![collectionView.tag]
        let categoryId:String = (subCategory["id"] as? String)!
        if let productList:[Dictionary<String, Any>] = catogariedProductList?[categoryId] as! [Dictionary<String, Any>]?  {
            let productDetail:Dictionary<String, Any> = productList[indexPath.row]
            collectionViewProductCell.configureProductCell(withProduct: productDetail)
        }
        
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
    
    func configureStorage() {
        let storageUrl = FIRApp.defaultApp()?.options.storageBucket
        storageRef = FIRStorage.storage().reference(forURL: "gs://" + storageUrl!)
    }
    
    func getCategyDetails(title:String, completionHandler:@escaping ((_ category:Dictionary<String, Any>)->())) {
        ref = FIRDatabase.database().reference()
        // Listen for new messages in the Firebase database
        _refHandle = self.ref.child("categories").queryOrdered(byChild: "title").queryEqual(toValue:title).observe(.value, with: { (snapshot) -> Void in
            
            print("snap \(snapshot)")
            if let categoryList = snapshot.value as? [Dictionary<String, Any>] {
                if categoryList.count > 0 {
                    completionHandler(categoryList[0])
                }
            }
        }, withCancel: { (error) in
            print(error)
        })
    }
    
    func getSubCategoriesList(_ category:String, completionHandler:@escaping ((_ subCatogaries:[Dictionary<String, Any>])->())) -> () {

        productRef = FIRDatabase.database().reference().child("subCategories")
        var subCategories : [Dictionary<String, Any>] = [Dictionary<String, Any>]()
        _subCategoryRefHandle = productRef.queryOrdered(byChild: "categories/\(category)").queryEqual(toValue:true).observe(.value, with: { (snapshot) -> Void in
            
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
    
    func getProductList(_ subCategory:String, completionHandler:@escaping ((_ productList:[Dictionary<String, Any>])->())) -> () {
        var productList = [Dictionary<String, Any>]()
        productRef = FIRDatabase.database().reference().child("products")
        
        _productRefHandle = productRef.queryOrdered(byChild: "subCategories/\(subCategory)").queryEqual(toValue:true).observe(.value, with: { (snapshot) -> Void in
            
            print("snap \(snapshot)")
            if let productDict = snapshot.value as? Dictionary<String, Any> {
                for (_, value) in productDict {
                    productList.append(value as! [String : Any])
                }
                completionHandler(productList)
            }
            
        }, withCancel: { (error) in
            print(error)
        })
        
    }
    
}
