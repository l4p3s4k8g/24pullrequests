require 'spec_helper'

describe 'Gifts' do
	subject { page }
	let(:user)          { create :user, nickname: "akira" }
	let(:pull_request)  { create(:pull_request, user: user, title: 'Example Pull Request') }
	let(:gift)          { create(:gift, user: user, pull_request: pull_request) }

	describe '#new' do
		should_not have_xpath "//option[contains(text(), '#{pull_request.title}')]"

		click_on "Gift it!"

		should_not have_xpath "//option[contains(text(), '#{pull_request.title}')]"
	end
end
