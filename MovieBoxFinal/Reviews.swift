//
//  Reviews.swift
//  MovieBoxFinal
//
//  Created by 2unni on 3/13/20.
//  Copyright © 2020 2unni. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Reviews
{
    var mydel : ReloadReviewsDeleget?
    var reviewList = [Review]()
    init(id : Int,deleget : ReloadReviewsDeleget) {
        mydel = deleget
        var urlString =  "https://api.themoviedb.org/3/movie/\(id)/reviews?api_key=d048bec4f5e8f1dda36816ab99be899e&language=en-US&page=1"
        var url = URL(string: urlString)
        AF.request(url!, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let results =  json["results"].arrayValue
                for i in 0..<results.count
                {
                    let review = Review.init(author: results[i]["author"].stringValue, content: results[i]["content"].stringValue)
                    self.reviewList.append(review)
                    print(review.author)
                }

                
            case .failure(let error):
                print(error)
            }
            print(self.reviewList.count)
            self.mydel?.reloadReviews(reviews: self.reviewList)
            
        }
        
    }
    
    func execute()->[Review]{

        return reviewList;
    }
    
        
}

