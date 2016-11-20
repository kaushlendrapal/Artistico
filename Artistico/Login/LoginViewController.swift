//
//  LoginViewController.swift
//  Artistico
//
//  Created by kaushal on 11/14/16.
//  Copyright © 2016 kaushal. All rights reserved.
//

import UIKit


struct RegisteredCellClassIdentifier {
    
    let loginTableCell:String = "LoginTableViewCell"
    let loginTableActionCell:String = "LoginTableViewActionCell"
    
}


class LoginViewController: UIViewController {
    
    @IBOutlet var tableView:UITableView!
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    
    override func viewWillLayoutSubviews() {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpView() -> Void {
        
        // do not use register cell for storyboard cell
//        self.tableView.register(LoginTableViewCell.self, forCellReuseIdentifier: RegisteredCellClassIdentifier().loginTableCell)
//        self.tableView.register(LoginTableViewActionCell.self, forCellReuseIdentifier: RegisteredCellClassIdentifier().loginTableActionCell)
        
         tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.estimatedRowHeight = 70.0
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension LoginViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 2;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var loginTableViewCell:LoginTableViewCell!
        var loginTableViewActionCell:LoginTableViewActionCell!
        
        if indexPath.row == 0 {
            
            loginTableViewCell = tableView.dequeueReusableCell(withIdentifier: RegisteredCellClassIdentifier().loginTableCell, for: indexPath) as! LoginTableViewCell
            loginTableViewCell.configureLoginTableViewCell()
            
            return loginTableViewCell
            
        } else if indexPath.row == 1 {
            
            loginTableViewActionCell = tableView.dequeueReusableCell(withIdentifier: RegisteredCellClassIdentifier().loginTableActionCell, for: indexPath) as! LoginTableViewActionCell
            loginTableViewActionCell.configureLoginTableActionCell()
            
            return loginTableViewActionCell;
        }
        
        return UITableViewCell.init()
    }
}

extension LoginViewController {
    
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        
        super.traitCollectionDidChange(previousTraitCollection)
        
        if traitCollection.verticalSizeClass != previousTraitCollection?.verticalSizeClass {
            
            switch traitCollection.verticalSizeClass {
                
            case UIUserInterfaceSizeClass.compact:
                
                break
            case UIUserInterfaceSizeClass.unspecified:
                fallthrough
                
            case UIUserInterfaceSizeClass.regular:
                
                break
            }
        }
    }
    
    
    
}





