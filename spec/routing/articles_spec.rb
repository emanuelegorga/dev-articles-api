require 'rails_helper'

describe 'articles routes' do
	it 'should root to articles index' do
		expect(get '/articles').to route_to('articles#index')
	end
end
