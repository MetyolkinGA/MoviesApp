// DataBaseRepositoryImpl.swift
// Copyright © Movie. All rights reserved.

/// Абстракция над репозиторием
class DataBaseRepository<DataBaseEntity> {
    func getData(filterPredicate: String?) -> [DataBaseEntity]? {
        fatalError("Override required")
    }

    func save(object: [DataBaseEntity]) {
        fatalError("Override required")
    }
}
