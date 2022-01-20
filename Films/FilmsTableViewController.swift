//
//  FilmsTableViewController.swift
//  Films
//
//  Created by munira almallki on 11/03/1443 AH.
//

import UIKit

class FilmsTableViewController: UITableViewController {

    var Films = [String]()
        override func viewDidLoad() {
            super.viewDidLoad()
            let url = URL(string: "https://swapi.dev/api/films/?format=json")
                  
                    let session = URLSession.shared
                    
                    let task = session.dataTask(with: url!, completionHandler: {
                       
                        data, response, error in
                        
                        do {
                            
                            if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                                print(jsonResult)
                            
                               if let  results = jsonResult["results"]{
                                   let resultArray = results as! NSArray
                                    for item in resultArray{
                                        let resultsDictionary  = item as! NSDictionary
                                        self.Films.append(resultsDictionary["title"] as! String)
                                    }
                                   print(self.Films)
                            }
                            }
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                        } catch {
                            print(error)
                        }
                    })
          
            task.resume()

                }
        
      
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return Films.count
        }
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellFilm", for: indexPath)
            cell.textLabel?.text = Films[indexPath.row]
            return cell
        }

}
