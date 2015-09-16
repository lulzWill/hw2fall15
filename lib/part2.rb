class WrongNumberOfPlayersError < StandardError ; end
class NoSuchStrategyError < StandardError ; end

def rps_game_winner(game)
  raise WrongNumberOfPlayersError unless game.length == 2
  raise NoSuchStrategyError unless game[0][1].match(/\A[RPS]\z/i)
  raise NoSuchStrategyError unless game[1][1].match(/\A[RPS]\z/i)
  
  if game[0][1].downcase.eql?("p")
    if game[1][1].downcase.eql?("p")
      return game[0]
    elsif game[1][1].downcase.eql?("s")
      return game[1]
    else
      return game[0]
    end
  elsif game[0][1].downcase.eql?("r")
    if game[1][1].downcase.eql?("p")
      return game[1]
    elsif game[1][1].downcase.eql?("s")
      return game[0]
    else
      return game[0]
    end
  elsif game[0][1].downcase.eql?("s")
    if game[1][1].downcase.eql?("p")
      return game[0]
    elsif game[1][1].downcase.eql?("s")
      return game[0]
    else
      return game[1]
    end
  end
end

def rps_tournament_winner(tournament)
  #flatten array so that depth doesn't matter
  tournament.flatten!
  winners_array = Array.new
  
  while(tournament.length != 2)
    while(!tournament.empty?)
      player1 = Array.new
      player2 = Array.new
      #pull last four elements from the tournament array to use as a match
      player1 << tournament.slice!(-2)
      player1 << tournament.slice!(-1)
      player2 << tournament.slice!(-2)
      player2 << tournament.slice!(-1)
      #form the match
      rps_match = Array.new
      rps_match << player2
      rps_match << player1
      #evaluate the match and add winner to winners list
      winners_array << rps_game_winner(rps_match)
    end
    #since tournament is now empty, refill it with the winners and repeat the previous process until one person is left
    tournament << winners_array
    tournament.flatten!
    winners_array = Array.new
  end
  
  return tournament
end