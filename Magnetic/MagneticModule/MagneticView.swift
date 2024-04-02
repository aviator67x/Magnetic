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
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let imageView = UIImageView()
    private let button = UIButton()
    
    // - MARK: Private properties
    private var buttonState: ButtonState = .search
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private(set) lazy var actionPublisher = actionSubject.eraseToAnyPublisher()
    private let actionSubject = PassthroughSubject<MagneticViewActions, Never>()
    
    func startSearch() {
//        imageView.rotate()
        
//        let rotate = CABasicAnimation(keyPath: "transform.rotation")
//        rotate.isRemovedOnCompletion = false
//        rotate.fromValue = 0
//        rotate.toValue = CGFloat.pi * 0.5
//        rotate.duration = 2.0
//        rotate.isRemovedOnCompletion = false
//        imageView.layer.add(rotate, forKey: "transform.rotation")
        
//        let transform = CGAffineTransform.identity
//        UIView.animate(withDuration: 0.3) {
//            self.imageView.transform = CGAffineTransform.identity
//        }
        UIImageView.animate(withDuration: 2) {
//            self.imageView.transform = transform.rotated(by: CGFloat(Double.pi * 0.5))
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
}

// - MARK: private extension
private extension MagneticView {
    @objc
    func rotateArrow() {
        buttonState == .search ? startSearch() : stopSearch()
        buttonState.toggle()
        button.setTitle(buttonState == .search ? "Seearch" : "Stop", for: .normal)
    }
    
    func setupViews() {
        scrollView.backgroundColor = .green
        contentView.backgroundColor = .yellow
        
        imageView.image = UIImage(named: "red")
        
        button.addTarget(self, action: #selector(rotateArrow), for: .touchUpInside)
        button.backgroundColor = .red
        button.setTitle(buttonState == .search ? "Seearch" : "Stop", for: .normal)
    }
    
    func setupLayout() {
//        addSubview(scrollView)
//        scrollView.snp.makeConstraints { (make) -> Void in
//            make.edges.equalToSuperview()
//               }
        
        addSubview(contentView)
        contentView.snp.makeConstraints { make -> Void in
            make.leading.trailing.top.bottom.equalToSuperview()
//            make.height.equalTo(3000)
        }
        
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make -> Void in
            make.center.equalToSuperview()
            make.size.equalTo(100)
        }
        
        contentView.addSubview(button)
        button.snp.makeConstraints { make -> Void in
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(150)
            make.top.equalTo(imageView.snp.bottom).offset(50)
        }
    }
}

extension UIView {
    func rotate() {
        let rotation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 0.5)
        rotation.duration = 3
        rotation.isCumulative = false
        rotation.repeatCount = 1 // Float.greatestFiniteMagnitude
        rotation.isRemovedOnCompletion = false
        layer.add(rotation, forKey: "rotationAnimation")
    }
}
