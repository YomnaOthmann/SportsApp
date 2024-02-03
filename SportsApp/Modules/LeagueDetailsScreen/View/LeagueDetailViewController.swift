

import UIKit
import Lottie

class LeagueDetailViewController: UIViewController ,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

    @IBOutlet weak var leagueNavItem: UINavigationItem!

    @IBOutlet weak var leagueDetailsCollectionView: UICollectionView!
    
    @IBOutlet weak var favButton: UIButton!
    
    var isFav : Bool = false
    
    var selectedLeague : League!
    
    var category:String?
    
    var upcomingEvents : [Event] = []
    var latestResults : [Event] = []
    
    var leagueTeams : [Team] = []
    
    let viewModel = LeagueDetailsViewModel(networkRequest: DependencyProvider.networkRequestHandler)
    
    let indicator = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.leagueNavItem.title = selectedLeague.leagueName
        
        leagueDetailsCollectionView.delegate = self
        leagueDetailsCollectionView.dataSource = self
        
        setIndicator()
       
        fetchUpcoming()
        fetchLatestResults()
        
        let layout = UICollectionViewCompositionalLayout{
            sectionIndex,
            environment in
                
            switch sectionIndex{
           
                case 0:
                self.leagueDetailsCollectionView.register(CutomCollectionViewCell.nib(), forCellWithReuseIdentifier: CutomCollectionViewCell.cellId)
                return self.drawUpComingEventsSection()
                case 1:
                self.leagueDetailsCollectionView.register(CutomCollectionViewCell.nib(), forCellWithReuseIdentifier: CutomCollectionViewCell.cellId)
                return self.drawLatestResultsSection()
                case 2:
                self.leagueDetailsCollectionView.register(TeamCollectionViewCell.nib(), forCellWithReuseIdentifier: TeamCollectionViewCell.teamCellId)
                return self.drawTeamsSection()
                default:
                    return self.drawTeamsSection()
           
            }
            
        }
      
        self.leagueDetailsCollectionView.setCollectionViewLayout(layout, animated: true)
        
        leagueDetailsCollectionView.register(NoDataCollectionViewCell.nib(), forCellWithReuseIdentifier: NoDataCollectionViewCell.id)
        
        self.leagueDetailsCollectionView.reloadData()
    }
    func fetchUpcoming(){
       
        viewModel.fetchUpcomingEvents(sport: (category ?? APIHelper.Sports.football.rawValue) , leagueID: selectedLeague.leagueId)
        
        viewModel.isRetrieveUpcomingEvents.bind(){ [weak self] state in
            
            guard let state = state else{
                return
            }
            self?.indicator.stopAnimating()
            
            if !(self?.viewModel.upcoming.events.isEmpty ?? false && state){
                self?.upcomingEvents = self?.viewModel.upcoming.events ?? []
                self?.leagueDetailsCollectionView.reloadData()
            }
        }
    }
    
    func fetchLatestResults(){
       
        viewModel.fetchLatestResults(sport: category ?? APIHelper.Sports.football.rawValue, leagueID: selectedLeague.leagueId)
        
        viewModel.isRetrieveLatestResult.bind(){ [weak self] state in
            guard let state = state else{
                return
            }
            self?.indicator.stopAnimating()
            if !(self?.viewModel.latest.events.isEmpty ?? false && state){
                self?.latestResults = self?.viewModel.latest.events ?? []
                self?.getTeams()
                self?.leagueDetailsCollectionView.reloadData()
            }
        }
    }
    
    func getTeams(){
        leagueTeams = []
        for event in upcomingEvents{
            leagueTeams.append(
                Team(
                    teamName: event.awayTeamName,
                    teamLogo: event.awayTeamLogo,
                    teamKey: event.awayTeamKey
                )
            )
        }
        for event in latestResults{
            leagueTeams.append(
                Team(
                    teamName: event.homeTeamName,
                    teamLogo: event.homeTeamLogo,
                    teamKey: event.homeTeamKey
                )
            )
            
        }
        
    }
    
    func setIndicator(){
        indicator.center = view.center
        indicator.color = .gray
        indicator.startAnimating()
        view.addSubview(indicator)
    }
    
    func drawUpComingEventsSection() -> NSCollectionLayoutSection{
    
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
    
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    
    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200))
    
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
    group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 32)
    let section = NSCollectionLayoutSection(group: group)
    section.orthogonalScrollingBehavior = .continuous
    section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 0)
    section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 0)
        
    
    
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                  heightDimension: .absolute(50.0))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)
        section.boundarySupplementaryItems = [header]
    return section
    
}
    
    func drawLatestResultsSection() -> NSCollectionLayoutSection{
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(180))
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                  heightDimension: .absolute(50.0))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)
        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
    func drawTeamsSection() -> NSCollectionLayoutSection{
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(leagueTeams.count == 0 ? 1 : 0.5), heightDimension: .absolute(200))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 16)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 0)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 0)
        
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                  heightDimension: .absolute(50.0))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)
        section.boundarySupplementaryItems = [header]
        
        return section
        
    }
    
    @IBAction func addToFavouties(_ sender: Any) {
        isFav = !isFav
        print(isFav)
        if isFav{
            favButton.setImage(UIImage(named: "heartred"), for: .normal)
            
            let animationView : LottieAnimationView = LottieAnimationView(frame: CGRect(x: 0, y: 0, width: 300, height: 500))
            
            animationView.center = self.view.center
            
            self.view.addSubview(animationView)
            guard let path = Bundle.main.path(forResource: "fav", ofType: "json")else{
                return
            }
            let url = URL(fileURLWithPath: path)
            LottieAnimation.loadedFrom(url: url) { animation in
                
                animationView.animation = animation
                animationView.contentMode = .scaleAspectFit
                
                animationView.loopMode = .playOnce
                
                animationView.animationSpeed = 1.0
                
                animationView.play()
               
                
            }
            viewModel.addToFavourites(league: selectedLeague)
            DispatchQueue.main.asyncAfter(deadline: .now()+1.5){
                animationView.stop()
                animationView.removeFromSuperview()
            }
        }
        else{
            viewModel.removeFromFavourites(id: selectedLeague.leagueId)
            favButton.setImage(UIImage(named: "heart"), for: .normal)
        }
        
       
    }
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true)
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
 
        guard let header =  collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderCollectionReusableView.id, for: indexPath) as? HeaderCollectionReusableView else{
            return UICollectionReusableView()
        }

        switch indexPath.section{
        case 0:
            header.hederTitle.text = "UpComing Events"
        case 1:
            header.hederTitle.text = "Latest Results"
        default:
            header.hederTitle.text = "Teams"
        }
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.width - 30, height: 60)
    }

}

