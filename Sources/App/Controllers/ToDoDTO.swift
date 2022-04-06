//
//  File.swift
//  
//
//  Created by Gianni Crivello on 4/5/22.
//

import Vapor

struct ToDo: Content {
    var title: String
    var desc: String?
}
