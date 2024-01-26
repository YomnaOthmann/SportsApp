//
//  FavouriteScreenViewController.swift
//  SportsApp
//
//  Created by Mac on 25/01/2024.
//

import UIKit

class FavouriteScreenViewController: UIViewController {

    @IBOutlet weak var favouritesTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        favouritesTable.register(CustomTableViewCell.nib(), forCellReuseIdentifier: CustomTableViewCell.cellReuseIdentifier)
    }

}
extension FavouriteScreenViewController : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.cellReuseIdentifier, for: indexPath) as! CustomTableViewCell
        cell.leagueImage.clipsToBounds = true
        
        cell.leagueImage.layer.cornerRadius = cell.leagueImage.bounds.width / 2
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Favourites"
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        //        if editingStyle == .delete {
        //            tableView.deleteRows(at: [indexPath], with: .fade)
        //        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let leagueDetailsVC = self.storyboard?.instantiateViewController(withIdentifier: "leagueDetails") as! LeagueDetailViewController
        
        leagueDetailsVC.modalPresentationStyle = .fullScreen
        self.present(leagueDetailsVC, animated: true)
    }
}
