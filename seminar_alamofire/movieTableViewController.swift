//
//  movieTableViewController.swift
//  
//
//  Created by LEOFALCON on 2017. 5. 15..
//
//

import UIKit
import Alamofire

class movieTableViewController: UITableViewController {
    var movies : [Movie] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchPosts()
    }
    fileprivate func fetchPosts() {
        let url = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=430156241533f1d058c603178cc3ca0e&targetDt=20120101"
        // URL 설정
        Alamofire.request(url).responseJSON { response in  // 이 URL로 호출하겠다.
            switch response.result {
            case .success(let value): // 성공했다면? 아래
                guard let json = value as? [String: Any] else { print("error"); return }
                
                // value 안에 값이 들어있음. 이 값을 우리가 원하는 형태로 사용할 수 잇어야 함.
                // 그러기 위해서 뽑아내 주어야 하는데 이때 as? [String: Any] 이걸 사용함. 이거 type casting
                // value를 [String : Any] 형태로 사용하겠다!
                // 만약 구조가 타입케스팅을 할수 없는 구조이면 error를 표시하면서 리턴
                
                let movieJSONArray = json["boxOfficeResult"] as? [String: Any] ?? [:]
                let range = movieJSONArray["showRange"]
                print(range as! String)
                
                let rankJSONArray = movieJSONArray["dailyBoxOfficeList"] as? [[String: Any]] ?? []
                print(rankJSONArray[0]["rnum"] as! String)
                
                self.movies = [Movie](JSONArray: rankJSONArray) ?? []
                self.tableView.reloadData()
                
                
            case .failure(let error): // 실패했다면 에러
                print(error)
            }
        }
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return movies.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movies", for: indexPath)
        cell.textLabel?.text = movies[indexPath.row].movieNm
        cell.detailTextLabel?.text = movies[indexPath.row].rank

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
