//
//  MovieHomeModel.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/3/20.
//  Copyright © 2019 lcz. All rights reserved.
//

import Foundation

class MovieHomeRootModel: Mappable {
    var code: Int = 0
    var msg: String?
    var page: Int = 0
    var list: Array<MovieHomeModel>?
    var total: Int = 0
    var limit: String?
    var pagecount: Int = 0
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        code   <- map["code"]
        msg   <- map["msg"]
        page   <- map["page"]
        list   <- map["list"]
        total   <- map["total"]
        limit   <- map["limit"]
        pagecount   <- map["pagecount"]
    }
}

class MovieHomeModel: NSObject,Mappable{
    @objc dynamic  var vod_en: String?
    @objc dynamic  var vod_play_note: String?
    @objc dynamic  var vod_pubdate: String?
    @objc dynamic  var type_id: Int = 0
    @objc dynamic  var vod_down_note: String?
    @objc dynamic  var vod_area: String?
    @objc dynamic  var vod_trysee: Int = 0
    @objc dynamic  var vod_tpl_play: String?
    @objc dynamic  var vod_play_url: String?
    @objc dynamic  var vod_status: Int = 0
    @objc dynamic  var vod_level: Int = 0
    @objc dynamic  var vod_pwd_play_url: String?
    @objc dynamic  var vod_duration: String?
    @objc dynamic  var vod_hits_day: Int = 0
    @objc dynamic  var vod_reurl: String?
    @objc dynamic  var vod_score_num: Int = 0
    @objc dynamic  var vod_up: Int = 0
    @objc dynamic  var vod_douban_id: Int = 0
    @objc dynamic  var vod_state: String?
    @objc dynamic  var vod_down_url: String?
    @objc dynamic  var vod_letter: String?
    @objc dynamic  var vod_score: String?
    @objc dynamic  var group_id: Int = 0
    @objc dynamic  var vod_rel_art: String?
    @objc dynamic  var vod_down: Int = 0
    @objc dynamic  var vod_play_from: String?
    @objc dynamic  var vod_isend: Int = 0
    @objc dynamic  var vod_pwd_play: String?
    @objc dynamic  var vod_rel_vod: String?
    @objc dynamic  var vod_down_server: String?
    @objc dynamic  var vod_lock: Int = 0
    @objc dynamic  var vod_lang: String?
    @objc dynamic  var vod_points: Int = 0
    @objc dynamic  var vod_id: Int = 0
    @objc dynamic  var vod_pic: String?
    @objc dynamic  var vod_color: String?
    @objc dynamic  var vod_time: String?
    @objc dynamic  var vod_serial: String?
    @objc dynamic  var vod_sub: String?
    @objc dynamic  var type_name: String?
    @objc dynamic  var vod_pwd_down: String?
    @objc dynamic  var vod_tv: String?
    @objc dynamic  var vod_version: String?
    @objc dynamic  var vod_pwd_down_url: String?
    @objc dynamic  var vod_weekday: String?
    @objc dynamic  var vod_time_hits: Int = 0
    @objc dynamic  var vod_hits: Int = 0
    @objc dynamic  var vod_tpl: String?
    @objc dynamic  var vod_pic_slide: String?
    @objc dynamic  var vod_class: String?
    @objc dynamic  var vod_behind: String?
    @objc dynamic  var vod_hits_month: Int = 0
    @objc dynamic  var vod_pwd_url: String? 
    @objc dynamic  var vod_down_from: String?
    @objc dynamic  var vod_year: String?
    @objc dynamic  var type_id_1: Int = 0
    @objc dynamic  var vod_time_add: Int = 0
    @objc dynamic  var vod_points_play: Int = 0
    @objc dynamic  var vod_tpl_down: String?
    @objc dynamic  var vod_points_down: Int = 0
    @objc dynamic  var vod_director: String?
    @objc dynamic  var vod_copyright: Int = 0
    @objc dynamic  var vod_time_make: Int = 0
    @objc dynamic  var vod_jumpurl: String?
    @objc dynamic  var vod_douban_score: String?
    @objc dynamic  var vod_pic_thumb: String?
    @objc dynamic  var vod_author: String?
    @objc dynamic  var vod_writer: String?
    @objc dynamic  var vod_remarks: String?
    @objc dynamic  var vod_blurb: String?
    @objc dynamic  var vod_content: String?
    @objc dynamic  var vod_score_all: Int = 0
    @objc dynamic  var vod_play_server: String?
    @objc dynamic  var vod_actor: String?
    @objc dynamic  var vod_pwd: String?
    @objc dynamic  var vod_total: Int = 0
    @objc dynamic  var vod_tag: String?
    @objc dynamic  var vod_hits_week: Int = 0
    @objc dynamic  var vod_name: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        vod_en   <- map["vod_en"]
        vod_play_note   <- map["vod_play_note"]
        vod_pubdate   <- map["vod_pubdate"]
        type_id   <- map["type_id"]
        vod_down_note   <- map["vod_down_note"]
        vod_area   <- map["vod_area"]
        vod_trysee   <- map["vod_trysee"]
        vod_tpl_play   <- map["vod_tpl_play"]
        vod_play_url   <- map["vod_play_url"]
        vod_status   <- map["vod_status"]
        vod_level   <- map["vod_level"]
        vod_pwd_play_url   <- map["vod_pwd_play_url"]
        vod_duration   <- map["vod_duration"]
        vod_hits_day   <- map["vod_hits_day"]
        vod_reurl   <- map["vod_reurl"]
        vod_score_num   <- map["vod_score_num"]
        vod_up   <- map["vod_up"]
        vod_douban_id   <- map["vod_douban_id"]
        vod_state   <- map["vod_state"]
        vod_down_url   <- map["vod_down_url"]
        vod_letter   <- map["vod_letter"]
        vod_score   <- map["vod_score"]
        group_id   <- map["group_id"]
        vod_rel_art   <- map["vod_rel_art"]
        vod_down   <- map["vod_down"]
        vod_play_from   <- map["vod_play_from"]
        vod_isend   <- map["vod_isend"]
        vod_pwd_play   <- map["vod_pwd_play"]
        vod_rel_vod   <- map["vod_rel_vod"]
        vod_down_server   <- map["vod_down_server"]
        vod_lock   <- map["vod_lock"]
        vod_lang   <- map["vod_lang"]
        vod_points   <- map["vod_points"]
        vod_id   <- map["vod_id"]
        vod_pic   <- map["vod_pic"]
        vod_color   <- map["vod_color"]
        vod_time   <- map["vod_time"]
        vod_serial   <- map["vod_serial"]
        vod_sub   <- map["vod_sub"]
        type_name   <- map["type_name"]
        vod_pwd_down   <- map["vod_pwd_down"]
        vod_tv   <- map["vod_tv"]
        vod_version   <- map["vod_version"]
        vod_pwd_down_url   <- map["vod_pwd_down_url"]
        vod_weekday   <- map["vod_weekday"]
        vod_time_hits   <- map["vod_time_hits"]
        vod_hits   <- map["vod_hits"]
        vod_tpl   <- map["vod_tpl"]
        vod_pic_slide   <- map["vod_pic_slide"]
        vod_class   <- map["vod_class"]
        vod_behind   <- map["vod_behind"]
        vod_hits_month   <- map["vod_hits_month"]
        vod_pwd_url   <- map["vod_pwd_url"]
        vod_down_from   <- map["vod_down_from"]
        vod_year   <- map["vod_year"]
        type_id_1   <- map["type_id_1"]
        vod_time_add   <- map["vod_time_add"]
        vod_points_play   <- map["vod_points_play"]
        vod_tpl_down   <- map["vod_tpl_down"]
        vod_points_down   <- map["vod_points_down"]
        vod_director   <- map["vod_director"]
        vod_copyright   <- map["vod_copyright"]
        vod_time_make   <- map["vod_time_make"]
        vod_jumpurl   <- map["vod_jumpurl"]
        vod_douban_score   <- map["vod_douban_score"]
        vod_pic_thumb   <- map["vod_pic_thumb"]
        vod_author   <- map["vod_author"]
        vod_writer   <- map["vod_writer"]
        vod_remarks   <- map["vod_remarks"]
        vod_blurb   <- map["vod_blurb"]
        vod_content   <- map["vod_content"]
        vod_score_all   <- map["vod_score_all"]
        vod_play_server   <- map["vod_play_server"]
        vod_actor   <- map["vod_actor"]
        vod_pwd   <- map["vod_pwd"]
        vod_total   <- map["vod_total"]
        vod_tag   <- map["vod_tag"]
        vod_hits_week   <- map["vod_hits_week"]
        vod_name   <- map["vod_name"]
    }
    
    
}

extension MovieHomeModel: IdentifiableType {
    var identity: MovieHomeModel {
        return self
    }
    
    typealias Identity = MovieHomeModel
}



