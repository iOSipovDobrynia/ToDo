//
//  NewTaskViewController.swift
//  ToDo
//
//  Created by Goodwasp on 25.10.2023.
//

import UIKit
import CoreLocation

class NewTaskViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet var titleTF: UITextField!
    @IBOutlet var locationTF: UITextField!
    @IBOutlet var dateTF: UITextField!
    @IBOutlet var addressTF: UITextField!
    @IBOutlet var descriptionTF: UITextField!
    
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    
    // MARK: - properties
    var taskManager: TaskManager!
    
    var geocoder = CLGeocoder()
    
    var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        return dateFormatter
    }


    // MARK: - IBActions
    @IBAction func save() {
        let titleString = titleTF.text ?? ""
        let locationString = locationTF.text ?? ""
        let date = dateFormatter.date(from: dateTF.text ?? "Tuesday, Jan 1, 2019")
        let descriptionString = descriptionTF.text
        let addressString = addressTF.text
        
        geocoder.geocodeAddressString(addressString ?? "У") { [weak self] (placemarks, error) in
            let placemark = placemarks?.first
            let coordinates = placemark?.location
            
            let location = Location(name: locationString, coordinates: coordinates?.coordinate)
            
            let task = Task(title: titleString, description: descriptionString, date: date, location: location)
            self?.taskManager.add(task)
        }
        
        dismiss(animated: true)
    }
}


