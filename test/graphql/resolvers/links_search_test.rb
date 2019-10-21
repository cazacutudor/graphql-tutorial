require 'test_helper'

module Resolvers
  class LinksSearchTest < ActiveSupport::TestCase
    def find(args)
      ::Resolvers::LinksSearch.call(nil, args, nil)
    end

    def create_user
      User.create name: 'test', email: 'test@email.com', password: '12345'
    end

    def create_link(**attributes)
      Link.create! attributes.merge(user: create_user)
    end

    test 'filter option' do
      link1 = create_link description: 'test1', url: 'http://test1.com'
      link2 = create_link description: 'test2', url: 'http://test2.com'

      result = find(
         filter: {
             description_contains: 'test1',
             OR: [{ url_contains: 'test2' }]
         }
      )

      assert_equal result.map(&:description).sort, [link1, link2].map(&:description).sort
    end
  end
end