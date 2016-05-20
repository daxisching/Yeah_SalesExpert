//
//  OppoInfoViewController.swift
//  Yeah_SalesExpert
//
//  Created by DavisChing on 16/5/20.
//  Copyright © 2016年 DavisChing. All rights reserved.
//

import UIKit

class OppoInfoViewController: UIViewController {

    @IBOutlet weak var tf_name: UITextField!
    @IBOutlet weak var tf_client: UITextField!
    @IBOutlet weak var tf_stage: UITextField!
    @IBOutlet weak var tf_target: UITextField!
    @IBOutlet weak var tf_product: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBAction func bt_Client(sender: AnyObject) {
        DataReader.setCurrentClient(client, _currentClientIndex: DataReader.getCurrentClientIndex(client.getId()))
        let clientInfoStoryBoard = UIStoryboard.init(name: "Index", bundle: nil)
        let clientaddView = clientInfoStoryBoard.instantiateViewControllerWithIdentifier("ClientInfoViewController")
        self.navigationController?.pushViewController(clientaddView, animated: true)
    }
    
    @IBAction func bt_stage(sender: AnyObject) {
        DataReader.setCurrentStage(oppo.getStage())
        let clientInfoStoryBoard = UIStoryboard.init(name: "Index", bundle: nil)
        let clientaddView = clientInfoStoryBoard.instantiateViewControllerWithIdentifier("SelectStageViewController")
        self.navigationController?.pushViewController(clientaddView, animated: true)
    }
    
    @IBAction func bt_product(sender: AnyObject) {
        if tf_product.text != "" {
            DataReader.setCurrentProduct(product, _currentProductIndex: DataReader.getCurrentProductIndex(product.getId()))
            let clientInfoStoryBoard = UIStoryboard.init(name: "Index", bundle: nil)
            let clientaddView = clientInfoStoryBoard.instantiateViewControllerWithIdentifier("ProductInfoViewController")
            self.navigationController?.pushViewController(clientaddView, animated: true)
        }
    }
    
    @IBAction func bt_modify(sender: AnyObject) {
        DataReader.isModifyingAnOppotunity = true
        let clientInfoStoryBoard = UIStoryboard.init(name: "Index", bundle: nil)
        let clientaddView = clientInfoStoryBoard.instantiateViewControllerWithIdentifier("NewOppoViewController")
        self.navigationController?.pushViewController(clientaddView, animated: true)
    }
    
    
    let _w : CGFloat = UIScreen.mainScreen().bounds.size.width
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentSize = CGSize.init(width: _w, height: 1000)
        transAll()
        initInfo()
        // Do any additional setup after loading the view.
    }
    
    private var oppo = OppoInfo.init()
    private var client = ClientInfo.init()
    private var product = ProductInfo.init()
    
    private func initInfo() {
        oppo = DataReader.getCurrentOppo()
        self.title = oppo.getName()
        client = DataReader.getClientWithId(oppo.getClientId())
        product = DataReader.getProductWithId(oppo.getProductId())
        tf_name.text = oppo.getName()
        tf_client.text = client.getName()
        tf_stage.text = Stage.getContextWithPercentage(oppo.getStage())
        tf_target.text = String(oppo.getTargetSales())
        tf_product.text = product.getName()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.tabBar.hidden = true
        initInfo()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    private func transAll(){
        trans(scrollView)
    }
    
    
    //Turn one view and all its subviews into suitable size
    private func trans(temp : UIView){
        temp.frame = remakeFrame(temp.frame.origin.x, y: temp.frame.origin.y, width: temp.frame.size.width, height: temp.frame.size.height)
        
        if(temp.subviews.count != 0){
            for i in temp.subviews{
                trans(i)
            }
        }
    }
    
    let transX = UIScreen.mainScreen().bounds.size.width / 375
    let transY = UIScreen.mainScreen().bounds.size.height / 667
    
    
    //Turn one view into suitable size
    private func remakeFrame(x : CGFloat, y : CGFloat, width : CGFloat, height : CGFloat) -> CGRect{
        var rect = CGRect.init()
        if(rect.origin.x < 0){
            
        }else{
            rect.origin.x = x * transX
        }
        
        rect.origin.y = y * transY
        rect.size.width = width * transX
        rect.size.height = height * transY
        return rect
    }

}