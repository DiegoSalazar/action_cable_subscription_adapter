# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'action_cable_subscription_adapter/version'

Gem::Specification.new do |spec|
  spec.name          = "action_cable_subscription_adapter"
  spec.version       = ActionCableSubscriptionAdapter::VERSION
  spec.authors       = ["Diego Salazar"]
  spec.email         = ["diego@greyrobot.com"]

  spec.summary       = %q{Custom Subscription adapter to inject a redis_connector for ActionCable}
  spec.description   = %q{Implements a SubscriptionAdapter for ActionCable which uses a configurable Redis client.}
  spec.homepage      = "https://github.com/DiegoSalazar/action_cable_subscription_adapter"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
end
