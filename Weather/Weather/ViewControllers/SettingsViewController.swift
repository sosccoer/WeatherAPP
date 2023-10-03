//
//  SettingsViewController.swift
//  Weather
//
//  Created by lelya.rumynin@gmail.com on 3.10.23.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let cells: [TypeOfTableViewCell] = [
    
        TypeOfTableViewCell(type: .SettingTableViewCell,nameOfSetting: "Velocity Type",nameOfValues: ["km/h","mp/h","m/s"]),
        TypeOfTableViewCell(type: .SettingTableViewCell,nameOfSetting: "Pressure Type",nameOfValues: ["in","mb","mmHg"]),
        TypeOfTableViewCell(type: .SettingTableViewCell,nameOfSetting: "Precipitation Type",nameOfValues: ["in","mm"]),
        TypeOfTableViewCell(type: .SettingTableViewCell,nameOfSetting: "Temperature Type",nameOfValues: ["°С","°F"]),
        TypeOfTableViewCell(type: .SettingTableViewCell,nameOfSetting: "Space Type",nameOfValues: ["km","mile"])
        
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
    }

    private func setupTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        registerCells()
        
    }
    
    private func registerCells() {
        
        let settingNib = UINib(nibName: "SettingTableViewCell", bundle: Bundle.main)
        tableView.register(settingNib, forCellReuseIdentifier: "SettingTableViewCell")
    }
    

}

extension SettingsViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        cells.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let index = indexPath.row
        
        switch cells[index].type {
            
        case .SettingTableViewCell : guard let cell = tableView.dequeueReusableCell(withIdentifier: "SettingTableViewCell", for: indexPath) as? SettingTableViewCell else {return UITableViewCell()}
            
            cell.label.text = cells[index].nameOfSetting
            cell.segmentControl.removeAllSegments()
                
                for value in cells[index].nameOfValues.indices{
                    
                    cell.segmentControl.insertSegment(withTitle: cells[index].nameOfValues[value], at: value, animated: false)
                    
                }
            
            return cell
        }
        
    }
    
}
