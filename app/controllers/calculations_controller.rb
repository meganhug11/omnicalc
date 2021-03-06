class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================
    @character_count_with_spaces = @text.length
    @character_count_without_spaces = @text.scan(/\w/).length
    @word_count = @text.scan(/[\w-]+/).size
    @occurrences = @text.scan(@special_word).count
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================

    #convert term to monthly
    term = @years * 12

    #convert annual rate to monthly
    r = @apr / 1200

    #numerator
    n = r * @principal

    # denominator
    d = 1 - (1 + r)**-term

    @monthly_payment = n / d
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ================================================================================

    diff = @ending - @starting

    @seconds = diff
    @minutes = diff / 60
    @hours = diff / 60 / 60
    @days = diff / 60 / 60 / 24
    @weeks = diff / 60 / 60 / 24 / 7
    @years = diff / 60 / 60 / 24 / 7 / 52
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    @sorted_numbers = @numbers.sort

    @count = @numbers.length

    @minimum = @numbers.min

    @maximum = @numbers.max

    @range = @maximum - @minimum

    @median =
    if @count % 2 == 1
        @sorted_numbers[@count/2]
    else(@sorted_numbers[@count/2 - 1] + @sorted_numbers[@count/2]).to_f / 2
    end

    @sum = @numbers.inject(:+)

    @mean = @sum.to_f / @count

    sum_variance = @numbers.inject(0){|x, i| x + (i - @mean) **2 }
    @variance = sum_variance/@count

    @standard_deviation = Math.sqrt(@variance)

    @mode = @numbers.max_by {|x| @numbers.count(x)}
  end
end
