//
//  CollectionViewProductCell.swift
//  Artistico
//
//  Created by kaushal on 12/19/16.
//  Copyright © 2016 kaushal. All rights reserved.
//

import UIKit

class CollectionViewProductCell: UICollectionViewCell {
    
    var didSetConstraints:Bool = false;
    var estimatedCellSize:CGSize = CGSize(width: 150, height: 150)
    var productView:UIView! = UIView.init(frame: CGRect.zero)
    var productImageView:UIImageView! = UIImageView()
    var productName:UILabel! = UILabel()
    var productActualPrice:UILabel! = UILabel()
    var productDiscountPrice:UILabel! = UILabel()
    var productDiscount:UILabel! = UILabel()
    var favouriteButton:UIButton! = UIButton()
    var addToCardButton:UIButton! = UIButton()
    
    var layoutConstraint = [NSLayoutConstraint]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        // collection view
            
    }
    
    override class var requiresConstraintBasedLayout: Bool {
        return true
    }
    
    override func prepareForReuse() {
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        productView.translatesAutoresizingMaskIntoConstraints = false
        productName.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(productView)
        contentView.addSubview(productName)
        setupView()
        
    }
    
    func setupView() -> Void {
        productView.backgroundColor = UIColor.yellow
    }
    
    override var intrinsicContentSize: CGSize {
        return self.estimatedCellSize
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
            productView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            productView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            productView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            productView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
   
            
            productName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            productName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20)
        ]
        NSLayoutConstraint.activate(layoutConstraint)
    }
    
    func configureProductCell(withProduct product:Dictionary<String, Any>) -> () {
        
        if let title = product["title"] as? String {
            productName.text = title
        } else {
            productName.text = "test Product"
        }
        setNeedsUpdateConstraints()
    }
    
}
