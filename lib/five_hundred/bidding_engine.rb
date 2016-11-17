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

    private

    attr_reader :cards
  end

  class Card
    attr_reader :value, :suit

    def initialize(options)
      @value = options[:value]
      @suit = Suit.new(options[:suit])
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

    def initialize(card, sweep_suit)
      @card = card
      @sweep_suit = Suit.new(sweep_suit)
    end

    def call
      return 13 if right_bower?
      return 12 if left_bower?

      card_values = {
        joker: 14,
        ace: 11,
        jack: 8,
      }

      card_values[card.value]
    end

    private

    attr_reader :card, :sweep_suit

    def right_bower?
      card.value == :jack && sweep_suit == card.suit
    end

    def left_bower?
      card.value == :jack && sweep_suit.color == card.suit.color && sweep_suit != card.suit
    end
  end

  class Suit
    def initialize(suit)
      @suit = suit
    end

    def color
      {
        :hearts => :red,
        :diamonds => :red,
        :clubs => :black,
        :spades => :black,
      }.fetch(suit)
    end

    def ==(other)
      self.class == other.class && suit == other.suit
    end

    protected

    attr_reader :suit
  end
end
