//
//  RatingsModel.swift
//  OpenMovieDB
//
//  Created by devdchaudhary on 14/02/23.
//

import Foundation

struct RatingsModel: Decodable {
    
    var uid: UUID
    var source: String
    var value: String
    
    init(_ data: [String : Any]) {
        
        uid = UUID()
        source = data["Source"] as? String ?? ""
        value = data["Value"] as? String ?? ""
    }
}
