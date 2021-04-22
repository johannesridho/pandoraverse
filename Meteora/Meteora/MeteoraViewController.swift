//
//  ViewController.swift
//  Meteora
//
//  Created by Phuong Vo on 22/4/21.
//

import UIKit
import CoreLocation
import MapKit
import HDAugmentedReality

class MeteoraViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
  }

  @IBAction func startDemo(_ sender: UIButton) {
    showARViewController()
  }

  func showARViewController() {
    let wilmerHouse = CLLocationCoordinate2D(latitude: 1.296687, longitude: 103.835418)

    let wilmerHouseLocation = CLLocation(coordinate: wilmerHouse, altitude: 0, horizontalAccuracy: 0, verticalAccuracy: 0, course: 0, speed: 0, timestamp: Date())
    if let wilmerHouseAnnotation = PandaAnnotation(identifier: "wh", title: "wilmerHouse", location: wilmerHouseLocation) {
      arViewController.setAnnotations([wilmerHouseAnnotation])
    }

    arViewController.modalPresentationStyle = .fullScreen
    //    addRadarMapView(to: arViewController)
    self.present(arViewController, animated: true, completion: nil)
  }

  lazy var arViewController: ARViewController = {
    // Creating ARViewController. You can use ARViewController(nibName:bundle:) if you have custom xib.
    let arViewController = ARViewController()

    //===== Presenter - handles visual presentation of annotations
    let presenter = arViewController.presenter!
    // Vertical offset by distance
    presenter.distanceOffsetMode = .manual
    presenter.distanceOffsetMultiplier = 0.05   // Pixels per meter
    presenter.distanceOffsetMinThreshold = 1000 // Tell it to not raise annotations that are nearer than this
    // Limiting number of annotations shown for performance
    presenter.maxDistance = 5000               // Don't show annotations if they are farther than this
    presenter.maxVisibleAnnotations = 100      // Max number of annotations on the screen
    // Telling it to stack vertically.
    presenter.presenterTransform = ARPresenterStackTransform()

    //===== Tracking manager - handles location tracking, heading, pitch, calculations etc.
    // Location precision
    let trackingManager = arViewController.trackingManager
    trackingManager.userDistanceFilter = 15
    trackingManager.reloadDistanceFilter = 50
    //trackingManager.filterFactor = 0.05
    //trackingManager.headingSource = .deviceMotion   // Read headingSource property description before changing.

    //===== ARViewController
    // Ui
    arViewController.dataSource = self
    // Debugging
    arViewController.uiOptions.debugLabel = false
    arViewController.uiOptions.debugMap = true
    arViewController.uiOptions.simulatorDebugging = Platform.isSimulator
    arViewController.uiOptions.setUserLocationToCenterOfAnnotations =  Platform.isSimulator
    // Interface orientation
    arViewController.interfaceOrientationMask = .all
    // Failure handling
    arViewController.onDidFailToFindLocation =
      {
        [weak self, weak arViewController] elapsedSeconds, acquiredLocationBefore in

        self?.handleLocationFailure(elapsedSeconds: elapsedSeconds, acquiredLocationBefore: acquiredLocationBefore, arViewController: arViewController)
      }
    return arViewController
  }()

  func addRadarMapView(to arViewController: ARViewController) {
    var safeArea = UIEdgeInsets.zero
    if #available(iOS 11.0, *) { safeArea = UIApplication.shared.delegate?.window??.safeAreaInsets ?? UIEdgeInsets.zero }

    let radar = RadarMapView()
    radar.startMode = .centerUser(span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    radar.trackingMode = .none
    //radar.configuration... Use it to customize
    radar.indicatorRingType = .segmented(segmentColor: nil, userSegmentColor: nil)
    //radar.indicatorRingType = .precise(indicatorColor: nil, userIndicatorColor: .white)
    //radar.maxDistance = 5000    // Limit bcs it drains battery if lots of annotations (>200), especially if indicatorRingType is .precise
    arViewController.addAccessory(radar, leading: 15, trailing: nil, top: nil, bottom: 15 + safeArea.bottom / 4, width: nil, height: 150)
  }

  func handleLocationFailure(elapsedSeconds: TimeInterval, acquiredLocationBefore: Bool, arViewController: ARViewController?)
  {
    guard let arViewController = arViewController else { return }
    guard !Platform.isSimulator else { return }
    NSLog("Failed to find location after: \(elapsedSeconds) seconds, acquiredLocationBefore: \(acquiredLocationBefore)")

    // Example of handling location failure
    if elapsedSeconds >= 20 && !acquiredLocationBefore
    {
      // Stopped bcs we don't want multiple alerts
      arViewController.trackingManager.stopTracking()

      let alert = UIAlertController(title: "Problems", message: "Cannot find location, use Wi-Fi if possible!", preferredStyle: .alert)
      let okAction = UIAlertAction(title: "Close", style: .cancel)
      {
        (action) in

        self.dismiss(animated: true, completion: nil)
      }
      alert.addAction(okAction)

      presentedViewController?.present(alert, animated: true, completion: nil)
    }
  }
}

