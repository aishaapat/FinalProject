//
//  MapPoint.swift
//  finalProject
//
//  Created by Alex Bringuel on 4/28/25.
//

import Foundation
import MapKit


class MapPoint: NSObject, MKAnnotation {
    var name: String?
    var photo: String?
    var longitude: Double
    var latitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    init (longitude: Double, latitude: Double){
        self.longitude = longitude
        self.latitude = latitude
    }
}
