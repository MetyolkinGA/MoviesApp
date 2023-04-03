// CoreDataRepository.swift
// Copyright © Movie. All rights reserved.

import CoreData

protocol DatabaseEntityMarkerProtocol: NSManagedObject {}

extension MovieCoreDataModel: DomainModelMarkerProtocol {}

final class CoreDataRepository<CoreDataEntity>: DataBaseRepository<CoreDataEntity> {
    // MARK: - Private Properties

    private let managedContext = AppDelegate.sharedAppDelegate.coreDataStack.managedContext
    private let entitySave = CoreDataSave()

    // MARK: - Internal Methods

    override func save(object: [CoreDataEntity]) {
        if let resultObject = object as? [Movie] {
            entitySave.saveMovieList(
                object: resultObject,
                argumentForPredicateGenre: "",
                context: managedContext
            )
            print("Все сохранилось")
        } else {
            print("Ошибка")
        }
    }

    override func getData(filterPredicate: String?) -> [CoreDataEntity]? {
        let fetchRequest: NSFetchRequest<MovieCoreDataModel> = MovieCoreDataModel.fetchRequest()
        fetchRequest.predicate = NSPredicate(
            format: "%K == %@",
            #keyPath(MovieCoreDataModel.filter),
            filterPredicate ?? String()
        )
        guard let objects = try? managedContext.fetch(fetchRequest) as? [CoreDataEntity] else { return [] }
        print(objects)
        return objects
    }
}
