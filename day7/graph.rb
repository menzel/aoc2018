#!/usr/bin/ruby

n = 26
rel = Array.new(n){Array.new(n,0)}

File.open("full", "r") do |f|
  f.each_line do |line| 
      parts = line.split(" ")
      a = parts[1]
      b = parts[7]
      #rel[to][from] 
      rel[b.ord - 65][a.ord - 65] = 1
  end
end


result = ""

while result.length < n do

    # find empty row
    rel.each_with_index do |row,i| 
        if row.inject(0, :+) == 0
            letter = (65 + i).chr 
            result << letter

            rel.each do |row| 
                row[letter.ord - 65] = 0
            end
            rel[i] = Array.new(n,8)

            break #break each row loop
        end 
    end
end


puts result
