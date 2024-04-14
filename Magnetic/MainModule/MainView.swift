//
//  MainView.swift
//  Magnetic
//
//  Created by Andrew Kasilov on 03.04.2024.
//

import Combine
import CombineCocoa
import Foundation
import SnapKit
import UIKit

enum MainViewActions {
    case magnetDidTAp
    case scanDidTap
}

final class MainView: UIView {
    // - MARK: Views
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let headerView = UIImageView()
    private let backgroundView = UIView()
    private let currentLabel = UILabel()
    private let wifiLabel = UILabel()
    private let readyLabel = UILabel()
    private let scanButton = UIButton()
    private let antispyButton = UIButton()
    private let magnetButton = UIButton()
    private let infraredButton = UIButton()
    private let bluetuthButton = UIButton()

    // - MARK: Private properties
    private(set) lazy var actionPublisher = actionSubject.eraseToAnyPublisher()
    private let actionSubject = PassthroughSubject<MainViewActions, Never>()
    private var cancellables = Set<AnyCancellable>()
    private let screenSize: CGRect = UIScreen.main.bounds

    // - MARK: Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupLayout()
        setupBinding()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// - MARK: private extension
private extension MainView {
    func setupBinding() {
        magnetButton.tapPublisher
            .sink { [weak self] _ in
                self?.actionSubject.send(.magnetDidTAp)
            }
            .store(in: &cancellables)
        
        scanButton.tapPublisher
            .sink { [weak self] _ in
                self?.actionSubject.send(.scanDidTap)
            }
            .store(in: &cancellables)
    }

    func setupViews() {
        backgroundColor = .black

        headerView.image = UIImage(named: "mainHeader")

        backgroundView.backgroundColor = UIColor(named: "tableBackground")
        backgroundView.layer.cornerRadius = 8

        currentLabel.text = "Current Wi-Fi"
        currentLabel.font = UIFont.systemFont(ofSize: 15)
        currentLabel.textColor = .white

        wifiLabel.text = "WIFI_Name"
        wifiLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        wifiLabel.textColor = UIColor(named: "buttonBackground")

        readyLabel.text = "Ready to Scan this network"
        readyLabel.font = UIFont.systemFont(ofSize: 17)
        readyLabel.textColor = .white

        scanButton.setTitle("Scan current nerwork", for: .normal)
        scanButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        scanButton.tintColor = .white
        scanButton.layer.cornerRadius = 25
        scanButton.backgroundColor = UIColor(named: "buttonBackground")

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
        addSubview(scrollView) {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }

        scrollView.addSubview(contentView) {
            $0.top.leading.trailing.bottom.equalToSuperview()
            $0.width.equalToSuperview()
        }

        contentView.addSubview(headerView) {
            $0.leading.top.trailing.equalToSuperview()
            $0.height.equalTo(self.screenSize.width / 1.2)
        }

        contentView.addSubview(backgroundView) {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(headerView.snp.bottom).offset(-40)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(190)
        }

        backgroundView.addSubview(currentLabel) {
            $0.top.equalToSuperview().offset(10)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(20)
        }

        backgroundView.addSubview(wifiLabel) {
            $0.top.equalTo(currentLabel.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(34)
        }

        addSubview(readyLabel) {
            $0.top.equalTo(wifiLabel.snp.bottom).offset(10).priority(700)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(20)
        }

        backgroundView.addSubview(scanButton) {
            $0.top.equalTo(readyLabel.snp.bottom).offset(10)
            $0.bottom.equalToSuperview().offset(-16)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }

        contentView.addSubview(infraredButton) {
            $0.top.equalTo(backgroundView.snp.bottom).offset(10)
            $0.leading.equalToSuperview().inset(20)
            $0.size.equalTo(screenSize.size.width * 0.4)
        }

        contentView.addSubview(bluetuthButton) {
            $0.top.equalTo(backgroundView.snp.bottom).offset(10)
            $0.trailing.equalToSuperview().inset(20)
            $0.size.equalTo(screenSize.size.width * 0.4)
        }

        contentView.addSubview(magnetButton) {
            $0.top.equalTo(infraredButton.snp.bottom).offset(20)
            $0.leading.bottom.equalToSuperview().inset(20)
            $0.size.equalTo(screenSize.size.width * 0.4)
        }

        contentView.addSubview(antispyButton) {
            $0.top.equalTo(infraredButton.snp.bottom).offset(20)
            $0.trailing.bottom.equalToSuperview().inset(20)
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
