

import UIKit
let payGray = UIColor(red:0.92, green:0.92, blue:0.92, alpha:1.00)
class SchedulePaymentsTVC: UITableViewController {

    let payment = ScheduledPayment(title: "Xfinity", type: "Utility", amount: 39.40)
    let payment1 = ScheduledPayment(title: "Mortgage", type: "House payment", amount: 2000.40)
    let payment2 = ScheduledPayment(title: "Xfinity", type: "Utility", amount: 39.40)
    var list: List!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        list = List(list: [payment, payment1, payment2])
        setupNavigationBar()
        print("we reached here ", #line, #function)
        view.backgroundColor = payGray
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = payGreen
        tableView.register(StagedCell.self, forCellReuseIdentifier: "stageCell")
        tableView.register(PaymentCell.self, forCellReuseIdentifier: "cell")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
    }
    
    //MARK Nav controller
    func setupNavigationBar() {
        print(#function, #line)
        self.navigationItem.title = ""
        let imgv = UIImageView(image: #imageLiteral(resourceName: "Rectangle 8"))
        let btn = UIBarButtonItem(image: #imageLiteral(resourceName: "Rectangle 8"), style: .done, target: self, action: nil)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Mom's Accounts", style: .plain, target: self, action: nil)
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: payGreen]
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(presentAddRecoveryView))
        //navigationItem.rightBarButtonItem?.tintColor = mainGreen
    }
    
    @objc func presentAddRecoveryView() {
        //navigationController?.pushViewController(SchedulePaymentVC.self, animated: true)
        let schedulePaymentVC = SchedulePaymentVC()
        navigationController?.pushViewController(schedulePaymentVC, animated: true)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        if row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "stageCell") as? StagedCell
            cell?.imageView?.image = #imageLiteral(resourceName: "nextMonthPayments copy 3")
            return cell!
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? PaymentCell
        cell?.typeLabel.text = list.scheduledPayments[row].type
        cell?.titleLabel.text = list.scheduledPayments[row].title
        cell?.amount.text = "\(list.scheduledPayments[row].amount)"
        return cell!
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.scheduledPayments.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

