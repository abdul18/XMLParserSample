//
//  ViewController.swift
//  xmlParser
//
//  Created by Yosemite on 27/10/15.
//  Copyright (c) 2015 Pavaratha. All rights reserved.
//

import UIKit

class ViewController: UIViewController, NSXMLParserDelegate {
    
    var array = NSMutableArray()
    var elements = NSMutableDictionary()
    var element = NSString()
    var title1 = NSMutableString()
    var description1 = NSMutableString()
    var parser = NSXMLParser()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var url = NSURL(string: "http://images.apple.com/au/main/rss/hotnews/hotnews.rss")
        var xmlParser = NSXMLParser(contentsOfURL: url!)
        xmlParser?.delegate = self
        xmlParser?.parse()
        
        
    
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func parserDidStartDocument(parser: NSXMLParser)
    {
        println("parserDidStartDocument")
    }
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [NSObject : AnyObject])
    {
        element = elementName
        if(elementName as NSString).isEqualToString("item")
        {
                elements = NSMutableDictionary()
                elements = [:]
                title1 = NSMutableString()
                title1 = ""
                description1 = NSMutableString()
                description1 = ""

        }
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String?)
    {
        if element.isEqualToString("title")
        {
            title1.appendString(string!)
        } else if element.isEqualToString("description")
        {
            description1.appendString(string!)
        }
    }
   
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
    {
        if (elementName as NSString).isEqualToString("item")
        {
                if !title1.isEqual(nil)
                {
                    elements.setObject(title1, forKey: "title")
                }
                if !description1.isEqual(nil) {
                    elements.setObject(description1, forKey: "description")
                }
                array.addObject(elements)
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    
    {

        return array.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell

    {
        var cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell
                
        cell.textLabel?.text = array.objectAtIndex(indexPath.row).valueForKey("title") as! NSString as String
        cell.detailTextLabel?.text = array.objectAtIndex(indexPath.row).valueForKey("description") as! NSString as String
//        cell.textLabel?.numberOfLines = 2
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
        cell.textLabel?.preferredMaxLayoutWidth = CGFloat(12)
        
        cell.detailTextLabel?.numberOfLines = 0
        cell.detailTextLabel?.lineBreakMode = NSLineBreakMode.ByTruncatingTail
        cell.detailTextLabel?.preferredMaxLayoutWidth = CGFloat(44)
        cell.textLabel?.sizeToFit()
        cell.detailTextLabel?.sizeToFit()
        return cell
    }

}

