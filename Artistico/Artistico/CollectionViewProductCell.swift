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
    var estimatedCellSize:CGSize = CGSize(width: 200, height: 200)
    weak var productView:UIView! = UIView()
    let flowLayout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
    
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
        
        contentView.addSubview(productView)
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
            productView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0)
        ]
        
        NSLayoutConstraint.activate(layoutConstraint)
    }
    
    func configureProductCell() -> () {
        setNeedsUpdateConstraints()
    }
    
}
