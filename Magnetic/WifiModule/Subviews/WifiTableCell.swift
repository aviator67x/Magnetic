//
//  WifiTableCell.swift
//  Magnetic
//
//  Created by Andrew Kasilov on 03.04.2024.
//

import UIKit

final class WifiTableCell: UITableViewCell {
    // MARK: - SubViews

    let nameLabel = UILabel()
    let addressLabel = UILabel()
    let checkmarkImageView = UIImageView()
    let icon = UIImageView()

    // MARK: - Life cycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(_ model: WifiDataModel) {
        icon.image = UIImage(named: model.isAvailable ? "wifi_ok" : "wifi_exclamation")

        nameLabel.text = model.name

        addressLabel.text = model.address
    }
}

// MARK: - private extension

private extension WifiTableCell {
    func setupUI() {
        nameLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)

        checkmarkImageView.image = UIImage(named: "chevron")
        checkmarkImageView.tintColor = .white
    }

    func setupLayout() {
        contentView.addSubview(icon) {
            $0.leading.top.bottom.equalToSuperview()
            $0.size.equalTo(60)
        }
        contentView.addSubview(nameLabel) {
            $0.leading.equalTo(icon.snp.trailing).offset(20)
            $0.height.equalTo(20)
        }

        contentView.addSubview(addressLabel) {
            $0.leading.equalTo(icon.snp.trailing).offset(20)
            $0.top.equalTo(icon.snp.bottom)
            $0.height.equalTo(20)
        }

        contentView.addSubview(checkmarkImageView) {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(24)
        }
    }
}
