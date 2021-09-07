//
//  StateModel.swift
//  MultilevelExpandCollapse
//
//  Created on 02/09/21.


import Foundation

class StateModel: NSObject {
    var stateName = ""
    var cityMArr = [CityModel]()
    var depthLevel = 1
    var isExpanded = false
    var hasChild = false
    init(dataDict : Dictionary<String, Any>) {
        super.init()
        stateName = dataDict["stateName"] as! String
        let childArr = dataDict["city"] as! Array<Any>
        for item in childArr
        {
            let topicM = CityModel(dataDict: item as! Dictionary<String, Any>)
            cityMArr.append(topicM)
        }
    }
}
