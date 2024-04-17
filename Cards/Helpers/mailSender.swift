//
//  mailSender.swift
//  Cards
//
//  Created by Valid Mohammadi on 17.04.2024.
//

import SwiftUI
import MessageUI


func sendEmail() {
   
    guard MFMailComposeViewController.canSendMail() else {
        
        let alert = UIAlertController(title: "Cannot Send Email", message: "Please ensure you have set up an email account on your device and have an active internet connection to send email.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true)
        return
    }

    let mailComposer = MFMailComposeViewController()
    mailComposer.setToRecipients(["mohammadivalid@gmail.com"])
    mailComposer.setSubject("Feedback")
    mailComposer.setMessageBody("Enter your feedback here.", isHTML: false)
    UIApplication.shared.windows.first?.rootViewController?.present(mailComposer, animated: true)
}
