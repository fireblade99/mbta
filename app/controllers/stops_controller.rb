class StopsController < ApplicationController

  def index
  	my_loc = []
  	my_loc << params[:lat].to_i
  	my_loc << params[:lon].to_i
  	
  	map = {}
  	@stops = Stop.all
  	
  	@stops.each do |stop|
  		stop_loc = []
  		stop_loc << stop.lat.to_i
  		stop_loc << stop.lon.to_i
  		map[stop.id] = self.distance(my_loc, stop_loc) 
  	end
  	a = Hash[map.sort_by { |k,v| v }[0..2]]	
  	@map_me = []
  	
  	@map_me << Stop.find(a.keys[0])
  	@map_me << Stop.find(a.keys[1])
  	@map_me << Stop.find(a.keys[2])
  end
  	  	 	
  def distance loc1, loc2
  	rad = Math::PI / 180
  	lat1, lon1 = loc1
    lat2, lon2 = loc2
    dLat = (lat2-lat1) * rad;
    dLon = (lon2-lon1) * rad;
    a = Math.sin(dLat/2) * Math.sin(dLat/2) +
        Math.cos(lat1 * rad) * Math.cos(lat2 * rad) *
        Math.sin(dLon/2) * Math.sin(dLon/2);
    c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
    
    return c
    
  end
   	
end
