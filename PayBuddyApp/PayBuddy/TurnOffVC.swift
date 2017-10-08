

import UIKit

class TurnOffVC: UIViewController {

   var theTitle: String? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = payGray
        title = "Disable Payment"
        setupStage()
    }

    func setupStage() {
        let disableView = UIImageView(frame: CGRect(x: 0, y: 60, width: view.frame.width, height: 60))
        disableView.image = #imageLiteral(resourceName: "Cell")
        view.addSubview(disableView)
        
        let uiSwitch = UISwitch(frame: CGRect(x: view.frame.width - 67, y: 73, width: 100, height: 100))
        uiSwitch.isOn = true
        view.addSubview(uiSwitch)
    }
}
