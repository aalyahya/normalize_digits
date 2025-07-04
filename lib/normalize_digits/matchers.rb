# frozen_string_literal: true

module NormalizeDigits
  # Matcher Module
  module Matchers
    # RSpec Examples:
    #
    #   it { is_expected.to normalize_digits_for(:phone_number) }
    #   it { is_expected.not_to normalize_digits_for(:password) }
    def normalize_digits_for(attribute)
      NormalizeDigitsForMatcher.new(attribute)
    end

    # Matcher class
    class NormalizeDigitsForMatcher
      def initialize(attribute)
        @attribute = attribute
        @options = {}
      end

      def matches?(subject)
        return false unless subject.send(@attribute).is_a?(String)

        subject.send("#{@attribute}=", "०۰٠")
        subject.valid?
        subject.send(@attribute) == "000"
      end

      # RSpec 3.x
      def failure_message
        "Expected to be normalized from #{@attribute}, but it was not"
      end

      # RSpec 1.2, 2.x
      alias failure_message_for_should failure_message

      # RSpec 3.x
      def failure_message_when_negated
        "Expected to remain on #{@attribute}, but it was normalized"
      end

      # RSpec 1.2, 2.x
      alias failure_message_for_should_not failure_message_when_negated

      # RSpec 1.1
      alias negative_failure_message failure_message_when_negated

      def description
        "Englishize non-english digits from #{@attribute}"
      end
    end
  end
end
