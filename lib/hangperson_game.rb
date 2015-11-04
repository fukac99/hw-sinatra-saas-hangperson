class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  # Get a word from remote "random word" service

  def initialize( word )
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def guess( letter )
    if letter == '' or letter.nil? or not letter =~ /[[:alpha:]]/
      raise ArgumentError
    end
    letter = letter.downcase
    if @guesses.include? letter or @wrong_guesses.include? letter
      return false
    elsif @word.include? letter
      @guesses += letter
    else
      @wrong_guesses += letter
    end
  end
  
  def word_with_guesses
    res = ''
    @word.each_char do |letter|
      if @guesses.include? letter
        res += letter
      else
        res += '-'
      end
    end
    return res 
  end
  
  def check_win_or_lose
    if @guesses.length == @word.chars.to_a.uniq.length and @wrong_guesses.length < 7
      res = :win
    elsif @guesses.length < @word.chars.to_a.uniq.length and @wrong_guesses.length >= 7
      res = :lose
    else
      res = :play
    end
    return res
  end
  
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
