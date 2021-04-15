def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"

  students = []
  name = gets.chomp

  while !name.empty? do
    students << {name: name, cohort: :november}
    puts "Now we have #{students.count} students"
    name = gets.chomp
  end
  
  students
end

def first_letter(students)
  puts "View students beginning with which letter?"
  puts "To finish, just hit return twice"
  
  while true do
    letter = gets.chomp
    break if letter.empty?
    students.each do |student|
      if student[:name].length < 12
        if student[:name][0] == letter
          puts "#{student[:name]} (#{student[:cohort]})"
        end
      end
    end
  end
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print(students)
  counter = 0
  while students.length > counter
    if students[counter][:name].length < 12
      puts "#{students[counter][:name]} (#{students[counter][:cohort]} cohort)"
    end
    counter += 1
  end
end

def print_footer(students)
  puts "Overall, we have #{students.count} great students"
end

students = input_students
print_header
print(students)
first_letter(students)
print_footer(students)