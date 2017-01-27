//
//  ViewController.swift
//  Calculator(swift)
//
//  Created by 陳鍾逸 on 2016/9/28.
//  Copyright © 2016年 陳鍾逸. All rights reserved.
//
//------------------------------------------------bug---------------------------------------------------------------//

//做完一次運算之後，如果要運算新的算式，要重新來過
//如果要做小數運算，在結果判斷是否是整數就行

//------------------------------------------------bug---------------------------------------------------------------//

//I4A27 陳鍾逸
import UIKit
import Darwin
import QuartzCore

var equationStack = Stack();      //用stack存算式
var equationArray: [String] = []  //用array存算式
var pressed      = false          //operator 只能按一次

var addPressed   = false,
subPressed   = false,
multPressed  = false,
divPressed   = false,
pointPressed = false;

var value = "0"

let labelInputMax = 9

class Stack {                     //實作stack
    private var items = [Any]()
    func push(item:Any) {
        items.append(item)
    }
    func pop() ->Any? {
        return items.removeLast()
    }
    func empty() -> Bool {
        return items.isEmpty
    }
    func peek() ->Any? {
        return items.last
    }
    func removeAll() -> Any? {
        return items.removeAll()
    }
}

func Compute() -> String {     //先乘除後加減
    
    var i = 0
    var compute1 = 0.0, compute2 = 0.0
    
    while equationArray.count > 1
    {
        if equationArray.count == 1
        {
            break;
        }
        
        if equationArray.index(of: "*") != nil || equationArray.index(of: "/") != nil
        {
            if equationArray[i] == "*"
            {
                compute1 = (equationArray[i - 1] as NSString).doubleValue
                compute2 = (equationArray[i + 1] as NSString).doubleValue
                equationArray[i - 1] = "\(compute1 * compute2)"
                equationArray.remove(at: i)
                equationArray.remove(at: i)
                i = 0
            }
            else if equationArray[i] == "/"
            {
                compute1 = (equationArray[i - 1] as NSString).doubleValue
                compute2 = (equationArray[i + 1] as NSString).doubleValue
                equationArray[i - 1] = "\(compute1 / compute2)"
                equationArray.remove(at: i)
                equationArray.remove(at: i)
                i = 0
            }
        }
        else if equationArray.index(of: "*") == nil && equationArray.index(of: "/") == nil
        {
            if equationArray[i] == "+"
            {
                compute1 = (equationArray[i - 1] as NSString).doubleValue
                compute2 = (equationArray[i + 1] as NSString).doubleValue
                equationArray[i - 1] = "\(compute1 + compute2)"
                equationArray.remove(at: i)
                equationArray.remove(at: i)
                i = 0
            }
            else if equationArray[i] == "-"
            {
                compute1 = (equationArray[i - 1] as NSString).doubleValue
                compute2 = (equationArray[i + 1] as NSString).doubleValue
                equationArray[i - 1] = "\(compute1 - compute2)"
                equationArray.remove(at: i)
                equationArray.remove(at: i)
                i = 0
            }
        }
        i += 1
    }
    
    if floor(Double(equationArray[0])!) == Double(equationArray[0])
    {
        return "\((equationArray[0] as NSString).intValue)"
    }
    
    else if floor(Double(equationArray[0])!) != Double(equationArray[0])
    {
        return "\((equationArray[0] as NSString).doubleValue)"
    }
    
    return "error"
}


class ViewController: UIViewController {
    
    @IBOutlet weak var label_input: UILabel!
    

    func isClear() -> Bool            //判斷計算機有沒有清空
    {
        if equationStack.empty() && equationArray.isEmpty && label_input.text == "0"
        {
            return true
        }
        
        return false
    }
    
