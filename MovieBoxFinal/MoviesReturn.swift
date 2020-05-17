//
//  MoviesReturn.swift
//  MovieBoxFinal
//
//  Created by 2unni on 3/16/20.
//  Copyright © 2020 2unni. All rights reserved.
//

import Foundation
import Reachability
class MoviesReturn
{
    func myMovieList(url : String,deleget : ReloadDataDeleget) -> [Movie]
    {
        var movies = [Movie]()
        let urlToExecute = URL(string: url)
        var networkingClient = NetworkClient(url: urlToExecute!, deleget: deleget)
        movies = networkingClient.execute()
        return movies
    }
    

}
