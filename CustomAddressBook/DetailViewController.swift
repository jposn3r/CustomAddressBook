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
    
    var mapPlacemark : MKPlacemark?
    

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
                        
                        self.mapPlacemark = pm
                        
                        self.mapView?.addAnnotation(pm)
                        let region = MKCoordinateRegionMakeWithDistance(pm.coordinate, 500, 500)
                        self.mapView?.setRegion(region, animated: false)
                    }
                }
                
            }
        }
    }
    
    @IBAction func emailButtonPressed(sender : UIButton) {
        if let email = detailItem?.email {
            if let url = NSURL(string: "mailto:\(email)") {
                UIApplication.shared.open(url as URL)
            }
            
        }
    }
    
    @IBAction func phoneButtonPressed(sender : UIButton) {
        if let phone = detailItem?.phone {
            if let url = NSURL(string:"tel://\(phone)") {
                UIApplication.shared.open(url as URL)
            }
            
        }
    }
    
    @IBAction func addressButtonPressed(sender : UIButton) {
        if let placemark = self.mapPlacemark {
            openMapForPlace(lat: placemark.coordinate.latitude, long: placemark.coordinate.longitude)
        }
    }
    
    func openMapForPlace(lat: CLLocationDegrees, long: CLLocationDegrees) {
        let coordinates = CLLocationCoordinate2D(latitude: lat, longitude: long)
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, 500, 500)
        let options = [
            MKLaunchOptionsMapCenterKey : NSValue(mkCoordinate : regionSpan.center),
            MKLaunchOptionsMapSpanKey : NSValue(mkCoordinateSpan : regionSpan.span)
        ]
        
        let mapItem = MKMapItem(placemark:  self.mapPlacemark!)
        
        var mapItemName = detailItem!.firstName!
        
        if let ln = detailItem!.lastName {
            mapItemName += " \(ln)"
        }
        
        mapItem.name = mapItemName
        
        mapItem.openInMaps(launchOptions: options)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "editSegue") {
            let controller = segue.destination as! AddViewController
            controller.person = detailItem
        }
    }

    
    
    
    
    

}

