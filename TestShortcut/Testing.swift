//
//  Test2.swift
//  TestShortcut
//
//  Created by Daud Mujib on 11/06/2025.
//

import AppIntents

struct TestModel: Identifiable, Hashable, Sendable {
    
    let id: Int
    let name: String
    let imageName: String
    
    init(id: Int, name: String, imageName: String) {
        self.id = id
        self.name = name
        self.imageName = imageName
    }
    
    static func == (lhs: TestModel, rhs: TestModel) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}


struct TestEntity: AppEntity {

    static var typeDisplayRepresentation: TypeDisplayRepresentation {
        TypeDisplayRepresentation(
            name: "Test"
        )
    }
    
    static let defaultQuery = TestEntityQuery()
    
    var id: TestModel.ID
    
    @Property var name: String
    
    var imageName: String
    
    var displayRepresentation: DisplayRepresentation {
        DisplayRepresentation(title: "\(name)",
                              image: DisplayRepresentation.Image(named: imageName)
        )
    }
    
    init(testModel: TestModel) {
        self.id = testModel.id
        self.imageName = testModel.imageName
        self.name = testModel.name
    }
}

struct TestEntityQuery: EntityQuery {
    
    func entities(for identifiers: [TestEntity.ID]) async throws -> [TestEntity] {
        return [
            TestEntity(testModel: TestModel(id: 1, name: "One", imageName: "One")),
            TestEntity(testModel: TestModel(id: 2, name: "Two", imageName: "Two")),
            TestEntity(testModel: TestModel(id: 3, name: "Three", imageName: "Three")),
        ]
    }
    
    func suggestedEntities() async throws -> [TestEntity] {
        return [
            TestEntity(testModel: TestModel(id: 1, name: "One", imageName: "One")),
            TestEntity(testModel: TestModel(id: 2, name: "Two", imageName: "Two")),
            TestEntity(testModel: TestModel(id: 3, name: "Three", imageName: "Three")),
        ]
    }
}

struct TestIntent: AppIntent {
    
    static let title: LocalizedStringResource = "Shortcut testing"
    
    @Parameter(title: "Shortcut", description: "Shortcut testing")
    var testEntity: TestEntity
    
    func perform() async throws -> some IntentResult {
        return .result()
    }
}

class TestShortcuts: AppShortcutsProvider {
    
    static var appShortcuts: [AppShortcut] {
        AppShortcut(intent: TestIntent(), phrases: [
            "Test \(\.$testEntity) with \(.applicationName)"
        ],
        shortTitle: "Shortcut",
        systemImageName: "plus"
        )
    }
}
