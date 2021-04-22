//
//  VendorPopupViewController.swift
//  Meteora
//
//  Created by Giorgy Gunawan on 22/4/21.
//

import UIKit

class VendorPopupViewController: UIViewController {
  @IBOutlet weak var containerView: UIView!
  var popupView: VendorPopupView?
    override func viewDidLoad() {
      super.viewDidLoad()
    }

  public init(viewModel: VendorPopupViewModel) {
    super.init(nibName: "VendorPopupViewController", bundle: nil)
    let view = VendorPopupView()
    view.setup(with: viewModel)
    popupView = view
    setUpConstraints()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    let view = VendorPopupView()
    popupView = view
    setUpConstraints()
  }

  private func setUpConstraints() {
    guard let popupView = popupView else { return }
    containerView.addSubview(popupView)
    NSLayoutConstraint.activate([
      view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
      view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
      view.topAnchor.constraint(equalTo: containerView.topAnchor),
      view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
    ])
  }
}
