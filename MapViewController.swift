//
//  MapViewController.swift
//  NiyaRegency
//
//  Created by Arun Vijayan on 11/02/20.
//  Copyright © 2020 Arun Vijayan. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import MapKit


protocol mapdelegate{
    func mapdatas(lat:CLLocationDegrees,long:CLLocationDegrees,mapaddress:String,changelocationflag:Int)
    
    
}

@available(iOS 13.0, *)
class MapViewController: UIViewController,UISearchBarDelegate {
    var marker=GMSMarker()
    @IBOutlet weak var lbladdress: UILabel!
    @IBOutlet weak var mapview: GMSMapView!
    var lat=CLLocationDegrees()
       var long=CLLocationDegrees()
       var address=String()
       var placeaddress=String()
       var currentAddress=String()
    var userlocation=CLLocation()
    
    var latitude=CLLocationDegrees()
       var longitude=CLLocationDegrees()
       let locationManager = CLLocationManager()
    
    var resultsViewController: GMSAutocompleteResultsViewController?
    var searchController: UISearchController?
    var resultView: UITextView?
    var cuurentaddress=String()
    var delegate:mapdelegate!
   
   
    
     private func reverseGeocodeCoordinate(_ coordinate: CLLocationCoordinate2D) {
         
       // 1
       let geocoder = GMSGeocoder()
       print("coordinate",coordinate)
         latitude=coordinate.latitude
         longitude=coordinate.longitude
         print("latitude",latitude)
         print("longitude",longitude)
         geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
         guard let address = response?.firstResult(), let lines = address.lines else {
           return
         }
           
         // 3show
       
       
           print(lines.joined(separator: "\n"))
            self.currentAddress=lines.joined(separator: "\n")
            self.lbladdress.text=self.currentAddress
        // self.addressLabel.text = lines.joined(separator: "\n")
       
         // 4
         UIView.animate(withDuration: 0.25) {
           self.view.layoutIfNeeded()
         }
       }
        let position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        marker.position=position
     }
     
    

      override func viewDidLoad() {
        super.viewDidLoad()
        
        let btnsback = backButton(imageName: "Icon feather-arrow-left", selector: #selector(back))
         navigationItem.leftBarButtonItem = btnsback
        
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
       
        
        
        
         mapview.delegate = self
        mapview.isMyLocationEnabled = true
        mapview.settings.zoomGestures   = true

        resultsViewController = GMSAutocompleteResultsViewController()
        resultsViewController?.delegate = self

        searchController = UISearchController(searchResultsController: resultsViewController)
        searchController?.searchResultsUpdater = resultsViewController

        let subView = UIView(frame: CGRect(x: 0, y: 65.0, width: 350.0, height: 45.0))

        subView.addSubview((searchController?.searchBar)!)
        view.addSubview(subView)
        searchController?.searchBar.sizeToFit()
        searchController?.hidesNavigationBarDuringPresentation = false

        // When UISearchController presents the results view, present it in
        // this view controller, not one further up the chain.
        definesPresentationContext = true
      }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
    
       
            let lbl = UILabel(frame: CGRect(x: 0 , y: 0, width: self.view.frame.size.width * 1, height: 20))
                            title = "Change Location"
        
                            lbl.text = title
                            lbl.font = UIFont.systemFont(ofSize: 20.0)
                          lbl.textColor =  UIColor.darkGray
                            lbl.textAlignment = .left
                            navigationItem.titleView=lbl
    }
    
    
    func backButton(imageName: String, selector: Selector) -> UIBarButtonItem {
                    let button = UIButton(type: .custom)
                    //        button.setImage(UIImage(named: imageName), for: .normal)
                    button.setBackgroundImage(UIImage(named: imageName), for: .normal)
                    button.frame = CGRect(x: 0, y: 0, width:20, height: 20)
                    button.backgroundColor = UIColor.clear
                    button.widthAnchor.constraint(equalToConstant: 20).isActive = true
                    button.heightAnchor.constraint(equalToConstant: 20).isActive = true
                    button.addTarget(self, action: selector, for: .touchUpInside)
                    return UIBarButtonItem(customView: button)
                }
                
                @objc func back(sender: UIBarButtonItem) {
                    // Perform your custom actions
                    // ...
                    // Go back to the previous ViewController
                    self.dismiss(animated: true, completion: nil)
                }
    
    
    func autosearchcompleted(){
        
      let position = CLLocationCoordinate2D(latitude: lat, longitude: long)
        marker.position=position
        let target = CLLocationCoordinate2D(latitude: lat, longitude: long)
        mapview.camera = GMSCameraPosition.camera(withTarget: target, zoom: 17)
        
       self.lbladdress.text=placeaddress
        
       
    }
    
    
    @IBAction func btncontinueaction(_ sender: Any) {
        
        // let home = self.storyboard?.instantiateViewController (withIdentifier: "HomepageViewController") as! HomepageViewController
        
        self.delegate.mapdatas(lat:latitude,long:longitude,mapaddress:currentAddress,changelocationflag: 1)
//         print("currentAddress",currentAddress)
//             takeawy.latitude=latitude
//             takeawy.longitude=longitude
//            takeawy.changelocationflag=1
//            takeawy.addressfrommap=currentAddress
        //        maincategory.currentlocation=placeaddress
        //        UserDefaults.standard.set(self.placeaddress, forKey: "currentaddress")
        //        maincategory.latitude=Float(lat)
        //        maincategory.longitude=Float(long)
        //        UserDefaults.standard.set(Float(lat), forKey: "latitude")
        //        UserDefaults.standard.set(Float(long), forKey: "longitude")
                self.dismiss(animated: true, completion: nil)
        
        
    }
    
    
    
    
    
    
    
}

