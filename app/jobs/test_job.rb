class TestJob < ApplicationJob
  queue_as :default

  def perform(*args)
    'Greetings!'
  end
end
