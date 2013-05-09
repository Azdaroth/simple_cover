module SimpleCover
  class YearsGetter
    
    def initialize(results)
      @results = results
    end

    def most_common
      years = []
      @results.each { |result| years << result["year"] }
      proper_year = years.group_by { |x| x }.to_a.map { |y| y.flatten }.sort_by { |z| z.length }[-1][0] 
    end

  end
end