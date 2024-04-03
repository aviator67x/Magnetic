//
//  MainView.swift
//  Magnetic
//
//  Created by Andrew Kasilov on 03.04.2024.
//

import Combine
import Foundation
import SnapKit
import UIKit

final class MainView: UIView {
    // - MARK: Views
    private let headerView = UIView()
    private let filterView = UIView()
    private let currentLabel = UILabel()
    private let wifiLabel = UILabel()
    private let readyLabel = UILabel()
    private let scanButton = UIButton()
    private let antispyButton = UIButton()
    private let magnetButton = UIButton()
    private let infraredButton = UIButton()
    private let bluetuthButton = UIButton()

    // - MARK: Private properties
    private let screenSize: CGRect = UIScreen.main.bounds

    // - MARK: Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// - MARK: private extension
private extension MainView {
    func setupViews() {
        backgroundColor = .black

        antispyButton.configuration = configureButton(
            title: "Antispy",
            subtitle: "Tips",
            imageName: "lamp")

        magnetButton.configuration = configureButton(
            title: "Magnetic",
            subtitle: "Detection",
            imageName: "magnet_image")

        infraredButton.configuration = configureButton(
            title: "Infrared",
            subtitle: "Detection",
            imageName: "infrared")

        bluetuthButton.configuration = configureButton(title:
            "Bluetooth",
            subtitle: "Detection",
            imageName: "bluetooth")
    }

    func setupLayout() {
        addSubview(headerView) {
            $0.leading.top.trailing.equalToSuperview()
            $0.height.equalTo(self.screenSize.width / 1.2)
        }
        
        addSubview(filterView) {
            $0.size.equalTo(24)
            $0.top.trailing.equalToSuperview().offset(16)
        }
        
        addSubview(currentLabel) {
            $0.centerX.equalToSuperview()
            $0.height.equalTo(20)
        }
        
        addSubview(wifiLabel) {
            $0.centerX.equalToSuperview()
            $0.height.equalTo(34)
        }
        
        addSubview(readyLabel) {
            $0.centerX.equalToSuperview()
            $0.height.equalTo(20)
        }
        
        addSubview(scanButton) {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }
        
        addSubview(magnetButton) {
            $0.leading.bottom.equalToSuperview().inset(20)
            $0.size.equalTo(screenSize.size.width * 0.4)
        }

        addSubview(antispyButton) {
            $0.trailing.bottom.equalToSuperview().inset(20)
            $0.size.equalTo(screenSize.size.width * 0.4)
        }
        
        addSubview(infraredButton) {
            $0.leading.equalToSuperview().inset(20)
            $0.bottom.equalTo(magnetButton.snp.top).offset(-20)
            $0.size.equalTo(screenSize.size.width * 0.4)
        }
        addSubview(bluetuthButton) {
            $0.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(antispyButton.snp.top).offset(-20)
            $0.size.equalTo(screenSize.size.width * 0.4)
        }
    }

    func configureButton(title: String, subtitle: String, imageName: String) -> UIButton.Configuration {
        var configuration = UIButton.Configuration.filled()
        var container = AttributeContainer()
        container.font = UIFont.systemFont(ofSize: 17)
        configuration.attributedTitle = AttributedString(title, attributes: container)
        configuration.attributedSubtitle = AttributedString(subtitle, attributes: container)
        configuration.image = UIImage(named: imageName)
        configuration.imagePadding = 10
        configuration.imagePlacement = .top
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
        configuration.baseBackgroundColor = UIColor(named: "button")
        configuration.background.cornerRadius = 8

        return configuration
    }
}
