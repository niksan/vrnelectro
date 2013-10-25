set :stage, :production

# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary
# server in each group is considered to be the first
# unless any hosts have the primary property set.
role :all, %w{@82.196.2.187}
role :app, %w{82.196.2.187}
role :web, %w{82.196.2.187}
role :db,  %w{82.196.2.187}

# Extended Server Syntax
# ======================
# This can be used to drop a more detailed server
# definition into the server list. The second argument
# something that quacks like a has can be used to set
# extended properties on the server.
server '82.196.2.187', user: 'root', roles: %w{all}#, my_property: :my_value

# you can set custom ssh options
# it's possible to pass any option but you need to keep in mind that net/ssh understand limited list of options
# you can see them in [net/ssh documentation](http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start)
# set it globally
# set :ssh_options, {
#   keys: %w(/home/niksan/.ssh/id_rsa),
#   forward_agent: true,
#   auth_methods: %w(password)
# }
# and/or per server
server '82.196.2.187',
  user: 'root',
  roles: %w{root},
  ssh_options: {
    user: 'root', # overrides user setting above
    keys: %w(/home/niksan/.ssh/id_rsa),
    forward_agent: true,
    auth_methods: %w(publickey)
  }


# fetch(:default_env).merge!(rails_env: :production)
