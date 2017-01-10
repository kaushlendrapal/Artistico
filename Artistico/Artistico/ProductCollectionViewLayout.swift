//
//  ProductCollectionViewLayout.swift
//  Artistico
//
//  Created by kaushal on 12/19/16.
//  Copyright © 2016 kaushal. All rights reserved.
//

import UIKit

enum CollectionViewFlowLayout : Int {
    
    case defaultLayout
    case productLayouy
    case categoryLayout
    
}

class ProductCollectionViewLayout: UICollectionViewFlowLayout {
    
    var flowType:CollectionViewFlowLayout
    
   override init() {
    
        flowType = .defaultLayout
        super.init()
        minimumLineSpacing = 1
        minimumInteritemSpacing = 1
        sectionInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        scrollDirection = .horizontal
        itemSize = CGSize.init(width: 150, height: 180)
    }
    
    init(flowType:CollectionViewFlowLayout) {
        
        self.flowType = flowType
        super.init()
        updateLayoutAttributes(flowType: flowType)
        
    }
    
    func updateLayoutAttributes(flowType:CollectionViewFlowLayout) -> () {
        
        switch flowType {
        case .defaultLayout :
            minimumLineSpacing = 1
            minimumInteritemSpacing = 1
            sectionInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
            scrollDirection = .horizontal
            itemSize = CGSize.init(width: 150, height: 150)
            
        case .productLayouy :
            minimumLineSpacing = 1
            minimumInteritemSpacing = 1
            sectionInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
            scrollDirection = .horizontal
            itemSize = CGSize.init(width: 150, height: 150)
        case .categoryLayout :
            minimumLineSpacing = 1
            minimumInteritemSpacing = 1
            sectionInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
            scrollDirection = .horizontal
            itemSize = CGSize.init(width: 150, height: 180)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
