//
//  ViewController.swift
//  YouTube
//
//  Created by Равиль Вильданов on 10.07.2018.
//  Copyright © 2018 Равиль Вильданов. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var videos: [Video] = []
    
    func fetchVideos() {
        ApiService.shared.fetchVideo { (videos) in
            self.videos = videos
            self.collectionView?.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchVideos()
        
        navigationController?.navigationBar.isTranslucent = false
        
        let titleLable = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLable.text = "  Home"
        titleLable.textColor = .white
        titleLable.font = UIFont.systemFont(ofSize: 24)
        navigationItem.titleView = titleLable
        
        collectionView?.backgroundColor = .white
        collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: "cellID")
        collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0) // to be under menuBar
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
        
        setupMenuBar()
        setupNavBarButtons()
    }
    
    let menuBar: MenuBar = {
        let mb = MenuBar()
        return mb
    }()
    
    private func setupNavBarButtons() {
        let searchImage = UIImage(named: "search_icon")?.withRenderingMode(.alwaysOriginal)
        let searchBarButtonItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
        
        let moreImage = UIImage(named: "nav_more_icon")?.withRenderingMode(.alwaysOriginal)
        let moreBarButtonItem = UIBarButtonItem(image: moreImage, style: .plain, target: self, action: #selector(handleMore))
        navigationItem.rightBarButtonItems = [moreBarButtonItem, searchBarButtonItem]
    }
    
    lazy var settingsLauncer: SettingsLauncher = {
        let launcher = SettingsLauncher()
        launcher.homeController = self
        return launcher
    }()
    
    @objc func handleMore() {
        // show menu
        settingsLauncer.showSettings()
    }
    
    func showControllerFor(setting: Setting) {
        let dummySettingsViewController = UIViewController()
        dummySettingsViewController.navigationItem.title = setting.name.rawValue
        dummySettingsViewController.view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        navigationController?.pushViewController(dummySettingsViewController, animated: true)
    }
    
    @objc func handleSearch() {
        print("handle search")
    }
    
    private func setupMenuBar() {
        navigationController?.hidesBarsOnSwipe = true
        
        let redView = UIView()
        redView.backgroundColor = UIColor.rgb(230, 32, 31)
        view.addSubview(redView)
        view.addConstraintsWith(format: "H:|[v0]|", views: redView)
        view.addConstraintsWith(format: "V:[v0(50)]", views: redView)
        
        view.addSubview(menuBar)
        view.addConstraintsWith(format: "H:|[v0]|", views: menuBar)
        view.addConstraintsWith(format: "V:[v0(50)]", views: menuBar)
        
        menuBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! VideoCell
        cell.video = videos[indexPath.item]
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.width - 16 - 16) * 9/16 // 16 from left and right.
        return CGSize(width: view.frame.width, height: height + 16 + 88) // 16 from the top, 68 is botom constraints
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}


















