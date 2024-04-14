//
//  ScanView.swift
//  Magnetic
//
//  Created by Andrew Kasilov on 14.04.2024.
//

import Combine
import Foundation
import Kingfisher
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
    private let scanImageView = UIImageView()
    private var lottieView = LottieAnimationView()
    private let percentageLabel = UILabel()
    private let countLabel = UILabel()
    private let countTitleLabel = UILabel()
    private let stopButton = UIButton()
    
    // - MARK: Private properties
    private(set) lazy var actionPublisher = actionSubject.eraseToAnyPublisher()
    private let actionSubject = PassthroughSubject<ScanViewActions, Never>()
    private var subtitle: String = "TLind_246_Ip"
    private var count: String = "26" {
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
//        lottieView.play()
//        setupBinding()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// - MARK: private extension
private extension ScanView {
    func setupViews() {
        backgroundColor = .black
        
        titleLabel.text = "Scanning Your Wi-Fi"
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        titleLabel.textColor = .white
        
        subTitleLabel.text = subtitle
        subTitleLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        subTitleLabel.textColor = UIColor(named: "purple")
        
        let gifURL: String = "https://s3-alpha-sig.figma.com/img/ec51/0138/18194cf01a9c50335fcc79fa746cd9e9?Expires=1713744000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=jqWsllJCr67-34-Lh8PH~hPS3vFlGKfGvs2HYIXJEHeuLz0gQ3IM6ClChirRP8zEcVUARRQH8QxrijQroMLNrMyakj7f8ohBoAbczjp4V01R51nybakxqXTFyjp1EMjx64uGIHMOYfMgXfnU4B-7RrnGCcEAY1PmBKxd6xIm0UhZPOjP8qO70kRONDExmYLzyaRO3YbB0WcTRVTnir3U0GfIpoP~2X~La-7djpnLxIMVCp~pNLs68i8Wd5lcmTI~7~TmHH0dRd-N2BVOVEfAreHAF4d3uMZE-nb0Lrd2L2Z2sHz8aIu-LIzO9PcOxY79iwGhqDQUQd8JVa6LTe68ag__"
        let url = URL(string: gifURL)
        scanImageView.kf.setImage(with: url)
        
        percentageLabel.text = "\(String(percents)) %"
        percentageLabel.font = UIFont.systemFont(ofSize: 17)
        percentageLabel.textColor = .white

        let attributedString = createAttributedString()
        countLabel.attributedText = attributedString
        
//        StopButton.addTarget(self, action: #selector(onButtonTap), for: .touchUpInside)
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
        let secondString = NSMutableAttributedString(string: "Devices found...", attributes: countTitleAttributes)
        firstString.append(secondString)
        return firstString
    }

    func setupLayout() {
        addSubview(scanImageView) {
            $0.center.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(scanImageView.snp.width)
        }
        
        addSubview(percentageLabel) {
            $0.center.equalToSuperview()
            $0.height.equalTo(20)
        }
        
        addSubview(subTitleLabel) {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(scanImageView.snp.top).offset(-80)
        }
        
        addSubview(titleLabel) {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(subTitleLabel.snp.top).offset(-10)
        }
        
        addSubview(countLabel) {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(scanImageView.snp.bottom).offset(30)
        }
        
        addSubview(stopButton) {
            $0.top.equalTo(countLabel.snp.bottom).offset(80)
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(50)
//            $0.bottom.equalToSuperview().inset(50)
        }
    }
}
