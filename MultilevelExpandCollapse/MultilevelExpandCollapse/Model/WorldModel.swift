//
//  WorldModel.swift
//  MultilevelExpandCollapse
//
//  Created on 02/09/21.

import Foundation

class WorldModel: NSObject {
    var countryMArr = [CountryModel]()
    
    init(dataDict : Dictionary<String, Any>) {
        super.init()
        let countryList = dataDict["country"] as! Array<Any>
        for item in countryList
        {
            let countryM = CountryModel(dataDict: item as! Dictionary<String , Any>)
            countryMArr.append(countryM)
        }
    }
}
