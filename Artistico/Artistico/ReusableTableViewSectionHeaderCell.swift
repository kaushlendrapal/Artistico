//
//  ReusableTableViewSectionHeaderCell.swift
//  Artistico
//
//  Created by kaushal on 12/19/16.
//  Copyright © 2016 kaushal. All rights reserved.
//

import UIKit

class TableViewSectionHeaderTitleCell: UITableViewCell {
    
    var didSetConstraints:Bool = false;
    var estimatedCellHeight:CGFloat = CGFloat(65)
    var label:UILabel! = UILabel()
    var layoutConstraint = [NSLayoutConstraint]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(label)
        setupView()
    }
    
    func setupView() -> Void {
        label.textColor      =   UIColor.white
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
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0),
            label.widthAnchor.constraint(equalToConstant: 250),
            label.heightAnchor.constraint(equalToConstant: 35)
        ]
        
        NSLayoutConstraint.activate(layoutConstraint)
        
    }
    

}
