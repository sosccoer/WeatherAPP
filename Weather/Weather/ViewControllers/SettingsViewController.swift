//
//  SettingsViewController.swift
//  Weather
//
//  Created by lelya.rumynin@gmail.com on 3.10.23.
//

import UIKit

class SettingsViewController: UIViewController {
    
    let test = Settings()
    
    weak var settings: Settings!
    
    @IBOutlet weak var tableView: UITableView!
    
    let cells: [TypeOfTableViewCell] = [
        
        TypeOfTableViewCell(type: .SettingTableViewCell,nameOfSetting: "Velocity Type",nameOfValues: [VelocityType.kph.rawValue,VelocityType.mph.rawValue,VelocityType.mps.rawValue]),
        
        TypeOfTableViewCell(type: .SettingTableViewCell,nameOfSetting: "Pressure Type",nameOfValues: [PressureType.inches.rawValue,PressureType.mb.rawValue,PressureType.mmHg.rawValue]),
        
        TypeOfTableViewCell(type: .SettingTableViewCell,nameOfSetting: "Precipitation Type",nameOfValues: [PrecipitationType.inches.rawValue,PrecipitationType.mm.rawValue]),
        
        TypeOfTableViewCell(type: .SettingTableViewCell,nameOfSetting: "Temperature Type",nameOfValues: [TemperatureType.celsius.rawValue,TemperatureType.fahrenheit.rawValue]),
        
        TypeOfTableViewCell(type: .SettingTableViewCell,nameOfSetting: "Space Type",nameOfValues: [SpaceType.km.rawValue,SpaceType.mile.rawValue])
        
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.clear
        
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
    
    private func chose(_ title: String, in selector: UISegmentedControl) {
        for segment in 0..<selector.numberOfSegments {
            if selector.titleForSegment(at: segment) == title {
                selector.selectedSegmentIndex = segment
            }
        }
    }
    
    private func updateSelected( for cell: SettingTableViewCell , with segmentControl: UISegmentedControl ) {
        
        chose(Settings.init().velocity.rawValue, in: cell.segmentControl)
        chose(Settings.init().precipitation.rawValue, in: cell.segmentControl)
        chose(Settings.init().pressure.rawValue, in: cell.segmentControl)
        chose(Settings.init().space.rawValue, in: cell.segmentControl)
        chose(Settings.init().temperature.rawValue, in: cell.segmentControl)
        
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
            
            cell.segmentedControlAction = { [self]   selectedIndex in
                
                switch indexPath.row {
                    
                case 0 : settings.velocity = VelocityType(rawValue: cell.segmentControl.titleForSegment(at: selectedIndex) ?? "") ?? settings.velocity
                    
                case 1 : settings.pressure = PressureType(rawValue: cell.segmentControl.titleForSegment(at: selectedIndex) ?? "") ?? settings.pressure
                    
                case 2 : settings.precipitation = PrecipitationType(rawValue: cell.segmentControl.titleForSegment(at: selectedIndex) ?? "") ?? settings.precipitation
                    
                case 3 : settings.temperature = TemperatureType(rawValue: cell.segmentControl.titleForSegment(at: selectedIndex) ?? "") ?? settings.temperature
                    
                case 4 : settings.space = SpaceType(rawValue: cell.segmentControl.titleForSegment(at: selectedIndex) ?? "") ?? settings.space
                    
                default:
                    return
                }
                
            }
            
            updateSelected(for: cell, with: cell.segmentControl)
            
            return cell
            
        }
        
    }
    
}
