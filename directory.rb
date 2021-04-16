@students = []

def input_students
  while true do
    puts "Please enter the name of a student".center(50, '-')
    puts "To finish, just hit return twice".center(50, '-')
    name = STDIN.gets.chomp.capitalize
    break if name.empty?
    puts "Please enter #{name}'s cohort".center(50, '-')
    cohort = STDIN.gets.chomp.capitalize
    cohort = 'Unknown' if cohort.empty?
    puts "Please enter #{name}'s hobby".center(50, '-')
    hobby = STDIN.gets.chomp
    puts "Please enter #{name}'s birthplace".center(50, '-')
    birthplace = STDIN.gets.chomp.capitalize
    puts "Please enter #{name}'s height in cm".center(50, '-')
    height = STDIN.gets.chomp
    @students << {name: name, cohort: cohort, hobby: hobby, birthplace: birthplace, height: height}
    @students.length == 1 ? (puts "Now we have 1 student") : (puts "Now we have #{@students.count} students".center(50, '-'))
  end
end

def first_letter
  puts "View students beginning with which letter?".center(50, '-')
  puts "To finish, just hit return twice".center(50, '-')
  
  while true do
    letter = gets.chomp.capitalize
    break if letter.empty?
    @students.each do |student|
      if student[:name].length < 12
        if student[:name][0] == letter
          puts "#{student[:name]} (#{student[:cohort]} cohort)"
        end
      end
    end
    puts "Enter another letter".center(50, '-')
  end
end

def print_header
  puts "The students of Villains Academy".center(50, '-')
  puts "-------------".center(50, '-')
end

def print_students_list
  counter = 0
  while @students.length > counter
    if @students[counter][:name].length < 12
      puts "#{@students[counter][:name]} (#{@students[counter][:cohort]} cohort)"
    end
    counter += 1
  end
end

def print_footer
  puts "Overall, we have #{@students.count} great students".center(50, '-')
end

def print_by_cohort
  puts "Which cohort would you like to print?".center(50, '-')
  puts "To finish, just hit return twice".center(50, '-')
  while true do
    input = STDIN.gets.chomp.capitalize
    break if input.empty?
    @students.map do |student|
      if student[:cohort] == input
        puts student[:name]
      end
    end
    puts "Select another cohort".center(50, '-')
  end
end

def show_students
  print_header
  print_students_list
  print_footer
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "9. Exit"
end

def process(selection)
  case selection
    when "1"
      input_students
    when "2"
      print_students_list
    when "3"
      save_students
    when "4"
      load_students
    when "9"
      exit
    else
      puts "I don't know what you meant, try again"
  end
end

def save_students
  file = File.open("students.csv", "w")
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def load_students(filename = "students.csv")
  file = File.open(filename, "r")
  file.readlines.each do |line|
  name, cohort = line.chomp.split(',')
    @students << {name: name, cohort: cohort.to_sym}
  end
  file.close
end

def try_load_students
  filename = ARGV.first # first argument from the command line
  return if filename.nil? # get out of the method if it isn't given
  if File.exists?(filename) # if it exists
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else # if it doesn't exist
    puts "Sorry, #{filename} doesn't exist"
    exit # quit the program
  end
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

try_load_students
interactive_menu
