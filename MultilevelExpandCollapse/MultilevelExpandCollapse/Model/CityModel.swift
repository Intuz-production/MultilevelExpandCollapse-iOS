//
//  CityModel.swift
//  MultilevelExpandCollapse
//
//  Created on 02/09/21.


import Foundation

class CityModel: NSObject {
    var cityName = ""
    var shortName = ""
    var depthLevel = 2
    var isExpanded = false
    
    init(dataDict : Dictionary<String, Any>) {
        super.init()
        cityName = dataDict["cityName"] as! String
        shortName = dataDict["shortName"] as! String
    }
}
