//
//  Movie.swift
//  MovieBoxFinal
//
//  Created by 2unni on 3/12/20.
//  Copyright © 2020 2unni. All rights reserved.
//

import Foundation
class Movie
{
    var poster_path : String?
    var title: String?
    var overview: String?
    var backdrop_path :String?
    var original_title: String?
    var vote_average: Double?
    var release_date: String?
    var id: Int?
    
    


    
    init(title : String,poster: String,bigImg : String, orgTitle : String,overView : String,rate : Double,date : String,id : Int)
    {
        self.title = title
        self.poster_path = poster
        self.backdrop_path = bigImg
        self.original_title = orgTitle
        self.overview = overView
        self.vote_average = rate
        self.release_date = date
        self.id = id
        
    }
    
    init(poster: String,orgTitle : String,overView : String,rate : Double,date : String,id : Int,title: String)
    {

        self.poster_path = poster
        self.original_title = orgTitle
        self.overview = overView
        self.vote_average = rate
        self.release_date = date
        self.id = id
        self.title = title
        
    }
    
    init(id: Int, title : String,poster: String,rate : Double)
    {
        self.id = id
        self.title = title
        self.poster_path = poster
        self.vote_average = rate
    }
    
}
