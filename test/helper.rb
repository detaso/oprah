require 'minitest/autorun'
require 'minitest/pride'
require 'oprah'
require 'oprah/railtie'
require 'oprah/test_helpers'
require 'dummy/init'

class Minitest::Test
  include Oprah::TestHelpers

  def setup
    super
    Oprah::Presenter.cache.clear
  end
end

module Fixtures
  module Entity
  end

  class EntityPresenter < Oprah::Presenter
    def foo
      "foo"
    end
  end

  class User
    include Entity

    def first_name
      "Foo"
    end

    def last_name
      "Bar"
    end

    private

    def password
      "baz"
    end
  end

  class UserPresenter < Oprah::Presenter
    def name
      [first_name, last_name].join(' ')
    end

    def foo
      super + "bar"
    end
  end

  class Comment
  end

  class CommentPresenter < Oprah::Presenter
  end

  class Project
    def comments
      Array.new(3) { Comment.new }
    end

    def owner
      User.new
    end
  end

  class ProjectPresenter < Oprah::Presenter
    presents_many :comments
    presents_one :owner
  end

  # EigenUser contains eigen class in ancestors list.
  #
  # > EigenUser.ancestors
  # => [Fixtures::EigenUser, #<Module:0x007faa79b128f0>, Object, ... , Kernel, BasicObject]
  #
  class EigenUser
    include Module.new
  end
end
