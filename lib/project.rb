class Project
  attr_accessor :name, :environments, :path
  def initialize(attributes)
    @name         = attributes["name"] || ""
    @environments = attributes["environments"] || []
    @path         = attributes["path"]
  end
end
