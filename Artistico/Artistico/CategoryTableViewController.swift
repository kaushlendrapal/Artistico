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
    var messages: [FIRDataSnapshot]! = []
    fileprivate var _refHandle: FIRDatabaseHandle!
    var storageRef: FIRStorageReference!
    
    deinit {
        self.ref.child("messages").removeObserver(withHandle: _refHandle)
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
        tableView.reloadData()
    }
    
    func setUpView() -> Void {
        
        self.clearsSelectionOnViewWillAppear = true
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.estimatedRowHeight = 210.0
        tableView.rowHeight = UITableViewAutomaticDimension
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
        
        
       
        tableViewSectionHeaderTitleCell.configureSectionHeaderTitleCell()
        
        return tableViewSectionHeaderTitleCell
    }
    
}

extension CategoryTableViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    
     func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
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
}

extension CategoryTableViewController {
    
    func configureDatabase() {
        ref = FIRDatabase.database().reference()
        // Listen for new messages in the Firebase database
        _refHandle = self.ref.child("messages").observe(.childAdded, with: { [weak self] (snapshot) -> Void in
            guard let strongSelf = self else { return }
            strongSelf.messages.append(snapshot)
            //            strongSelf.clientTable.insertRows(at: [IndexPath(row: strongSelf.messages.count-1, section: 0)], with: .automatic)
        })
    }
    
    func configureStorage() {
        let storageUrl = FIRApp.defaultApp()?.options.storageBucket
        storageRef = FIRStorage.storage().reference(forURL: "gs://" + storageUrl!)
    }
}
