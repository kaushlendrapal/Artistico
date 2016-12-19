//
//  ReusableTableViewSectionFooterCell.swift
//  Artistico
//
//  Created by kaushal on 12/19/16.
//  Copyright © 2016 kaushal. All rights reserved.
//

import UIKit

class TableViewSectionFooterCell: UITableViewCell {
    
    var didSetConstraints:Bool = false;
    var estimatedCellHeight:CGFloat = CGFloat(65)
    var label:UILabel! = UILabel()
    var layoutConstraint = [NSLayoutConstraint]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
