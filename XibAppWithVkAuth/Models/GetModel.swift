//
//  GetModel.swift
//  XibAppWithVkAuth
//
//  Created by Светлана Мухина on 03.04.2022.
//

import Foundation


struct GetModel {
    let urlPhoto: String
    let date: Int
    
    init(info: PhotoItems) {
        date = info.date
        urlPhoto = info.sizes.last!.url
    }

}
