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
    private let imageView = UIImageView()
    private let button = UIButton()
    
    // - MARK: Private properties
    private(set) lazy var actionPublisher = actionSubject.eraseToAnyPublisher()
    private let actionSubject = PassthroughSubject<MagneticViewActions, Never>()
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
    
    func startSearch() {
        UIImageView.animate(withDuration: 2) {
            let transformation = CGAffineTransform(rotationAngle: CGFloat(Double.pi * 0.5))
            self.imageView.transform = transformation
        }
    }
    
    func stopSearch() {
        UIImageView.animate(withDuration: 0.5) {
            let transformation = CGAffineTransform(rotationAngle: CGFloat(Double.pi * 0.0))
            self.imageView.transform = transformation
        }
    }

    // - MARK: Objc
    @objc
    func onButtonTap() {
        buttonState == .search ? startSearch() : stopSearch()
        buttonState.toggle()
        button.setTitle(buttonState == .search ? "Seearch" : "Stop", for: .normal)
    }
}

// - MARK: private extension
private extension MagneticView {
    func setupViews() {
        imageView.image = UIImage(named: "red")
        
        button.addTarget(self, action: #selector(onButtonTap), for: .touchUpInside)
        button.backgroundColor = .red
        button.setTitle(buttonState == .search ? "Seearch" : "Stop", for: .normal)
    }
    
    func setupLayout() {
        addSubview(imageView)
        imageView.snp.makeConstraints { make -> Void in
            make.center.equalToSuperview()
            make.size.equalTo(100)
        }
        
        addSubview(button)
        button.snp.makeConstraints { make -> Void in
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(150)
            make.top.equalTo(imageView.snp.bottom).offset(50)
        }
    }
}

