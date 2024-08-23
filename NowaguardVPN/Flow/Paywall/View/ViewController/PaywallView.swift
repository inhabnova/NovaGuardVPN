import Foundation

protocol PaywallView: AnyObject {
    func setOwnPurcshase(trialCount: Int, price: String, period: String)
    func setThreePurcshase(dataPurchase: [(Int, String)])
    func showBackButton()
    func showErrorAlert()
}

