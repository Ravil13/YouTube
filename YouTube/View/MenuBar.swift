//
//  MenuBar.swift
//  YouTube
//
//  Created by Равиль Вильданов on 12.07.2018.
//  Copyright © 2018 Равиль Вильданов. All rights reserved.
//

import UIKit

class MenuBar: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.rgb(230, 32, 31)
        cv.dataSource = self // collectionView must be lazy var to avoid the errors
        cv.delegate = self
        return cv
    }()
    
    let cellId = "cellId"
    let imageNames = ["home", "trending", "subscriptions", "account"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: cellId)
        
        addSubview(collectionView)
        addConstraintsWith(format: "H:|[v0]|", views: collectionView)
        addConstraintsWith(format: "V:|[v0]|", views: collectionView)
        
        // preselect the firs item
        let selectedIndexPath = IndexPath(item: 0, section: 0)
        collectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: [])
        
        setupHorizontalBar()
    }
    
    var horizontalBarleftAnchorConstraint: NSLayoutConstraint?
    
    func setupHorizontalBar() {
        let horizontalBarView = UIView()
        horizontalBarView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        addSubview(horizontalBarView)
        
        horizontalBarView.translatesAutoresizingMaskIntoConstraints = false
        horizontalBarleftAnchorConstraint = horizontalBarView.leftAnchor.constraint(equalTo: leftAnchor)
        horizontalBarleftAnchorConstraint?.isActive = true
        horizontalBarView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        horizontalBarView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/4).isActive = true
        horizontalBarView.heightAnchor.constraint(equalToConstant: 4).isActive = true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let x = CGFloat(indexPath.item) * frame.width / 4
        horizontalBarleftAnchorConstraint?.constant = x
        
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.layoutIfNeeded()
        }, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MenuCell
        cell.imageView.image = UIImage(named: imageNames[indexPath.row])?.withRenderingMode(.alwaysTemplate)
        cell.tintColor = UIColor.rgb(91, 14, 13)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / 4, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0 // to reduce spacing between items
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class MenuCell: BaseCell {
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "home")?.withRenderingMode(.alwaysTemplate)
        iv.tintColor = UIColor.rgb(91, 14, 13)
        return iv
    }()
    
    override var isHighlighted: Bool {
        didSet {
            imageView.tintColor = isHighlighted ? UIColor.white : UIColor.rgb(91, 14, 13)
        }
    }
    
    override var isSelected: Bool {
        didSet {
            imageView.tintColor = isSelected ? UIColor.white : UIColor.rgb(91, 14, 13)
        }
    }
    
    override func setupViews() {
        super.setupViews()
        addSubview(imageView)
        addConstraintsWith(format: "H:[v0(28)]", views: imageView)
        addConstraintsWith(format: "V:[v0(28)]", views: imageView)

        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
//        imageView.frame = CGRect(x: frame.width/2 - 14, y: frame.height/2 - 14, width: 28, height: 28)
    }
}

























