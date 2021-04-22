//
//  PandaAnnotation.swift
//  Meteora
//
//  Created by Phuong Vo on 22/4/21.
//

import CoreLocation
import HDAugmentedReality
import UIKit

class PandaAnnotation: ARAnnotation, RadarAnnotation {
  let defaultVendorImag = UIImage(named: "circlepanda")
  private var annotation: Annotation
  private let altitudeDelta: Double = 0

  public init?(annotation: Annotation) {
    self.annotation = annotation

    let location = CLLocation(
      coordinate: CLLocationCoordinate2D(latitude: annotation.lat ?? 0, longitude: annotation.long ?? 0),
      altitude: altitudeDelta * drand48(), // TODO: check again
      horizontalAccuracy: 1,
      verticalAccuracy: 1,
      course: 0,
      speed: 0,
      timestamp: Date()
    )
    super.init(identifier: nil, title: annotation.vendor, location: location)
  }

  var vendor: String? {
    annotation.vendor
  }

  var image: UIImage? {
    UIImage(named: annotation.image ?? "circlepanda") ?? UIImage(named: "circlepanda")
  }

  var discount: Double? {
    annotation.discount
  }

  var rating: Double? {
    return annotation.rating
  }
}
