# frozen_string_literal: true

RSpec.describe NormalizeDigits do
  include NormalizeDigits::Matchers

  module MockAttributes
    def self.included(base)
      base.include ActiveAttr::BasicModel
      base.include ActiveAttr::TypecastedAttributes
      base.include ActiveAttr::Serialization
      base.include ActiveModel::Validations::Callbacks
      base.attribute :a
      base.attribute :b
      base.attribute :c
      base.attribute :d
      base.attribute :e
      base.attribute :f
      base.attribute :g
      base.attribute :h
      base.attribute :access_token
      base.attribute :current_password
    end
  end

  class EnglishizeAll
    include MockAttributes
    normalize_digits
  end

  class EnglishizeOnlyOne
    include MockAttributes
    normalize_digits only: :a
  end

  class EnglishizeOnlyTwo
    include MockAttributes
    normalize_digits only: %i[a b]
  end

  class EnglishizeExceptOne
    include MockAttributes
    normalize_digits except: :a
  end

  class EnglishizeExceptTwo
    include MockAttributes
    normalize_digits except: %i[a b]
  end

  def instance_for(klass)
    klass.new(attrs).tap(&:valid?)
  end

  let(:attrs) { { a: "٩", b: " 1٦1 ", c: :val, d: "०۰٠", e: "", f: 5, g: now, h: nil, current_password: "١٢٣٤٥٦٧٨٩" } }
  let(:now) { Time.now }


  context "main gem / module" do
    it "must be defined" do
      expect(Object.const_defined?(:NormalizeDigits)).to be_truthy
    end

    it "has a version number" do
      expect(NormalizeDigits::VERSION).not_to be nil
    end
  end

  context "Englishize all attrs" do
    subject { instance_for(EnglishizeAll) }

    it "should englishize strings" do
      is_expected.to normalize_digits_for(:a)
      is_expected.to normalize_digits_for(:b)
      is_expected.to normalize_digits_for(:d)
      is_expected.to normalize_digits_for(:e)
    end

    it "should ignore non-string attributes" do
      is_expected.not_to normalize_digits_for(:c)
      is_expected.not_to normalize_digits_for(:f)
      is_expected.not_to normalize_digits_for(:g)
      is_expected.not_to normalize_digits_for(:h)
    end

    it "should ignore *password* attributes" do
      is_expected.not_to normalize_digits_for(:current_password)
    end
  end

  context "Englishize only one attr" do
    subject { instance_for(EnglishizeOnlyOne) }

    it "should englishize included strings" do
      is_expected.to normalize_digits_for(:a)
    end

    it "should ignore excluded strings" do
      is_expected.not_to normalize_digits_for(:b)
    end
  end

  context "Englishize only two attrs" do
    subject { instance_for(EnglishizeOnlyTwo) }

    it "should englishize included strings" do
      is_expected.to normalize_digits_for(:a)
      is_expected.to normalize_digits_for(:b)
    end

    it "should ignore excluded strings" do
      is_expected.to_not normalize_digits_for(:d)
    end
  end

  context "Englishize except one attr" do
    subject { instance_for(EnglishizeExceptOne) }

    it "should englishize included strings" do
      is_expected.to normalize_digits_for(:b)
    end

    it "should ignore excluded strings" do
      is_expected.to_not normalize_digits_for(:a)
    end
  end

  context "Englishize except two attrs" do
    subject { instance_for(EnglishizeExceptTwo) }

    it "should englishize included strings" do
      is_expected.to normalize_digits_for(:d)
    end

    it "should ignore excluded strings" do
      is_expected.to_not normalize_digits_for(:a)
      is_expected.to_not normalize_digits_for(:b)
    end
  end

  context "Englishize with invalid options" do
    it "should raise ArgumentError exception" do
      expect {
        NormalizeDigits.validate_options(invalid_option: :x)
      }.to raise_error(ArgumentError)
    end
  end
end
