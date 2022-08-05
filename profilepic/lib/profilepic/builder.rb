
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
      archetype = _norm_key( params[:t] || 'marc' )
      more_attributes = _parse_attributes( params[:attributes] || '' )

      eyes     = _norm_key( params[:eyes] || 'none' )
      face     = _norm_key( params[:face] || 'none' )
      beard     = _norm_key( params[:beard] || 'none' )
      hair      = _norm_key( params[:hair] || 'none' )
      headwear  = _norm_key( params[:headwear] || 'none' )
      eyewear  = _norm_key( params[:eyewear] || 'none' )
      mouth    = _norm_key( params[:mouth] || 'none' )

      zoom       = _parse_zoom( params[:z] || '1' )
      background = _norm_key( params[:bg] || 'none' )

      attributes = [archetype]
      attributes << eyes       if eyes != 'none'
      attributes << face       if face != 'none'
      attributes << hair       if hair != 'none'
      attributes << beard      if beard != 'none'
      attributes << headwear    if headwear != 'none'
      attributes << eyewear    if eyewear != 'none'
      attributes << mouth      if mouth != 'none'

      new( name: name,
           attributes:  attributes + more_attributes,
           zoom: zoom,
           background: background )
  end


  def self._norm_key( str )
    str.downcase.strip
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
end