@available(iOS 13.0, *)
extension MapViewController: CLLocationManagerDelegate {
  // 2
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    // 3
    guard status == .authorizedWhenInUse else {
      return
    }
    // 4
    locationManager.startUpdatingLocation()
      
    //5
    mapview.isMyLocationEnabled = true
    mapview.settings.myLocationButton = true
  }
  
  // 6
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let location = locations.first else {
      return
    }
    userlocation = locations.last!
    //locationManager.stopUpdatingLocation()

      
//        let camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
    // 7
//    mapview.camera = camera
    let target = CLLocationCoordinate2D(latitude: userlocation.coordinate.latitude, longitude: userlocation.coordinate.longitude)
     mapview.camera = GMSCameraPosition.camera(withTarget: target, zoom: 17)
//    showMarker(position: camera.target)
    let position = CLLocationCoordinate2D(latitude: userlocation.coordinate.latitude, longitude: userlocation.coordinate.longitude)
   showMarker(position: position)
    locationManager.stopUpdatingLocation()
   
  }
    
    
     func showMarker(position: CLLocationCoordinate2D){
           
        marker.position = position
        marker.tracksInfoWindowChanges = true
           // marker.title = "\(currentaddress)"
        print("title",marker.title)
           // marker.snippet = "San Francisco"
            marker.map = mapview
        }
    
    
}


class CustomButton: UIButton {
    var gps = ""
    var title = ""
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //TODO: Code for our button
    }
}



@available(iOS 13.0, *)

extension MapViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
            reverseGeocodeCoordinate(position.target)
            
            
        }
   
    
    
