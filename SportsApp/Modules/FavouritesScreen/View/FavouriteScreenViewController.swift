//
//  FavouriteScreenViewController.swift
//  SportsApp
//
//  Created by Mac on 25/01/2024.
//

import UIKit
import Kingfisher
import Network

class FavouriteScreenViewController: UIViewController {

    @IBOutlet weak var favouritesTable: UITableView!
    
    let database = DependencyProvider.database
    
    var viewModel : FavouriteScreenViewModel!
    var favouriteLeagues : [League] = []
    
    let networkMonitor = NWPathMonitor()
    var isConnected : Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Favourites"
        networkMonitor.pathUpdateHandler = {[weak self] path in
            if path.status == .satisfied{
                print("connected")
                self?.isConnected = true
            }
            else{
                print("not connected")
                self?.isConnected = false
            }
        }
        
        let queue = DispatchQueue(label: "Monitor")
        networkMonitor.start(queue: queue)
        
        viewModel = FavouriteScreenViewModel(database: database)
        
        favouriteLeagues = viewModel.fetchData()
        
        favouritesTable.reloadData()
        
        favouritesTable.register(CustomTableViewCell.nib(), forCellReuseIdentifier: CustomTableViewCell.cellReuseIdentifier)
    }
    override func viewDidAppear(_ animated: Bool) {
        favouritesTable.reloadData()
    }

}
extension FavouriteScreenViewController : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favouriteLeagues.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.cellReuseIdentifier, for: indexPath) as! CustomTableViewCell
        cell.leagueImage.clipsToBounds = true
        
        cell.leagueImage.layer.cornerRadius = cell.leagueImage.bounds.width / 2
        
        cell.leagueName.text = favouriteLeagues[indexPath.row].leagueName
        
        let url = URL(string: favouriteLeagues[indexPath.row].leagueLogo ?? "")
        cell.leagueImage.kf.setImage(with: url)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Favourites"
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
                if editingStyle == .delete {
                    
                    viewModel.removeLeague(id: favouriteLeagues[indexPath.row].leagueId)
                    favouriteLeagues.remove(at: indexPath.row)
                    tableView.reloadData()
                }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if isConnected{
            let leagueDetailsVC = self.storyboard?.instantiateViewController(withIdentifier: "leagueDetails") as! LeagueDetailViewController
            
            leagueDetailsVC.modalPresentationStyle = .fullScreen
            leagueDetailsVC.selectedLeague = favouriteLeagues[indexPath.row]
            self.present(leagueDetailsVC, animated: true)
        }
        else{
            let alert = UIAlertController(title: "Connection Lost", message: "You're offline\nPlease connect to network and try again", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "OK", style: .default)
            alert.addAction(action)
            self.present(alert, animated: true)
        }
        
    }
}
