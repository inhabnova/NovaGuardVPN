import UIKit
import MessageUI

protocol SettingsView: AnyObject, MFMailComposeViewControllerDelegate {
    func showVC(_ vc: UIViewController)
    func showErrorAlert()
    func showAlert(title: String, message: String)
}