    func changeTextSize()
    {
        if ((self.label_input.text?.characters)?.count == 7)
        {
            self.label_input.font = label_input.font.withSize(88)
        }
            
        else if ((self.label_input.text?.characters)?.count == 8)
        {
            self.label_input.font = label_input.font.withSize(77)
        }
            
        else if ((self.label_input.text?.characters)?.count == labelInputMax)
        {
            self.label_input.font = label_input.font.withSize(68)
        }
            
        else if ((self.label_input.text?.characters)?.count == 10)
        {
            self.label_input.font = label_input.font.withSize(49)
        }
            
        else
        {
            self.label_input.font = label_input.font.withSize(103)
        }
    }
    
    
    @IBOutlet weak var button_0: UIButton!
    @IBAction func button_0(_ sender: AnyObject) {
        if (self.label_input.text?.characters)?.count == labelInputMax
        {
            //停止輸入
        }
        else if ((self.label_input.text?.characters)?.count)! <= labelInputMax
        {
            if pressed
            {
                if isClear()
                {
                    //什麼都不做
                }
                else if !isClear()
                {
                    label_input.text = "0"
                }
            }
            else if !pressed
            {
                if isClear()
                {
                    //什麼都不做
                }
                else if !isClear()
                {
                    label_input.text = label_input.text! + "0"
                }
            }
        }
        pressed = false
        changeTextSize()
    }
    
    @IBOutlet weak var button_1: UIButton!
    @IBAction func button_1(_ sender: AnyObject) {
        if (self.label_input.text?.characters)?.count == labelInputMax
        {
            //停止輸入
        }
        else if ((self.label_input.text?.characters)?.count)! <= labelInputMax
        {
            if pressed
            {
                if isClear()
                {
                    //什麼都不做
                }
                else if !isClear()
                {
                    label_input.text = "1"
                }
            }
            else if !pressed
            {
                if isClear()
                {
                    label_input.text = "1"
                }
                else if !isClear()
                {
                    label_input.text = label_input.text! + "1"
                }
            }
        }
        pressed = false
        changeTextSize()
    }
    
    @IBOutlet weak var button_2: UIButton!
    @IBAction func button_2(_ sender: AnyObject) {
        if (self.label_input.text?.characters)?.count == labelInputMax
        {
            //停止輸入
        }
        else if ((self.label_input.text?.characters)?.count)! <= labelInputMax
        {
            if pressed
            {
                if isClear()
                {
                    //什麼都不做
                }
                else if !isClear()
                {
                    label_input.text = "2"
                }
            }
            else if !pressed
            {
                if isClear()
                {
                    label_input.text = "2"
                }
                else if !isClear()
                {
                    label_input.text = label_input.text! + "2"
                }
            }
        }
        pressed = false
        changeTextSize()
    }
    
    @IBOutlet weak var button_3: UIButton!
    @IBAction func button_3(_ sender: AnyObject) {
        if (self.label_input.text?.characters)?.count == labelInputMax
        {
            //停止輸入
        }
        else if ((self.label_input.text?.characters)?.count)! <= labelInputMax
        {
            if pressed
            {
                if isClear()
                {
                    //什麼都不做
                }
                else if !isClear()
                {
                    label_input.text = "3"
                }
            }
            else if !pressed
            {
                if isClear()
                {
                    label_input.text = "3"
                }
                else if !isClear()
                {
                    label_input.text = label_input.text! + "3"
                }
            }
        }
        pressed = false
        changeTextSize()
    }
    
    @IBOutlet weak var button_4: UIButton!
    @IBAction func button_4(_ sender: AnyObject) {
        if (self.label_input.text?.characters)?.count == labelInputMax
        {
            //停止輸入
        }
        else if ((self.label_input.text?.characters)?.count)! <= labelInputMax
        {
            if pressed{
                if isClear()
                {
                    //什麼都不做
                }
                else if !isClear()
                {
                    label_input.text = "4"
                }
            }
            else if !pressed{
                if isClear()
                {
                    label_input.text = "4"
                }
                else if !isClear()
                {
                    label_input.text = label_input.text! + "4"
                }
            }
        }
        pressed = false
        changeTextSize()
    }
    
