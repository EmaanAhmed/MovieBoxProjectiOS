//
//  NetworkClient.swift
//  MovieBoxFinal
//
//  Created by 2unni on 2/29/20.
//  Copyright © 2020 2unni. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class NetworkClient
{
    var mydel : ReloadDataDeleget?
    var movieList = [Movie]()
    init(url : URL,deleget : ReloadDataDeleget) {
        mydel = deleget
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let results =  json["results"].arrayValue
                print(results[0]["title"].stringValue)
                for i in 0..<results.count
                {
                    let movie = Movie.init(title: results[i]["title"].stringValue,poster:"https://image.tmdb.org/t/p/w185"+results[i]["poster_path"].stringValue,bigImg: "https://image.tmdb.org/t/p/w185"+results[i]["backdrop_path"].stringValue,orgTitle: results[i]["original_title"].stringValue, overView: results[i]["overview"].stringValue, rate:results[i]["vote_average"].doubleValue, date: results[i]["release_date"].stringValue, id: results[i]["id"].intValue)
                    self.movieList.append(movie)
                }
                print(results.count)
                print(self.movieList.count)
                
            case .failure(let error):
                print(error)
            }
            self.mydel?.reloadMovies(_movies: self.movieList)
            
        }
        
    }
    
    func execute()->[Movie]{
        print(movieList.count)
        return movieList;
    }
    

}





