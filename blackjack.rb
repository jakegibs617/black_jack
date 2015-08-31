#!/usr/bin/env ruby
require_relative "deck"
require_relative "hand"
require_relative "card"

require 'pry'
chips = 1000
fingers = 10

  SUITS = ["♠", "♥", "♦", "♣"]
  VALUES = [2, 3, 4, 5, 6, 7, 8, 9, 10, "J", "Q", "K", "A"]
  deck = Deck.new

while true
  puts "play or exit?"
  game = gets.chomp
	if fingers == 0
		puts "You are out of fingers, how do you plan on playing?"
		sleep(2)
		puts "go home, gambling is not for you pal"
		break
	end

  break if game.downcase == "exit"
  puts "how much do you want to bet?"
  bet = gets.chomp.to_i
  if bet > chips
    puts "sir you do not have the funds, are you sure you want to risk debt?"
      answer = gets.chomp
      if answer != "no"
        puts "enjoy"
      else
        break
      end
  end

  player = Hand.new(deck, "player")
  dealer = Hand.new(deck, "dealer")

  player.deal!
  puts "\nPLAYER SCORE: #{player.total}"
  player.choice

  sleep(1)
  dealer.deal!
  until dealer.total > 16
    puts "Dealer hits"
    dealer.hit
  end
  if dealer.total > 21
    puts "DEALER BUST!"
  else
    puts "\nDEALER SCORE: #{dealer.total}"
  end

  if (player.total > 21 || dealer.total > player.total) && dealer.total < 22
    sleep(0.5)
    puts "\nDealer Wins!"
    puts "player: -#{bet} chips"
    chips -= bet
    puts "player total chips: #{chips}"
    if chips < -5000
      system("say 'please step in our back room, we just want to talk about your finances'")
			sleep(3)
      puts "..."
      sleep(3)
			system("say -v whisper 'Nooooooooooo'")
      puts "**screams heard in the distance muffled**"
      sleep(2)
      fingers -= 1
      puts "you died, lives -1, fingers left:#{fingers}"
      chips = 1000
    end

  elsif (dealer.total > 21 || player.total > dealer.total) && player.total < 22
    sleep(0.5)
    puts "player: +#{bet} chips"
    puts "\nPlayer Wins!"
    chips += bet
    puts "player total chips: #{chips}"
    if chips > 50000
			sleep(2)
      system("say 'Sir, please step in our back room'")
      puts "..."
      sleep(3)
			system("say -v whisper 'Nooooooooooo'")
      puts "**screams heard in the distance muffled**"
      sleep(2)
      fingers -= 1
      puts "you died, fingers -1, fingers left:#{fingers} \n you have been kicked out of this casino"
      chips = 1000
    end
  else
    sleep(0.5)
    puts "\ndraw"
  end
end
