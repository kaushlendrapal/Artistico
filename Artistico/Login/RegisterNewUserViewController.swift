//
//  RegisterNewUserViewController.swift
//  Artistico
//
//  Created by kaushal on 12/5/16.
//  Copyright © 2016 kaushal. All rights reserved.
//

import UIKit

fileprivate struct RegisteredCellClassIdentifier {
    
    static let tableViewTextFieldCell:String = "TableViewTextFieldCell"
    static let loginTableActionCell:String = "LoginTableViewActionCell"
    
}

class RegisterNewUserViewController: UIViewController {
    
     @IBOutlet var tableView:UITableView!
     @IBOutlet var closeButton:UIButton!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpView() -> Void {
        
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.estimatedRowHeight = 100.0
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(TableViewTextFieldCell.self, forCellReuseIdentifier: RegisteredCellClassIdentifier.tableViewTextFieldCell)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        closeButton.addTarget(self, action: #selector(closeButtonTapped(sender:)) , for: .touchUpInside)
    }
    
    func keyboardWillShow(notification:NSNotification?) -> Void {
        
        if let noti = notification {
            let infoDictionary = noti.userInfo
            let keyboardSize: CGSize? = (infoDictionary![UIKeyboardFrameEndUserInfoKey] as? CGRect)?.size
            
            if let tableBottomConstraint =
                view.constraints.filter({ (testConstraint:NSLayoutConstraint) -> Bool in
                    return testConstraint.identifier == "tableViewBottomIdentifier"
                }).first {
                tableBottomConstraint.constant = (keyboardSize?.height)!
            }
            
            UIView.animate(withDuration: 0.35) { [unowned self] in
                self.tableView.setNeedsUpdateConstraints()
                self.tableView.setContentOffset(CGPoint.zero, animated: false)
            }
        }
    }
    
    func keyboardWillHide(notification:NSNotification?) -> Void {
        
        if let tableBottomConstraint =
            view.constraints.filter({ (testConstraint:NSLayoutConstraint) -> Bool in
                return testConstraint.identifier == "tableViewBottomIdentifier"
            }).first {
            tableBottomConstraint.constant = 0
        }
        
        UIView.animate(withDuration: 0.35) { [unowned self] in
            
            self.tableView.setNeedsUpdateConstraints()
            self.tableView.setContentOffset(CGPoint.zero, animated: false)
        }
    }
    
    @IBAction func closeButtonTapped(sender:Any) -> () {
      let _ =  navigationController?.popViewController(animated: true)
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


extension RegisterNewUserViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var tableViewTextFieldCell:TableViewTextFieldCell!
        
        switch indexPath.row {
        case 0:
            tableViewTextFieldCell = tableView.dequeueReusableCell(withIdentifier: RegisteredCellClassIdentifier.tableViewTextFieldCell, for: indexPath) as! TableViewTextFieldCell
            tableViewTextFieldCell.label.text = "User Name"
            tableViewTextFieldCell.configureTextFieldCell()
            return tableViewTextFieldCell
            
        case 1:
            tableViewTextFieldCell = tableView.dequeueReusableCell(withIdentifier: RegisteredCellClassIdentifier.tableViewTextFieldCell, for: indexPath) as! TableViewTextFieldCell
            tableViewTextFieldCell.label.text = "email"
            tableViewTextFieldCell.configureTextFieldCell()
            return tableViewTextFieldCell
            
        case 2:
            tableViewTextFieldCell = tableView.dequeueReusableCell(withIdentifier: RegisteredCellClassIdentifier.tableViewTextFieldCell, for: indexPath) as! TableViewTextFieldCell
            tableViewTextFieldCell.label.text = "Password"
            tableViewTextFieldCell.configureTextFieldCell()
            return tableViewTextFieldCell
        
            
        default:
            return UITableViewCell.init()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.row {
        case 0:
            return 65.0
        case 1:
            return 65.0
        default:
            return 44.0
        }
    }
}





