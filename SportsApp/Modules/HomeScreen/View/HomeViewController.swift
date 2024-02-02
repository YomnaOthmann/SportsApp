
import UIKit
import Kingfisher

class HomeViewController: UIViewController {

    @IBOutlet weak var sportsCollectionView: UICollectionView!
    
    @IBOutlet weak var layoutButton: UIButton!
    
    var cellIndentifier = "HomeCollectionViewCell"
    var isGrid : Bool = false
    

    lazy var listCollectionViewLayout: UICollectionViewFlowLayout = {
   
           let collectionFlowLayout = UICollectionViewFlowLayout()
           collectionFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
           collectionFlowLayout.itemSize = CGSize(width: ( self.view.bounds.width - 20),  height: 150)
           collectionFlowLayout.scrollDirection = .vertical
           return collectionFlowLayout
       }()
    
    
    lazy var gridCollectionViewLayout:UICollectionViewFlowLayout = {
        let collctionViewFlowLayout = UICollectionViewFlowLayout()
        collctionViewFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collctionViewFlowLayout.itemSize = CGSize(width:(self.sportsCollectionView.bounds.width - 30) / 2, height: 150)
        
        collctionViewFlowLayout.scrollDirection = .vertical
        return collctionViewFlowLayout
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.title = "Sports"
        self.tabBarController?.navigationItem.leftBarButtonItem?.title = ""
        self.tabBarController?.navigationItem.leftBarButtonItem?.tintColor = .black
        
        
        self.tabBarController?.navigationItem.setHidesBackButton(true, animated: true)
        
        sportsCollectionView.dataSource = self
        sportsCollectionView.delegate = self
        
        let nib = UINib(nibName: cellIndentifier, bundle: nil)
        
        sportsCollectionView.register(nib, forCellWithReuseIdentifier: cellIndentifier)
        sportsCollectionView.setCollectionViewLayout(listCollectionViewLayout, animated: true)
    }
    
    @IBAction func setLayout(_ sender: Any) {
        print("pressed")
       
        isGrid = !isGrid
       
        if isGrid{
            layoutButton.setImage(UIImage(named: "grid"), for: .normal)
            sportsCollectionView.setCollectionViewLayout(gridCollectionViewLayout, animated: true)
            
        }else{
            layoutButton.setImage(UIImage(named: "list"), for: .normal)
            sportsCollectionView.setCollectionViewLayout(listCollectionViewLayout, animated: true)
        }
       print(isGrid)
    }
}

extension HomeViewController:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let inset :CGFloat = 8
        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIndentifier, for: indexPath) as! HomeCollectionViewCell
      
        cell.sportName.text = Constants.sportsCategoriesTitles[indexPath.row]
       
        let url = URL(string: Constants.sportsCategoriesImages[indexPath.row])
        cell.sportImage.kf.setImage(with: url)
        
        cell.sportImage.layer.cornerRadius = 16
        cell.sportImage.clipsToBounds = true
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let sportsLeaguesVC = self.storyboard?.instantiateViewController(withIdentifier: "leagues") as! SportLeaguesTableViewController
        print(indexPath.row)
        
        sportsLeaguesVC.selectedIndex = indexPath.row
        
        self.navigationController?.pushViewController(sportsLeaguesVC, animated: true)
    }
    
  
    
    
}
