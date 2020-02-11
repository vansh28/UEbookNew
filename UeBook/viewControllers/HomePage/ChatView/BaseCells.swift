//
//  BaseCells.swift
//  UeBook
//
//  Created by Admin on 20/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class LKBaseTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    /**
     * Overriding a parent method does nothing, but could use for intialising subviews
     * This will be called on at the time of cell intialisation
     */
    func setupViews() {
        
    }
}

class LKBaseCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    /**
     * Overriding a parent method does nothing, but could use for intialising subviews
     * This will be called on at the time of cell intialisation
     */
    func setupViews() {
        
    }
}
