module ImaggaAutoTag
  
  class TaggedImage

    attr_reader :status, :tags

    def initialize(api_response)
      body = JSON.parse(api_response.body)

      @tags = []

      body['tags'].each do |tag|
        @tags.push Tag.new(tag)
      end

      @status = api_response.status
    end

    def scrub(threshold = 30)
      @tags.reject! do |tag|
        tag.confidence > threshold
      end
    end

    def to_csv
      @tags.join(',')
    end

  end

end