    @IBOutlet weak var button_5: UIButton!
    @IBAction func button_5(_ sender: AnyObject) {
        if (self.label_input.text?.characters)?.count == labelInputMax
        {
            //停止輸入
        }
        else if ((self.label_input.text?.characters)?.count)! <= labelInputMax
        {
            if pressed
            {
                if isClear()
                {
                    //什麼都不做
                }
                else if !isClear()
                {
                    label_input.text = "5"
                }
            }
            else if !pressed
            {
                if isClear()
                {
                    label_input.text = "5"
                }
                else if !isClear()
                {
                    label_input.text = label_input.text! + "5"
                }
            }
        }
        pressed = false
        changeTextSize()
    }
    
    @IBOutlet weak var button_6: UIButton!
    @IBAction func button_6(_ sender: AnyObject) {
        if (self.label_input.text?.characters)?.count == labelInputMax
        {
            //停止輸入
        }
        else if ((self.label_input.text?.characters)?.count)! <= labelInputMax
        {
            if pressed
            {
                if isClear()
                {
                    //什麼都不做
                }
                else if !isClear()
                {
                    label_input.text = "6"
                }
            }
            else if !pressed
            {
                if isClear()
                {
                    label_input.text = "6"
                }
                else if !isClear()
                {
                    label_input.text = label_input.text! + "6"
                }
            }
        }
        pressed = false
        changeTextSize()
    }
    
    @IBOutlet weak var button_7: UIButton!
    @IBAction func button_7(_ sender: AnyObject) {
        if (self.label_input.text?.characters)?.count == labelInputMax
        {
            //停止輸入
        }
        else if ((self.label_input.text?.characters)?.count)! <= labelInputMax
        {
            if pressed
            {
                if isClear()
                {
                    //什麼都不做
                }
                else if !isClear()
                {
                    label_input.text = "7"
                }
            }
            else if !pressed
            {
                if isClear()
                {
                    label_input.text = "7"
                }
                else if !isClear()
                {
                    label_input.text = label_input.text! + "7"
                }
            }
        }
        pressed = false
        changeTextSize()
    }
    
    @IBOutlet weak var button_8: UIButton!
    @IBAction func button_8(_ sender: AnyObject) {
        if (self.label_input.text?.characters)?.count == labelInputMax
        {
            //停止輸入
        }
        else if ((self.label_input.text?.characters)?.count)! <= labelInputMax
        {
            if pressed
            {
                if isClear()
                {
                    //什麼都不做
                }
                else if !isClear()
                {
                    label_input.text = "8"
                }
            }
            else if !pressed
            {
                if isClear()
                {
                    label_input.text = "8"
                }
                else if !isClear()
                {
                    label_input.text = label_input.text! + "8"
                }
            }
        }
        pressed = false
        changeTextSize()
    }
    
    @IBOutlet weak var button_9: UIButton!
    @IBAction func button_9(_ sender: AnyObject) {
        if (self.label_input.text?.characters)?.count == labelInputMax
        {
            //停止輸入
        }
        else if ((self.label_input.text?.characters)?.count)! <= labelInputMax
        {
            if pressed
            {
                if isClear()
                {
                    //什麼都不做
                }
                else if !isClear()
                {
                    label_input.text = "9"
                }
            }
            else if !pressed
            {
                if isClear()
                {
                    label_input.text = "9"
                }
                else if !isClear()
                {
                    label_input.text = label_input.text! + "9"
                }
            }
        }
        pressed = false
        changeTextSize()
    }
    
