# Copyright (C) 2012-2021 Zammad Foundation, http://zammad-foundation.org/

class Sequencer
  class Unit
    module Import
      module Kayako
        module Post
          module Channel
            class Base
              attr_reader :resource

              def initialize(resource)
                @resource = resource
              end

              def mapping
                {
                  message_id: resource['id'],
                  internal:   internal?,
                  from:       from,
                  type_id:    article_type_id,
                }
              end

              def article_type_id
                return if article_type_name.nil?

                ::Ticket::Article::Type.select(:id).find_by(name: article_type_name).id
              end

              private

              def internal?
                false
              end

              def original_post
                resource['original']
              end

              def article_type_name
                raise NotImplementedError
              end

              def identify_key
                raise NotImplementedError
              end

              def from
                return if resource['identity'].nil?

                resource['identity'][identify_key]
              end
            end
          end
        end
      end
    end
  end
end
