//
//  getVideo.swift
//  MovieBoxFinal
//
//  Created by 2unni on 3/13/20.
//  Copyright © 2020 2unni. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Video
{
    var mydel : ReloadVideoURLDeleget?
    var key = ""
    init(id: Int, deleget: ReloadVideoURLDeleget)
    {
        mydel = deleget
        var urlString =  "https://api.themoviedb.org/3/movie/\(id)/videos?api_key=d048bec4f5e8f1dda36816ab99be899e&language=en-US"
        var url = URL(string: urlString)
        AF.request(url!,method: .get).validate().responseJSON{ responce in
            switch responce.result{
            case .success(let value):
                let json = JSON(value)
                let results = json["results"].arrayValue
                for i in 0..<results.count
                {
                    self.key = results[i]["key"].stringValue
                    if (self.key != nil)
                    {
                        break
                    }
                }
                print(self.key)
                break
            case .failure(let error):
                break
                
            }
            self.mydel?.reloadVideoURL(key: self.key)
            }
    }
    func getURL()-> String
    {
        
        return self.key
    }
        
}

