//
//  DetailsViewController.swift
//  MovieBoxFinal
//
//  Created by 2unni on 3/13/20.
//  Copyright © 2020 2unni. All rights reserved.
//

import UIKit
import Cosmos
import SDWebImage
import YouTubePlayer
import Reachability



class DetailsViewController: UIViewController,ReloadVideoURLDeleget{
    
    
    
    @IBOutlet weak var myImg: UIImageView!
    @IBOutlet weak var myTitle: UILabel!
    @IBOutlet weak var starsView: CosmosView!
    @IBOutlet weak var myDate: UILabel!
    @IBOutlet weak var myOverView: UILabel!
    @IBOutlet weak var myPlayer: YouTubePlayerView!
    @IBOutlet weak var myPopup: UIView!
    
    var imgpath : String?
    var orgtitle : String?
    var rate : Double?
    var date : String?
    var overview : String?
    var id: Int?
    var theTitle : String?
    
    var isFavorite : Bool?
    
    private var myVideo :  Video!
    
    var coredata : MyOfflineData!
    var reviewsView = ReviewsTableViewController()
    
    let reachability = try! Reachability()
    override func viewDidLoad() {
        super.viewDidLoad()
        reviewsView = self.storyboard?.instantiateViewController(withIdentifier: "reviewsView") as! ReviewsTableViewController
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var watchBtn: UIButton!
    @IBOutlet weak var checkBtn: UIButton!
    override func viewWillAppear(_ animated: Bool) {
        myImg.sd_setImage(with: URL(string: imgpath!), placeholderImage:UIImage(named: "myPlaceHolder"))
        myTitle.text = orgtitle
        starsView.settings.updateOnTouch = false
        starsView.settings.fillMode = .precise
        starsView.rating = rate!/2
        myDate.text = date
        myOverView.text = overview
        myPlayer.isHidden = true
        myPopup.isHidden = true
        
        
        coredata = MyOfflineData(appdeleget: UIApplication.shared.delegate as! AppDelegate)
        isFavorite = coredata.doExist(id: id!)
        
        if(isFavorite == true)
        {
            favBtn.setImage(UIImage(named: "fill"), for: .normal)
        }
        else
        {
            favBtn.setImage(UIImage(named: "empty"), for: .normal)
        }
        
        
        

        reachability.whenReachable = { reachability in
            self.watchBtn.isEnabled = true
            self.checkBtn.isEnabled = true
            
        }
        reachability.whenUnreachable = { _ in
            self.watchBtn.isEnabled = false
            self.checkBtn.isEnabled = false
        }

        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func watchAction(_ sender: Any) {
        print(id)
        myVideo = Video(id:id!,deleget: self)
        myVideo.getURL()
        
    }
    
    func reloadVideoURL(key: String) {
        myPlayer.isHidden = false
        myPlayer.loadVideoID(key)
    }
    
    @IBAction func tapAction(_ sender: Any) {
        myPlayer.isHidden = true
    }
    
    @IBAction func checkReviews(_ sender: Any) {
        reviewsView.id = id
        self.present(reviewsView, animated: true, completion: nil)
        
    }
    
    

    @IBOutlet weak var favBtn: UIButton!
    @IBAction func favCkicked(_ sender: Any) {
        
        if(isFavorite == false)
        {
            var movie = Movie(id: id!, title: theTitle!, poster:imgpath!, rate: rate!)
            coredata.AddMovieToFavorites(movie: movie)
            favBtn.setImage(UIImage(named: "fill"), for: .normal)
        }
        else if (isFavorite == true)
        {
            myPopup.isHidden = false
        }
        
        
    }
    
    @IBAction func sureAction(_ sender: Any) {
        coredata.deleteMoviesFromFav(id: id!)
        myPopup.isHidden = true
        favBtn.setImage(UIImage(named: "empty"), for: .normal)
        
    }
    @IBAction func cancelAction(_ sender: Any) {
        myPopup.isHidden = true
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
