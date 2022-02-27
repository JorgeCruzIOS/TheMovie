//
//  Date+Extension.swift
//  SDKGCommonUtils
//
//  Created by Dsi Soporte Tecnico on 26/02/22.
//

import UIKit

public extension Date {
    
    func toString(format: String = "yyyy-MM-dd") -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "es_MX")
        formatter.dateStyle = .short
        formatter.dateFormat = format
        return formatter.string(from: self).capitalizingFirstLetter()
    }
}
