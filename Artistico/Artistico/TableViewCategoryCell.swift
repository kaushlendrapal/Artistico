//
//  TableViewCategoryCell.swift
//  Artistico
//
//  Created by kaushal on 12/19/16.
//  Copyright © 2016 kaushal. All rights reserved.
//

import UIKit

class TableViewCategoryCell: UITableViewCell {
    
    var didSetConstraints:Bool = false;
    var estimatedCellHeight:CGFloat = CGFloat(150)
    var collectionView:UICollectionView?
    let flowLayout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
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
        
        flowLayout.minimumLineSpacing = 1
        flowLayout.minimumInteritemSpacing = 1
        flowLayout.sectionInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize.init(width: 150, height: estimatedCellHeight)
        collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout:flowLayout)
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(collectionView!)
        setupView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    func setupView() -> Void {
//            collectionView
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
        
        if let _ = collectionView {
            layoutConstraint += [
                collectionView!.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
                collectionView!.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
                collectionView!.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
                collectionView!.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
                collectionView!.heightAnchor.constraint(greaterThanOrEqualToConstant:estimatedCellHeight)
            ]
        }
        
        NSLayoutConstraint.activate(layoutConstraint)
    }
    
    func configureCategoryCell() -> () {
        setNeedsUpdateConstraints()
    }
    
    func setCollectionViewDataSourceAndDelegate<D: UICollectionViewDataSource & UICollectionViewDelegate>(dataSourceDelegate: D, forRow row: Int) -> () {
        if let _ = collectionView {
            
            collectionView!.delegate = dataSourceDelegate
            collectionView!.dataSource = dataSourceDelegate
            collectionView!.tag = row
            collectionView!.register(CollectionViewProductCell.self, forCellWithReuseIdentifier: "CollectionViewProductCell")
            collectionView!.reloadData()
        }
    }

}
