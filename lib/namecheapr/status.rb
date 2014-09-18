module Namecheapr
  class Status
    attr_accessor :type, :message, :code
    
    def initialize(type, message, code = nil)
      @type     =   type
      @message  =   message
      @code     =   code
    end

  end
end
