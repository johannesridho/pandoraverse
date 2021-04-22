//
//  VendorPopupView.swift
//  Meteora
//
//  Created by Giorgy Gunawan on 22/4/21.
//

import UIKit

struct VendorPopupViewModel {
  let vendorId: String
  let vendorName: String
  let vendorImageUrl: String
  let rating: Double
  let vendorDescription: String
  let activeDeals: String
}

class VendorPopupView: UIView {
  @IBOutlet weak var closeButton: UIButton!
  @IBOutlet weak var labelPopupTitle: UILabel!
  @IBOutlet weak var vendorImageView: UIImageView!
  @IBOutlet weak var vendorNameLabel: UILabel!

  @IBOutlet weak var starImageView: UIImageView!
  @IBOutlet weak var ratingLabel: UILabel!
  @IBOutlet weak var vendorSubtitle: UILabel!
  @IBOutlet weak var activeDealsLabel: UILabel!
  @IBOutlet weak var activeDealsDescriptionLabel: UILabel!
  @IBOutlet weak var buttonSecondary: UIButton!
  @IBOutlet weak var buttonPrimary: UIButton!

  let titleColor = UIColor(red: 51, green: 51, blue: 51, alpha: 100)
  let subtitleColor = UIColor(red: 112, green: 112, blue: 112, alpha: 100)
  let primaryColor = UIColor(red: 215, green: 15, blue: 100, alpha: 100)
  override func awakeFromNib() {
    super.awakeFromNib()
    starImageView.image = UIImage(named: "star")
    closeButton.setImage(UIImage(named: "close-button"), for: .normal)
    labelPopupTitle.text = "Vendor info"
    labelPopupTitle.font = UIFont.boldSystemFont(ofSize: 14)
    labelPopupTitle.textColor = titleColor
    activeDealsLabel.text = "Active deal"
    activeDealsLabel.font = UIFont.boldSystemFont(ofSize: 14)
    activeDealsLabel.textColor = titleColor

    buttonSecondary.layer.cornerRadius = 8
    buttonSecondary.layer.masksToBounds = true
    buttonSecondary.layer.borderWidth = 1
    buttonSecondary.layer.borderColor = primaryColor.cgColor
    buttonSecondary.backgroundColor = .white
    buttonSecondary.setTitle("Navigate", for: .normal)
    buttonSecondary.setTitleColor(primaryColor, for: .normal)
    buttonPrimary.layer.cornerRadius = 8
    buttonPrimary.layer.masksToBounds = true
    buttonPrimary.backgroundColor = primaryColor
    buttonPrimary.setTitle("More Details", for: .normal)
    buttonPrimary.setTitleColor(.white, for: .normal)
  }

  func setup(with viewModel: VendorPopupViewModel) {
    vendorNameLabel.text = viewModel.vendorName
    vendorNameLabel.font = UIFont.boldSystemFont(ofSize: 14)
    vendorNameLabel.textColor = titleColor
    vendorSubtitle.text = viewModel.vendorDescription
    vendorSubtitle.font = UIFont.systemFont(ofSize: 14)
    vendorSubtitle.textColor = subtitleColor
    ratingLabel.text = viewModel.rating.description
    ratingLabel.font = UIFont.boldSystemFont(ofSize: 14)
    ratingLabel.textColor = titleColor
  }
}
