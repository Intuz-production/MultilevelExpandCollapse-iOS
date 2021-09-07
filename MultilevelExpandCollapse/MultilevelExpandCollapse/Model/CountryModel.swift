//
//  CountryModel.swift
//  MultilevelExpandCollapse
//
//  Created on 02/09/21.

import Foundation

class CountryModel : NSObject {
    var countryName = ""
    var stateMArr = [StateModel]()
    var depthLevel = 0
    var isExpanded = false
    var hasChild = false
    
    init(dataDict : Dictionary<String, Any>) {
        super.init()
        countryName = dataDict["countryName"] as! String
        let stateArr = dataDict["state"] as! Array<Any>
        for item in stateArr
        {
            let stateM = StateModel(dataDict: item as! Dictionary<String, Any>)
            stateMArr.append(stateM)
        }
    }
}
