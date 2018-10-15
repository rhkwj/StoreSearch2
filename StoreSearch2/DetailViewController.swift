//
//  DetailViewController.swift
//  StoreSearch2
//
//  Created by Kim Yeon Jeong on 2018/10/14.
//  Copyright © 2018 Kim Yeon Jeong. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        modalPresentationStyle = .custom
        transitioningDelegate = self
    }
    // MARK:- Actions
    
    
    @IBAction func close() {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var artworkImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var kindLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var priceButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.tintColor = UIColor(red: 20/255, green: 160/255,blue: 160/255, alpha: 1)
        popupView.layer.cornerRadius = 10

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DetailViewController: UIViewControllerTransitioningDelegate {
    func presentationController(
        forPresented presented: UIViewController,
        presenting: UIViewController?, source: UIViewController) ->
        UIPresentationController? {
            return DimmingPresentationController(
                presentedViewController: presented,
                presenting: presenting)
    }
}
