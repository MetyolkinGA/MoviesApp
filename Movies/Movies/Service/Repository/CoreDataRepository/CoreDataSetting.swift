// CoreDataSetting.swift
// Copyright © Movie. All rights reserved.

import CoreData

final class SettingCoreData {
    // MARK: - Internal Propeties

    lazy var managedContext = storeContainer.viewContext

    // MARK: - Privarte Properties

    private let modelName: String

    private lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.modelName)
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        }
        container.viewContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
        container.viewContext.shouldDeleteInaccessibleFaults = true
        container.viewContext.automaticallyMergesChangesFromParent = true
        return container
    }()

    // MARK: - Initializers

    init(modelName: String) {
        self.modelName = modelName
    }

    // MARK: - Internal Methods

    func saveContext() {
        guard managedContext.hasChanges else { return }
        managedContext.performAndWait {
            if managedContext.hasChanges {
                do {
                    try managedContext.save()
                    print("Все сохранилось!!!!!!!!!🍄")
                } catch {
                    managedContext.rollback()
                    print("Все Нихуя!!!!!!!!!🔥")
                }
            }
            managedContext.reset()
        }
    }
}
