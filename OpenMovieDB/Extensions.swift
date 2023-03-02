//
//  Extensions.swift
//  OpenMovieDB
//
//  Created by dddiehard on 14/02/23.
//

import SwiftUI

extension Date {
    
    func dateString(_ outputFormat: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy"
        return dateFormatter.date(from: outputFormat)
    }
}

extension View {
    func hideKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
    }
}
