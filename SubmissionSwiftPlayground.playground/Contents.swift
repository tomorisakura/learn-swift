import UIKit

struct Customer {
    var name : String
    var address : String
    var job : String
    var dateBirth : Date
    var isMerried : Bool
    var sallary : Double
    var dependent : Int? = nil
}

enum LoanType {
    case kreditAnggunan
    case kreditTanpaAnggunan
}

protocol Loan {
    func countTanggungan(customer : Customer, anggunan:Double, multiple:Int) ->Double
    func countWithoutTanggunan(customer: Customer, anggunan:Double, multiple:Int) -> Double
}

class LoanCount : Loan {
    var customer: Customer
    
    init(customer:Customer) {
        self.customer = customer
    }
    
    func hitung(loan: LoanType) -> Double {
        var result : Double = 0.0
        switch loan {
        case .kreditTanpaAnggunan:
            if customer.isMerried && customer.dependent != nil {
                result = countTanggungan(customer: self.customer, anggunan: 0.15, multiple: 12)
            } else {
                result = countWithoutTanggunan(customer: self.customer, anggunan: 0.15, multiple: 12)
            }
            
        case .kreditAnggunan:
            if customer.isMerried && customer.dependent != nil {
                result = countTanggungan(customer: self.customer, anggunan: 0.25, multiple: 24)
            } else {
                result = countWithoutTanggunan(customer: self.customer, anggunan: 0.25, multiple: 24)
            }
        }
        return result
    }
    
    func countTanggungan(customer : Customer, anggunan:Double, multiple:Int) ->Double {
        var tempDependent = 0.0
        for _ in 0..<customer.dependent! {
            tempDependent += 0.02
        }
        let result = customer.sallary * (anggunan - tempDependent) * Double(multiple)
        return result
    }
    
    func countWithoutTanggunan(customer: Customer, anggunan:Double, multiple:Int) -> Double {
        return (customer.sallary * anggunan) * Double(multiple)
    }
}

var format = DateFormatter()
format.dateFormat = "yyyy-MM-dd"
var nasabah = Customer(name: "Soel Dalmi", address: "Deket Sungai Han",
                      job: "System Designer", dateBirth: format.date(from: "1999-02-18")!,
                      isMerried: true, sallary: 14000000, dependent: 2)

var pinjaman = LoanCount(customer: nasabah)
print(nasabah)
print("Sallary : \(nasabah.sallary)")
print("Loan : \(pinjaman.hitung(loan: LoanType.kreditAnggunan))")
