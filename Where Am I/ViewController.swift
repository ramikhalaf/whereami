//
//  ViewController.swift
//  Where Am I
//
//  Created by Rami Khalaf on 2/22/16.
//  Copyright © 2016 Rami Khalaf. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    var manager: CLLocationManager!
    
    @IBOutlet var latitudeLabel: UILabel!
    @IBOutlet var longitudeLabel: UILabel!
    @IBOutlet var courseLabel: UILabel!
    @IBOutlet var speedLabel: UILabel!
    @IBOutlet var altitudeLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        manager = CLLocationManager();
        manager.delegate = self;
        manager.desiredAccuracy = kCLLocationAccuracyBest;
        manager.requestAlwaysAuthorization();
        manager.startUpdatingLocation();
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation: CLLocation = locations[0];
        
        CLGeocoder().reverseGeocodeLocation(userLocation) { (placemarks, error) -> Void in
            if (error != nil) {
                print(error);
                return;
            }
            
            var subThoroughfare: String = ""
            
            if let placemark = placemarks?[0] {
                
                subThoroughfare = (placemark.subThoroughfare != nil) ? placemark.subThoroughfare! : "";
                
                self.addressLabel.text = "\(subThoroughfare) \(placemark.thoroughfare!) \n\(placemark.subAdministrativeArea!) " +
                    "\(placemark.postalCode!) \n\(placemark.country!)";
            }
        }
        
        self.latitudeLabel.text = "\(userLocation.coordinate.latitude)";
        self.longitudeLabel.text = "\(userLocation.coordinate.longitude)";
        self.courseLabel.text = "\(userLocation.course)";
        self.speedLabel.text = "\(userLocation.speed)";
        self.altitudeLabel.text = "\(userLocation.altitude)";
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

