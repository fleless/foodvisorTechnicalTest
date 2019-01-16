//
//  ViewController.swift
//  foodvisor
//
//  Created by fahmi on 15/01/2019.
//  Copyright © 2019 fahmi. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var alimentsLst: [Aliment] = Array()
    var entreesLst: [Aliment] = Array()
    var platsLst: [Aliment] = Array()
    var dessertsLst: [Aliment] = Array()
    var healthyLst: [Combinaison] = Array()
    var allCombinationsLst: [Combinaison] = Array()
    @IBOutlet weak var segmentedController: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(segmentedController.selectedSegmentIndex == 0){
        return self.alimentsLst.count
        }else if(segmentedController.selectedSegmentIndex == 1){
            return self.healthyLst.count
        }else{
            return 0
        }
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(segmentedController.selectedSegmentIndex == 0){
        let cell = tableView.dequeueReusableCell(withIdentifier: "foodCell") as! FoodsTableViewCell
        cell.nomFood.text = self.alimentsLst[indexPath.row].nom
        cell.nbrCalories.text = self.alimentsLst[indexPath.row].calories+"Kcal"
        let im = self.alimentsLst[indexPath.row].image
        Alamofire.request(im).responseData { (response) in
                   if response.error == nil {
              if let data = response.data {
                cell.imageFood.image = UIImage(data: data)
            }
          }
       }
        return cell
        }else if(segmentedController.selectedSegmentIndex == 1){
            let cell = tableView.dequeueReusableCell(withIdentifier: "healthyCell") as! HealthyTableViewCell
            cell.nomEntree.text = self.healthyLst[indexPath.row].entree.nom
            cell.nomPlat.text = self.healthyLst[indexPath.row].plat.nom
            cell.nomDessert.text = self.healthyLst[indexPath.row].dessert.nom
            cell.nbrCaloriesEntree.text = self.healthyLst[indexPath.row].entree.calories+"Kcal"
            cell.nbrCaloriesPlat.text = self.healthyLst[indexPath.row].plat.calories+"Kcal"
            cell.nbrCaloriesDessert.text = self.healthyLst[indexPath.row].dessert.calories+"Kcal"
            cell.nbrCaloriesTotal.text = String(self.healthyLst[indexPath.row].sumCal)+"Kcal"
            var im:String!
            im = self.healthyLst[indexPath.row].entree.image
            Alamofire.request(im).responseData { (response) in
                if response.error == nil {
                    if let data = response.data {
                        cell.imageEntree.image = UIImage(data: data)
                    }
                }
            }
            im = self.healthyLst[indexPath.row].plat.image
            Alamofire.request(im).responseData { (response) in
                if response.error == nil {
                    if let data = response.data {
                        cell.imgPlat.image = UIImage(data: data)
                    }
                }
            }
            im = self.healthyLst[indexPath.row].dessert.image
            Alamofire.request(im).responseData { (response) in
                if response.error == nil {
                    if let data = response.data {
                        cell.imgDessert.image = UIImage(data: data)
                    }
                }
            }
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "allCell") as! AllCombinationsTableViewCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(segmentedController.selectedSegmentIndex == 0){
        return 88
        }else{
            return 210
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 88
        getData()
    }
    
    func getData(){
        self.alimentsLst.removeAll()
        let url = AppDelegate.url
        let headers: HTTPHeaders = [
            "Authorization":"Bearer iwn-31@!3pf(w]pmarewj236^in"
        ]
        Alamofire.request(url, method: .get, encoding: JSONEncoding.prettyPrinted, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON{ response in
                switch response.result{
                case .failure(let error):
                    print("\(error)erreur")
                case .success(let value):
                    let json = JSON(value)
                    for res in json.arrayValue {
                        let nom = res["display_name"].stringValue
                        let cal = res["cal"].stringValue
                        let img = res["imgUrl"].stringValue
                        let type = res["type"].stringValue
                        let alim = Aliment(nom: nom, calories: cal, type: type, image: img)
                        self.alimentsLst.append(alim)
                        switch type {
                        case typeAliment.starter.rawValue:
                            self.entreesLst.append(alim)
                        case typeAliment.dish.rawValue:
                            self.platsLst.append(alim)
                        case typeAliment.desert.rawValue:
                            self.dessertsLst.append(alim)
                        default:
                            break
                        }
                    }
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.preparerLesCombinaisons()
                }
            }
        }
    
    func preparerLesCombinaisons(){
        for starter in entreesLst{
            for dish in platsLst{
                for desert in dessertsLst{
                    let cal1 = Int(starter.calories)!
                    let cal2 = Int(dish.calories)!
                    let cal3 = Int(desert.calories)!
                    let sum = cal1+cal2+cal3
                    let combo = Combinaison(entree: starter, plat: dish, dessert: desert, sumCal: sum)
                    print(sum)
                    self.allCombinationsLst.append(combo)
                    if(450...550 ~= sum){
                        self.healthyLst.append(combo)
                    }
                }
            }
        }
    }
    
    @IBAction func valueChanged(_ sender: Any) {
        self.tableView.reloadData()
    }

}
