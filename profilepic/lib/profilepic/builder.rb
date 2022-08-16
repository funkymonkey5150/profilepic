
## keep cache of generated images (profile pics)
IMAGES = {}




class ImageReq    ## (Generate) Image Request
  def self.build( params )
    puts "==> image request params:"
    pp params

     name       = _norm_key( params[:t] || 'punk'  )
     attributes = _parse_attributes( params[:attributes] || '' )

     zoom       = _parse_zoom( params[:z] || '1' )
     background = _norm_key( params[:bg] || 'none' )

      new( name: name,
           attributes: attributes,
           zoom: zoom,
           background: background )
  end

  def self.build_marc( params )
    puts "==> image request params:"
    pp params

      name = 'marc'
      attributes = _build_attributes( params, MARC )

      zoom       = _parse_zoom( params[:z] || '1' )
      background = _norm_key( params[:bg] || 'none' )

      new( name: name,
           attributes:  attributes,
           zoom: zoom,
           background: background )
  end

  def self.build_doge( params )
    puts "==> image request params:"
    pp params

      name = 'doge'

      attributes = _build_attributes( params, DOGE )

      zoom       = _parse_zoom( params[:z] || '1' )
      background = _norm_key( params[:bg] || 'none' )


      new( name: name,
           attributes:  attributes,
           zoom: zoom,
           background: background )
  end


  def self.build_yeoldepunk( params )
    puts "==> image request params:"
    pp params

      name = 'yeoldepunk'

      attributes = _build_attributes( params, YEOLDEPUNK )

      zoom       = _parse_zoom( params[:z] || '1' )
      background = _norm_key( params[:bg] || 'none' )

      new( name: name,
           attributes:  attributes,
           zoom: zoom,
           background: background )
  end



  attr_reader :name,
              :attributes,
              :zoom,
              :background
  def initialize( name:, attributes:, zoom:, background: )
     @name       = name
     @attributes = attributes
     @zoom       = zoom
     @background = background
  end

  def image
    img = Original::Image.fabricate( @name, *@attributes )
    img = img.background( @background )   if @background != 'none'
    img = img.zoom( @zoom )  if [2,3,4,5,6,7,8,9,10,20].include?( @zoom )
    img
  end

  def image_key
     @key ||= begin
                key = "#{@name}#{Time.now.to_i}"
                key << "@#{@zoom}x"   if [2,3,4,5,6,7,8,9,10,20].include?( @zoom )
                key
             end
     @key
  end

#####
#  (static) helpers

def self._norm_key( str )
  str.downcase.strip
end


def self._build_attributes( params, spec )
  attributes = []
  spec.each do |name,h|

    value = params[name]

    if value.nil? || value.empty?
      required =  h[:none] == true   ## check if value is required or optional
      if required
         raise ArgumentError, "required attribute/param >#{name}< missing"
      else
         next   ## skip optional attributes
      end
    else
        key = _norm_key( value )
        attributes << key       if key != 'none'
    end
  end
  attributes
end


def self._parse_attributes( str )
  # convert attributes to array
  ##   allow various separators
  attributes = str.split( %r{[,;|+/]+} )
  attributes = attributes.map { |attr| attr.strip }
  attributes = attributes.select { |attr| !attr.empty?}   ## remove empty strings (if any)
  attributes
end

def self._parse_zoom( str )
  str.strip.to_i( 10 )
end

end

