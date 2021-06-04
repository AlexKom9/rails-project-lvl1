# # frozen_string_literal: true

# module TagsResolver
#   class << self
#     def br 
#       p 'br' 
#     end

#     def img
#       p 'img'
#     end

#     def input
#       p 'input'  
#     end

#     def label
#       p 'label'
#     end
#   end
# end

# module Tag
#   class Error < StandardError; end

#   include TagsResolver
  
#   class << self
#     def build type, params
#       self.class[type]
#     end
#   end
# end
