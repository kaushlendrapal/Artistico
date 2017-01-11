//
//  CollectionViewProductCell.swift
//  Artistico
//
//  Created by kaushal on 12/19/16.
//  Copyright © 2016 kaushal. All rights reserved.
//

import UIKit
import Firebase

class CollectionViewProductCell: UICollectionViewCell {
    
    var didSetConstraints:Bool = false;
    var estimatedCellSize:CGSize = CGSize(width: 150, height: 180)
    var productView:UIView! = UIView.init(frame: CGRect.zero)
    var productImageView:UIImageView! = UIImageView()
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView.init(activityIndicatorStyle: .gray)
    var productName:UILabel! = UILabel()
    var productActualPrice:UILabel! = UILabel()
    var productDiscountPrice:UILabel! = UILabel()
    var productDiscount:UILabel! = UILabel()
    var favouriteButton:UIButton! = UIButton()
//    var addToCardButton:UIButton! = UIButton()
    
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
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        productName.translatesAutoresizingMaskIntoConstraints = false
        productActualPrice.translatesAutoresizingMaskIntoConstraints = false
        productDiscountPrice.translatesAutoresizingMaskIntoConstraints = false
        productDiscount.translatesAutoresizingMaskIntoConstraints = false
        favouriteButton.translatesAutoresizingMaskIntoConstraints = false
        
        productImageView.addSubview(activityIndicator)
        productView.addSubview(productImageView)
        productView.addSubview(productName)
        productView.addSubview(productActualPrice)
        productView.addSubview(productDiscountPrice)
        productView.addSubview(productDiscount)
        productView.addSubview(favouriteButton)
        contentView.addSubview(productView)
        
        setupView()
        addConstraintsForSubView()
        didSetConstraints = true
        
    }
    
    func setupView() -> Void {
        productView.backgroundColor = UIColor.white
        favouriteButton.setImage(UIImage.init(named: "favorite_enabled"), for: .normal)
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
            productView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant:0),
            
            productImageView.topAnchor.constraint(equalTo: productView.topAnchor, constant: 10),
            productImageView.centerXAnchor.constraint(equalTo: productView.centerXAnchor, constant:0),
            productImageView.widthAnchor.constraint(equalToConstant: 45.0),
            productImageView.heightAnchor.constraint(equalToConstant: 45.0),
            
            activityIndicator.centerXAnchor.constraint(equalTo: productImageView.centerXAnchor, constant:0),
            activityIndicator.centerYAnchor.constraint(equalTo: productImageView.centerYAnchor, constant:0),
            
            productName.leadingAnchor.constraint(equalTo: productView.leadingAnchor, constant: 10),
            productName.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 10),
            productName.trailingAnchor.constraint(greaterThanOrEqualTo: productView.trailingAnchor, constant: -10),
            
            productDiscountPrice.leadingAnchor.constraint(equalTo: productName.leadingAnchor, constant: 0),
            productDiscountPrice.topAnchor.constraint(equalTo: productName.bottomAnchor, constant: 5),
            
            productActualPrice.centerYAnchor.constraint(equalTo: productDiscountPrice.centerYAnchor, constant: 0),
            productActualPrice.trailingAnchor.constraint(equalTo: productView.trailingAnchor, constant:-10),
            
            productDiscount.leadingAnchor.constraint(equalTo: productDiscountPrice.leadingAnchor, constant: 0),
            productDiscount.topAnchor.constraint(equalTo: productDiscountPrice.bottomAnchor, constant: 10),
            productDiscount.bottomAnchor.constraint(greaterThanOrEqualTo: productView.bottomAnchor, constant: -10),
            
            favouriteButton.centerYAnchor.constraint(equalTo: productDiscount.centerYAnchor, constant: 0),
            favouriteButton.widthAnchor.constraint(equalToConstant: 35),
            favouriteButton.heightAnchor.constraint(equalToConstant: 35),
            favouriteButton.trailingAnchor.constraint(equalTo:productView.trailingAnchor, constant:-10)
            
        ]
        NSLayoutConstraint.activate(layoutConstraint)
       let actualPriceLeading = productActualPrice.leadingAnchor.constraint(greaterThanOrEqualTo: productDiscountPrice.trailingAnchor, constant:5)
        actualPriceLeading.priority = 250
        actualPriceLeading.isActive = true
        
       let favButtonLeading = favouriteButton.leadingAnchor.constraint(greaterThanOrEqualTo: productDiscount.trailingAnchor, constant: 5)
        favButtonLeading.priority = 250
        favButtonLeading.isActive = true

    }
    
    func configureProductCell(withProduct product:Dictionary<String, Any>) -> () {
        
        if let title = product["title"] as? String {
            productName.text = title
        } else {
            productName.text = "test Product"
        }
        
        productActualPrice.text = "₨ 500"
        productDiscountPrice.text = "₨ 350"
        productDiscount.text = "25% off"
        if let imageURL = product["thumbImage"] as? String {
            if imageURL.hasPrefix("gs://") {
                self.activityIndicator.startAnimating()
                FIRStorage.storage().reference(forURL:imageURL).data(withMaxSize: INT64_MAX){[unowned self] (data, error) in
                    if let error = error {
                        print("Error downloading: \(error)")
                        return
                    }
                    self.productImageView.image = UIImage.init(data: data!)
                    self.activityIndicator.stopAnimating()
                }
            }
        }
        
        setNeedsUpdateConstraints()
    }
    
}
