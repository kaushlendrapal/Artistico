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
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView.init(activityIndicatorStyle: .gray)
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
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        if reuseIdentifier != Global.kEmptyString && reuseIdentifier == "SubCategoryTableViewCell" {
            contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 65).isActive = true
        }
        
        subCategoryName.translatesAutoresizingMaskIntoConstraints = false
        subCategoryImageView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        setContentHuggingPriority(755, for: .vertical)
        setContentCompressionResistancePriority(249, for: .vertical)
        contentView.addSubview(subCategoryName)
        subCategoryImageView.addSubview(activityIndicator)
        contentView.addSubview(subCategoryImageView)
        subCategoryImageView.contentMode = .scaleAspectFit
        activityIndicator.center = subCategoryImageView.center
        setupView()
        addConstraintsForSubView()
        didSetConstraints = true
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    func setupView() -> Void {
        
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIViewNoIntrinsicMetric, height:estimatedCellHeight)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.layoutIfNeeded()
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
                subCategoryImageView.bottomAnchor.constraint(greaterThanOrEqualTo: contentView.bottomAnchor, constant: 20) ,
                subCategoryImageView.heightAnchor.constraint(equalToConstant: 45),
                subCategoryImageView.widthAnchor.constraint(equalToConstant: 45),
                subCategoryName.leadingAnchor.constraint(equalTo: subCategoryImageView.trailingAnchor, constant: 30),
                subCategoryName.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant:0),
                subCategoryName.trailingAnchor.constraint(greaterThanOrEqualTo: contentView.trailingAnchor, constant: 20),
                activityIndicator.centerXAnchor.constraint(equalTo: subCategoryImageView.centerXAnchor, constant:0),
                activityIndicator.centerYAnchor.constraint(equalTo: subCategoryImageView.centerYAnchor, constant:0)
            ]
        layoutConstraint[2].priority = 750
        NSLayoutConstraint.activate(layoutConstraint)
    }
    
    func configureCategoryCell() -> () {
        setNeedsUpdateConstraints()
        setNeedsLayout()
    }

}
