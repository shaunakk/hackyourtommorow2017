import Foundation

struct Expense {
    var title: String
    var type: String
    var amount: Double
}

struct ScheduledPayment {
    var title: String
    var type: String
    var amount: Double
}

class List {
    var scheduledPayments: [ScheduledPayment]
    init(list: [ScheduledPayment]) {
        self.scheduledPayments = list
    }
}


