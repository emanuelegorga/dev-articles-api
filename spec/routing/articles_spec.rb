require 'rails_helper'

describe 'articles routes' do
	it 'should root to articles index' do
		expect(get '/articles').to route_to('articles#index')
	end

	it 'should root to articles show' do
		expect(get '/articles/1').to route_to('articles#show', id: '1')
	end
end
