# frozen_string_literal: true

# Loads nodes into chef zero
# @param [ChefSpec::ServerRunner] server
def load_nodes(server)
  nodes_dir = File.expand_path(File.join(__dir__, '../../test/fixtures/nodes'))

  Dir["#{nodes_dir}/*.json"].each do |node_json_file|
    json = JSON.parse(IO.read(node_json_file))
    node = Chef::Node.from_hash(json)
    server.create_node(node)
  end
end
