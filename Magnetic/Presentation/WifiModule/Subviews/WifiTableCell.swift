//
//  WifiTableCell.swift
//  Magnetic
//
//  Created by Andrew Kasilov on 03.04.2024.
//

import UIKit

final class WifiTableCell: UITableViewCell {
    // MARK: - SubViews

    private let nameLabel = UILabel()
    private let addressLabel = UILabel()
    private let checkmarkImageView = UIImageView()
    private let icon = UIImageView()

    // MARK: - Life cycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupLayout()
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
        selectionStyle = .none
        backgroundColor = UIColor(named: "tableBackground")

        nameLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        nameLabel.textColor = .white

        addressLabel.textColor = .white
        addressLabel.font = UIFont.systemFont(ofSize: 13)
        addressLabel.alpha = 0.5

        checkmarkImageView.image = UIImage(named: "chevron")
        checkmarkImageView.tintColor = .white
    }

    func setupLayout() {
        contentView.addSubview(icon) {
            $0.leading.equalToSuperview().offset(16)
            $0.top.bottom.equalToSuperview().inset(10)
            $0.size.equalTo(50)
        }
        contentView.addSubview(nameLabel) {
            $0.leading.equalTo(icon.snp.trailing).offset(20)
            $0.height.equalTo(20)
            $0.top.equalTo(icon.snp.top)
        }

        contentView.addSubview(addressLabel) {
            $0.leading.equalTo(icon.snp.trailing).offset(20)
            $0.bottom.equalTo(icon.snp.bottom)
            $0.height.equalTo(20)
        }

        contentView.addSubview(checkmarkImageView) {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
    }
}
