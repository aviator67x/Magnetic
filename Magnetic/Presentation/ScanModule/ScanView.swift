//
//  ScanView.swift
//  Magnetic
//
//  Created by Andrew Kasilov on 14.04.2024.
//

import Combine
import Foundation
import Lottie
import SnapKit
import UIKit

enum ScanViewActions {
    case stopScanning
}

final class ScanView: UIView {
    // - MARK: Views
    private let titleLabel = UILabel()
    private let subTitleLabel = UILabel()
    private var lottieView = LottieAnimationView(name: "scanner")
    private let percentageLabel = UILabel()
    private let countLabel = UILabel()
    private let countTitleLabel = UILabel()
    private let stopButton = UIButton()
    
    // - MARK: Private properties
    private(set) lazy var actionPublisher = actionSubject.eraseToAnyPublisher()
    private let actionSubject = PassthroughSubject<ScanViewActions, Never>()
    private var cancellables = Set<AnyCancellable>()
    private let screenSize: CGRect = UIScreen.main.bounds
    private var subtitle: String = "TLind_246_Ip"
    private var count: String = "23" {
        didSet {
            let attributedString = createAttributedString()
            countLabel.attributedText = attributedString
        }
    }

    private var percents: Int = 0 {
        didSet {
            percentageLabel.text = "\(String(percents)) %"
        }
    }
    
    // - MARK: Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupLayout()
        setupBinding()
        lottieView.play()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updatePercents(_ value: Int) {
        percents = value
    }
}

// - MARK: private extension
private extension ScanView {
    func setupBinding() {
        stopButton.tapPublisher
            .sink { [weak self] _ in
                self?.actionSubject.send(.stopScanning)
            }
            .store(in: &cancellables)
    }
    
    func setupViews() {
        backgroundColor = .black
        
        titleLabel.text = "Scanning Your Wi-Fi"
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        titleLabel.textColor = .white
        
        subTitleLabel.text = subtitle
        subTitleLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        subTitleLabel.textColor = UIColor(named: "purple")
        
        lottieView.contentMode = .scaleAspectFit
        lottieView.loopMode = .loop
        
        percentageLabel.text = "\(String(percents)) %"
        percentageLabel.font = UIFont.systemFont(ofSize: 17)
        percentageLabel.textColor = .white

        let attributedString = createAttributedString()
        countLabel.attributedText = attributedString

        stopButton.backgroundColor = UIColor(named: "purple")
        stopButton.setTitle("Stop", for: .normal)
        stopButton.layer.cornerRadius = 25
    }
    
    func createAttributedString() -> NSMutableAttributedString {
        let countAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 28, weight: .bold),
            .foregroundColor: UIColor(named: "purple")
        ]
        let countTitleAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 17),
            .foregroundColor: UIColor.white
        ]
        
        let firstString = NSMutableAttributedString(string: count, attributes: countAttributes)
        let secondString = NSMutableAttributedString(string: " Devices found...", attributes: countTitleAttributes)
        firstString.append(secondString)
        return firstString
    }

    func setupLayout() {
        addSubview(lottieView) {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-20)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(lottieView.snp.width)
        }
        
        addSubview(percentageLabel) {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-20)
            $0.height.equalTo(20)
        }
        
        addSubview(subTitleLabel) {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(lottieView.snp.top).offset(-70)
        }
        
        addSubview(titleLabel) {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(subTitleLabel.snp.top).offset(-10)
        }
        
        addSubview(countLabel) {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(lottieView.snp.bottom).offset(20)
        }
        
        addSubview(stopButton) {
            $0.top.equalTo(countLabel.snp.bottom).offset(screenSize.height * 0.1)
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(50)
        }
    }
}
