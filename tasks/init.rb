#!/opt/puppetlabs/puppet/bin/ruby
#
# Simply take the task's two parameters and use them to craft a `puppet agent`
# command with either --enable or --disable

require 'json'
require 'open3'
require 'puppet'

def set(action, message)
  cmd = ['puppet', 'agent', "--#{action}"]
  cmd << message.to_s unless message.nil? # Tack on the message if it's not nil
  _stdout, stderr, status = Open3.capture3(*cmd)
  raise Puppet::Error, _("stderr: ' #{stderr}') % { stderr: stderr }") if status != 0
  { result: "Set agent to #{action}" }
end

params = JSON.parse(STDIN.read)
action = params['action']
if !params['message'].nil? && params['action'] == 'disable'
  message = params['message'] # Use whatever was passed to us
elsif params['action'] == 'disable'
  message = 'Disabled by agent_disenable task' # Use a canned message
end

begin
  result = set(action, message)
  puts result.to_json
  exit 0
rescue Puppet::Error => e
  puts({ status: 'failure', error: e.message }.to_json)
  exit 1
end
