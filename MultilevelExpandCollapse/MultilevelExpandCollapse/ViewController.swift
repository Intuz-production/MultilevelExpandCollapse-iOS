//
//  ViewController.swift
//  MultilevelExpandCollapse
//
//  Created on 02/09/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var tblList: UITableView!
    
    var worldDataSet : WorldModel!
    var tableDataArr = Array<Any>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Country List"
        self.fetchCityData()
    }
    
    // MARK:- Other private function
    // Fetching stored data from CityData.plist file
    func fetchCityData() {
        guard let path = Bundle.main.path(forResource: "CityData", ofType: "plist"),
              let contentDict = NSDictionary(contentsOfFile: path) as? Dictionary<String, Any>
        else { return }
        worldDataSet = WorldModel(dataDict: contentDict)
        tableDataArr = (worldDataSet?.countryMArr) ?? []
        tblList.reloadData()
    }
}

//MARK:- TableView Data Source Method
extension ViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableDataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : WorldTVCell?
        let member = tableDataArr[indexPath.row]
        if let country = member as? CountryModel {
            cell = tableView.dequeueReusableCell(withIdentifier: "Level1") as? WorldTVCell
            cell?.titlel.text = country.countryName
        }
        else if let state = member as? StateModel {
            cell = tableView.dequeueReusableCell(withIdentifier: "Level2") as? WorldTVCell
            cell?.titlel.text = state.stateName
        }
        else if let city = member as? CityModel {
            cell = tableView.dequeueReusableCell(withIdentifier: "Level3") as? WorldTVCell
            cell?.titlel.text = city.cityName
        }
        else {
            return UITableViewCell()
        }
        return cell ?? UITableViewCell()
    }
    
    // MARK:- UITableView Delegate Method
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.isSelected = false
        let row = indexPath.row
        let member = tableDataArr[row]
        var ipsArr = Array<IndexPath>()
        if let country = member as? CountryModel {
            if !country.isExpanded {
                // Insert next level items
                country.isExpanded = !country.isExpanded
                for (index, value) in country.stateMArr.enumerated() {
                    self.tableDataArr.insert(value, at: row + index + 1)
                    let ip = IndexPath(row: row + index + 1, section: 0)
                    ipsArr.append(ip)
                }
                tableView.beginUpdates()
                tableView.insertRows(at: ipsArr, with: .bottom)
                tableView.endUpdates()
            }
            else {
                // Delete next level items
                var count = 1
                while row + 1 < tableDataArr.count {
                    let element = tableDataArr[row + 1]
                    if !(element is CountryModel) {
                        (element as? StateModel)?.isExpanded = false
                        (element as? CityModel)?.isExpanded = false
                        self.tableDataArr.remove(at: row + 1)
                        let ip = IndexPath(row: row + count, section: 0)
                        ipsArr.append(ip)
                        count += 1
                    }
                    else if (element is CountryModel) {
                        break
                    }
                }
                country.isExpanded = !country.isExpanded
                tableView.beginUpdates()
                tableView.deleteRows(at: ipsArr, with: .top)
                tableView.endUpdates()
            }
        }
        else if let state = member as? StateModel {
            if !state.isExpanded {
                state.isExpanded = true
                for (index, value) in state.cityMArr.enumerated() {
                    self.tableDataArr.insert(value, at: row + index + 1)
                    let ip = IndexPath(row: row + index + 1, section: 0)
                    ipsArr.append(ip)
                }
                tableView.beginUpdates()
                tableView.insertRows(at: ipsArr, with: .bottom)
                tableView.endUpdates()
            }
            else {
                // Delete next level items
                var count = 1
                while row + 1 < tableDataArr.count {
                    let element = tableDataArr[row + 1]
                    if (element is CountryModel) || (element is StateModel) {
                        break
                    }
                    else if !(element is CountryModel) {
                        (element as? StateModel)?.isExpanded = false
                        (element as? CityModel)?.isExpanded = false
                        self.tableDataArr.remove(at: row + 1)
                        let ip = IndexPath(row: row + count, section: 0)
                        ipsArr.append(ip)
                        count += 1
                    }
                }
                state.isExpanded = false
                tableView.beginUpdates()
                tableView.deleteRows(at: ipsArr, with: .top)
                tableView.endUpdates()
            }
        }
        else if member is CityModel {
            // Prompt new View controller
        }
    }
}
