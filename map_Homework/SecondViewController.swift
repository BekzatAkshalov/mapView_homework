//
//  SecondViewController.swift
//  map_Homework
//
//  Created by Bekzat on 17/11/24.
//

import UIKit
import MapKit

class SecondViewController: UIViewController, CLLocationManagerDelegate, UIGestureRecognizerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var mapview: MKMapView!
    
    
    let locationManager = CLLocationManager() //получает местоположение пользователя - получаем доступ к gps данным
    
    var userLocation = CLLocation() // данные самого пользователя - где находится пользователь
    
    var anotation = MKPointAnnotation()
    
    var followMe = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        
        locationManager.startUpdatingLocation()
        
        
        // Настраиваем отслеживания жестов - когда двигается карта вызывается didDragMap
        let mapDragRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.didDragMap))
        mapDragRecognizer.delegate = self
        mapview.addGestureRecognizer(mapDragRecognizer)
        
        mapview.delegate = self
        
        mapview.addAnnotation(anotation)
        
        
        
    }
    
    @objc func didDragMap(gestureRecognizer: UIGestureRecognizer) {
        if gestureRecognizer.state == .began {
            // Отключаем слежение за пользователем при начале перемещения карты
            followMe = false
            print("User started dragging the map, followMe disabled")
        }
    }
    
    @IBAction func showMyLocation(_ sender: Any) {
        // Включаем слежение и обновляем карту
        followMe = true
        let latDelta: CLLocationDegrees = 0.01
        let longDelta: CLLocationDegrees = 0.01
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: longDelta)
        let region = MKCoordinateRegion(center: userLocation.coordinate, span: span)
        mapview.setRegion(region, animated: true)
    }
    
    
    // Попробуем построить маршрут, если пользовательское местоположение уже известно
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        userLocation = locations[0]
        
        print(userLocation)
        
        buildRoute(to: anotation.coordinate)
        
        
        if !followMe {
            // Дельта - насколько отдалиться от координат пользователя по долготе и широте
            let latDelta:CLLocationDegrees = 0.01
            let longDelta:CLLocationDegrees = 0.01
            
            // Создаем область шириной и высотой по дельте
            let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: longDelta)
            
            // Создаем регион на карте с моими координатоми в центре
            let region = MKCoordinateRegion(center: userLocation.coordinate, span: span)
            
            // Приближаем карту с анимацией в данный регион
            mapview.setRegion(region, animated: true)
            
            let location:CLLocation = CLLocation(latitude: (anotation.coordinate.latitude), longitude: (anotation.coordinate.longitude))
            
        }
    }
    
    func buildRoute(to destinationCoordinates: CLLocationCoordinate2D) {
        // Проверяем доступность местоположения пользователя
        
        let sourcePlacemark = MKPlacemark(coordinate: userLocation.coordinate)
        let destinationPlacemark = MKPlacemark(coordinate: destinationCoordinates)
        
        let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
        
        let directionRequest = MKDirections.Request()
        directionRequest.source = sourceMapItem
        directionRequest.destination = destinationMapItem
        directionRequest.transportType = .automobile
        
        // Вычисляем маршрут
        let directions = MKDirections(request: directionRequest)
        directions.calculate { [weak self] (response, error) in
            guard let self = self else { return }
            guard let response = response, let route = response.routes.first else {
                if let error = error {
                    print("Error calculating directions: \(error.localizedDescription)")
                } else {
                    print("No route found")
                }
                return
            }
            
            
            // Удалить существующие маршруты
            self.mapview.removeOverlays(self.mapview.overlays)
            
            // Добавить новый маршрут
            self.mapview.addOverlay(route.polyline, level: .aboveRoads)
            
            // Настроить отображение маршрута
            let rect = route.polyline.boundingMapRect
            self.mapview.setRegion(MKCoordinateRegion(rect), animated: true)
        }
    }
    
    
    
    
    
    
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolyline {
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = UIColor.red
            renderer.lineWidth = 2.0
            return renderer
        }
        return MKOverlayRenderer(overlay: overlay)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

