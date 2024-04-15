//
//  DetailedView.swift
//  Magnetic
//
//  Created by Andrew Kasilov on 15.04.2024.
//

import SnapKit
import UIKit

final class DetailedView: UIView {
    let nameLabel = UILabel()
    let valueLabel = UILabel()
  
    init(name: String, value: String, frame: CGRect) {
        super.init(frame: frame)
        setupViews(name: name, value: value)
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - private extension

private extension DetailedView {
    func setupViews(name: String, value: String) {
        backgroundColor = UIColor(named: "tableBackground")
        nameLabel.text = name
        nameLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        nameLabel.textColor = .white
        
        valueLabel.text = value
        valueLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        valueLabel.textColor = .white
        valueLabel.alpha = 0.5
    }
    
    func setupLayout() {
        addSubview(nameLabel) {
            $0.leading.equalToSuperview().offset(20)
            $0.top.bottom.equalToSuperview().inset(10)
        }
        
        addSubview(valueLabel) {
            $0.trailing.equalToSuperview().offset(-20)
            $0.top.bottom.equalToSuperview().inset(10)
        }
    }
}
