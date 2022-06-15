//
//  PhotoScreenViewController.swift
//  EPIC
//
//  Created by Francisco Lopez on 14/06/2022.
//

import UIKit

class PhotoScreenViewController: UIViewController {

    var theDate: String?
    var theIdentifier: String?
    var epicPhoto: UIImage?
    private var viewProgress: UIActivityIndicatorView!
    
    @IBOutlet weak var theImageView: UIImageView!
    
    private var presenter = PhotoPresenter(getService: APIManager())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter.attachView(view: self)
    }
}

extension PhotoScreenViewController {
    
    func setupView(){
        self.setupProgressView()
        self.startSearch()
       
    }
    
    func startSearch(){
        let theDate = theDate
        let query = theIdentifier
        self.presenter.getPhoto(theDate ?? "", query ?? "")
    }
    
    func setupProgressView(){
        self.viewProgress = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        self.viewProgress.center = self.view.center
        self.viewProgress.isHidden = true
        self.view.addSubview(self.viewProgress)
    }
}

extension PhotoScreenViewController: PhotoView {
    func startLoading() {
        self.viewProgress.isHidden = false
        self.viewProgress.startAnimating()
    }
    
    func stopLoading() {
        DispatchQueue.main.async {
            self.viewProgress.stopAnimating()
            self.viewProgress.hidesWhenStopped = true
        }
    }
    
    func ShowData(_ photo: Any) {
        self.epicPhoto = photo as? UIImage
        DispatchQueue.main.async {
            self.theImageView.image = self.epicPhoto
        }
    }
}
