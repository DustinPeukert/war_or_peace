require 'rspec'
require 'game'

describe Game do
  describe '#initialize' do
    it 'is a Game' do
      game = Game.new

      expect(game).to be_a(Game)
    end
  end
end