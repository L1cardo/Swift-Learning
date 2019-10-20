//
//  Weather.swift
//  Weather
//
//  Created by Licardo on 2019/10/18.
//  Copyright © 2019 Licardo. All rights reserved.
//

import Foundation

class Weather {
    var temp = ""
    var location = ""
    var parentCity = ""
    var condCode = ""
    var condText = ""
    var status = ""

    var icon: String {
        return "\(condCode)"
    }
}