    @IBOutlet weak var button_clear: UIButton!
    @IBAction func button_clear(_ sender: AnyObject) {
        if sender.titleLabel!?.text == "AC"         //清空
        {
            if !isClear()
            {
                addPressed  = false
                subPressed  = false
                multPressed = false
                divPressed  = false
                button_add.setTitleColor(UIColor.white, for: UIControlState.normal)
                button_sub.setTitleColor(UIColor.white, for: UIControlState.normal)
                button_mult.setTitleColor(UIColor.white, for: UIControlState.normal)
                button_div.setTitleColor(UIColor.white, for: UIControlState.normal)
                equationStack.removeAll()
                equationArray.removeAll()
                label_input.text = "0"
            }
        }
        else if sender.titleLabel!?.text == "C"     //清空label上的輸入
        {
            if !isClear()
            {
                label_input.text = "0"
            }
        }
        pressed = false
        pointPressed = false
        changeTextSize()
    }
    
    @IBOutlet weak var button_point: UIButton!
    @IBAction func button_point(_ sender: AnyObject) {
        
        if !pointPressed
        {
            label_input.text = label_input.text! + "."
        }
        pointPressed = true
    }
    
    @IBOutlet weak var button_convert:UIButton!
    @IBAction func button_convert(_ sender: AnyObject) {
        
        if !pointPressed
        {
            var tmp1 = (label_input.text! as NSString).intValue
            
            if tmp1 > 0{
                tmp1 = -tmp1
                label_input.text = "\(tmp1)"
            }
            else if tmp1 < 0
            {
                tmp1 = -tmp1
                label_input.text = "\(tmp1)"
            }
            else if tmp1 == 0
            {
                //什麼都不做
            }
        }
        
        else if pointPressed
        {
            var tmp2 = (label_input.text! as NSString).floatValue
            
            if tmp2 > 0{
                tmp2 = -tmp2
                label_input.text = "\(tmp2)"
            }
            else if tmp2 < 0
            {
                tmp2 = -tmp2
                label_input.text = "\(tmp2)"
            }
            else if tmp2 == 0
            {
                //什麼都不做
            }
        }
    }
    
    @IBOutlet weak var button_percent: UIButton!
    @IBAction func button_percent(_ sender: AnyObject) {
        
        if label_input.text != "0"
        {
            label_input.text = "\((label_input.text! as NSString).doubleValue/100)"
        }
    }
    
    //******************************************************operator****************************************************//
    // operator 做的事情 :
    // 只能按一次
    // 將數字分別放進 stack 和 array 中
    // 將operator 也放進 stack 和 array 中
    
    @IBOutlet weak var button_delete: UIButton!
    @IBAction func button_delete(_ sender: AnyObject) {
        if label_input.text != "0"
        {
            label_input.text?.remove(at: (label_input.text?.index(before: (label_input.text?.endIndex)!))!)
            
            if(label_input.text == "")
            {
                label_input.text = "0"
            }
            changeTextSize()
        }
    }
    
    @IBOutlet weak var button_add: UIButton!
    @IBAction func button_add(_ sender: AnyObject) {
        if !pressed
        {
            addPressed  = true
            subPressed  = false
            multPressed = false
            divPressed  = false
            if addPressed
            {
                button_add.setTitleColor(UIColor.black, for: UIControlState.normal)
                button_sub.setTitleColor(UIColor.white, for: UIControlState.normal)
                button_mult.setTitleColor(UIColor.white, for: UIControlState.normal)
                button_div.setTitleColor(UIColor.white, for: UIControlState.normal)
            }
            pressed = true                                  //只能按一次
            equationArray.append(label_input.text!)         //數字放進 array
            equationStack.push(item: label_input.text!)     //數字放進 stack
            equationArray.append("+")                       //operator 放進 array
            equationStack.push(item: "+")                   //operator 放進 stack
        }
        else if pressed
        {
            //什麼都不做
        }
        changeTextSize()
        pointPressed = false
    }
    
