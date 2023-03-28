// ImageAPIService.swift
// Copyright © Movie. All rights reserved.

import UIKit

protocol ImageAPIService {
    func getImage(posterURL: String, completion: @escaping (Result<UIImage, Error>) -> ())
}
