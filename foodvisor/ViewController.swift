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

class ViewController: UIViewController {

    var alimentsLst: [Aliment] = Array()

    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }
    
    func getData(){
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
                        self.alimentsLst.append(Aliment(nom: nom, calories: cal, type: type, image: img))
                    }
                }
            }
        }
}
