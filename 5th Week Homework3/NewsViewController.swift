//
//  NewsViewController.swift
//  5th Week Homework3
//
//  Created by Murat Ceyhun Korpeoglu on 8.01.2023.
//

import UIKit
import AVKit
import AVFoundation
import SafariServices

class NewsViewController: UIViewController {
    
    @IBOutlet weak var newsCollectionView: UICollectionView!
    
    private var articles = [Article]()
    
    private var viewModels = [NewsCollectionViewCellViewModel]()
    

    fileprivate func fetchNews() {
        APICaller.shared.getNews { [weak self] result in
            switch result {
            case .success(let articles):
                self?.articles = articles
                self?.viewModels = articles.compactMap({
                    NewsCollectionViewCellViewModel(author: $0.author ?? "No Author",
                                                    title: $0.title ?? "No Title",
                                                    imageURL: URL(string: $0.urlToImage ?? ""))
                    
                })
                
                DispatchQueue.main.async {
                    self?.newsCollectionView.reloadData()
                }
            case .failure(let error):
                print("******ERROR: \(error)")
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsCollectionView.delegate = self
        newsCollectionView.dataSource = self
        newsCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
        
        fetchNews()
        
//        newsCollectionView.contentInset = UIEdgeInsets(top: 12, left: 4, bottom: 12, right: 4)
        
//        if let layout = newsCollectionView?.collectionViewLayout as? PinterestLayout {
//            layout.delegate = self
//        }
    }
    
    
    @IBAction func backButtonClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
//MARK: -DELEGATE and DATASOURCE
    

}

extension NewsViewController: UICollectionViewDelegate {
    
}

extension NewsViewController: UICollectionViewDataSource {
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! NewsCollectionViewCell
        cell.configure(with: viewModels[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        collectionView.deselectItem(at: indexPath, animated: true)
        let articles = articles[indexPath.row]
        
        
        
        guard let url = URL(string: articles.url ?? "") else { return }
        
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true, completion: nil)
    }
    
    
}

//extension NewsViewController : PinterestLayoutDelegate {
//    func collectionView(collectionView: UICollectionView, heightForPhotoAt indexPath: IndexPath, with width: CGFloat) -> CGFloat {
//
//        var article = articles[indexPath.item]
//        if let photo = article.urlToImage {
//
//            let boundingRect = CGRect(x: 0, y: 0, width: width, height: CGFloat(MAXFLOAT))
//
//            let rect = AVMakeRect(aspectRatio: <#T##CGSize#>, insideRect: <#T##CGRect#>)
//
//            return rect.size.height
//
//        }
//
//        return 0
//    }
//
//    func collectionView(collectionView: UICollectionView, heightForCaptionAt indexPath: IndexPath, with width: CGFloat) -> CGFloat {
//        return 0.0
//
//
//    }
//}
//
//
//
//
//
extension NewsViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 209, height: 300)
    }
}
