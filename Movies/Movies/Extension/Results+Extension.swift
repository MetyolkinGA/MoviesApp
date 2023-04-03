// Results+Extension.swift
// Copyright © Movie. All rights reserved.

import RealmSwift

extension Results {
    func toArray() -> [Element] {
        map { $0 }
    }
}
