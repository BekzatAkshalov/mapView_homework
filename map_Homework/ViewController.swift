//
//  ViewController.swift
//  map_Homework
//
//  Created by Bekzat on 17/11/24.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var firstMap: MKMapView!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    var anotation = MKPointAnnotation()
   

    
    
    var mall = Mall()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("SecondViewController loaded.")
           print("Received annotation at coordinates: \(anotation.coordinate.latitude),\(anotation.coordinate.longitude)")

        
        nameLabel.text = mall.name
        addressLabel.text = mall.address
        imageView.image = UIImage(named: mall.imagename)
        
        
        // ______________ Метка на карте ______________
        // Новые координаты для метки на карте
        let lat = mall.lat
        let long = mall.long
        
        // Создаем координта передавая долготу и широту
        let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(lat, long)
        
        // Создаем метку на карте
       anotation = MKPointAnnotation()
        
        // Задаем коортинаты метке
        anotation.coordinate = location
        
        anotation.title = mall.name
     
        
        // Добавляем метку на карту
        firstMap.addAnnotation(anotation)
        
        //region
        let latDelta:CLLocationDegrees = 0.002
        let longDelta:CLLocationDegrees = 0.002

        // Создаем область шириной и высотой по дельте
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: longDelta)
        
        // Создаем регион на карте с моими координатоми в центре
        let region = MKCoordinateRegion(center: location, span: span)
        
        // Приближаем карту с анимацией в данный регион
        firstMap.setRegion(region, animated: true)
        
        
    }
    
    @IBAction func openMapTwo(_ sender: Any) {
        print("Opening SecondViewController with annotation at coordinates: \(anotation.coordinate.latitude), \(anotation.coordinate.longitude)")
        let vc = storyboard?.instantiateViewController(withIdentifier: "third vc") as! SecondViewController
        
        vc.anotation = anotation
        
        navigationController?.show(vc, sender: self)
        
    }
    
    
    
}

