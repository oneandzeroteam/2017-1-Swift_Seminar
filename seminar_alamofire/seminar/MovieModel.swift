//
//  MovieModel.swift
//  seminar
//
//  Created by LEOFALCON on 2017. 5. 15..
//  Copyright © 2017년 LeFal. All rights reserved.
//

import Foundation
import ObjectMapper

struct Movie: Mappable {
    
    var rank: String!
    var movieNm: String!
    
    init?(map: Map) {
    }
    
    
    mutating func mapping(map: Map) {
        self.rank <- map["rank"]
        self.movieNm <- map["movieNm"]
    }

}
