// RealmSwift.List+Extension.swift
// Copyright © Movie. All rights reserved.

import RealmSwift

extension RealmSwift.List {
    func toArray() -> [Element] {
        map { $0 }
    }
}
