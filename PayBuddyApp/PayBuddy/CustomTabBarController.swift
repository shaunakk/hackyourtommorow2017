
import UIKit

let payGreen: UIColor = UIColor(red:0.04, green:0.78, blue:0.46, alpha:1.0)

class CustomTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let expensesController = MainTVC()
        let navigationController = UINavigationController(rootViewController: expensesController )
        expensesController.title = "Expenses"
      //selectedImage
        //btn-expenses-off
        //btn-expenses-on
        //btn-schedulePayments-off
        //btn-schedulePayments-on
        var customTabBarItem:UITabBarItem = UITabBarItem(title: nil, image: UIImage(named: "btn-expenses-off")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal), selectedImage: UIImage(named: "btn-expenses-on"))
        customTabBarItem.selectedImage = #imageLiteral(resourceName: "btn-expenses-on")
        expensesController.tabBarItem = customTabBarItem
  
        
        let schedulePaymentsVC = SchedulePaymentsTVC()
        let schedulePaymentsVCNavController = UINavigationController(rootViewController: schedulePaymentsVC)
        schedulePaymentsVC.title = "Payment Schedule"
        
        var customTabBarItem2:UITabBarItem = UITabBarItem(title: nil, image: UIImage(named: "btn-schedulePayments-off")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal), selectedImage: UIImage(named: "btn-schedulePayments-on"))
        schedulePaymentsVC.tabBarItem = customTabBarItem2
        schedulePaymentsVC.tabBarItem.selectedImage = #imageLiteral(resourceName: "btn-schedulePayments-on")
        
        
        let label = UILabel(frame: CGRect(x: 20, y: view.frame.height - 20, width: 60, height: 60))
        label.text = "Expenses"
        label.layer.zPosition = 100
        view.addSubview(label)
        viewControllers = [navigationController, schedulePaymentsVCNavController]
       
    }
    

}

extension UITabBar {
    
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = 80
        return sizeThatFits
    }
}
