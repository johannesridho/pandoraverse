//
//  Annotation.swift
//  Meteora
//
//  Created by Phuong Vo on 22/4/21.
//

import Foundation

struct Annotations: Codable {
  var annotations: [Annotation]
}

struct Annotation: Codable {
  var vendor: String
  var image: String?
  var discount: Double?
  var rating: Double?
  var lat: Double?
  var long: Double?
}
