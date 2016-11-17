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
      card = Card.new(value: :joker)
      hand = Hand.new

      hand.receive(card)

      expect(hand.contents).to eq([card])
    end
  end

  describe Card do
    it 'should handle joker' do
      expect(Card.new(value: :joker).value).to be :joker
    end

    it 'should determine suit' do
      card = Card.new(value: 7, suit: :hearts)

      expect(card.value).to eq 7
      expect(card.suit).to eq Suit.new(:hearts)
    end
  end

  describe CardScore do
    it 'should calculate score for joker' do
      card = Card.new(value: :joker)

      expect(CardScore.new(card, nil).call).to eq 14
    end

    it 'should calculate score for ace' do
      card = Card.new(value: :ace)

      expect(CardScore.new(card, nil).call).to eq 11
    end

    describe 'jacks' do
      it 'should calculate score for right bower' do
        card = Card.new(value: :jack, suit: :hearts)

        expect(CardScore.new(card, :hearts).call).to eq 13
      end

      it 'should calculate score for left bower' do
        card = Card.new(value: :jack, suit: :diamonds)

        expect(CardScore.new(card, :hearts).call).to eq 12
      end

      it 'should calculate score for jack' do
        card = Card.new(value: :jack, suit: :clubs)

        expect(CardScore.new(card, :hearts).call).to eq 8
      end
    end
  end

  describe Suit do
    describe '#color' do
      it 'should know hearts are red' do
        expect(Suit.new(:hearts).color).to eq :red
      end

      it 'should know diamonds are a girls best friend' do
        expect(Suit.new(:diamonds).color).to eq :red
      end

      it 'should know clubs are black' do
        expect(Suit.new(:clubs).color).to eq :black
      end

      it 'should know spades are black' do
        expect(Suit.new(:spades).color).to eq :black
      end
    end
  end
end
