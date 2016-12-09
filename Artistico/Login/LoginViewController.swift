//
//  LoginViewController.swift
//  Artistico
//
//  Created by kaushal on 11/14/16.
//  Copyright © 2016 kaushal. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import GoogleSignIn
import FBSDKCoreKit
import FBSDKLoginKit

fileprivate struct RegisteredCellClassIdentifier {
    
   static let loginTableCell:String = "LoginTableViewCell"
   static let loginTableActionCell:String = "LoginTableViewActionCell"
   static let signInWithSocialActionCell:String = "SignInWithSocialActionCell"
   static let registerNewActionCell:String = "RegisterNewActionCell"
    
}

class LoginViewController: UIViewController {
    
    var rootViewController : RootViewController?
    @IBOutlet var tableView:UITableView!
    var signInAuthService:SignInAuthService?
    
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpView()
        #if false
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        #else
        signInAuthService = SignInAuthService.init(delegated: self, signInType: .google)
        #endif
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true;
//        if let _ = FIRAuth.auth()?.currentUser {
//             createMenuView()
//        }
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
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return true;
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
        
        return 4;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var loginTableViewCell:LoginTableViewCell!
        var loginTableViewActionCell:LoginTableViewActionCell!
        var signInWithSocialActionCell:SignInWithSocialActionCell!
        var registerNewActionCell:RegisterNewActionCell!
        
        switch indexPath.row {
        case 0:
            loginTableViewCell = tableView.dequeueReusableCell(withIdentifier: RegisteredCellClassIdentifier.loginTableCell, for: indexPath) as! LoginTableViewCell
            loginTableViewCell.configureLoginTableViewCell()
            return loginTableViewCell
            
         case 1:
            loginTableViewActionCell = tableView.dequeueReusableCell(withIdentifier: RegisteredCellClassIdentifier.loginTableActionCell, for: indexPath) as! LoginTableViewActionCell
            loginTableViewActionCell?.submitButton.addTarget(self, action: #selector(submitButtonTapped(sender:)), for: .touchUpInside)
            loginTableViewActionCell.configureLoginTableActionCell()
            return loginTableViewActionCell
            
        case 2:
            signInWithSocialActionCell = tableView.dequeueReusableCell(withIdentifier: RegisteredCellClassIdentifier.signInWithSocialActionCell, for: indexPath) as! SignInWithSocialActionCell
            
            signInWithSocialActionCell.configureLoginTableActionCell()

//            signInWithSocialActionCell?.facebookSignInButton.addTarget(self, action: #selector(facebookSignInButtonTapped(sender:)), for: .touchUpInside)
            signInWithSocialActionCell?.facebookSignInButton.readPermissions = ["public_profile", "email"]
            signInWithSocialActionCell?.facebookSignInButton.delegate = self
            
            signInWithSocialActionCell?.googleSignInButton.addTarget(self, action: #selector(googleSignInButtonTapped(sender:)), for: .touchUpInside)
            
            signInWithSocialActionCell?.twitterSignInButton.addTarget(self, action: #selector(twitterSignInButtonTapped(sender:)), for: .touchUpInside)
            return signInWithSocialActionCell
            
        case 3:
            registerNewActionCell = tableView.dequeueReusableCell(withIdentifier: RegisteredCellClassIdentifier.registerNewActionCell, for: indexPath) as! RegisterNewActionCell
            registerNewActionCell?.registerNewButton.addTarget(self, action: #selector(registerNewUserButtonTapped(sender:)), for: .touchUpInside)
            registerNewActionCell.configureLoginTableActionCell()
            return registerNewActionCell
            
        default:
            return UITableViewCell.init()
        }
    }
    
    @IBAction func submitButtonTapped(sender :Any) -> () {
        // Sign In with credentials.
        let user:UserLogin = UserLogin.init(name: "kaushal", email: "kaushal.workboard+10000@gmail.com", password: "Workboard1")
        
        AccountManager.sharedInstance.FIR_Authenticate(withEmail: user.email, password: user.password){[unowned self] (user, errorDesc) in
            
            guard let _:FIRUser = user else {
                if let _ = errorDesc {
                    // show alert for error.
                }
                return
            }
            self.createMenuView()
        }
    }
    
    @IBAction func registerNewUserButtonTapped(sender:Any) -> () {
        return
    }
    
    @IBAction func facebookSignInButtonTapped(sender:Any) -> () {
        
        let fbLoginButton:FBSDKLoginButton = FBSDKLoginButton()
        fbLoginButton.readPermissions = ["public_profile", "email"]
        fbLoginButton.delegate = self
        return
    }
    
    @IBAction func googleSignInButtonTapped(sender:Any) -> () {
        
        #if false
         GIDSignIn.sharedInstance().signIn()
        #else
            signInAuthService?.signIn(){ user, errorDesc in
                guard let _:FIRUser = user else {
                    if let _ = errorDesc {
                        // show alert for error.
                        print("dead lock")
                    }
                    return
                }
                print("sucess call back sign in")
            }
        #endif
        
        return
    }
    
    @IBAction func twitterSignInButtonTapped(sender:Any) -> () {
        return
    }
    
   fileprivate func showMainViewController() -> Void {
        
        if let mainVC = rootViewController {
            show(mainVC, sender: nil)
        } else {
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

extension LoginViewController : FBSDKLoginButtonDelegate {
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
    }
    
}

//MARK: GIDSignInDelegate
extension LoginViewController: GIDSignInDelegate, GIDSignInUIDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        
        let authentication = user.authentication
        let credential = FIRGoogleAuthProvider.credential(withIDToken: (authentication?.idToken)!,
                                                          accessToken: (authentication?.accessToken)!)
        print(credential)
        FIRAuth.auth()?.signIn(with: credential) { (user, error) in
            
            guard let _:FIRUser = user else {
                if let _ = error {
                    // show error
                }
                return
            }
            print(user?.email ?? "test@email")
            self.createMenuView()
        }
        
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }
    
    //GIDSignInUIDelegate
    
    func sign(inWillDispatch signIn: GIDSignIn!, error: Error!) {
        
    }
    
     func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!) {
        
         self.present(viewController, animated: true, completion: nil)
    }
    
    func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
        
        self.dismiss(animated: true, completion: nil)
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


extension LoginViewController {
    
    @IBAction func didTapSignIn(sender: AnyObject) {
        
        //MARK: Amalofire request demo.
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
}




