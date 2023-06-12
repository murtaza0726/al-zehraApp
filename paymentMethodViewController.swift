//
//  paymentMethodViewController.swift
//  al-zehraApp
//
//  Created by Murtaza Haider Naqvi on 2023-06-11.
//

import UIKit

class paymentMethodViewController: UIViewController {

    
    @IBOutlet var paymentMethodTableView: UITableView!
    
    var paymentType = [paymentMethod]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let visa = paymentMethod(paymentName: "VISA", paymentImage: "visa")
        paymentType.append(visa)
        let mastercard = paymentMethod(paymentName: "Mastcard", paymentImage: "mastercard")
        paymentType.append(mastercard)
        let AmericanExpress = paymentMethod(paymentName: "American Express", paymentImage: "americanexpress")
        paymentType.append(AmericanExpress)
        let delta = paymentMethod(paymentName: "Delta", paymentImage: "delta")
        paymentType.append(delta)
        let paypal = paymentMethod(paymentName: "Paypal", paymentImage: "paypal")
        paymentType.append(paypal)
        let westernUnion = paymentMethod(paymentName: "Western Union", paymentImage: "westernunion")
        paymentType.append(westernUnion)
    }
}

extension paymentMethodViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paymentType.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = paymentMethodTableView.dequeueReusableCell(withIdentifier: "paymentMethodTableViewCell", for: indexPath) as! paymentMethodTableViewCell
        cell.selectionStyle = .none
        self.paymentMethodTableView.separatorStyle = .none
        cell.paymentLabel?.adjustsFontSizeToFitWidth = true
        cell.paymentLabel?.font = UIFont.systemFont(ofSize: 12.0)
        cell.paymentLabel?.text = paymentType[indexPath.row].paymentName
        cell.paymentImage.image = UIImage(named: paymentType[indexPath.row].paymentImage)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let addCartVC = storyboard?.instantiateViewController(withIdentifier: "cardDataViewController") as? cardDataViewController
        addCartVC?.onePaymentType = paymentType[indexPath.row]
        navigationController?.pushViewController(addCartVC!, animated: true)
    }
}
