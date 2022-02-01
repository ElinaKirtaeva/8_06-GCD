//
//  SecondViewController.swift
//  8_06 GCD
//
//  Created by Элина Рупова on 31.01.2022.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityInd: UIActivityIndicatorView!
    fileprivate var imageURL: URL?
    fileprivate var image: UIImage? {
        get {
            return imageView.image
        }
        
        set {
            activityInd.stopAnimating()
            activityInd.isHidden = true
            imageView.image = newValue
            imageView.sizeToFit()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchImage()
        delay(3) {
            self.loginAlert()
        }
        
        // Do any additional setup after loading the view.
    }
    
    func loginAlert() {
        let ac = UIAlertController(title: "Зарегистрированы?", message: "Введите ваш логин и пароль", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        ac.addAction(okAction)
        ac.addAction(cancelAction)
        ac.addTextField { (userNameTF) in
            userNameTF.placeholder = "Enter login"
        }
        ac.addTextField { (userPasswordTF) in
            userPasswordTF.placeholder = "Enter password"
            userPasswordTF.isSecureTextEntry = true
        }
        
        self.present(ac, animated: true, completion: nil)
    }
    
    fileprivate func fetchImage() {
        imageURL = URL(string: "https://images.pexels.com/photos/8644153/pexels-photo-8644153.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260")
        activityInd.isHidden = false
        activityInd.startAnimating()
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            var a = 0
            for _ in 0...10000000 {
                a = a + 1
            }
            guard let url = self.imageURL, let imageData = try? Data(contentsOf: url) else {return}
            DispatchQueue.main.async {
                self.image = UIImage(data: imageData)
            }
        }
        
    }
    
    func delay(_ delay: Int, closure: @escaping() ->()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delay)){
            closure()
        }
    }
}
