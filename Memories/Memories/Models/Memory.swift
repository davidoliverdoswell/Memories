//
//  Memory.swift
//  Memories
//
//  Created by David Oliver Doswell on 8/1/18.
//  Copyright © 2018 David Oliver Doswell. All rights reserved.
//

import Foundation

struct Memory: Codable, Equatable {
    var title : String
    var bodyText: String
    var imageData: Data
}
