//
//  VendorPopupViewController.swift
//  Meteora
//
//  Created by Giorgy Gunawan on 22/4/21.
//

import UIKit

class VendorPopupViewController: UIViewController {
  @IBOutlet weak var vendorPopupView: VendorPopupView!
  var viewModel: VendorPopupViewModel?
  var popupView: VendorPopupView?
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
  func onButtonPrimaryTapped() {

  }

  func onButtonSecondaryTapped() {

  }

  func onCloseButtonTapped() {
    self.dismiss(animated: true, completion: nil)
  }
}
