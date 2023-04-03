// ImageAPIService.swift
// Copyright © Movie. All rights reserved.

import UIKit

protocol ImageAPIService {
    func loadImageData(urlPhoto: String, completion: @escaping (Result<Data, Error>) -> ())
}
