require 'rspec'
require 'game'

describe Game do
  describe '#initialize' do
    it 'is a Game' do
      game = Game.new

      expect(game).to be_a(Game)
    end

    it 'has attributes' do
      game = Game.new

      expect(game.player1_wins).to eq(0)
      expect(game.player2_wins).to eq(0)
      expect(game.no_winners).to eq(0)
      expect(game.mad_count).to eq(0)
      expect(game.war_count).to eq(0)
      expect(game.turn_number).to eq(0)
    end
  end
end