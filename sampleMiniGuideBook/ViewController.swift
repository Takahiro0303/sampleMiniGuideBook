//
//  ViewController.swift
//  sampleMiniGuideBook
//
//  Created by takahiro tshuchida on 2017/09/12.
//  Copyright © 2017年 Takahiro Tshuchida. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var myTableView: UITableView!
    
//    紹介したいエリア名が格納される配列
    var placeList:[String] = []
    
    var selectedName =  "" //選択された行の表示エリア
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        ファイルパスを取得(エリア名が格納されているプロパティリスト)
        let filePath = Bundle.main.path(forResource: "guidList", ofType: "plist")

        
//        ファイルの内容を読み込んでディクショナリー型に格納
        let dic = NSDictionary(contentsOfFile:filePath!)
        
        
//        TableViewで扱いやすい形（エリア名の入っている配列）を作成
//        Dictionary型の高速列挙
        
        for(key,data) in dic!{
        print(key)
        placeList.append(key as! String)
        
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
       
        cell.textLabel?.text = placeList[indexPath.row]
//        cell.textLabel?.text = "\(indexPath.row)行目"
        //文字を設定したセルを返す
        return cell
    }
    
//    セルがタップされた時、segueを使って画面移動
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        //        選択された名前エリアを保存
        selectedName = placeList[indexPath.row]
        
        //        セグエを指定して、画面遷移
        performSegue(withIdentifier: "showDetail", sender: nil)
    }
    
    //        セグエを使って画面を移動しようとしている時発動するメソッド
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //        prepareの中では、移動元の画面、移動先の画面、どちらも操作が可能
        //        移動先の画面に渡したい情報をセットできる
        //        dv　今から移動する画面のオブジェクト（インスタンス）
        //        segue.destination セグエを使って移動する先
        //        as ダウンキャスト変換するための記号
        
        let dv:DetailViewContollore = segue.destination as! DetailViewContollore
        
        //        作成しておいたプロパティー（メンバ変数）に名前エリアを保存
        dv.scSelectedName = selectedName
        
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

