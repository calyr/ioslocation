//
//  ViewController.swift
//  EjemploLatLog
//
//  Created by Roberto Carlos Callisaya Mamani on 9/19/16.
//  Copyright © 2016 Roberto Carlos Callisaya Mamani. All rights reserved.
//

import UIKit
import CoreLocation
class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var latitud: UILabel!
    @IBOutlet weak var longitud: UILabel!
    @IBOutlet weak var exactitud: UILabel!
    @IBOutlet weak var nortMagnetico: UILabel!
    @IBOutlet weak var norteGeografico: UILabel!

    private let manejador = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        manejador.delegate = self
//        manejador.desiredAccuracy = kCLLocationAccuracyBest
//        if (manejador.respondsToSelector(Selector("requestWhenInUseAuthorization"))) {
//            manejador.requestWhenInUseAuthorization()
//        } else {
//            manejador.startUpdatingLocation()
//        }
        
        manejador.requestWhenInUseAuthorization()
        print("Ingresando a la aplicación")
    
    }
    
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        print("\(status)")
        print("\(status.rawValue)")
        if status == .AuthorizedWhenInUse || status == .AuthorizedAlways{
            manejador.startUpdatingLocation()
            manejador.startUpdatingHeading()
            print("Se tiene autorización")
        }else{
            print("No se tiene autorización")
            manejador.stopUpdatingLocation()
            manejador.stopUpdatingHeading()
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        print("Actualizando la localización")
        latitud.text = String(manager.location!.coordinate.latitude)
        longitud.text = String(manager.location!.coordinate.longitude)
        exactitud.text = String(manager.location!.horizontalAccuracy)

    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        let alerta = UIAlertController(title: "ERROR", message: "erro \(error.code)", preferredStyle: .Alert)
        let accionOK = UIAlertAction(title: "OK", style: .Default, handler:
            {accion in
            // alguna accion aqui
            })
        alerta.addAction(accionOK)
        self.presentViewController(alerta, animated: true, completion: nil)
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        nortMagnetico.text = String(newHeading.magneticHeading)
        norteGeografico.text = String(newHeading.trueHeading)
    }
    
    
    



}

