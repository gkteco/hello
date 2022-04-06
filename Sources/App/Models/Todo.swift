import Fluent
import Vapor

final class Todo: Model, Content {
    static let schema = "Todos"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "Title")
    var title: String
    
    @OptionalField(key: "Desc")
    var description: String?
    
    @Parent(key: "User_id")
    var user: User

    init() { }

    init(id: UUID? = nil, title: String, description: String?, user: User) {
        self.id = id
        self.title = title
        self.description = description
        self.$user.id = user.id!
    }
}
