//
//  HomeViewController.swift
//  MovieBoxFinal
//
//  Created by 2unni on 2/29/20.
//  Copyright © 2020 2unni. All rights reserved.
//

import UIKit
import SDWebImage
import SwiftyJSON
import YouTubePlayer
import Reachability

class HomeViewController: UIViewController ,UICollectionViewDelegate,UICollectionViewDataSource,ReloadDataDeleget,ReloadVideoURLDeleget{
    func reloadVideoURL(key: String) {
        myPlayer.isHidden = false
        myPlayer.loadVideoID(key)
    }
    
    @IBAction func watch(_ sender: Any) {
        myVideo = Video(id:movieList[6].id!,deleget: self)
        myVideo.getURL()
    }
    
    
    @IBOutlet weak var watchBtn: UIButton!
    @IBOutlet weak var myLbl: UILabel!
    @IBOutlet weak var mySegmat: UISegmentedControl!
    @IBOutlet weak var myBigImageView: UIImageView!
    private var networkingClient : NetworkClient!
    @IBOutlet weak var myPlayer: YouTubePlayerView!
    var movieList = [Movie]()
    @IBOutlet weak var myCollectionView: UICollectionView!
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    var detailsView = DetailsViewController()
    private var myMovies = MoviesReturn()
    let reachability = try! Reachability()
    var result : Bool?
    
    
    private var myVideo :  Video!
    override func viewDidLoad() {
        super.viewDidLoad()
        detailsView = self.storyboard?.instantiateViewController(withIdentifier: "detailsView") as! DetailsViewController
        
        
        screenSize = UIScreen.main.bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: screenWidth/4, height: screenWidth/3)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 10
        myCollectionView.collectionViewLayout = layout
        
        
        
    }
    
    
    func reloadMovies(_movies: [Movie]) {
        movieList = _movies
        self.myCollectionView.reloadData()
        myPlayer.isHidden = true
        myBigImageView.sd_setImage(with: URL(string: movieList[6].backdrop_path!), placeholderImage:UIImage(named: "cinema"))
        myLbl.text = movieList[6].original_title
        updateCoreData(movies: movieList)
    }
    
    @IBAction func valueChanged(_ sender: Any) {
        
        switch mySegmat.selectedSegmentIndex {
        case 0:
            checkReachability()
            if (result == true)
            {
                movieList = myMovies.myMovieList(url: "https://api.themoviedb.org/3/discover/movie?api_key=d048bec4f5e8f1dda36816ab99be899e&language=en-US&sort_by=popularity.desc", deleget: self)
                watchBtn.isEnabled = true
            }
            else
            {
                var coredata = MyOfflineData(appdeleget: UIApplication.shared.delegate as! AppDelegate)
                movieList = coredata.getMostPop() as! [Movie]
                self.myCollectionView.reloadData()
                myLbl.text = movieList[6].original_title
                myBigImageView.image = UIImage(named: "cinema")

                watchBtn.isEnabled = false
                
            }
            
        case 1:
            checkReachability()
            if (result == true)
            {
                movieList = myMovies.myMovieList(url: "https://api.themoviedb.org/3/discover/movie/?api_key=d048bec4f5e8f1dda36816ab99be899e&certification_country=US&certification=R&sort_by=vote_average.desc", deleget: self)
                watchBtn.isEnabled = true
                
            }
            else
            {
                var coredata = MyOfflineData(appdeleget: UIApplication.shared.delegate as! AppDelegate)
                movieList = coredata.getHighRated() as! [Movie]
                self.myCollectionView.reloadData()
                myLbl.text = movieList[6].original_title
                myBigImageView.image = UIImage(named: "cinema")
                watchBtn.isEnabled = false
            }
            
        default:
            break
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        myPlayer.isHidden = true
        mySegmat.selectedSegmentIndex = 0
        checkReachability()
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        if (result == true)
        {
            movieList = myMovies.myMovieList(url: "https://api.themoviedb.org/3/discover/movie?api_key=d048bec4f5e8f1dda36816ab99be899e&language=en-US&sort_by=popularity.desc", deleget: self)
            watchBtn.isEnabled = true
            
            
            
        }
        else
        {
            var coredata = MyOfflineData(appdeleget: UIApplication.shared.delegate as! AppDelegate)
            movieList = coredata.getMostPop() as! [Movie]
            print(movieList.count)
            self.myCollectionView.reloadData()
            myLbl.text = movieList[6].original_title
            myBigImageView.image = UIImage(named: "cinema")

            watchBtn.isEnabled = false
            
        }
    }
    
    func updateCoreData(movies : [Movie])  {
        var coredata = MyOfflineData(appdeleget: UIApplication.shared.delegate as! AppDelegate)
        if(mySegmat.selectedSegmentIndex == 0)
        {
            coredata.deleteMostPop()
            for movie in movieList
            {
                print("here")
                coredata.AddMovieToMostPop(movie: movie)
            }
        }
        else
        {
            coredata.deleteHighRated()
            for movie in movieList
            {
                print("here")
                coredata.AddMovieToHighRated(movie: movie)
            }
        }
    }
    func changeResult(res : Bool)
    {
        self.result = res
    }
    func checkReachability()
    {
        
        reachability.whenReachable = { reachability in
            print ("reachable")
            self.changeResult(res: true)
            
        }
        reachability.whenUnreachable = { _ in
            print("Not reachable")
            self.changeResult(res: false)
        }
        
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        
        return movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MyCollectionViewCell
        cell.myImg!.sd_setImage(with: URL(string: movieList[indexPath.row].poster_path!), placeholderImage:UIImage(named: "myPlaceHolder"))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        detailsView.imgpath = movieList[indexPath.row].poster_path
        detailsView.orgtitle = movieList[indexPath.row].original_title
        detailsView.rate = movieList[indexPath.row].vote_average
        detailsView.date = movieList[indexPath.row].release_date
        detailsView.overview = movieList[indexPath.row].overview
        detailsView.id = movieList[indexPath.row].id
        detailsView.theTitle = movieList[indexPath.row].title
        self.present(detailsView, animated: true, completion: nil)
        
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
