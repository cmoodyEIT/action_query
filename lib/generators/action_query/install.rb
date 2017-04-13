class ActionQuery::InstallGenerator < Rails::Generators::Base
  source_root File.join(File.dirname(__FILE__), 'templates')

  def copy_initializer
    template "initializer.rb", "config/initializers/action_query.rb"
  end
end
