//
//  FoodDeoRepository.swift
//  FoodieGuide
//
//  Created by Gül Karataş on 10.10.2024.
//

import Foundation
import RxSwift
import Alamofire

class FoodDeoRepository {
    
    var foodList = BehaviorSubject<[Food]>(value: [Food]())
    func foodInstall() {
        AF.request("http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php", method: .get).response { response in
            if let data = response.data {
                do {
                    let cevap = try JSONDecoder().decode(FoodCevap.self, from: data)
                    if let list = cevap.yemekler {
                        print("Çekilen yemek listesi: \(list)")  // Veriyi kontrol et
                        self.foodList.onNext(list)
                    } else {
                        print("Veri boş!")
                    }
                } catch {
                    print("JSON decode hatası: \(error.localizedDescription)")
                }
            } else if let error = response.error {
                print("İstek hatası: \(error.localizedDescription)")
            }
        }
    }
}
    



