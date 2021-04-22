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

open class PandaAnnotationView: ARAnnotationView, UIGestureRecognizerDelegate {
    open var backgroundImageView: UIImageView?
    open var gradientImageView: UIImageView?
    open var iconImageView: UIImageView?
    open var titleLabel: UILabel?
    open var arFrame = CGRect.zero // Just for test stacking
    override open weak var annotation: ARAnnotation? { didSet { self.bindAnnotation() } }

    override open func initialize() {
        super.initialize()
        loadUi()
    }

    override open func didMoveToSuperview() {
        super.didMoveToSuperview()
        if superview != nil { startRotating() }
        else { stopRotating() }
    }

    /// We are creating all UI programatically because XIBs are heavyweight.
    func loadUi() {
        let image = UIImage(named: "annotationViewBackground")?.resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 30), resizingMode: .stretch)
        let gradientImage = UIImage(named: "annotationViewGradient")?.withRenderingMode(.alwaysTemplate)

        // Gradient
        let gradientImageView = UIImageView()
        gradientImageView.contentMode = .scaleAspectFit
        gradientImageView.image = gradientImage
        addSubview(gradientImageView)
        self.gradientImageView = gradientImageView

        // Background
        let backgroundImageView = UIImageView()
        backgroundImageView.image = image
        addSubview(backgroundImageView)
        self.backgroundImageView = backgroundImageView

        // Icon
        let iconImageView = UIImageView()
        iconImageView.contentMode = .scaleAspectFit
        addSubview(iconImageView)
        self.iconImageView = iconImageView

        // Title label
        titleLabel?.removeFromSuperview()
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.numberOfLines = 0
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.white
        addSubview(label)
        titleLabel = label

        // Gesture
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(TestAnnotationView.tapGesture))
        addGestureRecognizer(tapGesture)

        // Other
        backgroundColor = UIColor.clear

        if annotation != nil { bindUi() }
    }

    func bindAnnotation() {
        guard let annotation = self.annotation as? PandaAnnotation else { return }
        let type = annotation.type

        let icon = type.icon
        let tintColor = type.tintColor

        gradientImageView?.tintColor = tintColor
        iconImageView?.tintColor = tintColor
        iconImageView?.image = icon
    }

    func layoutUi() {
        let height = frame.size.height

        backgroundImageView?.frame = bounds

        iconImageView?.frame.size = CGSize(width: 20, height: 20)
        iconImageView?.center = CGPoint(x: height / 2, y: height / 2)

        gradientImageView?.frame.size = CGSize(width: 40, height: 40)
        gradientImageView?.center = CGPoint(x: height / 2, y: height / 2)
        gradientImageView?.layer.cornerRadius = (gradientImageView?.frame.size.width ?? 0) / 2
        gradientImageView?.layer.masksToBounds = true

        titleLabel?.frame = CGRect(x: 58, y: 0, width: frame.size.width - 20, height: frame.size.height)
    }

    // This method is called whenever distance/azimuth is set
    override open func bindUi() {
      titleLabel?.text = (annotation as? PandaAnnotation)?.type.title ?? annotation?.title ?? ""
    }

    override open func layoutSubviews() {
        super.layoutSubviews()
        layoutUi()
    }

    @objc open func tapGesture() {
        guard let annotation = self.annotation, let rootViewController = UIApplication.shared.delegate?.window??.rootViewController else { return }

        let alertController = UIAlertController(title: annotation.title, message: "Tapped", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        rootViewController.presentedViewController?.present(alertController, animated: true, completion: nil)
    }

    //==========================================================================================================================================================

    // MARK: Annotations

    //==========================================================================================================================================================
    private func startRotating() {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0
        rotateAnimation.toValue = CGFloat(Double.pi * 2)
        rotateAnimation.isRemovedOnCompletion = false
        rotateAnimation.duration = Double.random(in: 1 ..< 3)
        rotateAnimation.repeatCount = Float.infinity
        gradientImageView?.layer.add(rotateAnimation, forKey: nil)
    }

    private func stopRotating() {
        gradientImageView?.layer.removeAllAnimations()
    }
}
