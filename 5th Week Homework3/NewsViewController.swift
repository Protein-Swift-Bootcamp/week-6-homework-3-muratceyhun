//
//  NewsViewController.swift
//  5th Week Homework3
//
//  Created by Murat Ceyhun Korpeoglu on 8.01.2023.
//

import UIKit

class NewsViewController: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        APICaller.shared.getNews { result in
            switch result {
            case .success(let response):
                print("******ERROR: \(response)")
            case .failure(let error):
                print("******ERROR: \(error)")
            }
            
        }
    }
    @IBAction func backButtonClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}

