module TalentScout
  class OrderDefinition

    DEFAULT_ASC_SUFFIX = ""
    DEFAULT_DESC_SUFFIX = "_desc"

    attr_reader :name, :asc_choice, :asc_value, :desc_choice, :desc_value

    def initialize(name, columns, asc_suffix: DEFAULT_ASC_SUFFIX, desc_suffix: DEFAULT_DESC_SUFFIX)
      columns = Array(columns || name)
      @name = name.to_s
      @asc_value = Arel.sql(columns.join(", "))
      @desc_value = Arel.sql(self.class.desc(columns).join(", "))
      @asc_choice = "#{@name}#{asc_suffix}"
      @desc_choice = @desc_value == @asc_value ? @asc_choice : "#{@name}#{desc_suffix}"
    end

    def self.desc(columns)
      columns.map do |column|
        column.match?(/ (?:ASC|DESC)$/i) ? column : "#{column} DESC"
      end
    end

  end
end