    @IBOutlet weak var button_sub: UIButton!
    @IBAction func button_sub(_ sender: AnyObject) {
        if !pressed
        {
            addPressed  = false
            subPressed  = true
            multPressed = false
            divPressed  = false
            if subPressed
            {
                button_add.setTitleColor(UIColor.white, for: UIControlState.normal)
                button_sub.setTitleColor(UIColor.black, for: UIControlState.normal)
                button_mult.setTitleColor(UIColor.white, for: UIControlState.normal)
                button_div.setTitleColor(UIColor.white, for: UIControlState.normal)
            }
            pressed = true                                  //只能按一次
            equationArray.append(label_input.text!)         //數字放進 array
            equationStack.push(item: label_input.text!)     //數字放進 stack
            equationArray.append("-")                       //operator 放進 array
            equationStack.push(item: "-")                   //operator 放進 stack
        }
        else if pressed
        {
            //什麼都不做
        }
        changeTextSize()
        pointPressed = false
    }
    
    @IBOutlet weak var button_mult: UIButton!
    @IBAction func button_mult(_ sender: AnyObject) {
        if !pressed
        {
            addPressed  = false
            subPressed  = false
            multPressed = true
            divPressed  = false
            if multPressed
            {
                button_add.setTitleColor(UIColor.white, for: UIControlState.normal)
                button_sub.setTitleColor(UIColor.white, for: UIControlState.normal)
                button_mult.setTitleColor(UIColor.black, for: UIControlState.normal)
                button_div.setTitleColor(UIColor.white, for: UIControlState.normal)
            }
            pressed = true                                  //只能按一次
            equationArray.append(label_input.text!)         //數字放進 array
            equationStack.push(item: label_input.text!)     //數字放進 stack
            equationArray.append("*")                       //operator 放進 array
            equationStack.push(item: "*")                   //operator 放進 stack
        }
        else if pressed
        {
            //什麼都不做
        }
        changeTextSize()
        pointPressed = false
    }
    
    @IBOutlet weak var button_div: UIButton!
    @IBAction func button_div(_ sender: AnyObject) {
        if !pressed
        {
            addPressed  = false
            subPressed  = false
            multPressed = false
            divPressed  = true
            if divPressed
            {
                button_add.setTitleColor(UIColor.white, for: UIControlState.normal)
                button_sub.setTitleColor(UIColor.white, for: UIControlState.normal)
                button_mult.setTitleColor(UIColor.white, for: UIControlState.normal)
                button_div.setTitleColor(UIColor.black, for: UIControlState.normal)
            }
            pressed = true                                  //只能按一次
            equationArray.append(label_input.text!)         // 放進 array
            equationStack.push(item: label_input.text!)     //數字放進 stack
            equationArray.append("/")                       //operator 放進 array
            equationStack.push(item: "/")                   //operator 放進 stack
        }
        else if pressed
        {
            //什麼都不做
        }
        changeTextSize()
        pointPressed = false
    }
    
    @IBOutlet weak var button_equ: UIButton!
    @IBAction func button_equ(_ sender: AnyObject) {
        if !pressed
        {
            addPressed  = false
            subPressed  = false
            multPressed = false
            divPressed  = false
            button_add.setTitleColor(UIColor.white, for: UIControlState.normal)
            button_sub.setTitleColor(UIColor.white, for: UIControlState.normal)
            button_mult.setTitleColor(UIColor.white, for: UIControlState.normal)
            button_div.setTitleColor(UIColor.white, for: UIControlState.normal)
            
            pressed = true
            equationArray.append(label_input.text!)         //數字放進 array
            equationStack.push(item: label_input.text!)     //數字放進 stack
            //            equationArray.append("=")                       //operator 放進 array
            //            equationStack.push(item: "=")                   //operator 放進 stack
            
            label_input.text = Compute()
            
            equationArray.removeAll()
            pressed = false
        }
        else if pressed
        {
            //什麼都不做
        }
        changeTextSize()
        pointPressed = false
    }
    
