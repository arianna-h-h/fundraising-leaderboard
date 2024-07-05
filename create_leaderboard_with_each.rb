require 'csv'

leaderboard = {}

# optimization batch or parallel processing, minimze hash reads by storing in a variable

def level_order(level)
    case level
    when "gold"
        0
    when "silver"
        1
    when "bronze"
        2
    else
        3
    end
end

CSV.foreach('donations.csv', headers: true) do |row|
    name = row["donor_name"]
    amount = row["donation_amount"].to_f
    level = row["level"]

    donor_data = leaderboard[name]
    if donor_data
        donor_data[0] += amount
        donor_data[1] = level
    else 
        leaderboard[name] = [amount, level]
    end
end 

sorted_leaderboard = leaderboard.sort_by { |_, (amount, level) | [-amount, level_order(level)] }.to_h

CSV.open("map_leaderboard.csv", 'w', write_headers: true, headers: ["donor_name", "total_donated", "membership_level"]) do |csv|
     sorted_leaderboard.each do |name, (amount, level)|
        csv << [name, amount, level]
    end
end
