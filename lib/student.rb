require_relative "../config/environment.rb"

class Student

attr_accessor :name, :grade
attr_reader :id

  def initialize(name, grade, id=nil)
    @name=name
    @grade=grade
    @id=id
  end

  def self.create_table
    sql = "CREATE TABLE IF NOT EXISTS students (
    id INTEGER PRIMARY KEY,
    name TEXT,
    grade INTEGER);"
    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = "DROP TABLE IF EXISTS students"

    DB[:conn].execute(sql)
  end

  def update 
    sql= "UPDATE students SET name = ?, grade = ? WHERE id = ?;"
    DB[:conn].execute(sql, self.name, self.grade, self.id)
  end 

  def save
    if self.id 
      self.update 
    else 
    sql = "INSERT INTO students (name, grade)
    VALUES (?,?);"

    DB[:conn].execute(sql,self.name,self.grade)
    @id= DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
  end
end
