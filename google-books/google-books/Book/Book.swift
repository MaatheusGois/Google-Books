//
//  Book.swift
//  google-books
//
//  Created by Matheus Gois on 13/07/19.
//  Copyright © 2019 Matheus Gois. All rights reserved.
//

import Foundation


struct Book: Codable {
    var title:String
    var authors:[String]
    var printType:String //Diz se é Book ou magazine
    var publishedDate:String
    var description:String
    var pageCount:Int
    var language:String
    var id:String
    var link:URL
    var thumbnail:URL //imagem
}
