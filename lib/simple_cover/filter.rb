module SimpleCover
  class Filter
      
    def initialize(collection)
      @collection = collection
    end

    def reject_by(filter_method)
      @collection.reject { |el| el.send(filter_method) }
    end

  end
end