## 3rd party libs
require 'originals'

## pull-in web service support
require 'sinatra/base'    ## note: using the "modular" style
require 'webrick'


## our own code
require_relative 'profilepic/version'    # note: let version always go first
require_relative 'profilepic/builder'
require_relative 'profilepic/helper'

require_relative 'profilepic/config/yeoldepunks'
require_relative 'profilepic/config/marcs'
require_relative 'profilepic/config/saudis'
require_relative 'profilepic/config/doge'
require_relative 'profilepic/config/ordinalpunks'
require_relative 'profilepic/service'



module Profilepic
  def self.main
     puts 'hello from main'

  #####
  # fix/todo:
  ##   use differnt port ??
  ##
  ##  use --local  for host e.g. 127.0.0.1  insteaod of 0.0.0.0 ???

 #   puts 'before Puma.run app'
 #   require 'rack/handler/puma'
 #   Rack::Handler::Puma.run ProfilepicService, :Port => 3000, :Host => '0.0.0.0'
 #   puts 'after Puma.run app'

 # use webrick for now - why? why not?
     puts 'before WEBrick.run service'
     Rack::Handler::WEBrick.run ProfilepicService, :Port => 3000, :Host => '127.0.0.1'
     puts 'after WEBrick.run service'

    puts 'bye'
  end
end


####
# convenience aliases / shortcuts / alternate spellings
ProfilePic        = Profilepic
ProfilePicService = ProfilepicService



puts Profilepic.banner    # say hello
