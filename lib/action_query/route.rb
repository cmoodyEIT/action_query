module ActionQuery
  module Route
    def self.result
      variances = HashWithIndifferentAccess.new(::Rails.application.config.action_query) rescue {}
      controllers = HashWithIndifferentAccess.new
      ::Rails.application.routes.routes.each do |route|
        next unless route.defaults[:controller]
        names = route.defaults[:controller].split('/')
        obj = controllers
        names.each_with_index do |name,index|
          obj[name.classify()] ||= HashWithIndifferentAccess.new
          obj = obj[name.classify()]
        end
        obj[route.defaults[:action]] ||= []
        notArray = !!route.path.spec.to_s.match(/\:id/) || ['CREATE','NEW'].include?(route.defaults[:action].upcase)
        if (variance = HashWithIndifferentAccess.new(variances[route.defaults[:controller]])).present?
          notArray = !variance[route.defaults[:action]][:array] unless variance[route.defaults[:action]].nil?
        end
        path = {
          parts:        route.parts.map(&:to_s),
          path:         route.path.spec.to_s,
          verb:         route.verb,
          requirements: route.required_parts.map(&:to_s),
          method:       route.defaults[:action],
          array:        !notArray
        }
        obj[route.defaults[:action]] << path
      end
      controllers
    end

    def self.to_coffee
      result.map{|k,v| self.write_class("#{k}",v)}.flatten.join
    end


    def self.write_class(key,val)
      classes = []
      res  = "class ActionQuery.#{key} extends ActionQuery.$Base\n"
      res += "  @methods("
      arr = []
      val.each do |k,v|
        if v.is_a? Array
          arr << "#{k}: [{#{v.map{|path| path.map{|l,m| "#{l}: #{m.inspect}"}.join(',')}.join('},{')}}]"
        else
          classes << write_class("#{key}.#{k}",v)
        end
      end
      res += arr.join(',')
      res += "  )\n"
      [res] | classes
    end

  end
end
