require 'pry-byebug'

class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]

  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name, grade, id=nil)
    @name = name
    @grade = grade
    @id = id
  end

  def self.create_table
    sql = "CREATE TABLE IF NOT EXISTS students (
    id INTEGER PRIMARY KEY,
    name TEXT,
    grade TEXT
    );"
    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = "DROP TABLE students;"
    DB[:conn].execute(sql)
  end

  def save
    save = "INSERT INTO students (name, grade) VALUES (?, ?);"
    DB[:conn].execute(save, self.name, self.grade)
    pull = "SELECT students.id FROM students ORDER BY students.id DESC LIMIT 1"
    # binding.pry
    @id = DB[:conn].execute(pull).flatten[0]
  end

  def self.create(attributes)
    new_student = Student.new(attributes[:name], attributes[:grade])
    new_student.save
    new_student
  end

end
