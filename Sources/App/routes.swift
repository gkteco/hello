import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req in
        return "it works!"
    }
    app.get("hello", ":msg") { req -> EventLoopFuture<String> in
        
        let prom = req.eventLoop.makePromise(of: String.self)
        
        //query string param
        let msg: String = req.parameters.get("msg") ?? "ANON"
        prom.succeed("Hello \(msg)")
        
        return prom.futureResult
    }
    
    app.post("hello") { req -> EventLoopFuture<String> in
        let dto = try req.content.decode(ToDo.self)
        let prom = req.eventLoop.makePromise(of: String.self)
        
        //content
        print("dto \(dto)")
        prom.succeed("ToDO: \(dto.title)")
        
        return prom.futureResult
    }
    try app.register(collection: UserController())
    try app.register(collection: TodoController())
    
}
