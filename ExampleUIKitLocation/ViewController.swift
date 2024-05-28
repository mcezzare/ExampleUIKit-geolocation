//
//  ViewController.swift
//  ExampleUIKit
//
//  Created by Mario Chiodi on 22/05/24.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    var locationManager: CLLocationManager?
    var currentLocation:CLLocation?
    
    private lazy var myView: View = {
        let view = View()
        view.delegate = self
        return view
    }()
    
    override func loadView() {
        super.loadView()
        
        self.view = myView
    }
    
    
    override func viewDidLoad() {
        myView.setup(labelText: "Ver minha localizacão", buttonTitle: "Testar", buttonSeeTitle: "Escolher local")
        super.viewDidLoad()
        setupLocation()
    }
    
    fileprivate func setupLocation() {
        let authorizationStatus: CLAuthorizationStatus
        let manager = CLLocationManager()
        
        if #available(iOS 14, *) {
            authorizationStatus = manager.authorizationStatus
        } else {
            authorizationStatus = CLLocationManager.authorizationStatus()
        }
        
        self.locationManager = CLLocationManager();
        self.locationManager?.delegate = self;
        self.locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        
        
        switch authorizationStatus {
            
        case .notDetermined:
            locationManager?.requestWhenInUseAuthorization()
        case .restricted:
            break
        case .denied:
            showInfoAlert(theMessage: "Permita a leitura de sua localizacão.") {
                self.locationManager?.requestWhenInUseAuthorization()
            }
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager?.startUpdatingLocation()
        @unknown default:
            print("default case")
        }
    }
    
    
}

extension ViewController: ViewDelegate {
    func didTapButton() {
        if let longitude = locationManager?.location?.coordinate.longitude, let latitude = locationManager?.location?.coordinate.latitude {
            let positionDescription = "Lat: \(String(describing: latitude)) | Long: \(String(describing: longitude))"
            myView.setup(labelText: positionDescription, buttonTitle: "Testar novamente", buttonSeeTitle: "Escolher local")
        }
        
    }
}

extension ViewController : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let localizacao = locations.first {
            print(localizacao.coordinate.latitude)
            print(localizacao.coordinate.longitude)
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
            
        case .notDetermined:
            print("notDetermined")
            break
        case .restricted:
            print("restritcted")
            break
        case .denied:
            print("denied")
            break
        case .authorizedAlways,.authorizedWhenInUse:
            locationManager?.startUpdatingLocation()
            
        @unknown default:
            break
            
        }
    }
}
