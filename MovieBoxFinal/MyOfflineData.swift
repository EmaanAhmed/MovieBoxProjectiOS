//
//  MyOfflineData.swift
//  MovieBoxFinal
//
//  Created by 2unni on 3/15/20.
//  Copyright © 2020 2unni. All rights reserved.
//

import Foundation
import CoreData
import SDWebImage



class MyOfflineData
{
    var appdeleget : AppDelegate?
    var nsContext : NSManagedObjectContext?
    init(appdeleget : AppDelegate){
        self.appdeleget = appdeleget
        nsContext = appdeleget.persistentContainer.viewContext
    }
    
    func AddMovieToFavorites(movie : Movie)
    {
        let entity = NSEntityDescription.insertNewObject(forEntityName: "Favorits", into:nsContext! )
        
        entity.setValue(movie.title, forKey: "title")
        entity.setValue(movie.vote_average, forKey: "vote_average")
        entity.setValue(movie.poster_path, forKey: "poster_path")
        entity.setValue(movie.id, forKey: "id")
        
        do{
            try self.nsContext?.save()
        }
        catch
        {
            
        }
        
    }
    
    func AddMovieToMostPop(movie: Movie) {
        let entity = NSEntityDescription.insertNewObject(forEntityName: "MostMovies", into:nsContext! )

            entity.setValue(movie.id, forKey: "id")
            entity.setValue(movie.original_title, forKey: "original_title")
            entity.setValue(movie.overview, forKey: "overview")
            entity.setValue(movie.poster_path, forKey: "poster_path")
            entity.setValue(movie.release_date, forKey: "release_date")
            entity.setValue(movie.vote_average, forKey: "vote_average")
        entity.setValue(movie.title, forKey: "title")
            
            do{
                try self.nsContext?.save()
            }
            catch
            {
                
            }
        

    }
    func AddMovieToHighRated(movie: Movie) {
        let entity = NSEntityDescription.insertNewObject(forEntityName: "HighRated", into:nsContext! )

            entity.setValue(movie.id, forKey: "id")
            entity.setValue(movie.original_title, forKey: "original_title")
            entity.setValue(movie.overview, forKey: "overview")
            entity.setValue(movie.poster_path, forKey: "poster_path")
            entity.setValue(movie.release_date, forKey: "release_date")
            entity.setValue(movie.vote_average, forKey: "vote_average")
            entity.setValue(movie.title, forKey: "title")
            do{
                try self.nsContext?.save()
            }
            catch
            {
                
            }
        

    }
    func deleteMostPop()
    {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MostMovies")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do{
            try self.nsContext?.execute(batchDeleteRequest)
        }
        catch
        {
            
        }
    }
    func deleteHighRated()
    {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "HighRated")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do{
            try self.nsContext?.execute(batchDeleteRequest)
        }
        catch
        {
            
        }
    }
    func getFavorites()->[Any]
    {
        var movies : [Any] = []
        var myMovies = [Favorits]()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorits")
        myMovies = try!nsContext!.fetch(fetchRequest) as![Favorits]
        for movie in myMovies
        {
            movies.append(movie)
        }
        return movies
    }
    
    func getMostPop() -> [Any] {
        var movies : [Movie] = []
        var myMovies = [MostMovies]()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MostMovies")
        myMovies = try!nsContext!.fetch(fetchRequest) as! [MostMovies]
        for movie in myMovies
        {
            var myMovie = Movie(poster: movie.poster_path!, orgTitle: movie.original_title!, overView: movie.overview!, rate: movie.vote_average, date: movie.release_date!, id: Int(movie.id),title: movie.title!)
            movies.append(myMovie)
        }
        return movies
    }
    func getHighRated() -> [Any] {
        var movies : [Movie] = []
        var myMovies = [HighRated]()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "HighRated")
        myMovies = try!nsContext!.fetch(fetchRequest) as! [HighRated]
        for movie in myMovies
        {
            var myMovie = Movie(poster: movie.poster_path!, orgTitle: movie.original_title!, overView: movie.overview!, rate: movie.vote_average, date: movie.release_date!, id: Int(movie.id),title: movie.title!)
            movies.append(myMovie)
        }
        return movies
    }
    
    
    func doExist(id : Int)->Bool
    {
        var exist = false
        let entity = NSEntityDescription.entity(forEntityName: "Favorits", in: nsContext!)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorits")
        fetchRequest.entity = entity
        let pred = NSPredicate(format:"id=%d", id)
        fetchRequest.predicate=pred
        do
        {
            let result = try nsContext?.fetch(fetchRequest)
            print(result?.count)
            if result!.count > 0 {
                exist = true
            }
        }
        catch
        {
            
        }
        return exist
    }
    func deleteMoviesFromFav(id : Int){
        let entity = NSEntityDescription.entity(forEntityName: "Favorits", in: nsContext!)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorits")
        fetchRequest.entity = entity
        let pred = NSPredicate(format:"id=%d", id)
        fetchRequest.predicate=pred
        do
        {
            let result = try nsContext?.fetch(fetchRequest)
            print(result?.count)
            if result!.count > 0 {
                let manage = result![0] as! NSManagedObject
                nsContext?.delete(manage)
                try nsContext?.save()
            }
        }
        catch
        {
            
        }

        
    }
}
