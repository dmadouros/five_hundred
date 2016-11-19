require 'spec_helper'

module FiveHundred
  describe BiddingEngine do
    it 'should pass on empty hand' do
      hand = Hand.new

      expect(BiddingEngine.new(hand).bid).to eq :pass
    end

    it 'should bid on amazing hand' do
      # Joker
      # Right bower
      # Left bower
      # Ace
      # King
      # Queen
      # 10
      # 9
      # 8
      # 7
    end
  end

  describe Hand do
    it 'should receive card' do
      card = Card.new(name: :joker)
      hand = Hand.new

      hand.receive(card)

      expect(hand.contents).to eq([card])
    end

    it 'should calculate score of perfect hearts hand' do
      hand = Hand.new
      [
        Card.new(name: :joker),
        Card.new(name: :ace, suit: Suit.hearts),
        Card.new(name: :king, suit: Suit.hearts),
        Card.new(name: :queen, suit: Suit.hearts),
        Card.new(name: :jack, suit: Suit.hearts),
        Card.new(name: :jack, suit: Suit.diamonds),
        Card.new(name: :ten, suit: Suit.hearts),
        Card.new(name: :nine, suit: Suit.hearts),
        Card.new(name: :eight, suit: Suit.hearts),
        Card.new(name: :seven, suit: Suit.hearts),
      ].each { |card| hand.receive(card) }

      expect(hand.score).to eq 95
    end
  end

  describe Card do
    it 'should handle joker' do
      expect(Card.new(name: :joker).name).to be :joker
    end

    it 'should determine suit' do
      card = Card.new(name: :seven, suit: Suit.hearts)

      expect(card.name).to eq :seven
      expect(card.suit).to eq Suit.hearts
    end
  end

  describe CardScore do
    it 'should calculate score for joker' do
      card = Card.new(name: :joker)

      expect(CardScore.new(card, nil).call).to eq 14
    end

    it 'should calculate score for ace' do
      card = Card.new(name: :ace)

      expect(CardScore.new(card, nil).call).to eq 11
    end

    it 'should calculate score for king' do
      card = Card.new(name: :king)

      expect(CardScore.new(card, nil).call).to eq 10
    end

    it 'should calculate score for queen' do
      card = Card.new(name: :queen)

      expect(CardScore.new(card, nil).call).to eq 9
    end

    describe 'jacks' do
      it 'should calculate score for right bower' do
        card = Card.new(name: :jack, suit: Suit.hearts)

        expect(CardScore.new(card, Suit.hearts).call).to eq 13
      end

      it 'should calculate score for left bower' do
        card = Card.new(name: :jack, suit: Suit.diamonds)

        expect(CardScore.new(card, Suit.hearts).call).to eq 12
      end

      it 'should calculate score for jack' do
        card = Card.new(name: :jack, suit: Suit.clubs)

        expect(CardScore.new(card, Suit.hearts).call).to eq 8
      end
    end

    it 'should calculate score for ten' do
      card = Card.new(name: :ten)

      expect(CardScore.new(card, nil).call).to eq 7
    end

    it 'should calculate score for nine' do
      card = Card.new(name: :nine)

      expect(CardScore.new(card, nil).call).to eq 6
    end

    it 'should calculate score for eight' do
      card = Card.new(name: :eight)

      expect(CardScore.new(card, nil).call).to eq 5
    end

    it 'should calculate score for seven' do
      card = Card.new(name: :seven)

      expect(CardScore.new(card, nil).call).to eq 4
    end

    it 'should calculate score for six' do
      card = Card.new(name: :six)

      expect(CardScore.new(card, nil).call).to eq 3
    end

    it 'should calculate score for five' do
      card = Card.new(name: :six)

      expect(CardScore.new(card, nil).call).to eq 2
    end

    it 'should calculate score for four' do
      card = Card.new(name: :six)

      expect(CardScore.new(card, nil).call).to eq 1
    end
  end

  describe Suit do
    describe '#color' do
      it 'should know hearts are red' do
        expect(Suit.hearts.color).to eq :red
      end

      it 'should know diamonds are a girls best friend' do
        expect(Suit.diamonds.color).to eq :red
      end

      it 'should know clubs are black' do
        expect(Suit.clubs.color).to eq :black
      end

      it 'should know spades are black' do
        expect(Suit.spades.color).to eq :black
      end
    end
  end
end
