class Chef
  class Provider
    # Logstash Config Provider. Basic class
    class LogstashConfig < Chef::Provider
      def whyrun_supported?
        true
      end

      def load_current_resource
        true
      end

      def template_cookbook
        new_resource.cookbook.nil? ? new_resource.cookbook_name.to_s : new_resource.cookbook
      end

      def action_create
        conf_dir.run_action :create
        conf_file.run_action :create

        new_resource.updated_by_last_action(true) if conf_file.updated_by_last_action?
      end

      def action_delete
        conf_file.run_action :delete

        new_resource.updated_by_last_action(true) if conf_file.updated_by_last_action?
      end

      def conf_dir
        return @conf_dir if @conf_dir
        @conf_dir = Chef::Resource::Directory.new(::File.dirname(new_resource.config), run_context)
        @conf_dir.recursive true
        @conf_dir.owner new_resource.owner
        @conf_dir.group new_resource.group
        @conf_dir.mode '0755'
        @conf_dir.action :nothing

        @conf_dir
      end

      def conf_file
        return @conf_file if @conf_file
        @conf_file = Chef::Resource::Template.new(new_resource.config, run_context)
        @conf_file.path new_resource.config
        @conf_file.cookbook template_cookbook
        @conf_file.source new_resource.source
        @conf_file.owner new_resource.owner
        @conf_file.group new_resource.group
        @conf_file.mode new_resource.mode
        @conf_file.variables new_resource.variables
        @conf_file.action :nothing

        @conf_file
      end
    end
  end
end
