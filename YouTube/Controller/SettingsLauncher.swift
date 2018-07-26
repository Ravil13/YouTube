//
//  SettingsLauncher.swift
//  YouTube
//
//  Created by Равиль Вильданов on 19.07.2018.
//  Copyright © 2018 Равиль Вильданов. All rights reserved.
//

import UIKit

class Setting: NSObject {
    let name: SettingName
    let imageName: String
    
    init(name: SettingName, imageName: String) {
        self.name = name
        self.imageName = imageName
    }
}

enum SettingName: String {
    case cancel = "Cancel" 
    case settings = "Settings"
    case termsPrivacy = "Terms & privacy"
    case sendFeedback = "Send Feedback"
    case help = "Help"
    case switchAccount = "Switch Account"
}

class SettingsLauncher: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let blackView = UIView()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }()
    
    let cellId = "cellId"
    let cellHeight: CGFloat = 50
    
    let settings: [Setting] = {
        return [Setting(name: .settings, imageName: "settings"),
                Setting(name: .termsPrivacy, imageName: "privacy"),
                Setting(name: .sendFeedback, imageName: "feedback"),
                Setting(name: .help, imageName: "help"),
                Setting(name: .switchAccount, imageName: "switch_account"),
                Setting(name: .cancel, imageName: "cancel")]
    }()
    
    var homeController: HomeController?
    
    @objc func showSettings() {
        // show menu
        if let window = UIApplication.shared.keyWindow {
            window.addSubview(blackView)
            window.addSubview(collectionView)
            
            let height: CGFloat = CGFloat(settings.count)  * cellHeight
            let y = window.frame.height
            collectionView.frame = CGRect(x: 0, y: y, width: window.frame.width, height: height)
            
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            blackView.frame = window.frame
            blackView.alpha = 0
            
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                self.blackView.alpha = 1
                self.collectionView.frame.origin.y = y - height
            }, completion: nil)
            
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSettingOrDismiss(setting:))))
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SettingCell
        let setting = settings[indexPath.item]
        cell.setting = setting
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    @objc func handleSettingOrDismiss(setting: Setting) {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            self.blackView.alpha = 0
            if let window = UIApplication.shared.keyWindow {
                self.collectionView.frame.origin.y = window.frame.height
            }
        }) { (isCompleted: Bool) in
            if setting.name != .cancel {
                self.homeController? .showControllerFor(setting: setting)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let setting = self.settings[indexPath.row]
        handleSettingOrDismiss(setting: setting)
    }
    
    override init() {
        super.init()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SettingCell.self, forCellWithReuseIdentifier: cellId)
    }
}
