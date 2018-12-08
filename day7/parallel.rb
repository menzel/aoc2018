#!/usr/bin/ruby

$n = 26
rel = Array.new($n){Array.new($n,0)}

File.open("full", "r") do |f|
  f.each_line do |line| 
      parts = line.split(" ")
      a = parts[1]
      b = parts[7]
      #rel[to][from] 
      rel[b.ord - 65][a.ord - 65] = 1
  end
end

def nextletter(processing, rel) 

    rel.each_with_index do |row,i| 
        if row.inject(0, :+) == 0
            letter = (65 + i).chr 

            if not processing.map{|p| p[0]}.include? letter 
                puts "job #{letter} is to do"
                return letter 
            end
        end 
    end
    return ""
end

def removefinished(rel, letter)

    if letter.length < 1
        return
    end

    puts "remove #{letter}"


    rel.each_with_index do |row,i| 
        rel.each do |row| 
            row[letter.ord - 65] = 0
        end 
    end

    rel[letter.ord-65] = Array.new($n,8) 
end


def onestep(rel,processing,result) 
    processing.each do |worker|
        if worker[1] > 0
            worker[1] -= 1
        end

        if worker[1] == 0 
            result << worker[0] # get the finished letter 
            removefinished(rel,worker[0])
            puts "result: #{result}"
            worker[1] = -1
            worker[0] = ""
        end 
    end 
end

def free_worker(processing)
    processing.each_with_index do |worker,i|
        if worker[1] <= 0
            puts "#{i} is free to work"
            return i
        end
    end 
    return -1 # no free worker found
end

result = ""
time = 0
$nworker = 5

#curren letter and time to got 
processing = Array.new($nworker,["",0])

while result.length < $n 

    onestep(rel,processing,result)

    while true
        worker = free_worker(processing)

        if worker != -1 #if there is a free worker
            letter = nextletter(processing, rel) 

            if letter.length > 0 # if there is a step to do
                puts "worker #{worker} does job #{letter}"
                processing[worker] = [letter,60 + letter.ord - 64]
            else
                puts "no free job"
                break
            end
        else 
            puts "no free worker"
            break
        end
    end

    puts "#{time}\t#{processing[0][0]}:#{processing[0][1]}\t#{processing[1][0]}:#{processing[1][1]}\t#{result}"
    time+=1 
end
puts
puts
puts "result: #{time-1}"
