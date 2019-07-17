# module Errors
#   class Invalid < Errors::StandardError
#     def initialize(errors: {})
#       @errors = errors
#       @status = 422
#       @title = "Unprocessable Entity"
#     end

#     def serializable_hash
#       errors.reduce([]) do |r, (att, msg)|
#         r << {
#           status: status,
#           title: title,
#           detail: msg,
#           source: { pointer: "/data/attributes/#{att}" }
#         }
#       end
#     end

#     private

#     attr_reader :errors
#   end
# end
