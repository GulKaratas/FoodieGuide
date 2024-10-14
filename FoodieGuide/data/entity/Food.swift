//
//  Food.swift
//  FoodieGuide
//
//  Created by Gül Karataş on 10.10.2024.
//

import Foundation

class Food: Codable {
    var yemek_id: String?   // JSON'daki "yemek_id" ile eşleşiyor
    var yemek_adi: String?  // JSON'daki "yemek_adi" ile eşleşiyor
    var yemek_resim_adi: String?  // JSON'daki "yemek_resim_adi" ile eşleşiyor
    var yemek_fiyat: String?  // JSON'daki "yemek_fiyat" String olarak geliyor

    init() {
    }

    init(yemek_id: String, yemek_adi: String, yemek_resim_adi: String, yemek_fiyat: String) {
        self.yemek_id = yemek_id
        self.yemek_adi = yemek_adi
        self.yemek_resim_adi = yemek_resim_adi
        self.yemek_fiyat = yemek_fiyat
    }
}
