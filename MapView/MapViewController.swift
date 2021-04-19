//
//  MapViewController.swift
//  MapView
//
//  Created by Renato Vieira on 8/5/20.
//  Copyright © 2020 Stant. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    let myAnnotation = MKPointAnnotation()
    
    var mapView:               MKMapView?
    var locationManager:       CLLocationManager?
    var currentLocation:       CLLocation?
    var confirmLocationButton: UIButton?
    var delegate:              MapViewDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        configure()
    }
    
    func configure() {
        configureMap()
        configureButton()
    }
    
    func configureMap() {
        mapView = MKMapView()
        guard let mapView = mapView else { return }
        mapView.mapType = MKMapType.standard
        mapView.center = view.center
        //mapView.isZoomEnabled = true
        
        self.view.addSubview(mapView)
        mapView.anchor(top:      self.view.topAnchor,
                       leading:  self.view.leadingAnchor,
                       bottom:   self.view.bottomAnchor,
                       trailing: self.view.trailingAnchor,
                       padding:  UIEdgeInsets(top: 40, left: 0, bottom: 100, right: 0))
        
        determineCurrentLocation()
    }
    
    func configureButton() {
        confirmLocationButton                 = UIButton()
        guard let confirmLocationButton       = confirmLocationButton else { return }
        confirmLocationButton.backgroundColor = .systemGreen
        
        confirmLocationButton.setTitle("Confirm Location", for: .normal)
        confirmLocationButton.setTitleColor(.white, for: .normal)
        
        self.view.addSubview(confirmLocationButton)
        confirmLocationButton.anchor(top:      mapView?.bottomAnchor,
                                     leading:  self.view.leadingAnchor,
                                     trailing: self.view.trailingAnchor,
                                     padding:  UIEdgeInsets(top: 15, left: 16, bottom: 0, right: 16),
                                     size:     CGSize(width: 0, height: 50))
        
        confirmLocationButton.addTarget(self, action: #selector(goToSendLocation), for: .touchUpInside)
    }
    
    @objc func goToSendLocation() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension MapViewController: CLLocationManagerDelegate, MKMapViewDelegate {
    func determineCurrentLocation() {
        locationManager                  = CLLocationManager()
        locationManager?.delegate        = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        
        locationManager?.requestAlwaysAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager?.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let mapView = mapView else { return }
        mapView.removeAnnotation(myAnnotation)
        
        self.currentLocation = locations.last
        
        let center = CLLocationCoordinate2D(latitude: ((currentLocation?.coordinate.latitude)!), longitude: ((currentLocation?.coordinate.longitude)!))
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        mapView.setRegion(region, animated: true)
        
        myAnnotation.coordinate = (currentLocation?.coordinate)!
        myAnnotation.title = NSLocalizedString("Voce está aqui", comment: "")
        
        mapView.addAnnotation(myAnnotation)
        mapView.selectAnnotation(myAnnotation, animated: true)
        manager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
    }
}

protocol MapViewDelegate {
    func getCoordinate(location: CLLocation)
}

