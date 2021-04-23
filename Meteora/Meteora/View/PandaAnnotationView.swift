//
//  PandaAnnotationView.swift
//  HDAugmentedRealityDemo
//
//  Created by Danijel Huis on 30/04/15.
//  Copyright (c) 2015 Danijel Huis. All rights reserved.
//

import CoreLocation
import HDAugmentedReality
import UIKit

protocol PandaAnnotationViewDelegate: AnyObject {
  func onTapped(_ annotation: PandaAnnotation)
}

open class PandaAnnotationView: ARAnnotationView, UIGestureRecognizerDelegate {
  let expectedHeight: CGFloat = 50
  let expectedWidth: CGFloat = 150
  let trailingCornerRadius: CGFloat = 8

  let titleColor = UIColor(red: 0.20, green: 0.20, blue: 0.20, alpha: 1.00)
  let subtitleColor = UIColor(red: 0.44, green: 0.44, blue: 0.44, alpha: 1.00)
  let primaryColor = UIColor(red: 0.84, green: 0.06, blue: 0.39, alpha: 1.00)

  @IBOutlet weak var ratingView: UIView!
  @IBOutlet weak var discountView: UIView!
  @IBOutlet var iconImageView: UIImageView!
  @IBOutlet var titleLabel: UILabel!
  @IBOutlet weak var discountLabel: UILabel!
  @IBOutlet weak var distanceLabel: UILabel!
  @IBOutlet weak var ratingLabel: UILabel!
  @IBOutlet weak var inforContainer: UIView!

  weak var delegate: PandaAnnotationViewDelegate?

  override open weak var annotation: ARAnnotation? {
    didSet {
      bindAnnotation()
    }
  }

  open override func awakeFromNib() {
    super.awakeFromNib()

    clipsToBounds = true
    inforContainer.layer.cornerRadius = trailingCornerRadius
    inforContainer.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]

    iconImageView.layer.cornerRadius = expectedHeight/2
    iconImageView.clipsToBounds = true

    discountView.clipsToBounds = true
    discountView.layer.cornerRadius = 2

    let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapGesture))
    addGestureRecognizer(tapRecognizer)

    bindAnnotation()
  }

  func bindAnnotation() {
    guard let annotation = annotation as? PandaAnnotation,
          let iconImageView = iconImageView else {
      return
    }
    iconImageView.sd_setImage(
      with: URL(string: annotation.image ?? ""),
      placeholderImage: UIImage(named: "circlepanda"),
      options: [],
      completed: nil
    )

    titleLabel?.text = annotation.vendor
    if let discount = annotation.discount {
      discountLabel.text = "\(Int(discount * 100))%"
      discountView.isHidden = false
    } else {
      discountView.isHidden = true
    }
    if let rating = annotation.rating {
      ratingLabel.text = String(format: "%.1f", rating)
      ratingView.isHidden = false
    } else {
      ratingView.isHidden = true
    }
    let distance = annotation.distanceFromUser > 1000
      ? String(format: "%.1fkm", annotation.distanceFromUser / 1000)
      : String(format: "%.0fm", annotation.distanceFromUser)
    distanceLabel.text = distance
  }

  @objc func tapGesture() {
    guard let annotation = annotation as? PandaAnnotation else {
      return
    }
    delegate?.onTapped(annotation)
  }
}

extension PandaAnnotationView: UIViewNibLoader {}
