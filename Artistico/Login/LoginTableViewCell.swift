//
//  LoginTableViewCell.swift
//  Artistico
//
//  Created by kaushal on 11/19/16.
//  Copyright © 2016 kaushal. All rights reserved.
//

import UIKit

class LoginTableViewCell: UITableViewCell {
    
    @IBOutlet var userNameTextField:UITextField!
    @IBOutlet var passwordTextField:UITextField!
    @IBOutlet var userNameLabel:UILabel!
    @IBOutlet var passwordLabel:UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
   override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureLoginTableViewCell() -> Void {
        
        userNameTextField.attributedPlaceholder = NSAttributedString(string: "eg@gmail.com", attributes: [NSForegroundColorAttributeName:UIColor.white, NSFontAttributeName : UIFont.systemFont(ofSize: 12) ])
        
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "enter password", attributes: [NSForegroundColorAttributeName:UIColor.white, NSFontAttributeName : UIFont.systemFont(ofSize: 12) ])

    }

}

extension LoginTableViewCell : UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
     
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
}


class LoginTableViewActionCell: UITableViewCell {
    
    @IBOutlet var submitButton:UIButton!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureLoginTableActionCell() -> Void {
        submitButton.layer.cornerRadius = 5.0
        submitButton.layer.borderWidth = 2.0
        submitButton.layer.borderColor = UIColor.white.cgColor
        submitButton.clipsToBounds = true
    }
    
    @IBAction func submitButtonTapped(sander:Any) -> Void {
        
    }
    
}
