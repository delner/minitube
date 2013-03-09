class Policy
  @@policies = {}


  def self.all_policies
    @@policies.values
  end

  def self.add_policy policy
    @@policies[policy.id] = policy.instance
  end

  def self.get_policy id
    @@policies[id]
  end

  # def self.id
  #   -1
  # end

  # def self.name
  #   'Default Policy'
  # end

  # def on_show_video
  #   puts 'Default behavior: do nothing.'
  # end

  
end
