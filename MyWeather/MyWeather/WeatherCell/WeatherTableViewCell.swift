//
//  WeatherTableViewCell.swift
//  MyWeather
//
//  Created by Adam Rodrigues on 2022-11-26.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    
    @IBOutlet var dayLabel: UILabel!
    @IBOutlet var highTempLabel: UILabel!
    @IBOutlet var lowTempLabel: UILabel!
    @IBOutlet var precipSumLabel: UILabel!
    // @IBOutlet var iconImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .gray
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
       
    }
    
    static let identifier = "WeatherTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "WeatherTableViewCell", bundle: nil)
    }
    
    func configure(with model: DailyWeatherViewModel) {
        self.lowTempLabel.text = "\(model._temperature_2m_min)°"
        self.highTempLabel.text = "\(model._temperature_2m_max)°"
        self.precipSumLabel.text = "\(model._precipitation_sum)mm"
        self.dayLabel.text = getDayForDate(getDateFromTimeData(model._time))
        // self.iconImageView.image =
    }
    
    func getDateFromTimeData(_ timeStr: String?) -> Date? {
        guard let inputTimeStamp = timeStr else {
            return nil
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: inputTimeStamp)
    }
    
    func getDayForDate(_ date: Date?) -> String {
        guard let inputDate = date else {
            print("Timestamp format was incorrect")
            return "No date"
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter.string(from: inputDate)
    }
    
}

// need to make dictionary mapping weathercodes to image asssets
// need to get day of the week from the _time property from the viewmodel

