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
  var vendorDescription: String
  var image: String?
  var discount: Double?
  var discountDescription: String
  var rating: Double?
  var lat: Double?
  var long: Double?

  enum CodingKeys: String, CodingKey {
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

extension Annotation {
  func mapToViewModel() -> VendorPopupViewModel {
    return VendorPopupViewModel(vendorId: "1", vendorName: vendor, vendorImageUrl: image ?? "", rating: rating ?? 0, vendorDescription: vendorDescription, activeDeals: discountDescription)
  }
}
