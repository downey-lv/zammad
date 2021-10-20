# Copyright (C) 2012-2021 Zammad Foundation, http://zammad-foundation.org/

class Sequencer
  class Unit
    module Import
      module Kayako
        module Case
          class PriorityId < Sequencer::Unit::Common::Provider::Named

            uses :resource

            private

            def priority_id
              ::Ticket::Priority.select(:id).find_by(name: local).id
            end

            def local
              mapping.fetch(resource['priority']&.fetch('level'), mapping[nil])
            end

            def mapping
              {
                1   => '1 low',
                nil => '2 normal',
                2   => '2 normal',
                3   => '3 high',
                4   => '3 high',
              }.freeze
            end
          end
        end
      end
    end
  end
end
