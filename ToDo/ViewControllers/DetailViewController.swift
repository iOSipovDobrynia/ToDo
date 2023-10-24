//
//  DetailViewController.swift
//  ToDo
//
//  Created by Goodwasp on 24.10.2023.
//

import UIKit
import MapKit

class DetailViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var locationLabel: UILabel!
    
    // MARK: - Public properties
    var task: Task!
    
    var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        return dateFormatter
    }
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        titleLabel.text = task.title
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        titleLabel.text = task.title
        descriptionLabel.text = task.description
        locationLabel.text = task.location?.name
        dateLabel.text = dateFormatter.string(from: task.date)
        
        if let coordinates = task.location?.coordinates {
            let region = MKCoordinateRegion(
                center: coordinates.coordinate,
                latitudinalMeters: 100,
                longitudinalMeters: 100
            )
            mapView.region = region
        }
    }
}
