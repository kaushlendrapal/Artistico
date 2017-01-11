//
//  ReusableTableViewCell.swift
//  Artistico
//
//  Created by kaushal on 12/6/16.
//  Copyright © 2016 kaushal. All rights reserved.
//

import UIKit

fileprivate let controllStanderdWidth = CGFloat(240)


class TableViewTextFieldCell: UITableViewCell {
    
    var didSetConstraints:Bool = false;
    var estimatedCellHeight:CGFloat = CGFloat(65)
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
    
    override class var requiresConstraintBasedLayout: Bool {
        return true
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
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIViewNoIntrinsicMetric, height:estimatedCellHeight)
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
        
        textField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 5),
        textField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant:22),
        textField.widthAnchor.constraint(equalToConstant:controllStanderdWidth),
        
        textFieldbottomLine.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 0),
        textFieldbottomLine.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant:22),
        textFieldbottomLine.widthAnchor.constraint(equalToConstant:controllStanderdWidth) ,
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
        setNeedsUpdateConstraints()
        updateConstraintsIfNeeded()
        
    }
}

class TableViewButtonActionCell: UITableViewCell {
    
    var didSetConstraints:Bool = false;
    var estimatedCellHeight:CGFloat = CGFloat(70)
    
    var actionTitle:String? {
        
        willSet(newValue) {
            if let _ = newValue {
                actionButton.setTitle(newValue, for: .normal)
            } else {
                actionButton.setTitle("Submit", for: .normal)
            }
        }
    }
    var actionButton:UIButton = UIButton()
    
    var layoutConstraint = [NSLayoutConstraint]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override class var requiresConstraintBasedLayout: Bool {
        return true
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.autoresizingMask = [.flexibleLeftMargin, .flexibleLeftMargin,.flexibleBottomMargin,.flexibleRightMargin,  .flexibleHeight, .flexibleWidth]
        
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = ColorStyle.backgroundColor
        contentView.addSubview(actionButton)
        setupView()
    }
    
    func setupView() -> Void {
        
        actionButton.setTitleColor(UIColor.white, for: .normal)
        actionButton.setTitle(actionTitle, for: .normal)
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIViewNoIntrinsicMetric, height:estimatedCellHeight)
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
            actionButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0),
            actionButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0),
            actionButton.widthAnchor.constraint(equalToConstant: 250),
            actionButton.heightAnchor.constraint(equalToConstant: 35)
        ]
        
        NSLayoutConstraint.activate(layoutConstraint)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configureButtonActionCell() -> () {
        setNeedsUpdateConstraints()
        updateConstraintsIfNeeded()
    }
    
}


class TableViewConfirmTextFieldCell: UITableViewCell {
    
    var didSetConstraints:Bool = false;
    var estimatedCellHeight:CGFloat = CGFloat(150)
    var label:UILabel! = UILabel()
    var textField:UITextField! = UITextField()
    var textFieldbottomLine:UIView! = UIView()
    
    var retypeLabel:UILabel! = UILabel()
    var confirmTextField:UITextField! = UITextField()
    var confirmFieldbottomLine:UIView! = UIView()
    
    var layoutConstraint = [NSLayoutConstraint]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override class var requiresConstraintBasedLayout: Bool {
      return true
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.autoresizingMask = [.flexibleLeftMargin, .flexibleLeftMargin,.flexibleBottomMargin,.flexibleRightMargin,  .flexibleHeight, .flexibleWidth]
        
        label.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        textFieldbottomLine.translatesAutoresizingMaskIntoConstraints = false
        retypeLabel.translatesAutoresizingMaskIntoConstraints = false
        confirmTextField.translatesAutoresizingMaskIntoConstraints = false
        confirmFieldbottomLine.translatesAutoresizingMaskIntoConstraints = false
        
        self.backgroundColor = ColorStyle.backgroundColor
        textField.setContentHuggingPriority(251, for: .vertical)
        label.setContentHuggingPriority(252, for: .vertical)
        
        contentView.addSubview(label)
        contentView.addSubview(textField)
        contentView.addSubview(textFieldbottomLine)
        
        contentView.addSubview(retypeLabel)
        contentView.addSubview(confirmTextField)
        contentView.addSubview(confirmFieldbottomLine)
        
        setupView()
    }
    
    func setupView() -> Void {
        
        label.textColor      =   UIColor.white
        textField.textColor  =   UIColor.white
        textFieldbottomLine.backgroundColor = UIColor.white
        
        retypeLabel.textColor      =   UIColor.white
        confirmTextField.textColor  =   UIColor.white
        confirmFieldbottomLine.backgroundColor = UIColor.white
        
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIViewNoIntrinsicMetric, height:estimatedCellHeight)
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
            
            textField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 5),
            textField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant:22),
            textField.widthAnchor.constraint(equalToConstant:controllStanderdWidth),
            
            textFieldbottomLine.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 0),
            textFieldbottomLine.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant:22),
            textFieldbottomLine.widthAnchor.constraint(equalToConstant:controllStanderdWidth) ,
            textFieldbottomLine.heightAnchor.constraint(equalToConstant:1),
//            textFieldbottomLine.bottomAnchor.constraint(greaterThanOrEqualTo: contentView.bottomAnchor, constant: 10),
            //confirm text view.
            
            retypeLabel.topAnchor.constraint(equalTo: textFieldbottomLine.bottomAnchor, constant: 10),
            retypeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            confirmTextField.topAnchor.constraint(equalTo: retypeLabel.bottomAnchor, constant: 5),
            confirmTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant:22),
            confirmTextField.widthAnchor.constraint(equalToConstant:controllStanderdWidth),
            
            confirmFieldbottomLine.topAnchor.constraint(equalTo: confirmTextField.bottomAnchor, constant: 0),
            confirmFieldbottomLine.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant:22),
            confirmFieldbottomLine.widthAnchor.constraint(equalToConstant:controllStanderdWidth),
            confirmFieldbottomLine.heightAnchor.constraint(equalToConstant:1),
            confirmFieldbottomLine.bottomAnchor.constraint(greaterThanOrEqualTo: contentView.bottomAnchor, constant: 10)
            
        ]
        
        layoutConstraint.last?.priority = 249
        NSLayoutConstraint.activate(layoutConstraint)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configureTextFieldCell() -> () {
        setNeedsUpdateConstraints()
        updateConstraintsIfNeeded()
        
    }

}


