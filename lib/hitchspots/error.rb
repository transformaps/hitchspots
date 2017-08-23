module Hitchspots
  class Error < StandardError; end
  class ApiError < Error; end
  class ApiChanged < Error; end
  class NotFound < Error; end
end
