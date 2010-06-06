class JavascriptSpecGenerator < Rails::Generator::NamedBase

  def execute
    file_path_with_spec, file_path_without_spec = file_path_with_and_without_spec
    
    base_dir = BlueRidge.javascript_spec_dir
    
    directory base_dir
    directory "#{base_dir}/fixtures"
    
    options = {:class_name_without_spec => class_name_without_spec, :file_path_without_spec => file_path_without_spec}
    template 'javascript_spec.js.erb', "#{base_dir}/#{file_path_with_spec}.js", :assigns => options
    template 'fixture.html.erb', "#{base_dir}/fixtures/#{file_path_without_spec}.html", :assigns => options
  end

  protected
    def file_path_with_and_without_spec
      if (file_path =~ /_spec$/i)
        [file_path, file_path.gsub(/_spec$/, "")]
      else
        [file_path + "_spec", file_path]
      end
    end
  
    def class_name_without_spec
      (class_name =~ /Spec$/) ? class_name.gsub(/Spec$/, "") : class_name
    end
end
