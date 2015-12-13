module Concerns
  module Coderwall
    def coderwall_username
      coderwall_user_name || nickname
    end

    def change_coderwall_username!(username)
      update_attributes!(coderwall_user_name: username)
    end

    def award_coderwall_badges
      return unless coderwall.configured?

      return unless pull_requests.year(CURRENT_YEAR).any?
      coderwall.award_badge(coderwall_username, ::Coderwall::PARTICIPANT)

      return unless pull_requests.year(CURRENT_YEAR).length > 23
      coderwall.award_badge(coderwall_username, ::Coderwall::CONTINUOUS)
    end

    private

    def coderwall
      @coderwall ||= ::Coderwall.new
    end
  end
end
