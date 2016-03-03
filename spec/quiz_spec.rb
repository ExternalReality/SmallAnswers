require 'spec_helper'
require_relative '../small_answers'

RSpec.describe "Sign on process" do
  it "can upload data from a questions csv file" do
    Given 'I have a properly formatted questions CSV file uploader' do
      @uploader = Uploader.new('spec/questions.csv')
    end

    When 'I upload the quiz data' do
      @uploader.upload_quiz_data
    end

    Then 'I should have access to all the quiz data found in the CSV' do
      strand_count = 2
      standard_count = 6
      question_count = 12

      expect(@uploader.strands.count).to be strand_count
      expect(@uploader.standards.count).to be standard_count
      expect(@uploader.questions.count).to be question_count
    end
  end
end

