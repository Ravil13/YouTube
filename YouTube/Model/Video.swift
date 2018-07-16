//
//  Video.swift
//  YouTube
//
//  Created by Равиль Вильданов on 13.07.2018.
//  Copyright © 2018 Равиль Вильданов. All rights reserved.
//

import UIKit

//class Video: NSObject {
//    var thumbNailImageName: String?
//    var title: String?
//    var numberOfViews: NSNumber?
//    var uploadDate: Date?
//
//    var channel: Channel?
//}
//
//class Channel: NSObject {
//    var name: String?
//    var profileImageName: String?
//}


struct Video: Codable {
    let title: String?
    let numberOfViews: Int?
    let thumbnailImageName: String?
    let channel: Channel?
    let duration: Int?
}

struct Channel: Codable {
    let name: String?
    let profileImageName: String?
}
