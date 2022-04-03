//
//  Models.swift
//  XibAppWithVkAuth
//
//  Created by Светлана Мухина on 02.04.2022.
//

import Foundation


struct Models: Decodable {
    var response: Items
}
struct Items: Decodable {
    var items: [PhotoItems]
}
struct PhotoItems: Decodable {
    var date: Int
    var sizes: [Sizes]
}
struct Sizes: Decodable {
    var url: String
}
