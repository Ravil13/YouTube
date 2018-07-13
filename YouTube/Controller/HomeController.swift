//
//  ViewController.swift
//  YouTube
//
//  Created by Равиль Вильданов on 10.07.2018.
//  Copyright © 2018 Равиль Вильданов. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var videos: [Video] = {
        var kanyeChannel = Channel()
        kanyeChannel.name = "KanyeIsTheBestChannel"
        kanyeChannel.profileImageName = "kanye_profile"
        
        var blankSpace = Video()
        blankSpace.thumbNailImageName = "taylor_swift_blank_space"
        blankSpace.title = "Taylor Swift - Blank Space"
        blankSpace.channel = kanyeChannel
        blankSpace.numberOfViews = 1_937_432_879
        
        var badBlood = Video()
        badBlood.thumbNailImageName = "taylor_swift_bad_blood"
        badBlood.title = "Taylor Swift - Bad Blood featuring Kendrick Lamar"
        badBlood.channel = kanyeChannel
        badBlood.numberOfViews = 4_453_894_431
        
        return [blankSpace, badBlood]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Home"
        navigationController?.navigationBar.isTranslucent = false
        
        let titleLable = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLable.text = "Home"
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
    
    @objc func handleMore() {
        print("handle more")
    }
    
    @objc func handleSearch() {
        print("handle search")
    }
    
    private func setupMenuBar() {
        view.addSubview(menuBar)
        view.addConstraintsWith(format: "H:|[v0]|", views: menuBar)
        view.addConstraintsWith(format: "V:|[v0(50)]", views: menuBar)
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


















