
import UIKit
import Lottie

class LaunchScreenVC: UIViewController {

    @IBOutlet weak var lottieAnimationView: LottieAnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lottieAnimationView.contentMode = .scaleAspectFit
        
        lottieAnimationView.loopMode = .loop
        
        lottieAnimationView.animationSpeed = 1.0
        
        lottieAnimationView.play()
       
        DispatchQueue.main.asyncAfter(deadline: .now()+3){
            if AppDelegate.reachability.getReachable(){
                self.performSegue(withIdentifier: "leaveLaunch", sender: self)
            }else{
                self.performSegue(withIdentifier: "noNetwork", sender: self)
            }
            
            
        }
       
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
