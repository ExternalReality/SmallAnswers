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

app = Application.new
app.start
