//
//  FirstViewController.swift
//  URL Shortener
//
//  Created by Ryan on 2020-04-21.
//  Copyright © 2020 Ryan Ball. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    let dispatchGroup = DispatchGroup()

    var longURL = ""
    var shortURL = ""
    
    func run(after seconds: Int, completion: @escaping () -> Void) {
        let deadline = DispatchTime.now() + .seconds(seconds)
        DispatchQueue.main.asyncAfter(deadline: deadline) {
            completion()
        }
    }
    
    @IBOutlet weak var urlText: UITextField!
    @IBAction func shortenButton(_ sender: UIButton) {
        let urlInput = (urlText.text)!
        print(urlInput)

        let url = URL(string: "https://api.shrtco.de/v2/shorten?url=" + urlInput)!
        //let url = URL(string: "https://api.shrtco.de/v2/shorten?url=google.ca")!
        
        print("Shortening link")
        shortenLink(url: url)
        
        dispatchGroup.notify(queue: .main) {
            //self.showAlert()
            //this self.showAlert() gives error Thread 1: Exception: "-[URL_Shortener.FirstViewController urlTextBox:]: unrecognized selector sent to instance 0x7fdca8d0ae80"
        }
    }
    
    func shortenLink(url: URL) {
        dispatchGroup.enter()
        run(after: 2) {
            //create the session object
            let session = URLSession.shared

            //now create the URLRequest object using the url object
            let request = URLRequest(url: url)

            //create dataTask using the session object to send data to the server
            let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in

                guard error == nil else {
                    return
                }

                guard let data = data else {
                    return
                }

                do {
                    //create json object from data
                    if let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] {
                        if let result = json["result"] as? [String: Any] {
                            if let generatedURL = result["full_short_link"] as? String {
                                self.shortURL = generatedURL
                                print(self.shortURL)
                            }
                            if let ogURL = result["original_link"] as? String {
                                self.longURL = ogURL
                                print(self.longURL)
                            }
                            self.dispatchGroup.leave()
                        }
                    }
                    DispatchQueue.main.async {
                        self.urlText.text = "Copied new link to clipboard: " + self.shortURL
                        
                        let pasteboard = UIPasteboard.general
                        pasteboard.string = self.shortURL
                        
                        //self.copyToClipboard() also does not work here
                        
                        //self.showAlert()
                        //this self.showAlert() gives error Thread 1: Exception: "-[URL_Shortener.FirstViewController urlTextBox:]: unrecognized selector sent to instance 0x7fd038c05ff0"
                    }
                } catch let error {
                    print(error.localizedDescription)
                }
            })
            task.resume()
        }
    }
    
    func continueProcessing() {
        self.urlText.text = "Copied new link to clipboard: " + self.shortURL
        self.copyToClipboard()
        
        //self.showAlert()
        //also gives Thread 1: Exception: "-[URL_Shortener.FirstViewController urlTextBox:]: unrecognized selector sent to instance 0x7fb7bfc0dfd0"
    }
    
    func copyToClipboard() {
        let pasteboard = UIPasteboard.general
        pasteboard.string = self.shortURL
    }
    
    func showAlert() {
        let msg = String(self.longURL + " -> " + self.shortURL)
        let alert = UIAlertController(title: "Result",
                                      message: msg,
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "Copy To Clipboard", style: .default,
                                   handler: { action in
                                    self.copyToClipboard() })
//        let action = UIAlertAction(title: "Save & Copy", style: .default,
//                                   handler: { action in
//                                    self.SaveAndCopyToClipboard() })
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}

