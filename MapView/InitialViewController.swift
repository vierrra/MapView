//
//  InitialViewController.swift
//  MapView
//
//  Created by Renato Vieira on 4/18/21.
//  Copyright © 2021 Stant. All rights reserved.
//

import UIKit
import CoreLocation

class InitialViewController: UIViewController {
    
    var imageLocation:         UIImageView?
    var labelLongitude:        UILabel?
    var labelLatitude:         UILabel?
    var updatedLongitude:      String? = "-43.2096"
    var updatedLatitude:       String? = "-22.9035"
    var actionButtonGoMapView: UIButton?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.configureView()
    }
    
    func configureView() {
        self.setImageView()
        self.setLabelLongitude()
        self.setLabelLatitude()
        self.setActionButtonMapView()
    }
    
    func setImageView() {
        imageLocation           = UIImageView()
        guard let imageLocation = imageLocation else { return }
        
        imageLocation.image           = UIImage(named: "location")
        imageLocation.contentMode     = .scaleAspectFill
        
        self.view.addSubview(imageLocation)
        imageLocation.anchor(top:      self.view.topAnchor,
                             leading:  self.view.leadingAnchor,
                             trailing: self.view.trailingAnchor,
                             padding:  UIEdgeInsets(top: 40, left: 0, bottom: 0, right: 0),
                             size:     CGSize(width: 0, height: 250))
    }
    
    func setLabelLongitude() {
        labelLongitude             = UILabel()
        guard let labelLongitude   = labelLongitude,
              let updatedLongitude = updatedLongitude else { return }
        
        labelLongitude.backgroundColor     = .systemGreen
        labelLongitude.textAlignment       = .center
        labelLongitude.layer.masksToBounds = true
        labelLongitude.layer.cornerRadius  = 5
        labelLongitude.text                = "Longitude: \(updatedLongitude)"
        
        self.view.addSubview(labelLongitude)
        labelLongitude.anchor(top:      imageLocation?.bottomAnchor,
                              leading:  self.view.leadingAnchor,
                              trailing: self.view.trailingAnchor,
                              padding:  UIEdgeInsets(top: 20, left: 90, bottom: 0, right: 90),
                              size:     CGSize(width: 0, height: 40))
    }
    
    func setLabelLatitude() {
        labelLatitude             = UILabel()
        guard let labelLatitude   = labelLatitude,
              let updatedLatitude = updatedLatitude else { return }
        
        labelLatitude.backgroundColor     = .systemGreen
        labelLatitude.textAlignment       = .center
        labelLatitude.layer.masksToBounds = true
        labelLatitude.layer.cornerRadius  = 5
        labelLatitude.text                = "Longitude: \(updatedLatitude)"
        
        self.view.addSubview(labelLatitude)
        labelLatitude.anchor(top:      labelLongitude?.bottomAnchor,
                             leading:  self.view.leadingAnchor,
                             trailing: self.view.trailingAnchor,
                             padding:  UIEdgeInsets(top: 10, left: 90, bottom: 0, right: 90),
                             size:     CGSize(width: 0, height: 40))
    }
    
    func setActionButtonMapView() {
        actionButtonGoMapView           = UIButton()
        guard let actionButtonGoMapView = actionButtonGoMapView else { return }
        
        actionButtonGoMapView.backgroundColor    = . systemBlue
        actionButtonGoMapView.layer.cornerRadius = 5
        
        actionButtonGoMapView.setTitle("Go To Map View", for: .normal)
        
        
        self.view.addSubview(actionButtonGoMapView)
        actionButtonGoMapView.anchor(top:      labelLatitude?.bottomAnchor,
                                     leading:  self.view.leadingAnchor,
                                     trailing: self.view.trailingAnchor,
                                     padding:  UIEdgeInsets(top: 40, left: 100, bottom: 0, right: 100),
                                     size:     CGSize(width: 0, height: 40))
        
        actionButtonGoMapView.addTarget(self, action: #selector(goToMapView), for: .touchUpInside)
    }
    
    @objc func goToMapView() {
        let mapViewController = MapViewController()
        
        mapViewController.delegate = self
        
        self.presentFullScreen(mapViewController, animated: true)
    }
}

extension InitialViewController: MapViewDelegate {
    func getCoordinate(location: CLLocation) {
       
    }
}
