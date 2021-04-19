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
    push_student_info(name, cohort)
    @students.length == 1 ? (puts "Now we have 1 student") : (puts "Now we have #{@students.count} students".center(50, '-'))
  end
end

def push_student_info(name, cohort)
  @students << {name: name, cohort: cohort.to_sym}
end

def search_first_letter
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

def select_menu_item(selection)
  case selection
    when "1"
      input_students
    when "2"
      print_students_list
    when "3"
      puts "Please enter a filename to save as"
      save_students(STDIN.gets.chomp)
    when "4"
      puts "Which file would you like to load?"
      load_students(STDIN.gets.chomp)
    when "9"
      exit
    else
      puts "I don't know what you meant, try again"
  end
end

def save_students(filename)
  filename.empty? ? save_file = "students.csv" : save_file = filename
  File.open(save_file, "w") do |f|
    @students.each do |student|
      student_data = [student[:name], student[:cohort]]
      csv_line = student_data.join(",")
      f.puts csv_line
    end
  end
  puts "Student list saved"
end

def load_students(filename)
  filename.empty? ? load_file = "students.csv" : load_file = filename
  File.open(load_file, "r") do |f|
    f.readlines.each do |line|
    name, cohort = line.chomp.split(',')
      push_student_info(name, cohort)
    end
  end
  puts "#{@students.length} students from #{filename} loaded"
end

def startup_load_students
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
    select_menu_item(STDIN.gets.chomp)
  end
end

startup_load_students
interactive_menu