    //******************************************************operator****************************************************//
    
    
    @IBAction func testButton(_ sender: AnyObject) {
        //        print("array[0] = ", equationArray[0])
        //        print("array[1] = ", equationArray[1])
        //        print("array[2] = ", equationArray[2])
        //        print("array[3] = ", equationArray[3])
        //        print("array[4] = ", equationArray[4])
        //        print("array[5] = ", equationArray[5])
    }
    
    
    @IBOutlet weak var launchScreen: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.button_0.layer.borderWidth = 0.5
        self.button_0.layer.borderColor = UIColor.white.cgColor
        self.button_0.layer.cornerRadius = 10
        self.button_1.layer.borderWidth = 0.5
        self.button_1.layer.borderColor = UIColor.white.cgColor
        self.button_1.layer.cornerRadius = 10
        self.button_2.layer.borderWidth = 0.5
        self.button_2.layer.borderColor = UIColor.white.cgColor
        self.button_2.layer.cornerRadius = 10
        self.button_3.layer.borderWidth = 0.5
        self.button_3.layer.borderColor = UIColor.white.cgColor
        self.button_3.layer.cornerRadius = 10
        self.button_4.layer.borderWidth = 0.5
        self.button_4.layer.borderColor = UIColor.white.cgColor
        self.button_4.layer.cornerRadius = 10
        self.button_5.layer.borderWidth = 0.5
        self.button_5.layer.borderColor = UIColor.white.cgColor
        self.button_5.layer.cornerRadius = 10
        self.button_6.layer.borderWidth = 0.5
        self.button_6.layer.borderColor = UIColor.white.cgColor
        self.button_6.layer.cornerRadius = 10
        self.button_7.layer.borderWidth = 0.5
        self.button_7.layer.borderColor = UIColor.white.cgColor
        self.button_7.layer.cornerRadius = 10
        self.button_8.layer.borderWidth = 0.5
        self.button_8.layer.borderColor = UIColor.white.cgColor
        self.button_8.layer.cornerRadius = 10
        self.button_9.layer.borderWidth = 0.5
        self.button_9.layer.borderColor = UIColor.white.cgColor
        self.button_9.layer.cornerRadius = 10
        self.button_add.layer.borderWidth = 0.5
        self.button_add.layer.borderColor = UIColor.white.cgColor
        self.button_add.layer.cornerRadius = 10
        self.button_sub.layer.borderWidth = 0.5
        self.button_sub.layer.borderColor = UIColor.white.cgColor
        self.button_sub.layer.cornerRadius = 10
        self.button_mult.layer.borderWidth = 0.5
        self.button_mult.layer.borderColor = UIColor.white.cgColor
        self.button_mult.layer.cornerRadius = 10
        self.button_div.layer.borderWidth = 0.5
        self.button_div.layer.borderColor = UIColor.white.cgColor
        self.button_div.layer.cornerRadius = 10
        self.button_equ.layer.borderWidth = 0.5
        self.button_equ.layer.borderColor = UIColor.white.cgColor
        self.button_equ.layer.cornerRadius = 10
        self.button_point.layer.borderWidth = 0.5
        self.button_point.layer.borderColor = UIColor.white.cgColor
        self.button_point.layer.cornerRadius = 10
        self.button_clear.layer.borderWidth = 0.5
        self.button_clear.layer.borderColor = UIColor.white.cgColor
        self.button_clear.layer.cornerRadius = 10
        self.button_convert.layer.borderWidth = 0.5
        self.button_convert.layer.borderColor = UIColor.white.cgColor
        self.button_convert.layer.cornerRadius = 10
        self.button_percent.layer.borderWidth = 0.5
        self.button_percent.layer.borderColor = UIColor.white.cgColor
        self.button_percent.layer.cornerRadius = 10
        self.button_delete.layer.borderWidth = 0.5
        self.button_delete.layer.borderColor = UIColor.white.cgColor
        self.button_delete.layer.cornerRadius = 10
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

