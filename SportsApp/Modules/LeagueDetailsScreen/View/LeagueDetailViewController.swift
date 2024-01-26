//
//  LeagueDetailViewController.swift
//  SportsApp
//
//  Created by Mac on 25/01/2024.
//

import UIKit
import Lottie

class LeagueDetailViewController: UIViewController {

    @IBOutlet weak var leagueNavItem: UINavigationItem!

    @IBOutlet weak var leagueDetailsCollectionView: UICollectionView!
    
    @IBOutlet weak var favButton: UIButton!
    
    
    var isFav : Bool = false
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.leagueNavItem.title = "English League"
        

        self.leagueDetailsCollectionView.delegate = self
        self.leagueDetailsCollectionView.dataSource = self
        
        let layout = UICollectionViewCompositionalLayout{ sectionIndex, environment in
            
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
    }
    
    func drawUpComingEventsSection() ->
    NSCollectionLayoutSection{
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 32)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 0)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 0)
        
//        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
//                                                                  heightDimension: .absolute(50.0))
//        let header = NSCollectionLayoutBoundarySupplementaryItem(
//            layoutSize: headerSize,
//            elementKind: UICollectionView.elementKindSectionHeader,
//            alignment: .top)
//        section.boundarySupplementaryItems = [header]
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
        
        return section
    }
    
    func drawTeamsSection() -> NSCollectionLayoutSection{
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .absolute(200))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 16)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 0)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 0)
        
        
        
        section.visibleItemsInvalidationHandler = { (items, offset, environment) in
            items.forEach { item in
                let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
                let minScale: CGFloat = 0.8
                let maxScale: CGFloat = 1.0
                let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
                item.transform = CGAffineTransform(scaleX: scale, y: scale)
            }
            
            
        }
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
            DispatchQueue.main.asyncAfter(deadline: .now()+1.5){
                animationView.stop()
                animationView.removeFromSuperview()
            }
        }
        else{
            favButton.setImage(UIImage(named: "heart"), for: .normal)
        }
        
       
    }
    

    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true)
    }
}

extension LeagueDetailViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    // MARK: UICollectionViewDataSource

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section{
        case 0 , 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CutomCollectionViewCell.cellId, for: indexPath) as! CutomCollectionViewCell
            let url = URL(string: "https://apiv2.allsportsapi.com/logo/96_juventus.jpg")
            
            let backgroundUrl = URL(string:"https://img.freepik.com/vecteurs-libre/versus-vs-ecran-deux-effets-lumiere-focalises_1017-26146.jpg?w=1380&t=st=1706197856~exp=1706198456~hmac=6a0557116fa8466da62f8e2bf6d0f2c6027f473597fbf8619ed218f12a01cf32")
            
            cell.homeTeamLogo.kf.setImage(with: url)
            cell.awayTemLogo.kf.setImage(with: url)
        
            cell.homeTeamLogo.clipsToBounds = true
            cell.awayTemLogo.clipsToBounds = true
            cell.cellBackground.clipsToBounds = true
            
            cell.cellBackground.layer.cornerRadius = 30
            cell.homeTeamLogo.layer.cornerRadius = 35
            cell.awayTemLogo.layer.cornerRadius = 35
            
            cell.cellBackground.kf.setImage(with: backgroundUrl)
            cell.homeTeamName.text = "Manchester"
            cell.awayTeamName.text = "Chelsi"

            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TeamCollectionViewCell.teamCellId, for: indexPath) as! TeamCollectionViewCell
          
            
            cell.teamName.text = "Paris"
            let url = URL(string: "https://apiv2.allsportsapi.com/logo/100_psg.jpg")
            cell.teamImage.kf.setImage(with: url)
            cell.cellView.layer.cornerRadius = 32

            return cell
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    

    // MARK: UICollectionViewDelegate
 
    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}
