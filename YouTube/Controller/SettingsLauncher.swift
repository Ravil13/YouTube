//
//  SettingsLauncher.swift
//  YouTube
//
//  Created by Равиль Вильданов on 19.07.2018.
//  Copyright © 2018 Равиль Вильданов. All rights reserved.
//

import UIKit

class SettingsLauncher: NSObject {
    
    let blackView = UIView()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }()
    
    @objc func showSettings() {
        // show menu
        if let window = UIApplication.shared.keyWindow {
            window.addSubview(blackView)
            window.addSubview(collectionView)
            
            let height: CGFloat = 400
            let y = window.frame.height
            collectionView.frame = CGRect(x: 0, y: y, width: window.frame.width, height: height)
            
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            blackView.frame = window.frame
            blackView.alpha = 0
            
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                self.blackView.alpha = 1
                self.collectionView.frame.origin.y = y - height
            }, completion: nil)
            
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
        }
    }
    
    @objc func handleDismiss() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            self.blackView.alpha = 0
            if let window = UIApplication.shared.keyWindow {
                self.collectionView.frame.origin.y = window.frame.height
            }
        }, completion: nil)
    }
    
    override init() {
        super.init()
        
    }
}