//    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
//            let view = UIView(frame: CGRect.init(x: 0, y: 0, width: 150, height: 30))
//            view.backgroundColor = UIColor.white
//            view.layer.cornerRadius = 6
//            
//            let lbl1 = UILabel(frame: CGRect.init(x: 8, y: 8, width: view.frame.size.width - 16, height: 15))
//            lbl1.text = "Your location"
//            view.addSubview(lbl1)
//            
//    //        let lbl2 = UILabel(frame: CGRect.init(x: lbl1.frame.origin.x, y: lbl1.frame.origin.y + lbl1.frame.size.height + 3, width: view.frame.size.width - 16, height: 15))
//    //        lbl2.text = "I am a custom info window."
//    //        lbl2.font = UIFont.systemFont(ofSize: 14, weight: .light)
//    //        view.addSubview(lbl2)
//            print(marker.title)
//          
//            if marker.title != nil {
//                            let buttontitle=marker.title
//                            let mapViewHeight = mapView.frame.size.height
//                            let mapViewWidth = mapView.frame.size.width
//                print("mapViewHeight",mapViewHeight)
//                print("mapViewWidth",mapViewWidth)
//                
//                            let container = UIView()
//                            container.frame = CGRect(x: 600, y: 700,width: mapViewWidth - 200,  height: mapViewHeight - 70)
//                            container.backgroundColor = UIColor.white
//                            self.view.addSubview(container)
//                
//                            let googleMapsButton = CustomButton()
//                            googleMapsButton.setTitle("", for: .normal)
//                            googleMapsButton.setImage(UIImage(named: "greentick"), for: .normal)
//                            googleMapsButton.setTitleColor(UIColor.blue, for: .normal)
//                            googleMapsButton.frame = CGRect(x: 50, y: 50, width: mapViewWidth - 80, height:  mapViewHeight - 70)
//                            googleMapsButton.tag = 0
//    //                        googleMapsButton.addTarget(self, action: "markerClick:", for: .touchUpInside)
//                googleMapsButton.addTarget(self, action: #selector(markerClick(sender:)), for: .touchUpInside)
//                            googleMapsButton.gps = String(marker.position.latitude) + "," + String(marker.position.longitude)
//                            googleMapsButton.title = buttontitle!
//                
//                
//                            let directionsButton = CustomButton()
//                
//                            directionsButton.setTitle("", for: .normal)
//                            directionsButton.setImage(UIImage(named: "greentick"), for: .normal)
//                            directionsButton.setTitleColor(UIColor.blue, for: .normal)
//                
//                            directionsButton.frame = CGRect(x: 50, y: 50, width: mapViewWidth - 110, height:  mapViewHeight - 70)
//                           directionsButton.tag = 1
//    //                       directionsButton.addTarget(self, action: "markerClick:", for: .touchUpInside)
//                directionsButton.addTarget(self, action: #selector(markerClick(sender:)), for: .touchUpInside)
//                            directionsButton.gps = String(marker.position.latitude) + "," + String(marker.position.longitude)
//                            directionsButton.title = buttontitle!
//                
//                            self.view.addSubview(googleMapsButton)
//                            self.view.addSubview(directionsButton)
//                        }
//                    return view
//                    }
        
        
//        @objc func markerClick(sender: CustomButton) {
//            print(sender.tag)
//            let fullGPS = sender.gps
//            let fullGPSArr = fullGPS.split{$0 == ","}.map(String.init)
//
//            let lat1 : NSString = fullGPSArr[0] as NSString
//            let lng1 : NSString = fullGPSArr[1] as NSString
//
//
//            let latitude:CLLocationDegrees =  lat1.doubleValue
//            let longitude:CLLocationDegrees =  lng1.doubleValue
//
//            if (UIApplication.shared.openURL(NSURL(string:"comgooglemaps://")! as URL)) {
//                if (sender.tag == 1) {
//                    UIApplication.shared.openURL(NSURL(string:
//                        "comgooglemaps://?saddr=&daddr=\(latitude),\(longitude)&directionsmode=driving")! as URL)
//                } else if (sender.tag == 0) {
//                    UIApplication.shared.openURL(NSURL(string:
//                        "comgooglemaps://?center=\(latitude),\(longitude)&zoom=14&views=traffic")! as URL)
//                }
//
//            } else {
//                let regionDistance:CLLocationDistance = 10000
//                let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
//                //let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
//                let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
//                var options=[String:AnyObject]()
//                if (sender.tag == 1) {
//                    options = [
//                        MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
//                        MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span),
//                        MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving as AnyObject
//                    ]
//                } else if (sender.tag == 0) {
//                    options = [
//                        MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
//                        MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
//                    ]
//                }
//
//                let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
//                let mapItem = MKMapItem(placemark: placemark)
//                mapItem.name = sender.title
//                mapItem.openInMaps(launchOptions: options as? [String : AnyObject])
//            }
//        }
        
        
    }

    
    





    // Handle the user's selection.
@available(iOS 13.0, *)
extension MapViewController: GMSAutocompleteResultsViewControllerDelegate {
      func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                             didAutocompleteWith place: GMSPlace) {
        searchController?.isActive = false
//        // Do something with the selected place.
//        print("Place name: \(place.name)")
//        print("Place address: \(place.formattedAddress)")
//        print("Place attributions: \(place.attributions)")
        
        placeaddress=place.formattedAddress!
               print("placeaddress",placeaddress)
               print("Place name: \(place.name)")
               print("Place address: \(place.formattedAddress)")
               print("Place attributions: \(place.attributions)")
                lat=place.coordinate.latitude
                long=place.coordinate.longitude
               print("lat",lat)
               print("long",long)
        latitude=lat
        longitude=long
               //dismiss(animated: true, completion: nil)
        currentAddress=placeaddress
        searchController?.searchBar.text=placeaddress
            autosearchcompleted()
      }

      func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                             didFailAutocompleteWithError error: Error){
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
      }

      // Turn the network activity indicator on and off again.
      func didRequestAutocompletePredictions(forResultsController resultsController: GMSAutocompleteResultsViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
      }

      func didUpdateAutocompletePredictions(forResultsController resultsController: GMSAutocompleteResultsViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
      }
    }

