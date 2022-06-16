//
//  DateViewController.swift
//  EPIC
//
//  Created by Francisco Lopez on 14/06/2022.
//

import UIKit

class DateViewController: UIViewController {

    private var viewProgress: UIActivityIndicatorView!
    @IBOutlet weak var theTableView: UITableView!
    private var theDates = [DateResult]()
    
    private var presenter = DatePresenter(getService: APIManager())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.presenter.attachView(view: self)
        self.presenter.getDatetList()
        registerCell()
        theTableView.delegate = self
        theTableView.dataSource = self
    }

    func registerCell(){
        self.theTableView.register(UINib(nibName: "DateTVCell", bundle: nil), forCellReuseIdentifier: "dateCell")
    }
}

extension DateViewController {
    func setupView(){
        self.setupProgressView()
    }
    
    func setupProgressView(){
        self.viewProgress = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        self.viewProgress.center = self.view.center
        self.viewProgress.isHidden = true
        self.view.addSubview(self.viewProgress)
    }
}

extension DateViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.theDates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dateCell", for: indexPath)
        
        if let dateCell = cell as? DateTVCell{
            var newSort = theDates
                newSort.sort{
                $1.date > $0.date
            }
            dateCell.setup(dateCell: newSort[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedDate = theDates[indexPath.row]
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "PhotosListViewController") as? PhotosListViewController {
            vc.theDate = selectedDate.date
            self.navigationController!.pushViewController(vc, animated: true)
        }
    }
}

extension DateViewController: DateView {
    func startLoading() {
        viewProgress.isHidden = false
        viewProgress.startAnimating()
    }
    
    func stopLoading() {
        DispatchQueue.main.async {
            self.viewProgress.stopAnimating()
            self.viewProgress.hidesWhenStopped = true
        }
    }
    
    func ShowData(_ dates: [DateResult]) {
        self.theDates = dates
        DispatchQueue.main.async {
            self.theTableView.reloadData()
        }
    }
}
