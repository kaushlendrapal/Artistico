//
//  ReusableTableViewCell.swift
//  Artistico
//
//  Created by kaushal on 12/6/16.
//  Copyright © 2016 kaushal. All rights reserved.
//

import UIKit

class TableViewTextFieldCell: UITableViewCell {
    
    var didSetConstraints:Bool = false;
    var label:UILabel! = UILabel()
    var textField:UITextField! = UITextField()
    var textFieldbottomLine:UIView! = UIView()
    var layoutConstraint = [NSLayoutConstraint]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.autoresizingMask = [.flexibleLeftMargin, .flexibleLeftMargin,.flexibleBottomMargin,.flexibleRightMargin,  .flexibleHeight, .flexibleWidth]
        
        label.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        textFieldbottomLine.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = ColorStyle.backgroundColor
        textField.setContentHuggingPriority(251, for: .vertical)
        label.setContentHuggingPriority(252, for: .vertical)
        
        contentView.addSubview(label)
        contentView.addSubview(textField)
        contentView.addSubview(textFieldbottomLine)
        setupView()
    }
    
    func setupView() -> Void {
        
       label.textColor      =   UIColor.white
       textField.textColor  =   UIColor.white
       textFieldbottomLine.backgroundColor = UIColor.white
        
    }
    
    override func updateConstraints() {
        
        if didSetConstraints == false {
            // add constraints to view.
            didSetConstraints = true
            addConstraintsForSubView()
        }
        //update constraints if needed
        
        super.updateConstraints()
        
    }
    
    func addConstraintsForSubView() -> () {
        
        layoutConstraint += [
        label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
        label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
        label.bottomAnchor.constraint(equalTo: textField.topAnchor, constant:10),

        textField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant:22),
        textField.widthAnchor.constraint(equalToConstant:150),
        textField.bottomAnchor.constraint(equalTo: textFieldbottomLine.topAnchor, constant: 0),
            
        textFieldbottomLine.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant:22),
        textFieldbottomLine.widthAnchor.constraint(equalToConstant:150) ,
        textFieldbottomLine.heightAnchor.constraint(equalToConstant:1),
        textFieldbottomLine.bottomAnchor.constraint(greaterThanOrEqualTo: contentView.bottomAnchor, constant: 10)
        ]
        
        layoutConstraint[0].identifier = "Label_top"
        layoutConstraint.last?.priority = 249
        NSLayoutConstraint.activate(layoutConstraint)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureTextFieldCell() -> () {
//        label.text = "User Name"
        textField.text = "kaushal"
        setNeedsUpdateConstraints()
        updateConstraintsIfNeeded()

    }
}

class TableViewConfirmTextFieldCell: UITableViewCell {

}
