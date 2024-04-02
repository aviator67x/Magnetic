//
//  View.swift
//  MagneticDetection
//
//  Created by Andrew Kasilov on 02.04.2024.
//

import Combine
import Foundation
import SnapKit
import UIKit

enum MagneticViewActions {
    case didPressButton
    case showWifi
}

final class MagneticView: UIView {
    enum ButtonState {
        case search
        case stop
        
        mutating func toggle() {
            switch self {
                case .search:
                    self = .stop
                case .stop:
                    self = .search
            }
        }
    }
    
    // - MARK: Views
    private let magnetView = UIImageView()
    private let dashboardView = UIImageView()
    private let arrowView = UIImageView()
    private let magnetismLabel = UILabel()
    private let button = UIButton()
    
    // - MARK: Private properties
    private(set) lazy var actionPublisher = actionSubject.eraseToAnyPublisher()
    private let actionSubject = PassthroughSubject<MagneticViewActions, Never>()
    private let screenSize: CGRect = UIScreen.main.bounds
    private var buttonState: ButtonState = .search
    
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
    
    // - MARK: Objc
    @objc
    func onButtonTap() {
        rotateArrow(angle: CGFloat(Double.pi * 0.5))
        buttonState.toggle()
        button.setTitle(buttonState == .search ? "Seearch" : "Stop", for: .normal)
        magnetismLabel.text = buttonState == .search ? "Search checking" : "50 µT"
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.actionSubject.send(.showWifi)
        }
    }
    
    func rotateArrow(angle: CGFloat) {
        buttonState == .search ? clockwise(angle: CGFloat(Double.pi * 0.5)) : counterClockwise(angle: 0)
    }
}

// - MARK: private extension
private extension MagneticView {
    func clockwise(angle: CGFloat) {
        UIImageView.animate(withDuration: 2) {
            let transformation = CGAffineTransform(rotationAngle: CGFloat(angle))
            self.arrowView.transform = transformation
        }
    }
    
    func counterClockwise(angle: CGFloat) {
        UIImageView.animate(withDuration: 0.5) {
            let transformation = CGAffineTransform(rotationAngle: CGFloat(angle))
            self.arrowView.transform = transformation
        }
    }
    
    func setupViews() {
        magnetView.image = UIImage(named: "magnet")
        dashboardView.image = UIImage(named: "dashboard")
        
        arrowView.image = UIImage(named: "arrow")
        let xOffset = arrowView.frame.size.width / 2
        let yOffset = arrowView.frame.size.height / 2
//        arrowView.layer.anchorPoint = CGPoint(x: xOffset, y: 0)
//        arrowView.layer.anchorPoint = CGPoint(x: xOffset, y: yOffset)
        arrowView.setAnchorPoint(CGPoint(x: 0.95, y: 0.9))
//        arrowView.layer.anchorPoint = CGPoint(x: 1, y: 1)
        
        magnetismLabel.text = buttonState == .search ? "Search checking" : "50 µT"
        magnetismLabel.font = UIFont.systemFont(ofSize: 17)
        magnetismLabel.textColor = .white
        
        button.addTarget(self, action: #selector(onButtonTap), for: .touchUpInside)
        button.backgroundColor = UIColor(named: "purple")
        button.setTitle(buttonState == .search ? "Search" : "Stop", for: .normal)
        button.layer.cornerRadius = 25
    }
    
    func setupLayout() {
        addSubview(magnetView) {
            $0.leading.top.trailing.equalToSuperview()
            $0.height.equalTo(self.screenSize.width / 1.2)
        }
        addSubview(dashboardView) {
            $0.top.equalTo(magnetView.snp.bottom).offset(50)
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(self.screenSize.width / 1.9)
        }
        
        addSubview(arrowView) {
            $0.centerX.equalToSuperview() // .offset(20)
            $0.centerY.equalTo(dashboardView.snp.bottom)
        }
        
        addSubview(magnetismLabel) {
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(arrowView.snp.bottom).offset(50)
        }
        
        addSubview(button) {
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(50)
            $0.bottom.equalToSuperview().inset(50)
        }
    }
}
