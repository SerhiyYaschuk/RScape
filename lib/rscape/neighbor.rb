require_relative 'sugarscape.rb'

module RScape
  module Neighbor
    def neighbors(sugarscape)
      neighbors = []
      neighborhood = [
        [@row, @col - 1],
        [@row, @col + 1],
        [@row - 1, @col],
        [@row + 1, @col]
      ]
      
      neighborhood.each do |site|
        destination = sugarscape.cell(site[0], site[1])
        
        if destination.occupied?
          neighbors << destination.occupant
        end
      end
      
      neighbors
    end
  end
end
