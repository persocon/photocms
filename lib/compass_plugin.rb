module CompassInitializer
  def self.registered(app)
    require 'sass/plugin/rack'
    apps = {}

    apps[app] = app.to_s.downcase.split('::').last

    Compass.configuration do |config|
      config.project_path = Padrino.root
      config.project_type = :stand_alone
      config.http_path = "/"
      #default css
      config.sass_dir = "app/stylesheets"
      config.css_dir = "public/stylesheets"
      config.images_dir = "public/images"
      config.javascripts_dir = "public/javascripts"

      apps.each do |name, path|
        unless name != 'app'
          config.sass_dir = "#{path}/stylesheets"
          config.css_dir = "public/#{path}/stylesheets"
          config.images_dir = "public/#{path}/images"
          config.javascripts_dir = "public/#{path}/javascripts"
        end
      end

      config.output_style = :compressed
    end

    Compass.configure_sass_plugin!
    Compass.handle_configuration_change!

    app.use Sass::Plugin::Rack
  end
end