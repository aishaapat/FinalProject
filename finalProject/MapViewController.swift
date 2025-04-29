//
//  MapViewController.swift
//  finalProject
//
//  Created by Alex Bringuel on 4/28/25.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var switchMapType: UISegmentedControl!
    @IBAction func mapChangeType(_ sender: UISegmentedControl) {
        switch switchMapType.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .hybrid
        case 2:
            mapView.mapType = .satellite
        default:
            break
        }
    }
    //adding comments
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.setUserTrackingMode(.follow, animated: true)
        // Do any additional setup after loading the view.
    }
    


}
