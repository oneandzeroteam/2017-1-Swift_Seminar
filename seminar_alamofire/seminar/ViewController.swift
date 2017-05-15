//
//  ViewController.swift
//  seminar
//
//  Created by LEOFALCON on 2017. 5. 15..
//  Copyright © 2017년 LeFal. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    var movies : [Movie] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPosts()

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
//                self.tableView.reloadData()
                
                
            case .failure(let error): // 실패했다면 에러
                print(error)
            }
        }
    }
}



