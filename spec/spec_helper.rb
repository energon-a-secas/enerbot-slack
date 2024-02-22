require 'ostruct'

class DummyClass
  def initialize; end

  def struct
    data = { 'type' => 'message',
             'channel' => 'CQZA6RJ2E',
             'subtype' => 'user',
             'user' => 'UR0KGQUQK',
             'text' => 'RSPEC',
             'suppress_notification' => false,
             'username' => 'PATHFINDER' }
    OpenStruct.new data
  end
end
