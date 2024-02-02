

import UIKit
import Kingfisher

class SportLeaguesTableViewController: UITableViewController {

    var selectedIndex : Int?
    
    var category : String {
        switch selectedIndex{
        case 0:
            return APIHelper.Sports.football.rawValue
        case 1:
            return APIHelper.Sports.basketball.rawValue
        case 2:
            return APIHelper.Sports.tennis.rawValue
        default:
            return APIHelper.Sports.cricket.rawValue
        }
    }
    
    var leagues = Leagues(leagues: [])
    
    var viewModel = LeagueViewModel()
    
    let indicator = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("category = \(category)")
        self.tableView.register(CustomTableViewCell.nib(), forCellReuseIdentifier: CustomTableViewCell.cellReuseIdentifier)
        
        setIndicator()
        
        viewModel.fetchLeagues(sport:category)
        
        viewModel.bindResultToViewController = {[weak self] in
        
            self?.leagues = (self?.viewModel.getLeagues())!
            self?.tableView.reloadData()
            self?.indicator.stopAnimating()
            
        }
    }
    
    func setIndicator(){
        indicator.center = view.center
        indicator.color = .gray
        indicator.startAnimating()
        view.addSubview(indicator)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.leagues.leagues.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        cell.leagueImage.clipsToBounds = true
        cell.leagueImage.layer.cornerRadius = cell.leagueImage.bounds.width / 2
        cell.leagueName.text = leagues.leagues[indexPath.row].leagueName
        let url = URL(string: leagues.leagues[indexPath.row].leagueLogo ?? Constants.leagueLogoPlaceholder)
        cell.leagueImage.kf.setImage(with: url)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let leagueDetailsVC = self.storyboard?.instantiateViewController(withIdentifier: "leagueDetails") as! LeagueDetailViewController
        
        print("from leagues : leagueId = \(leagues.leagues[indexPath.row].leagueId)")
        leagueDetailsVC.leagueId = leagues.leagues[indexPath.row].leagueId
        
        leagueDetailsVC.category = category
        print("from leagues : category = \(category)")
        
        leagueDetailsVC.leagueName = leagues.leagues[indexPath.row].leagueName
        print("from leagues : leagueName = \(leagues.leagues[indexPath.row].leagueName)")
        
        leagueDetailsVC.modalPresentationStyle = .fullScreen
        self.present(leagueDetailsVC, animated: true)
    }

}