// MARK: ARDataSource
extension MeteoraViewController: ARDataSource {
  func ar(_ arViewController: ARViewController, viewForAnnotation annotation: ARAnnotation) -> ARAnnotationView {
    let annotationView = PandaAnnotationView()
    annotationView.frame = CGRect(x: 0,y: 0,width: 150,height: 50)
    return annotationView;
  }

  func ar(_ arViewController: ARViewController, didFailWithError error: Error)
  {
    if let _ = error as? CameraViewError
    {
      let alert = UIAlertController(title: "Error", message: "Failed to initialize camera.", preferredStyle: .alert)
      let okAction = UIAlertAction(title: "Close", style: .cancel)
      {
        (action) in

        self.dismiss(animated: true, completion: nil)
      }
      alert.addAction(okAction)

      self.presentedViewController?.present(alert, animated: true, completion: nil)
    }
  }
}

// MARK: Dummy data
extension MeteoraViewController
{
  public class func getDummyAnnotations(centerLatitude: Double, centerLongitude: Double, deltaLat: Double, deltaLon: Double, altitudeDelta: Double, count: Int) -> Array<ARAnnotation>
  {
    var annotations: [ARAnnotation] = []

    srand48(2)
    for i in stride(from: 0, to: count, by: 1)
    {
      let location = self.getRandomLocation(centerLatitude: centerLatitude, centerLongitude: centerLongitude, deltaLat: deltaLat, deltaLon: deltaLon, altitudeDelta: altitudeDelta)

      if let annotation = TestAnnotation(identifier: nil, title: "POI \(i)", location: location, type: TestAnnotationType.allCases.randomElement()!)
      {
        annotations.append(annotation)
      }
    }
    return annotations
  }

  func addDummyAnnotation(_ lat: Double,_ lon: Double, altitude: Double, title: String, annotations: inout [ARAnnotation])
  {
    let location = CLLocation(coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lon), altitude: altitude, horizontalAccuracy: 0, verticalAccuracy: 0, course: 0, speed: 0, timestamp: Date())
    if let annotation = ARAnnotation(identifier: nil, title: title, location: location)
    {
      annotations.append(annotation)
    }
  }

  public class func getRandomLocation(centerLatitude: Double, centerLongitude: Double, deltaLat: Double, deltaLon: Double, altitudeDelta: Double) -> CLLocation
  {
    var lat = centerLatitude
    var lon = centerLongitude

    let latDelta = -(deltaLat / 2) + drand48() * deltaLat
    let lonDelta = -(deltaLon / 2) + drand48() * deltaLon
    lat = lat + latDelta
    lon = lon + lonDelta

    let altitude = drand48() * altitudeDelta
    return CLLocation(coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lon), altitude: altitude, horizontalAccuracy: 1, verticalAccuracy: 1, course: 0, speed: 0, timestamp: Date())
  }
}
