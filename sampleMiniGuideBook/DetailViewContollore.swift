//
//  DetailViewContollore.swift
//  sampleMiniGuideBook
//
//  Created by takahiro tshuchida on 2017/09/13.
//  Copyright © 2017年 Takahiro Tshuchida. All rights reserved.
//

import UIKit
import MapKit

class DetailViewContollore: UIViewController {
    
    var scSelectedName:String = ""
    
    @IBOutlet weak var myTextField: UITextView!
    
    @IBOutlet weak var myImageView: UIImageView!
    
    @IBOutlet weak var myMapView: MKMapView!
    
    @IBOutlet weak var myNavi: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = scSelectedName
     //   myNavi.title = scSelectedName
        
        //print(scSelectedName)
        
        //        選択されたエリア名を保存するプロパティ！
        //print("\(scSelectedName)が押されて移動してきました")
        
        
        //プロパティーリスト読み込み
        //        ファイルパスを取得(エリア名が格納されているプロパティリスト)
        let filePath = Bundle.main.path(forResource: "guidList", ofType: "plist")
        
        //        ファイルの内容を読み込んでディクショナリー型に格納
        let dic = NSDictionary(contentsOfFile:filePath!)
        
        let dic_class = dic?[scSelectedName] as! NSDictionary
        
        //print(dic_class["descruotion"])
        
        //print(dic?[scSelectedName])
        
        if let value = dic_class.object(forKey: "descruotion"){
            //print(value)
            myTextField.text = value as! String
        } else {
            print("取得失敗")
        }
        
        
        if let value = dic_class.object(forKey: "image"){
            //print(value)
            myImageView.image = UIImage(named: value as! String)
            
            //myImageView.image = UIImage(named: "warau.jpg")
        } else {
            print("取得失敗")
        }
        
        let lat = dic_class["latitude"]
        //print(lat)
        let long = dic_class["longitude"]
        
        //        経度、緯度を中心とした地図を表示
        //        1.中心となる場所の座標オブジェクトを作成
        //        atof文字から数字に変換
        let coodinate = CLLocationCoordinate2DMake(atof(lat as! String), atof(long as! String))
        
        //        2.縮尺を設定(数字を大きくすると広い範囲、少なくすると狭い範囲)
        let span = MKCoordinateSpanMake(0.05, 0.05)
        
        //        3.範囲オブジェクトを作成
        let region = MKCoordinateRegionMake(coodinate, span)
        
        
        //        4.MapViewに範囲オブジェクトを設定
        myMapView.setRegion(region, animated: true)
        
        
        //        ピンを立てる
        //        1.pinオブジェクトを生成
        let myPin = MKPointAnnotation()
        
        ////        2.pinの座標を設定
        //        myPin.coordinate = CLLocationCoordinate2DMake(10.317347, 123.905759)
        myPin.coordinate = coodinate
        
        
        //        4.mapViewにピンを追加
        myMapView.addAnnotation(myPin)
        
    }
    @IBAction func tapAction(_ sender: UIBarButtonItem) {
        
        //    アクティビティーを作成（インスタンス化）
        //    イニシャライズ（初期化）＝インスタンス化したものを宣言した変数に直接代入すること。
        //    activityItems　シェアしたい情報の配列（中身はAny型、なんでもいける）
        let controller = UIActivityViewController(activityItems: [myImageView.image], applicationActivities: nil)
        
        //    アクティビティーを表示
        //    presentとはモーダル表示方法（主にAlart,ActionSheet,ActivitiViewに使用されるが、通常サイズの画面をモーダル表示する時にも使える）
        present(controller,animated: true,completion: nil)

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
