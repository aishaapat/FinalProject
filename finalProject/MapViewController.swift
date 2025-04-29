import UIKit
import CoreLocation
import MapKit
import CoreData


class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    var locationManager: CLLocationManager!
    var addresses: [Address] = []
    
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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        mapView.setUserTrackingMode(.follow, animated: true)
        mapView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Fetch Address objects from Core Data
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext

        let fetchRequest: NSFetchRequest<Address> = Address.fetchRequest()
        do {
            addresses = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print("Failed to fetch Address: \(error), \(error.userInfo)")
        }

        mapView.removeAnnotations(mapView.annotations)

        for address in addresses {
            if let latitutde = address.latitude,
               let longititude = address.longititude,
               let lat = Double(latitutde),
               let lon = Double(longititude) {
                
                let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                let annotation = MKPointAnnotation()
                annotation.coordinate = coordinate
                annotation.title = address.name ?? "N/A"
                annotation.subtitle = "Lat: \(lat), Lon: \(lon)"
                
                mapView.addAnnotation(annotation)
            }
        }
    }
}

