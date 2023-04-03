// RealmRepository.swift
// Copyright © Movie. All rights reserved.

import RealmSwift

final class RealmRepository<RealmEntity: Object>: DataBaseRepository<RealmEntity> {
    override func getData(filterPredicate: String?) -> [RealmEntity]? {
        do {
            let realm = try Realm()
            let objects = realm.objects(RealmEntity.self).toArray()
            var entites: [RealmEntity]?
            objects.forEach { movie in
                (entites?.append(movie)) ?? (entites = [movie])
            }
            return entites
        } catch {
            return nil
        }
    }

    override func save(object: [RealmEntity]) {
        do {
            let realm = try Realm()
            let oldData = realm.objects(RealmEntity.self)
            realm.beginWrite()
            realm.delete(oldData)
            realm.add(object, update: .modified)
            try realm.commitWrite()
        } catch {
            print(error.localizedDescription)
        }
    }
}
