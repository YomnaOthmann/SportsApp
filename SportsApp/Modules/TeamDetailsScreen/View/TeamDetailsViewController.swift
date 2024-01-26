//
//  TeamDetailsViewController.swift
//  SportsApp
//
//  Created by Mac on 26/01/2024.
//

import UIKit

class TeamDetailsViewController: UIViewController {

    @IBOutlet weak var headerView: UIView!

    @IBOutlet weak var teamsTable: UITableView!
    
    let playersImages = [
        "https://apiv2.allsportsapi.com/logo/players/5466_a-letellier.jpg",
        "https://apiv2.allsportsapi.com/logo/players/8006_danilo-pereira.jpg",
        "https://apiv2.allsportsapi.com/logo/players/8897_l-kurzawa.jpg",
        "https://apiv2.allsportsapi.com/logo/players/11183_sergio-rico.jpg",
        "https://apiv2.allsportsapi.com/logo/players/14159_marquinhos.jpg",
        "https://apiv2.allsportsapi.com/logo/players/20423_m-kriniar.jpg"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        teamsTable.delegate = self
        teamsTable.dataSource = self
        teamsTable.register(TeamPlayerCustomCell.nib(), forCellReuseIdentifier: TeamPlayerCustomCell.teamCellId)
        
        headerView.addGradient([UIColor(cgColor: CGColor(red: 33/255, green: 50/255, blue: 59/255, alpha: 1.0)),UIColor.white], locations: [0.15,0.7,0.1], frame: headerView.frame)
        
    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: false)
    }
    
}

extension TeamDetailsViewController : UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TeamPlayerCustomCell.teamCellId, for: indexPath) as! TeamPlayerCustomCell
        
        cell.playerName.text = "christiano Ronaldo"
        let url = URL(string: playersImages[indexPath.row])
        cell.playerImage.kf.setImage(with: url)
        cell.playerImage.clipsToBounds = true
        cell.playerImage.layer.cornerRadius = 27
        cell.playerPosition.text = "GoalKeeper"
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Players"
    }
}


extension UIView {
   func addGradient(_ colors: [UIColor], locations: [NSNumber], frame: CGRect = .zero) {

      
      let gradientLayer = CAGradientLayer()
      
     
      gradientLayer.colors = colors.map{ $0.cgColor }
      gradientLayer.locations = locations

      
      gradientLayer.frame = frame

      layer.insertSublayer(gradientLayer, at: 0)
   }
    
    
}
