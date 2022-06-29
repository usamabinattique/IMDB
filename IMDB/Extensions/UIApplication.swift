//
//  UIApplication.swift
//  IMDB
//
//  Created by Usama on 29/06/2022.
//

import UIKit


extension UIApplication {
    func dismissKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
