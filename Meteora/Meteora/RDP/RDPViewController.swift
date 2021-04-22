//
//  RDPViewController.swift
//  Meteora
//
//  Created by Phuong Vo on 22/4/21.
//

import UIKit

protocol RDPViewControllerDelegate: NSObjectProtocol {
  func didClosed()
}

class RDPViewController: UIViewController {

  var annotation: PandaAnnotation? {
    didSet {
      updateAnnotation()
    }
  }
  weak var delegate: RDPViewControllerDelegate?

  public init(annotation: PandaAnnotation, delegate: RDPViewControllerDelegate?) {
    super.init(nibName: "RDPViewController", bundle: nil)
    self.annotation = annotation
    self.delegate = delegate
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }

  @IBOutlet weak var rdpImageView: UIImageView!

  override func viewDidLoad() {
    super.viewDidLoad()
    updateAnnotation()
  }

  @IBAction func close(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
    delegate?.didClosed()
  }

  func updateAnnotation() {
    guard let annotation = annotation else {
      return
    }
    rdpImageView.image = UIImage(named: annotation.annotation.rdpImage ?? "") ?? UIImage(named: "circlepanda")
  }
}
