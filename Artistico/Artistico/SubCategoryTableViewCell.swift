//
//  SubCategoryTableViewCell.swift
//  Artistico
//
//  Created by kaushal on 1/6/17.
//  Copyright © 2017 kaushal. All rights reserved.
//

import UIKit

class SubCategoryTableViewCell: UITableViewCell {
    
    var didSetConstraints:Bool = false;
    var estimatedCellHeight:CGFloat = CGFloat(65)
    var subCategoryName:UILabel = UILabel()
    var subCategoryImageView:UIImageView = UIImageView()
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
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
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        subCategoryName.translatesAutoresizingMaskIntoConstraints = false
        subCategoryImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(subCategoryName)
        subCategoryImageView.addSubview(activityIndicator)
        contentView.addSubview(subCategoryImageView)
        subCategoryImageView.contentMode = .scaleAspectFit
        
        setupView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    func setupView() -> Void {
        
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
                subCategoryImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant:10),
                subCategoryImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
                subCategoryImageView.bottomAnchor.constraint(greaterThanOrEqualTo: contentView.bottomAnchor, constant: 5) ,
//                subCategoryImageView.trailingAnchor.constraint(equalTo: subCategoryName.leadingAnchor, constant: 30),
                subCategoryImageView.heightAnchor.constraint(equalToConstant: 45),
                subCategoryImageView.widthAnchor.constraint(equalToConstant: 45),
                subCategoryName.leadingAnchor.constraint(equalTo: subCategoryImageView.trailingAnchor, constant: 30),
                subCategoryName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
                activityIndicator.centerXAnchor.constraint(equalTo: subCategoryImageView.centerXAnchor, constant: 0),
                activityIndicator.centerYAnchor.constraint(equalTo: subCategoryImageView.centerYAnchor, constant: 0)
            ]
        
        NSLayoutConstraint.activate(layoutConstraint)
    }
    
    func configureCategoryCell() -> () {
        setNeedsUpdateConstraints()
    }

}
