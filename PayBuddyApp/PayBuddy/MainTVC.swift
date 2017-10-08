

import UIKit



class StagedCell: UITableViewCell {
    let img = UIImageView()
   
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(img)
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        img.translatesAutoresizingMaskIntoConstraints = false
        
        img.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        img.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        img.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        img.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class MainTVC: UITableViewController  {

    var userEmail: String?
    var password: String?
    var expenses: [Expense] = [Expense(title: "XFinity", type: "Utility", amount: 39.00)]
    var isOn = true
    var counter = 0
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        getExpenses()
        view.backgroundColor = payGray
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = payGreen
        //title = "Expenses"
        setupNavigationBar()
        tableView.register(PaymentCell.self, forCellReuseIdentifier: "payCell")
        tableView.register(StagedCell.self, forCellReuseIdentifier: "stageCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
        tabBarItem.selectedImage = #imageLiteral(resourceName: "btn-expenses-on")
        counter += 1
        if counter >= 2 {
            isOn = false
            tableView.reloadData()
        }
    }



    func setupNavigationBar() {
        print(#function, #line)
        self.navigationItem.title = ""
        let imgv = UIImageView(image: #imageLiteral(resourceName: "Rectangle 8"))
           let btn = UIBarButtonItem(image: #imageLiteral(resourceName: "Rectangle 8"), style: .done, target: self, action: nil)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Mom's Accounts", style: .plain, target: self, action: nil)

        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: payGreen]
    }
    
    @objc func presentAddRecoveryView()  {
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expenses.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        if row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "stageCell") as? StagedCell
            cell?.imageView?.image = #imageLiteral(resourceName: "deNewGraph")
            return cell!
        } else if row == 1 && isOn {
            let cell = tableView.dequeueReusableCell(withIdentifier: "payCell") as? PaymentCell
            cell?.titleLabel.text = "PEOPLE MAGAZINE SUBSCRIPTIONS"
            cell?.typeLabel.text = "Luxury"
            cell?.amount.text = "$175.00"
            let imgV = UIImageView(frame: CGRect(x: 0, y: 0, width: 5, height: (cell?.frame.height)!))
            imgV.image = #imageLiteral(resourceName: "btn-green copy")
            imgV.image = imgV.image!.withRenderingMode(.alwaysTemplate)
            imgV.tintColor = UIColor(red:1.00, green:0.43, blue:0.01, alpha:1.0)
            cell?.addSubview(imgV)
            return cell!
        } else if row == 1 && !isOn {
            let cell = tableView.dequeueReusableCell(withIdentifier: "payCell") as? PaymentCell
            let imgV = UIImageView(frame: CGRect(x: 0, y: 0, width: 5, height: (cell?.frame.height)!))
            imgV.image = #imageLiteral(resourceName: "btn-green copy")
            imgV.image = imgV.image!.withRenderingMode(.alwaysTemplate)
            imgV.tintColor = .white
            cell?.addSubview(imgV)
            cell?.titleLabel.text = expenses[row].title
            
            /*.characters.map {
             let s = String($0)
             let val = false
             if s == " " {
             }*/
            cell?.typeLabel.text = expenses[row].type
            cell?.amount.text = "$\(expenses[row].amount)"
            return cell!
        }
        
        /*
         theImageView.image = theImageView.image!.withRenderingMode(.alwaysTemplate)
         theImageView.tintColor = UIColor.red
         */
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "payCell") as? PaymentCell
        cell?.titleLabel.text = expenses[row].title
        
        /*.characters.map {
         let s = String($0)
         let val = false
         if s == " " {
         }*/
        cell?.typeLabel.text = expenses[row].type
        cell?.amount.text = "$\(expenses[row].amount)"
        return cell!
    }
        
    

    func getExpenses() {
        let url = URL(string: "http://hackyourtommorow.herokuapp.com/historydata")
        let task = URLSession.shared.dataTask(with: url!) {
            (data, response, error) in
            if let err = error {
                print(err, "<<<-SL")
            }
            print(data!)
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [[String: String]]
                print("we got the json<<<<<<")
                if let json = json {
                    for expenseDict in json {
                        if let expense = expenseDict["expense"], let date = expenseDict["date"], let amount = expenseDict["amount"], let expenseType = expenseDict["mcc"] {
                            self.expenses.append(Expense(title: expense, type: expenseType, amount: Double(amount)!))
                        }
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                }
            } catch {
                print("catching error from jsonSerialization")
            }
        }
        task.resume()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 300
        } else {
            return 100
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let turntOff = TurnOffVC()
        turntOff.theTitle = expenses[indexPath.row].title
        turntOff.title = expenses[indexPath.row].title
        navigationController?.pushViewController(turntOff, animated: true)
    }
}




extension UITabBarItem {
    func tabBarItemShowingOnlyImage() -> UITabBarItem {
        // offset to center
        self.imageInsets = UIEdgeInsets(top:6,left:0,bottom:-6,right:0)
        // displace to hide
        self.titlePositionAdjustment = UIOffset(horizontal:0,vertical:30000)
        return self
    }
}
