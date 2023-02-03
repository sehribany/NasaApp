//
//  PopUpScreen.swift
//  NASAApp
//
//  Created by Şehriban Yıldırım on 1.02.2023.
//

import UIKit
import SDWebImage

class PopUpScreen: UIViewController {
    @IBOutlet weak var backview: UIView!
    @IBOutlet weak var contentview: UIView!
    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var eartdate: UILabel!
    @IBOutlet weak var vehicle: UILabel!
    @IBOutlet weak var camera: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var launchdate: UILabel!
    @IBOutlet weak var landingdate: UILabel!
    @IBAction func backbutton(_ sender: Any) {
        hide()
    }
    var photo : [Photo] = [Photo]()
    var otherphoto : [SpiritPhoto] = [SpiritPhoto]()
    var index: Int?
    
    init(){
        super.init(nibName: "PopUpScreen", bundle: nil)
        self.modalPresentationStyle = .overFullScreen
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if photo.count != 0{
            let imageURL = URL(string: photo[index ?? 0].imgSrc)
            imageview.sd_setImage(with: imageURL)
            camera.text = "Camera: \( photo[index ?? 0].camera.name)"
            landingdate.text = "Landing Date: \(photo[index ?? 0].rover.landingDate)"
            launchdate.text = "Launch Date: \(photo[index ?? 0].rover.launchDate)"
            status.text = "Status: \(photo[index ?? 0].rover.status)"
            eartdate.text = "Earth Date: \(photo[index ?? 0].earthDate)"
            vehicle.text = "Vehicle: \(photo[index ?? 0].rover.name)"
        }else{
            let imageURL = URL(string: otherphoto[index ?? 0].imgSrc)
            imageview.sd_setImage(with: imageURL)
            camera.text = "Camera: \(otherphoto[index ?? 0].camera.name)"
            landingdate.text = "Landing Date: \(otherphoto[index ?? 0].rover.landingDate)"
            launchdate.text = "Launch Date: \(otherphoto[index ?? 0].rover.launchDate)"
            status.text = "Status: \(otherphoto[index ?? 0].rover.status)"
            eartdate.text = "Earth Date: \(otherphoto[index ?? 0].earthDate)"
            vehicle.text = "Vehicle: \(otherphoto[index ?? 0].rover.name)"
        }
        configView()
    }

    func configView(){
        self.view.backgroundColor = .clear
        self.backview.backgroundColor = .black.withAlphaComponent(0.6)
        self.backview.alpha = 0
        self.contentview.alpha = 0
        self.contentview.layer.cornerRadius = 10
    }
    
    func apear(sender : UIViewController){
        sender.present(self, animated: false) {
            self.show()
        }
    }
    
    private func show(){
        UIView.animate(withDuration: 1, delay: 0.1) {
            self.backview.alpha = 1
            self.contentview.alpha = 1
        }
    }
    
    func hide(){
        UIView.animate(withDuration: 1, delay: 0.0, options: .curveEaseOut){
            self.backview.alpha = 0
            self.contentview.alpha = 0
        }completion: { _ in
            self.dismiss(animated: false)
            self.removeFromParent()
        }
    }
}
