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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = ColorStyle.backgroundColor
        contentView.addSubview(label)
        contentView.addSubview(textField)
        setupView()
    }
    
    func setupView() -> Void {
        
       label.textColor      =   UIColor.white
       textField.textColor  =   UIColor.white
        
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width:UIViewNoIntrinsicMetric , height:100)
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
        
        label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        label.widthAnchor.constraint(equalToConstant: 150)
        label.heightAnchor.constraint(equalToConstant: 22)
        
        textField.topAnchor.constraint(equalTo: label.topAnchor, constant: 10).isActive = true
        textField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        textField.bottomAnchor.constraint(greaterThanOrEqualTo: contentView.bottomAnchor, constant: 10).isActive = true
        textField.widthAnchor.constraint(equalToConstant: 150)
        textField.heightAnchor.constraint(equalToConstant: 22)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureTextFieldCell() -> () {
        label.text = "User Name"
        textField.text = "kaushal"
        self.updateConstraintsIfNeeded()
    }
}
