//
//  PhotosListViewController.swift
//  EPIC
//
//  Created by Francisco Lopez on 14/06/2022.
//

import UIKit

class PhotosListViewController: UIViewController {

    var theDate: String?
    private var viewProgress: UIActivityIndicatorView!
    private var theObjects = [PhotoResult]()
    private var theList: [PhotoList] = []
    private var searchPhotos = [PhotoList]()
    
    @IBOutlet weak var photoCollection: UICollectionView!
    
    
    private var presenter = PhotoListPresenter(getService: APIManager())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.presenter.attachView(view: self)
        photoCollection.delegate = self
        photoCollection.dataSource = self
    }
    
    @IBAction func playerBtn(_ sender: Any) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "PlayerViewController") as? PlayerViewController {
            let item = theList
            vc.photosArr = item
            self.navigationController!.pushViewController(vc, animated: true)
        }
    }
}

extension PhotosListViewController {
    
    
    func setupView(){
        self.setupProgressView()
        self.startSearch()
    }
    
    func startSearch(){
        let query = theDate
        self.presenter.getPhotostDate(query: query ?? "")
    }
    
    func setupProgressView(){
        self.viewProgress = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        self.viewProgress.center = self.view.center
        self.viewProgress.isHidden = true
        self.view.addSubview(self.viewProgress)
    }
    
    func starPhotoListRequest(){
        if theObjects.count > 0 {
            for i in self.theObjects{
                
                let dateFormatterGet = DateFormatter()
                dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
                
                let dateFormatterPrint = DateFormatter()
                dateFormatterPrint.dateFormat = "yyyy/MM/dd"
                
                let date: Date? = dateFormatterGet.date(from: i.date)
                print(dateFormatterPrint.string(from: date!))

                let object = PhotoList(identifier: i.identifier, date: dateFormatterPrint.string(from:date!))
                theList.append(object)
                
            }
            searchPhotos = theList
            print("SEARCH FOTOS! \(searchPhotos.count)")
        }
        DispatchQueue.main.async {
            self.photoCollection.reloadData()
        }
    }
    
    
}

extension PhotosListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.searchPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCVCell", for: indexPath) as! PhotoCVCell
        
        
        if let photo = searchPhotos[indexPath.row] as? PhotoList {
            cell.activityIndicator.isHidden = false
            cell.activityIndicator.startAnimating()
            cell.setup(photoModel: photo)
        }
        cell.activityIndicator.stopAnimating()
        cell.activityIndicator.isHidden = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedItem = searchPhotos[indexPath.row]
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "PhotoScreenViewController") as? PhotoScreenViewController{
            vc.theDate = selectedItem.date
            vc.theIdentifier = selectedItem.identifier
            self.navigationController!.pushViewController(vc, animated: true)
        }
    }
}

extension PhotosListViewController: PhotoListView {

    func startLoading() {
        DispatchQueue.main.async {
            self.viewProgress.isHidden = false
            self.viewProgress.startAnimating()
        }
    }
    
    func stopLoading() {
        DispatchQueue.main.async {
            self.viewProgress.stopAnimating()
            self.viewProgress.hidesWhenStopped = true
        }
    }
    
    func ShowData(_ photos: [PhotoResult]) {
        self.theObjects = photos
        self.starPhotoListRequest()
       
    }
}
