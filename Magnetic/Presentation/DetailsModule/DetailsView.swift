//
//  DetailsView.swift
//  Magnetic
//
//  Created by Andrew Kasilov on 15.04.2024.
//

import Foundation
import SnapKit
import UIKit

final class DetailsView: UIView {
    // - MARK: Views
    private let headerImageView = UIImageView()
    private let attentionImageView = UIImageView()
    private let cameraLabel = UILabel()
    private let addressLabel = UILabel()
    private var connectionView = DetailedView(name: "", value: "", frame: .zero)
    private var ipView = DetailedView(name: "", value: "", frame: .zero)
    private var mackView = DetailedView(name: "", value: "", frame: .zero)
    private var haostView = DetailedView(name: "", value: "", frame: .zero)
    private let separatorView = UIView()
    
    // - MARK: Private properties
    private let screenSize: CGRect = UIScreen.main.bounds
    private var deviceData: DeviceDataModel
    private var ipAddress: String = "192.168.1.1"
    private var isConnection: Bool = false
    
    // - MARK: Lifecycle
    init(deviceData: DeviceDataModel, frame: CGRect) {
        self.deviceData = deviceData
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
private extension DetailsView {
    func setupViews() {
        backgroundColor = .black
        
        headerImageView.image = UIImage(named: "detailsHeader")
        
        attentionImageView.image = isConnection ? UIImage(named: "attentionPositiv") : UIImage(named: "attentionNegativ")
        
        cameraLabel.text = "Camera"
        cameraLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        cameraLabel.textColor = UIColor(named: "purple")
        
        addressLabel.text = ipAddress
        addressLabel.font = UIFont.systemFont(ofSize: 15)
        addressLabel.textColor = .white
        
        connectionView = DetailedView(name: "Connection Type", value: deviceData.connectionType, frame: .zero)
        
        ipView = DetailedView(name: "IP Address", value: deviceData.ipAddress, frame: .zero)
        
        mackView = DetailedView(name: "MAC Address", value: deviceData.macAddress, frame: .zero)
        
        haostView = DetailedView(name: "Hostname", value: deviceData.hostName, frame: .zero)
        
        separatorView.backgroundColor = .white
        separatorView.alpha = 0.5
    }
    
    func setupLayout() {
        addSubview(headerImageView) {
            $0.top.equalToSuperview().offset(50)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(self.screenSize.width / 1.3)
        }
        
        addSubview(attentionImageView) {
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(headerImageView.snp.centerY).offset(40)
            $0.size.equalTo(self.screenSize.width / 3)
        }
        
        addSubview(cameraLabel) {
            $0.top.equalTo(headerImageView.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
        }
        
        addSubview(addressLabel) {
            $0.top.equalTo(cameraLabel.snp.bottom)
            $0.centerX.equalToSuperview()
        }
        
        addSubview(connectionView) {
            $0.top.equalTo(addressLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        addSubview(separatorView) {
            $0.top.equalTo(connectionView.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(0.5)
        }
        
        addSubview(ipView) {
            $0.top.equalTo(connectionView.snp.bottom).offset(0.5)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        addSubview(mackView) {
            $0.top.equalTo(ipView.snp.bottom).offset(0.5)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        addSubview(haostView) {
            $0.top.equalTo(mackView.snp.bottom).offset(0.5)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
//        addSubview(separatorView) {
//            $0.top.equalTo(ipView.snp.bottom)
//            $0.leading.trailing.equalToSuperview().inset(16)
//            $0.height.equalTo(0.5)
//        }
    }
}
