require 'csv'

class Application
  def start
    quiz = Quiz.new
    quiz.get_question_amount
  end
end

class Quiz
  def get_question_amount
    puts "How many questions would you like to answer?"
    a = gets.chomp
    @question_amount = Integer(a)
  end
end

class Uploader
  attr_reader :strands, :standards, :questions

  def initialize(csv_path)
    @csv_path = csv_path
    @strands = Array.new
    @standards = Array.new
    @questions = Array.new
  end

  #fix read process
  def upload_quiz_data
    guests = CSV.foreach(@csv_path, headers:true) do |row|
      @strands << read_strand(row['strand_id'], row['strand_name'])
      @standards << Standard.new(row['standard_id'], row['standard_name'])
      @questions << Question.new(row['question_id'], row['question_difficulty'])
    end
    @strands.compact!
  end

  #should not map over enumerable every time
  def read_strand(id, name)
    @strands.compact!
    Strand.new(id, name) unless @strands.map(&:id).include?(id)
  end
end

#move all classes to unique files
class Strand
  attr_accessor :standards
  attr_reader :id, :name
  def initialize(id, name)
    @id = id
    @name = name
    @standards = Array.new
  end
end

class Standard
  attr_accessor :questions
  attr_reader :id, :name
  def initialize(id, name)
    @id = id
    @name = name
    @questions = Array.new
  end
end

class Question
  attr_accessor :id, :difficulty
  def initialize(id, difficulty)
    @id = id
    @difficulty = difficulty
  end
end
