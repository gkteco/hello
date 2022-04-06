//
//  File.swift
//  
//
//  Created by Gianni Crivello on 4/5/22.
//

import Vapor
import Fluent

 
final class User: Model, Content {
    static let schema: String = "User"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "UserName")
    var userName: String
    
    @Children(for: \.$user)
    var todos: [Todo]
    
    init() {}
    
    init(id: UUID? = nil, userName: String) {
        self.id = id
        self.userName = userName
    }
}

