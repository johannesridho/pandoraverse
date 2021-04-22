//
//  VendorPopupView.swift
//  Meteora
//
//  Created by Giorgy Gunawan on 22/4/21.
//

import UIKit
import SDWebImage

struct VendorPopupViewModel {
  let vendorId: String
  let vendorName: String
  let vendorImageUrl: String
  let rating: Double
  let vendorDescription: String
  let activeDeals: String
}

class VendorPopupView: UIView {
  @IBOutlet var contentView: UIView!
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

  let titleColor = UIColor(red: 0.20, green: 0.20, blue: 0.20, alpha: 1.00)
  let subtitleColor = UIColor(red: 0.44, green: 0.44, blue: 0.44, alpha: 1.00)
  let primaryColor = UIColor(red: 0.84, green: 0.06, blue: 0.39, alpha: 1.00)

  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    commonInit()
  }

  private func commonInit() {
    Bundle.main.loadNibNamed("VendorPopupView", owner: self, options: nil)
    addSubview(contentView)
    contentView.frame = self.bounds
    contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]

  }
  override func awakeFromNib() {
    super.awakeFromNib()
    starImageView.image = UIImage(named: "star")
    closeButton.setImage(UIImage(named: "close-button")?.withRenderingMode(.alwaysOriginal), for: .normal)
    closeButton.setTitle(nil, for: .normal)
    closeButton.titleLabel?.isHidden = true
    labelPopupTitle.text = "Vendor info"
    labelPopupTitle.font = UIFont.boldSystemFont(ofSize: 16)
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
    activeDealsDescriptionLabel.text = viewModel.activeDeals
    activeDealsDescriptionLabel.font = UIFont.systemFont(ofSize: 14)
    activeDealsDescriptionLabel.textColor = titleColor

    vendorImageView.sd_setImage(with: URL(string: viewModel.vendorImageUrl), completed: nil)
    vendorImageView.contentMode = .scaleAspectFill
    vendorImageView.layer.cornerRadius = 8
    vendorImageView.layer.masksToBounds = true
  }
}