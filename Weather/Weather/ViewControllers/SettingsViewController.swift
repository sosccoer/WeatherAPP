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
    
        TypeOfTableViewCell(type: .SettingTableViewCell, nameOfSetting: "", nameOfValues: ["",""])
    
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    private func setupTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    private func registerCells() {
        
        let settingNib = UINib(nibName: "SettingTableViewCell", bundle: Bundle.main)
        tableView.register(settingNib, forCellReuseIdentifier: "SettingTableViewCell")
    }
    

}

extension SettingsViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        5
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SettingTableViewCell", for: indexPath) as? SettingTableViewCell else {return UITableViewCell()}
        
        return cell
        
    }
    
    
    
    
}
