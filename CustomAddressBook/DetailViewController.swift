//
//  DetailViewController.swift
//  CustomAddressBook
//
//  Created by Jacob Posner on 1/13/17.
//  Copyright © 2017 Kaizen Human. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    
    @IBOutlet weak var firstNameLabel: UILabel?
    @IBOutlet weak var lastNameLabel: UILabel?
    @IBOutlet weak var phoneButton: UIButton?
    @IBOutlet weak var emailButton: UIButton?
    @IBOutlet weak var addressButton: UIButton?
    
    @IBOutlet weak var mapView : MKMapView?
    


    func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem {
            self.title = detail.firstName
            
            firstNameLabel?.text = detail.firstName
            lastNameLabel?.text = detail.lastName
            
            phoneButton?.setTitle(detail.phone, for: .normal)
            emailButton?.setTitle(detail.email, for: .normal)
            addressButton?.setTitle(detail.address, for: .normal)
            
            if let address = detail.address {
                let geocoder = CLGeocoder()
                geocoder.geocodeAddressString(address) {
                    (placemarks, error) -> Void in
                    if let firstPlacemark = placemarks?[0] {
                        let pm = MKPlacemark(placemark: firstPlacemark)
                        self.mapView?.addAnnotation(pm)
                        let region = MKCoordinateRegionMakeWithDistance(pm.coordinate, 500, 500)
                        self.mapView?.setRegion(region, animated: false)
                    }
                }
                
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var detailItem: Person? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }


}

