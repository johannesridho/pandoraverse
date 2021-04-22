//
//  Repository.swift
//  Meteora
//
//  Created by Phuong Vo on 22/4/21.
//

import CoreLocation
import Foundation
import HDAugmentedReality

class Repository: NSObject {
    static let shared = Repository()

    private let maxRating = 5
    private var altitude: Double {
        drand48() * altitudeDelta
    }

    private let altitudeDelta: Double = 0

    func fetchAnnotation() -> [ARAnnotation] {
        generateAnnotationAround()
    }

    func fetchLocalAnnotation() -> [ARAnnotation] {
        guard let url = Bundle.main.url(forResource: "annotations", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let annotations = try? JSONDecoder().decode([Annotation].self, from: data)
        else {
            return [ARAnnotation]()
        }
        return annotations.compactMap {
            PandaAnnotation(
                annotation: $0,
                type: PandaAnnotationType.allCases.randomElement()!
            )
        }
    }

    func generateAnnotationAround() -> [ARAnnotation] {
        let lat = 1.2918981
        let lon = 103.8382425
        let deltaLat = 0.2 // Area in which to generate annotations
        let deltaLon = 0.2 // Area in which to generate annotations
        let annotationCount = 200
        return getDummyAnnotations(
            centerLatitude: lat,
            centerLongitude: lon,
            deltaLat: deltaLat,
            deltaLon: deltaLon,
            altitudeDelta: altitudeDelta,
            count: annotationCount
        )
    }
}

extension Repository {
    func getDummyAnnotations(
        centerLatitude: Double,
        centerLongitude: Double,
        deltaLat: Double,
        deltaLon: Double,
        altitudeDelta _: Double,
        count: Int
    ) -> [ARAnnotation] {
        var annotations: [ARAnnotation] = []

        srand48(2)
        for i in stride(from: 0, to: count, by: 1) {
            var lat = centerLatitude
            var lon = centerLongitude

            let latDelta = -(deltaLat / 2) + drand48() * deltaLat
            let lonDelta = -(deltaLon / 2) + drand48() * deltaLon
            lat = lat + latDelta
            lon = lon + lonDelta

            if let annotation = PandaAnnotation(
                annotation: Annotation(
                    name: "Panda \(i)",
                    lat: lat,
                    long: lon,
                    rating: Double(maxRating) * drand48(),
                    discount: drand48()
                ),
                type: PandaAnnotationType.allCases.randomElement()!
            ) {
                annotations.append(annotation)
            }
        }
        return annotations
    }

    func addDummyAnnotation(
        _ lat: Double,
        _ lon: Double,
        altitude: Double,
        title: String,
        annotations: inout [ARAnnotation]
    ) {
        let location = CLLocation(
            coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lon),
            altitude: altitude,
            horizontalAccuracy: 0,
            verticalAccuracy: 0,
            course: 0,
            speed: 0,
            timestamp: Date()
        )
        if let annotation = ARAnnotation(identifier: nil, title: title, location: location) {
            annotations.append(annotation)
        }
    }
}
