class WidgetGenerator < Rails::Generator::NamedBase
  def initialize(runtime_args, runtime_options = {})
    @widget_file_name = "#{runtime_args.first.underscore}_widget.rb"
    @widget_view_file = "_#{runtime_args.first.underscore}_widget.html.erb"
    super
  end
  
  def manifest
    record do |m|
      # Check for class collisions
      m.class_collisions class_name
      
      m.directory File.join(Widgeon::Widget.path_to_widgets, name.underscore)
      
      # Create files
      m.template 'widget.rb', File.join(Widgeon::Widget.path_to_widgets, name.underscore, @widget_file_name),
        :assigns => { :widget_class_name => class_name }
      m.template 'widget.rhtml', File.join(Widgeon::Widget.path_to_widgets, name.underscore, @widget_view_file),
        :assigns => { :widget_name => name.underscore }
    end
  end
end