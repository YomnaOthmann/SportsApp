

import UIKit

class TeamDetailsViewController: UIViewController {

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var teamsTable: UITableView!
    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var teamImage: UIImageView!
    
    let indicator = UIActivityIndicatorView(style: .large)
    
    var selectedTeam : Team!
    var team : Teams?
    var category : String!
    var leagueId : Int!
    
    let viewModel = TeamViewModel(networkRequest: DependencyProvider.networkRequestHandler)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        teamsTable.delegate = self
        teamsTable.dataSource = self
        
        teamsTable.register(TeamPlayerCustomCell.nib(), forCellReuseIdentifier: TeamPlayerCustomCell.teamCellId)
        
        headerView.addGradient([UIColor(cgColor: CGColor(red: 33/255, green: 50/255, blue: 59/255, alpha: 1.0)),UIColor.white], locations: [0.03,0.3,0.1], frame: self.view.frame)
        
        let url = URL(string: selectedTeam?.teamLogo ?? "")
        teamImage.kf.setImage(with: url)
        teamName.text = selectedTeam?.teamName
        
        setIndicator()
        
        fetchTeam()
    }
    
    func fetchTeam(){
        
        viewModel.fetchTeams(sport: category, leagueID: leagueId, teamId: selectedTeam
            .teamKey)
        
        viewModel.isRetrieveTeams.bind { [weak self] state in
            guard let state = state else{
                return
            }
            if !(self?.team?.teams.isEmpty ?? false && state){
                self?.team = self?.viewModel.teams
                self?.indicator.stopAnimating()
                self?.teamsTable.reloadData()
            }
        }
    }
    
    func setIndicator(){
        indicator.center = view.center
        indicator.color = .gray
        indicator.startAnimating()
        view.addSubview(indicator)
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
        return team?.teams[0].teamPlayers?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TeamPlayerCustomCell.teamCellId, for: indexPath) as! TeamPlayerCustomCell
        cell.playerName.text = team?.teams[0].teamPlayers?[indexPath.row].playerName
        let url = URL(string: team?.teams[0].teamPlayers?[indexPath.row].playerImage ?? "")
        cell.playerImage.kf.setImage(with: url)
        cell.playerImage.clipsToBounds = true
        cell.playerImage.layer.cornerRadius = 27
        cell.playerPosition.text = team?.teams[0].teamPlayers?[indexPath.row].playerPosition
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
