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
    private(set) var type: PandaAnnotationType
    private var annotation: Annotation
    private let altitudeDelta: Double = 0

    public init?(
        annotation: Annotation,
        type: PandaAnnotationType = .default
    ) {
        self.type = type
        self.annotation = annotation

        let location = CLLocation(
            coordinate: CLLocationCoordinate2D(latitude: annotation.lat, longitude: annotation.long),
            altitude: altitudeDelta * drand48(), // TODO: check again
            horizontalAccuracy: 1,
            verticalAccuracy: 1,
            course: 0,
            speed: 0,
            timestamp: Date()
        )
        super.init(identifier: nil, title: annotation.name, location: location)
    }

    public var radarAnnotationTintColor: UIColor? {
        return type.tintColor
    }
}

enum PandaAnnotationType: CaseIterable {
    case `default`

    var icon: UIImage? {
        UIImage(named: "circlepanda")
    }

    var title: String {
        "Panda"
    }

    var tintColor: UIColor {
        .clear
    }
}
