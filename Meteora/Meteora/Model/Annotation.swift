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
  var id: String
  var vendor: String
  var vendorDescription: String
  var image: String?
  var discount: Double?
  var discountDescription: String
  var rating: Double?
  var lat: Double?
  var long: Double?

  enum CodingKeys: String, CodingKey {
    case id
    case vendorDescription = "vendor_description"
    case vendor
    case image
    case discount
    case discountDescription = "discount_description"
    case rating
    case lat
    case long
  }
}
