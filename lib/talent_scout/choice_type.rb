module TalentScout
  class ChoiceType < ActiveModel::Type::Value

    attr_reader :choices

    def initialize(choices)
      @choices = choices.stringify_keys.merge!(choices) do |key, old_val, new_val|
        next old_val if old_val == new_val
        raise ArgumentError.new("Multiple possible values for key #{key.inspect}")
      end.merge!(choices.values.index_by(&:itself)) do |key, old_val, new_val|
        next old_val if old_val == new_val
        raise ArgumentError.new("Value #{key.inspect} is also a key")
      end
    end

    def cast(value)
      super(@choices[value])
    end

  end
end
