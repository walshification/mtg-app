class Card

  attr_accessor 

  def self.find(id)
    Card.new(Unirest.get("http://api.mtgdb.info/cards/#{id}").body)
  end
end
