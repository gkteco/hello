import Fluent
import Vapor

struct TodoController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let todos = routes.grouped("todos")
        todos.get(use: index)
        todos.post(use: create)
        todos.group(":todoID") { todo in
            todo.delete(use: delete)
        }
    }

    func index(req: Request) async throws -> [Todo] {
        try await Todo.query(on: req.db).all()
    }

    func create(req: Request) throws -> EventLoopFuture<Todo> {
        let dto = try req.content.decode(ToDo.self)
        
        return User.query(on: req.db)
            .filter(\.$userName == "gianni")
            .first()
            .unwrap(or: Abort(.notFound))
            .flatMap { usr in
                let todo = Todo(title: dto.title, description: dto.desc, user: usr)
                return todo.create(on: req.db).map { todo }
            }
    }
    
    func delete(req: Request) async throws -> HTTPStatus {
        guard let todo = try await Todo.find(req.parameters.get("todoID"), on: req.db) else {
            throw Abort(.notFound)
        }
        try await todo.delete(on: req.db)
        return .ok
    }
}
