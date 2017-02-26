//
//  DataVC.swift
//  Goeuro-Sample
//
//  Created by Ramesh on 18/02/17.
//  Copyright © 2017 Ramesh. All rights reserved.
//

import UIKit

class DataVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tbvTravel: UITableView!
    @IBOutlet weak var btnDeparture: UIButton!
    @IBOutlet weak var btnArrival: UIButton!
    @IBOutlet weak var btnDuration: UIButton!
    
    var objTravellResult:[TravellResultModel]!
    let TravellViewCellIdentifier = "TravellViewCell"

    override func viewDidLoad() {
        if self.tbvTravel != nil {
            self.tbvTravel.register(UINib(nibName: "TravellViewCell", bundle: nil), forCellReuseIdentifier: TravellViewCellIdentifier)
        }
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadData(dataArray:[TravellResultModel]) {
        objTravellResult = dataArray
        DispatchQueue.main.async {
            self.reloadtbvTravel()
            self.btnArrivalClick(self.btnArrival)
        }
    }
    
    func reloadtbvTravel() {
        self.tbvTravel.reloadData()
        self.tbvTravel.setContentOffset(CGPoint.zero, animated: true)

    }
    
    @IBAction func btnDepartureClick(_ sender: Any) {
        self.resetButtons()
        if self.btnDeparture.descriptiveName == "DESC" {
            let sortedArray = objTravellResult.sorted {
                $0.departure_time! > $1.departure_time!
            }
            
            objTravellResult = sortedArray
            self.btnDeparture.descriptiveName = "ASC"
            self.btnDeparture.setImage(UIImage(named: "Arrow_Down"),for: .normal)
            
        }else{
            let sortedArray = objTravellResult.sorted {
                $0.departure_time! < $1.departure_time!
            }
            
            objTravellResult = sortedArray
            self.btnDeparture.descriptiveName = "DESC"
            self.btnDeparture.setImage(UIImage(named: "Arrow_Upward"),for: .normal)
        }
        self.reloadtbvTravel()
    }
    
    @IBAction func btnArrivalClick(_ sender: Any) {
        self.resetButtons()
        if self.btnArrival.descriptiveName == "DESC" {
            let sortedArray = objTravellResult.sorted {
                $0.arrival_time! > $1.arrival_time!
            }
            
            objTravellResult = sortedArray
            self.btnArrival.descriptiveName = "ASC"
            self.btnArrival.setImage(UIImage(named: "Arrow_Down"),for: .normal)
            
        }else{
            let sortedArray = objTravellResult.sorted {
                $0.arrival_time! < $1.arrival_time!
            }
            
            objTravellResult = sortedArray
            self.btnArrival.descriptiveName = "DESC"
            self.btnArrival.setImage(UIImage(named: "Arrow_Upward"),for: .normal)
        }
        self.reloadtbvTravel()
    }
    
    @IBAction func btnDurationClick(_ sender: Any) {
        self.resetButtons()
        if self.btnDuration.descriptiveName == "DESC" {
            let sortedArray = objTravellResult.sorted {
                $0.duration! > $1.duration!
            }
            
            objTravellResult = sortedArray
            self.btnDuration.descriptiveName = "ASC"
            self.btnDuration.setImage(UIImage(named: "Arrow_Down"),for: .normal)
            
        }else{
            let sortedArray = objTravellResult.sorted {
                $0.duration! < $1.duration!
            }
            
            objTravellResult = sortedArray
            self.btnDuration.descriptiveName = "DESC"
            self.btnDuration.setImage(UIImage(named: "Arrow_Upward"),for: .normal)
        }
        self.reloadtbvTravel()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:TravellViewCell = tableView.dequeueReusableCell(withIdentifier: TravellViewCellIdentifier) as! TravellViewCell!
        let objTravelModel:TravellResultModel = objTravellResult[indexPath.row]
        
        cell.lblPrice.text = Double((objTravelModel.price_in_euros?.description)!)?.formatAsCurrency(currencyCode: "EUR",locale: "es_ES")
        cell.lblDeparture.text = objTravelModel.departure_time
        cell.lblArrival.text = objTravelModel.arrival_time
        cell.lblChanges.text = (objTravelModel.number_of_stops == 0) ? ("Non-stop") : (objTravelModel.number_of_stops.description) + " Stops"
        cell.lblDuration.text = objTravelModel.duration
        
        let catPictureURL = (objTravelModel.provider_logo?.replacingOccurrences(of: "{size}", with: "63"))!
        cell.imgLogo.downloadImage(url: catPictureURL)
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (objTravellResult != nil){
            return objTravellResult.count;
        }
        else{
            return 0;
        }
    }
    
    func resetButtons() {
        self.btnArrival.setImage(nil, for: .normal)
        self.btnDuration.setImage(nil, for: .normal)
        self.btnDeparture.setImage(nil, for: .normal)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
