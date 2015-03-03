# encoding: utf-8

module Bookfile

class Bookfile

  ## include LogUtils::Logging

  attr_reader :packages
  attr_reader :databases
  attr_reader :books

  def initialize
    @packages  = []    # only allow single package  - why, why not??
    @databases = []    # only allow single database - why, why not??
    @books     = []    # only allow single book     - why, why not??
  end


  def download
##    logger.info( "[datafile] dowload" )
##    @datasets.each do |dataset|
##      dataset.download()
##    end
  end


  def setup
    puts "[bookfile] setup database connections n models"
    @databases.each do |database|
      database.setup
    end
  end

  def prepare
    @databases.each do |database|
      database.prepare
    end
  end


  def build
    puts "[bookfile] build books"
    @books.each do |book|
      book.build
    end
  end



  def dump
##    ## for debugging dump datasets (note: will/might also check if zip exits)
##    logger.info( "[datafile] dump datasets (for debugging)" )
##    @datasets.each do |dataset|
##      dataset.dump()
##    end
  end


end # class Bookfile
end # module Bookfile

