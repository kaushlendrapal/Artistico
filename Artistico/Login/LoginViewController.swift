//
//  LoginViewController.swift
//  Artistico
//
//  Created by kaushal on 11/14/16.
//  Copyright © 2016 kaushal. All rights reserved.
//

import UIKit
import Firebase

struct RegisteredCellClassIdentifier {
    
   static let loginTableCell:String = "LoginTableViewCell"
   static let loginTableActionCell:String = "LoginTableViewActionCell"
    
}


class LoginViewController: UIViewController {
    
    var rootViewController : RootViewController?
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
        navigationController?.navigationBar.isHidden = true;
    }
    
    
    override func viewWillLayoutSubviews() {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpView() -> Void {
        
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.estimatedRowHeight = 70.0
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)

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
        
//        if let noti = notification {
        
//            _ = noti.userInfo
//            let keyboardSize: CGSize? = (infoDictionary![UIKeyboardFrameEndUserInfoKey] as? CGRect)?.size
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
//        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    deinit {
        
        NotificationCenter.default.removeObserver(self, name:Notification.Name.UIKeyboardWillShow , object: nil)
        NotificationCenter.default.removeObserver(self, name:Notification.Name.UIKeyboardWillHide , object: nil)
        
    }

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
            
            loginTableViewCell = tableView.dequeueReusableCell(withIdentifier: RegisteredCellClassIdentifier.loginTableCell, for: indexPath) as! LoginTableViewCell
            loginTableViewCell.configureLoginTableViewCell()
            
            return loginTableViewCell
            
        } else if indexPath.row == 1 {
            
            loginTableViewActionCell = tableView.dequeueReusableCell(withIdentifier: RegisteredCellClassIdentifier.loginTableActionCell, for: indexPath) as! LoginTableViewActionCell
            loginTableViewActionCell?.submitButton.addTarget(self, action: #selector(submitButtonTapped(sender:)), for: .touchUpInside)
            loginTableViewActionCell.configureLoginTableActionCell()
            
            return loginTableViewActionCell;
        }
        
        return UITableViewCell.init()
    }
    
    @IBAction func submitButtonTapped(sender :Any) {
        
        let user:UserLogin = UserLogin.init(name: "kaushal.workboard@gmail.com", email: "kaushal.workboard@gmail.com", password: "Workboard1")
        HTTPRestClient.DefaultRestClient.loginUser(withUser: user, completionHandler: {
             result in
            
            switch result {
            case .success:
                if let loginUser = result.value as? UserLogin  {
                    print("JSON: \(loginUser)")
                    DispatchQueue.main.async(execute: {
                        self.showMainViewController()
                    })
                }
            case .failure(let error):
                print(error)
            }
        })
        
    }
    
    func showMainViewController() -> Void {
        
        if let mainVC = rootViewController {
            show(mainVC, sender: nil)
        } else {
//            let storyboard : UIStoryboard = UIStoryboard.init(name:"Main", bundle: nil)
//            self.rootViewController = storyboard.instantiateViewController(withIdentifier: "RootViewController") as? RootViewController
            createMenuView()
            
        }
    }
    
    fileprivate func createMenuView() {
        
        // create viewController code...
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.rootViewController = storyboard.instantiateViewController(withIdentifier: "RootViewController") as? RootViewController
        let leftViewController = storyboard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
        let nvc: UINavigationController = UINavigationController(rootViewController: self.rootViewController!)
        
        UINavigationBar.appearance().tintColor = UIColor(hex: "00C895")
        
        leftViewController.mainViewController = nvc
        
        let slideMenuController = SlideMenuController(mainViewController:nvc, leftMenuViewController: leftViewController, rightMenuViewController: UIViewController.init())
        slideMenuController.automaticallyAdjustsScrollViewInsets = true
        slideMenuController.delegate = self.rootViewController
       show(slideMenuController, sender: nil)
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

//MARK: Firebase login
extension LoginViewController {
    
    @IBAction func didTapSignIn(_ sender: AnyObject) {
        // Sign In with credentials.
        let user:UserLogin = UserLogin.init(name: "kaushal.workboard@gmail.com", email: "kaushal.workboard@gmail.com", password: "Workboard1")
        FIRAuth.auth()?.signIn(withEmail: user.email, password: user.password) { (user, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            self.signedIn(user!)
        }
    }
    
    func signedIn(_ user: FIRUser?) {
        MeasurementHelper.sendLoginEvent()
        
        AppState.sharedInstance.displayName = user?.displayName ?? user?.email
        AppState.sharedInstance.photoURL = user?.photoURL
        AppState.sharedInstance.signedIn = true
        let notificationName = Notification.Name(rawValue: Constants.NotificationKeys.SignedIn)
        NotificationCenter.default.post(name: notificationName, object: nil, userInfo: nil)
//        performSegue(withIdentifier: Constants.Segues.SignInToFp, sender: nil)
    }
}





