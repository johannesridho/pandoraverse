//
//  StackTestViewController.swift
//  HDAugmentedRealityDemo
//
//  Created by Danijel Huis on 01/03/2017.
//  Copyright © 2017 Danijel Huis. All rights reserved.
//

import UIKit

class StackTestViewController: UIViewController {
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var generationStepper: UIStepper!
    @IBOutlet var generationLabel: UILabel!

    private var annotationViews: [TestAnnotationView] = []
    private var originalAnnotationViews: [TestAnnotationView] = []
    private var step: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        loadUi()
        bindUi()
    }

    func loadUi() {
        edgesForExtendedLayout = []

        //===== Original annotationViews(ones from xib)
        for subview in scrollView.subviews {
            guard let annotationView = subview as? TestAnnotationView else { continue }
            guard !annotationView.isHidden else { continue }
            annotationView.titleLabel?.text = "y: \(annotationView.frame.origin.y)"
            annotationView.arFrame = annotationView.frame
            annotationViews.append(annotationView)
        }

        originalAnnotationViews = annotationViews
    }

    func bindUi() {
        generationLabel.text = "\(generationStepper.value)"
    }

    open func stackAnnotationViews(stepByStep _: Bool) {
        let sortedAnnotationViews = annotationViews.sorted(by: { $0.frame.origin.y > $1.frame.origin.y })

        var i = 0
        for annotationView in sortedAnnotationViews {
            annotationView.titleLabel?.text = "\(i) y: \(annotationView.frame.origin.y)"
            i = i + 1
        }

        for annotationView1 in sortedAnnotationViews {
            var hasCollision = false

            var i = 0
            while i < sortedAnnotationViews.count {
                let annotationView2 = sortedAnnotationViews[i]
                if annotationView1 == annotationView2 {
                    if hasCollision {
                        hasCollision = false
                        i = 0
                        continue
                    }
                    break
                }

                let collision = annotationView1.frame.intersects(annotationView2.frame)

                if collision {
                    annotationView1.frame.origin.y = annotationView2.frame.origin.y - annotationView1.frame.size.height - 5
                    hasCollision = true
                }

                i = i + 1
            }
        }
    }

    func generate() {
        srand48(Int(generationStepper.value))

        let width: CGFloat = 1000
        let height: CGFloat = 1000

        let count: Int = 100

        scrollView.contentSize = CGSize(width: width, height: height)
        scrollView.contentOffset = CGPoint(x: width / 2 - scrollView.frame.size.width / 2, y: height - scrollView.frame.size.height)

        // Clear current annotation views
        annotationViews.forEach { $0.removeFromSuperview() }
        annotationViews.removeAll()

        // Generate new annotation views
        for _ in stride(from: 0, to: count, by: 1) {
            let annotationView = TestAnnotationView()
            annotationView.frame.size.width = 120
            annotationView.frame.size.height = 40
            annotationView.frame.origin.x = CGFloat(drand48()) * (width - annotationView.frame.size.width)
            annotationView.frame.origin.y = height - annotationView.frame.size.height - CGFloat(drand48()) * 300
            annotationView.arFrame = annotationView.frame
            scrollView.addSubview(annotationView)
            annotationViews.append(annotationView)

            let r = CGFloat(drand48() * 200) / CGFloat(255)
            let g = CGFloat(drand48() * 200) / CGFloat(255)
            let b = CGFloat(drand48() * 200) / CGFloat(255)
            let color = UIColor(red: r, green: g, blue: b, alpha: 0.5)
            annotationView.backgroundColor = color

            annotationView.titleLabel?.textColor = UIColor.black
        }
    }

    @IBAction func nextButtonTapped(_: Any) {
        generate()
        stackAnnotationViews(stepByStep: true)
    }

    @IBAction func resetButtonTapped(_: Any) {
        // self.step = 0
        annotationViews.forEach { $0.removeFromSuperview() }
        annotationViews = originalAnnotationViews
        for annotationView in annotationViews {
            scrollView.addSubview(annotationView)
            annotationView.frame = annotationView.arFrame
        }
    }

    @IBAction func stackButtonTapped(_: Any) {
        stackAnnotationViews(stepByStep: false)
    }

    @IBAction func generateButtonTapped(_: Any) {
        generate()
    }

    @IBAction func generationStepperValueChanged(_: Any) {
        bindUi()
    }
}
