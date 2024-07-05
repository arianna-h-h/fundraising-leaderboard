require 'csv'

donations = CSV.parse(File.read("donations.csv"), headers: true)

leaderboard = donations.reduce({}) do |acc, donation|
    name = donation["donor_name"]
    amount = donation["donation_amount"].to_f

    acc[name] ? acc[name] += amount : acc[name] = amount
    acc
end

sorted_leaderboard = leaderboard.sort_by { |_, total| -total }

CSV.open("leaderboard.csv", 'w', write_headers: true, headers: ["donor_name", "total_donated"]) do |csv|
    sorted_leaderboard.each do |row|
        csv << row568l;p+õi9
    end
end