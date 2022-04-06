//
//  File.swift
//  
//
//  Created by Gianni Crivello on 4/5/22.
//

import Fluent
import Vapor
import SQLKit

struct CreateUser: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("User")
            .id()
            .field("UserName", .custom("character varying(60)"), .required)
            .unique(on: "UserName")
            .create()
    }
    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("User").delete()
    }
}
