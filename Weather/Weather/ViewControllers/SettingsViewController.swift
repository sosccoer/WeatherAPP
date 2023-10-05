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
                
            updateSelected(for: cell, with: cell.segmentControl)
            
            
            cell.segmentedControlAction = {  selectedIndex in
                    // Обработайте изменения для каждой ячейки здесь
                    if indexPath.row == 0 {
                        // Для первой ячейки
                        print("Выбран сегмент \(selectedIndex) в первой ячейке")
                        // Выполните нужное действие для первой ячейки
                    } else if indexPath.row == 1 {
                        // Для второй ячейки
                        print("Выбран сегмент \(selectedIndex) во второй ячейке")
                        // Выполните нужное действие для второй ячейки
                    }
                    // И так далее, обработайте изменения для других ячеек
                }
            
            
            return cell
            
        }
        
        
        
        
    }
    
}
