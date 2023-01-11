//
//  EntranceViewController.swift
//  5th Week Homework3
//
//  Created by Murat Ceyhun Korpeoglu on 11.01.2023.
//

import UIKit

class EntranceViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        title = "NEWS"
    }
    
    @IBAction func startButtonClicked(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "NewsNavCont")
        destinationVC.modalTransitionStyle = .flipHorizontal
        destinationVC.modalPresentationStyle = .fullScreen
        present(destinationVC, animated: true, completion: nil)
    }
}
