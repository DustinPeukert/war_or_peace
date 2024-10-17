class CardGenerator
  attr_reader :deck

  def initialize
    @deck = []
  end

  def create_cards(file_path)
    File.foreach(file_path) do |line| # File.foreach takes a file path as its argument and reads it line by line
      card_data = line.split(',') # splits the line using commas as a delimiter, returning an array
      
      value = card_data[0].strip # .strip removes all white space and newline characters
      
      if card_data[1].strip == 'Heart'
        suit = :heart
      elsif card_data[1].strip == 'Diamond'
        suit = :diamond
      elsif card_data[1].strip == 'Club'
        suit = :club
      elsif card_data[1].strip == 'Spade'
        suit = :spade
      end
    
      rank = card_data[2].to_i
    
      @deck << Card.new(suit, value, rank)
    end
  end
end