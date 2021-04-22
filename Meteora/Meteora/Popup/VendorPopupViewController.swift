//
//  VendorPopupViewController.swift
//  Meteora
//
//  Created by Giorgy Gunawan on 22/4/21.
//

import UIKit
import MapKit

protocol VendorPopupViewControllerDelegate: AnyObject {
  func onNavigateTapped(viewModel: VendorPopupViewModel)
}

class VendorPopupViewController: UIViewController {
  @IBOutlet weak var vendorPopupView: VendorPopupView!
  weak var delegate: VendorPopupViewControllerDelegate?
  var viewModel: VendorPopupViewModel?
  override func viewDidLoad() {
    super.viewDidLoad()
    vendorPopupView.setup(with: viewModel!)
    vendorPopupView.layer.cornerRadius = 8
    vendorPopupView.layer.masksToBounds = true
    vendorPopupView.delegate = self
  }

  public init(viewModel: VendorPopupViewModel) {
    super.init(nibName: "VendorPopupViewController", bundle: nil)
    self.viewModel = viewModel
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }

  private func setUpConstraints() {
  }
}

extension VendorPopupViewController: VendorPopupViewDelegate {
  /// More details
  func onButtonPrimaryTapped() {
    guard let annotation = viewModel?.annotation else {
      return
    }
    vendorPopupView?.isHidden = true
    let vc = RDPViewController(annotation: annotation, delegate: self)
    vc.modalPresentationStyle = .overCurrentContext
    present(vc, animated: false, completion: nil)
  }

  func onButtonSecondaryTapped(viewModel: VendorPopupViewModel) {
    self.dismiss(animated: true, completion: nil)
    delegate?.onNavigateTapped(viewModel: viewModel)
  }

  func onCloseButtonTapped() {
    self.dismiss(animated: true, completion: nil)
  }
}

extension VendorPopupViewController: RDPViewControllerDelegate {
  func didClosed() {
    dismiss(animated: false, completion: nil)
  }
}