extension LeagueDetailViewController{
    
    // MARK: UICollectionViewDataSource

    func numberOfSections(in collectionView: UICollectionView) -> Int {
     
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch section{
        case 0:
            return upcomingEvents.count == 0 ? 1 : upcomingEvents.count
        case 1:
            return latestResults.count == 0 ? 1 : latestResults.count
        default:
            return leagueTeams.count == 0 ? 1 : leagueTeams.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section{
        case 0 :
            if upcomingEvents.count == 0{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NoDataCollectionViewCell.id, for: indexPath)
                return cell
            }
            else{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CutomCollectionViewCell.cellId, for: indexPath) as! CutomCollectionViewCell
                
                //Edit With real data
                
                let homeTeamUrl = URL(string: upcomingEvents[indexPath.row].homeTeamLogo)
                cell.homeTeamLogo.kf.setImage(with: homeTeamUrl)
                cell.homeTeamLogo.clipsToBounds = true
                cell.homeTeamLogo.layer.cornerRadius = 35
                cell.homeTeamName.text = upcomingEvents[indexPath.row].homeTeamName
                
                let awayTeamUrl = URL(string: upcomingEvents[indexPath.row].awayTeamLogo)
                cell.awayTemLogo.kf.setImage(with: awayTeamUrl)
                cell.awayTemLogo.clipsToBounds = true
                cell.awayTemLogo.layer.cornerRadius = 35
                cell.awayTeamName.text = upcomingEvents[indexPath.row].awayTeamName
                
                
                cell.eventDate.text = upcomingEvents[indexPath.row].eventDate
                cell.eventTime.text = upcomingEvents[indexPath.row].eventTime
                
                let backgroundUrl = URL(string: Constants.eventBackgroundImage)
                cell.cellBackground.kf.setImage(with: backgroundUrl)
                cell.cellBackground.clipsToBounds = true
                cell.cellBackground.layer.cornerRadius = 30
                
                return cell
            }

        case 1:
            
            if latestResults.count == 0{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NoDataCollectionViewCell.id, for: indexPath)
                return cell
            }
            else{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CutomCollectionViewCell.cellId, for: indexPath) as! CutomCollectionViewCell
                
                //Edit With real data
                
                let homeTeamUrl = URL(string: latestResults[indexPath.row].homeTeamLogo)
                let awayTeamUrl = URL(string: latestResults[indexPath.row].awayTeamLogo)
                
                let backgroundUrl = URL(string:Constants.eventBackgroundImage)
                
                cell.homeTeamLogo.kf.setImage(with: homeTeamUrl)
                cell.awayTemLogo.kf.setImage(with: awayTeamUrl)
                cell.cellBackground.kf.setImage(with: backgroundUrl)

                cell.homeTeamLogo.clipsToBounds = true
                cell.awayTemLogo.clipsToBounds = true
                cell.cellBackground.clipsToBounds = true
                
                cell.cellBackground.layer.cornerRadius = 30
                cell.homeTeamLogo.layer.cornerRadius = 35
                cell.awayTemLogo.layer.cornerRadius = 35
                
                cell.homeTeamName.text = latestResults[indexPath.row].homeTeamName
                cell.awayTeamName.text = latestResults[indexPath.row].awayTeamName
                
                cell.eventDate.text = latestResults[indexPath.row].eventDate
                cell.eventTime.text = latestResults[indexPath.row].eventTime
                
                cell.finalScore.text = latestResults[indexPath.row].finalResult
    

                return cell
            }
            
        default:
            if leagueTeams.count == 0{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NoDataCollectionViewCell.id, for: indexPath)
                return cell
                
            }
            else{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TeamCollectionViewCell.teamCellId, for: indexPath) as! TeamCollectionViewCell
              
                
                cell.teamName.text = leagueTeams[indexPath.row].teamName
                let url = URL(string: leagueTeams[indexPath.row].teamLogo)
                cell.teamImage.kf.setImage(with: url)
                cell.cellView.layer.cornerRadius = 32
                return cell
            }
            
        }
        
    }
    
    
    // MARK: UICollectionViewDelegate
 
    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.section == 2 && leagueTeams.count != 0{
            let teamDetail = self.storyboard?.instantiateViewController(withIdentifier: "team") as! TeamDetailsViewController
            teamDetail.category = category
            teamDetail.modalPresentationStyle = .fullScreen
            teamDetail.leagueId = selectedLeague.leagueId
            teamDetail.selectedTeam = leagueTeams[indexPath.row]
            self.present(teamDetail, animated: true)
        }
        
    }
}
