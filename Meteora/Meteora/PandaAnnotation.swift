//
//  PandaAnnotation.swift
//  Meteora
//
//  Created by Phuong Vo on 22/4/21.
//

import UIKit
import CoreLocation
import HDAugmentedReality

class PandaAnnotation: ARAnnotation, RadarAnnotation {
  var type: PandaAnnotationType

  public init?(
    identifier: String?,
    title: String?,
    location: CLLocation,
    type: PandaAnnotationType = .default
  ) {
    self.type = type
    super.init(identifier: identifier, title: title, location: location)
  }

  public var radarAnnotationTintColor: UIColor? {
    return self.type.tintColor
  }

}

/// This is just test data, in a normal project you would probably get annotation data in json format from some external service.
enum PandaAnnotationType: CaseIterable
{
  case `default`

  var icon: UIImage?
  {
    UIImage(named: "circlepanda")
  }

  var title: String?
  {
    ""
  }

  var tintColor: UIColor
  {
    .clear
  }
}
