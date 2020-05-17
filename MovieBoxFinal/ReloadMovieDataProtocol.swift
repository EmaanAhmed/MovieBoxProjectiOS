//
//  ReloadMovieDataProtocol.swift
//  MovieBoxFinal
//
//  Created by 2unni on 3/12/20.
//  Copyright © 2020 2unni. All rights reserved.
//

import Foundation
protocol ReloadDataDeleget
{
    func reloadMovies (_movies : [Movie])
}

protocol ReloadVideoURLDeleget {
    
    func reloadVideoURL (key : String)
}

protocol ReloadReviewsDeleget
{
    func reloadReviews (reviews : [Review])
}


