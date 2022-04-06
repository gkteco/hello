//
//  File.swift
//  
//
//  Created by Gianni Crivello on 4/5/22.
//

import Vapor
import Fluent

struct UserController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let users = routes.grouped("users")
        users.post(use: create)
        users.group(":userName") { usr in
            usr.get(use: get)
            
        }
    }
    
    func get(req: Request) throws -> EventLoopFuture<User> {
        return User.query(on: req.db)
            .filter(\.$userName == req.parameters.get("userName") ?? "NA")
            .first()
            .unwrap(or: Abort(.notFound))
    }
    
    func create(req: Request) throws -> EventLoopFuture<User> {
        let user = try req.content.decode(User.self)
        return user.create(on: req.db).map { user }
    }
}
