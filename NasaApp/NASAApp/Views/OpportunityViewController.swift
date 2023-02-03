//
//  OpportunityViewController.swift
//  NASAApp
//
//  Created by Şehriban Yıldırım on 30.01.2023.
//

import UIKit
import SDWebImage

class OpportunityViewController: UIViewController {

    @IBOutlet weak var opportunityCollectionview: UICollectionView!
    private var originalPhotos: [SpiritPhoto] = [SpiritPhoto]()
    private var filterPhotos: [SpiritPhoto] = [SpiritPhoto]()
    
    var cameras = ["navcam","pancam","fhaz","rhaz","mast","chemcam","mahli","mardi"]
    var data:[SpiritPhoto] = []
    
    var displayImages: [SpiritPhoto] = Array()
    var filterCameraName = ""
    var limit = 5
    var totalImages = 0
    var index = 0
    
    let pickerView = UIPickerView()
    
    let viewModel = NasaViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        VeriAl()
        pickerViewDesing()
    }
    
    func VeriAl() {
        let url = URL(string: "https://api.nasa.gov/mars-photos/api/v1/rovers/opportunity/photos?sol=1000&api_key=DEMO_KEY")
        WebService().spiritandopportunityDownload(url: url!) { (datalar) in
            if let datalar = datalar{
                DispatchQueue.main.async {
                    self.data = datalar
                    self.originalPhotos = datalar
                    NasaViewModel.shared.spiritandopportunityphoto = datalar
                    self.totalImages = self.data.count
                    while self.index < self.limit {
                        self.displayImages.append(self.data[self.index])
                        self.index += 1
                    }
                    
                    self.opportunityCollectionview.dataSource = self
                    self.opportunityCollectionview.delegate = self
                    self.opportunityCollectionview.reloadData()
                }
            }
        }
    }
    func pickerViewDesing(){
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.isHidden = true
        view.addSubview(pickerView)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chart.bar"), style: .done, target: self, action: #selector(filter))
        pickerView.backgroundColor = .systemGray
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pickerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pickerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            pickerView.widthAnchor.constraint(equalTo: view.widthAnchor),
            pickerView.heightAnchor.constraint(equalToConstant: 216),
            ])
    }
    
    func removeTransparentView() {
        let frames = CGRect(x: 0, y: 0, width: 200, height: 200)
        UIView.animate(withDuration: 0.4, delay: 0.0,  usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut) {
            self.pickerView.alpha = 0
            self.pickerView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
        }
    }
    func allTransparentView() {
        let frames = CGRect(x: 0, y: 0, width: 200, height: 200)
        UIView.animate(withDuration: 0.4, delay: 0.0,  usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut) {
            self.pickerView.alpha = 1
            self.pickerView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
        }
    }
    
    @objc func filter() {
        allTransparentView()
        pickerView.isHidden = false
    }

}
extension OpportunityViewController : UICollectionViewDataSource, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return displayImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "opportunityhucre", for: indexPath) as! OpportunityCollectionViewCell
        let nasaViewModel = displayImages[indexPath.row]
        let imageURL = URL(string: nasaViewModel.imgSrc)
        cell.imageview.sd_setImage(with: imageURL)
        return cell
  }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = PopUpScreen()
        vc.otherphoto = data
        vc.photo = []
        vc.index = indexPath.row
        vc.apear(sender: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == displayImages.count-1 {
            var index = displayImages.count-1
            if index+10 > data.count-1{
                limit = data.count-index
            }
            else {
                 limit = index + 10
            }
            while index < limit {
                if self.filterCameraName == "" {
                    displayImages.append(data[index])
                    index += 1
                }
                else {
                    displayImages = []
                    for _ in 0...data.count-1 {
                        let dataCamera = "\(data[index].camera.name)"
                        if dataCamera == self.filterCameraName {
                            displayImages.append(data[index])
                            index += 1
                        }
                    }
                }
            }
            self.perform(#selector(loadData),with: nil, afterDelay: 0.5)
        }
    }
    @objc func loadData() {
        self.opportunityCollectionview.reloadData()
    }
}

extension OpportunityViewController:UIPickerViewDelegate,UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cameras.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cameras[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let cameraName = cameras[row]
        self.filterCameraName = cameras[row]
        guard let url = URL(string: "https://api.nasa.gov/mars-photos/api/v1/rovers/opportunity/photos?sol=1000&camera=\(cameraName)&page=0&api_key=ZBGxwNTkOJXhcEQjaXPMxok9Bq5cpBmVnjOsHEQu") else { return }
        WebService().filterRover2(url: url) { (photos) in
            if let photos = photos {
                DispatchQueue.main.async {
                    self.displayImages = photos
                    self.data = photos
                    self.opportunityCollectionview.reloadData()
                }
            }
        }
        removeTransparentView()
    }
}


