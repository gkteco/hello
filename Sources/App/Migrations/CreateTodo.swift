import Fluent

struct CreateTodo: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("Todos")
            .id()
            .field("Title", .custom("character varying(100)"), .required)
            .field("Desc", .custom("character varying(100)"))
            .field("User_id", .uuid, .required, .references("User", "id"))
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("Todos").delete()
    }
}
