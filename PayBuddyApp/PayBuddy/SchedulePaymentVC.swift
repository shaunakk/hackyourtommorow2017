
import UIKit

class SchedulePaymentVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "schedule5"))
//        self.view.backgroundColor = .white
//        let uimg = UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
//        view.addSubview(uimg)
        tabBarController?.tabBar.isHidden = true
        title = "Schedule Payment"
    }

}
