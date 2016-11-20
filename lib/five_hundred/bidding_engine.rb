module FiveHundred
  class BiddingEngine
    def initialize(hand)

    end

    def bid
      :pass
    end
  end

  class Hand
    def initialize
      @cards = []
    end

    def receive(card)
      cards << card
    end

    def contents
      @cards
    end

    def score(suit)
      contents.inject(0) do |sum, card|
        score = CardScore.new(card, suit).call
        sum + score
      end
    end

    private

    attr_reader :cards
  end

  class Card
    attr_reader :name, :suit

    def initialize(options)
      @name = options[:name]
      @suit = options[:suit]
    end

    def right_bower?(suit)
      name == :jack && self.suit == suit
    end

    def left_bower?(suit)
      name == :jack && self.suit.color == suit.color && self.suit != suit
    end

    def score(suit)
      CardScore.new(self, suit).call
    end
  end

  class CardScore
=begin
    idea

    value         => weight
    -----------------------
    :four         => 1
    :five         => 2
    :six          => 3
    :seven        => 4
    :eight        => 5
    :nine         => 6
    :ten          => 7
    :jack         => 8
    :queen        => 9
    :king         => 10
    :ace          => 11
    :left_bower   => 12
    :right_bower  => 13
    :joker        => 14
=end

    def initialize(card, suit)
      @card = card
      @suit = suit
    end

    def call
      return 13 if card.right_bower?(suit)
      return 12 if card.left_bower?(suit)
      return 14 if card.name == :joker
      return 0 unless trump_suit?

      values[card.name]
    end

    private

    attr_reader :card, :suit

    def trump_suit?
      suit == card.suit
    end

    def values
      {
        four: 1,
        five: 2,
        six: 3,
        seven: 4,
        eight: 5,
        nine: 6,
        ten: 7,
        jack: 8,
        queen: 9,
        king: 10,
        ace: 11,
      }
    end
  end

  class Suit
    class << self
      def hearts
        new(:hearts, :red)
      end

      def diamonds
        new(:diamonds, :red)
      end

      def spades
        new(:spades, :black)
      end

      def clubs
        new(:clubs, :black)
      end
    end

    attr_reader :color

    def ==(other)
      self.class == other.class && name == other.name
    end

    private
    def initialize(name, color)
      @name = name
      @color = color
    end

    protected

    attr_reader :name
  end
end
