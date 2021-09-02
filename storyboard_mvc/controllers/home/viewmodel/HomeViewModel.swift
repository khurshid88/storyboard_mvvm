//
//  HomeViewModel.swift
//  storyboard_mvc
//
//  Created by User on 2021/04/22.
//

import Foundation
import Bond

//https://swiftwithmajid.com/2018/01/11/mastering-mvvm-on-ios/

class HomeViewModel {
    var controller: BaseViewController!
    let items = Observable<[Post]>([])

    func apiPostList(){
        controller.showProgress()
        
        AFHttp.get(url: AFHttp.API_POST_LIST, params: AFHttp.paramsEmpty(), handler: { response in
            self.controller.hideProgress()
            
            switch response.result {
            case .success:
                let posts = try! JSONDecoder().decode([Post].self, from: response.data!)
                self.items.value = posts
            case let .failure(error):
                print(error)
            }
        })
    }
    
    func apiPostDelete(post:Post, handler: @escaping (Bool) -> Void){
        controller.showProgress()
        
        AFHttp.del(url: AFHttp.API_POST_DELETE + post.id!, params: AFHttp.paramsEmpty(), handler: {response in
            self.controller.hideProgress()
            
            switch response.result {
            case .success:
                handler(true)
            case let .failure(error):
                print(error)
                handler(false)
            }
        })
    }
    
}
