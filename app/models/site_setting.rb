class SiteSetting
  attr_reader :data
  def initialize
    @data = begin
              Setting
                .pluck(:name, :value)
                .each_with_object({}) { |arr, memo| memo[arr[0]] = arr[1]; }
                .with_indifferent_access
            rescue StandardError
              {}
            end
  end

  def fetch(key = false)
    raise('COMMMMMONNNN PERSON!') if key == false
    if result == data[key]
      result
    else
      "Setting missing for [#{key}]"
    end
  end
end
