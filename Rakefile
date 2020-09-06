require 'confidante'
require 'rake_terraform'
require 'rake_ssh'

configuration = Confidante.configuration

RakeTerraform.define_installation_tasks(
    path: File.join(Dir.pwd, 'vendor', 'terraform'),
    version: '0.12.28')

namespace :bootstrap do
  RakeTerraform.define_command_tasks(
      configuration_name: 'bootstrap',
      argument_names: [:deployment_identifier]
  ) do |t, args|
    configuration = configuration
        .for_scope(args.to_h.merge(role: 'bootstrap'))

    t.source_directory = 'infra/bootstrap'
    t.work_directory = 'build'

    t.state_file =
        File.join(
            Dir.pwd,
            "state/bootstrap/#{args.deployment_identifier}.tfstate")
    t.vars = configuration.vars
  end
end

namespace :domain do
  RakeTerraform.define_command_tasks(
      configuration_name: 'domain',
      argument_names: [:deployment_identifier, :domain_name]
  ) do |t, args|
    configuration = configuration
        .for_overrides(domain_name: args.domain_name)
        .for_scope(
            {deployment_identifier: args.deployment_identifier}
                .merge(role: 'domain'))

    t.source_directory = 'infra/domain'
    t.work_directory = 'build'

    t.backend_config = configuration.backend_config
    t.vars = configuration.vars
  end
end

namespace :certificate do
  RakeTerraform.define_command_tasks(
      configuration_name: 'certificate',
      argument_names: [:deployment_identifier, :domain_name]
  ) do |t, args|
    configuration = configuration
        .for_overrides(domain_name: args.domain_name)
        .for_scope(
            {deployment_identifier: args.deployment_identifier}
                .merge(role: 'certificate'))

    t.source_directory = 'infra/certificate'
    t.work_directory = 'build'

    t.backend_config = configuration.backend_config
    t.vars = configuration.vars
  end
end

namespace :network do
  RakeTerraform.define_command_tasks(
      configuration_name: 'network',
      argument_names: [:deployment_identifier]
  ) do |t, args|
    configuration = configuration
        .for_scope(args.to_h.merge(role: 'network'))

    t.source_directory = 'infra/network'
    t.work_directory = 'build'

    t.backend_config = configuration.backend_config
    t.vars = configuration.vars
  end
end

namespace :cluster do
  RakeTerraform.define_command_tasks(
      configuration_name: 'cluster',
      argument_names: [:deployment_identifier]
  ) do |t, args|
    configuration = configuration
        .for_scope(args.to_h.merge(role: 'cluster'))

    t.source_directory = 'infra/cluster'
    t.work_directory = 'build'

    t.backend_config = configuration.backend_config
    t.vars = configuration.vars
  end

  RakeSSH.define_key_tasks(
      namespace: :key,
      path: 'config/secrets/cluster/',
      comment: 'maintainers@infrablocks.io')
end

namespace :load_balancer do
  RakeTerraform.define_command_tasks(
      configuration_name: 'load balancer',
      argument_names: [:deployment_identifier, :domain_name]
  ) do |t, args|
    configuration = configuration
        .for_overrides(domain_name: args.domain_name)
        .for_scope(
            {deployment_identifier: args.deployment_identifier}
                .merge(role: 'load_balancer'))

    t.source_directory = 'infra/load_balancer'
    t.work_directory = 'build'

    t.backend_config = configuration.backend_config
    t.vars = configuration.vars
  end
end

namespace :service_registry do
  RakeTerraform.define_command_tasks(
      configuration_name: 'service registry',
      argument_names: [:deployment_identifier, :domain_name]
  ) do |t, args|
    configuration = configuration
        .for_overrides(domain_name: args.domain_name)
        .for_scope(
            {deployment_identifier: args.deployment_identifier}
                .merge(role: 'service_registry'))

    t.source_directory = 'infra/service_registry'
    t.work_directory = 'build'

    t.backend_config = configuration.backend_config
    t.vars = configuration.vars
  end
end

namespace :service do
  RakeTerraform.define_command_tasks(
      configuration_name: 'service',
      argument_names: [:deployment_identifier, :domain_name]
  ) do |t, args|
    configuration = configuration
        .for_overrides(domain_name: args.domain_name)
        .for_scope(
            {deployment_identifier: args.deployment_identifier}
                .merge(role: 'service'))

    t.source_directory = 'infra/service'
    t.work_directory = 'build'

    t.backend_config = configuration.backend_config
    t.vars = configuration.vars
  end
end

namespace :deployment do
  task :provision, [:deployment_identifier, :domain_name] do |_, args|
    Rake::Task['bootstrap:provision'].invoke(*args)
    Rake::Task['domain:provision'].invoke(*args)
    Rake::Task['certificate:provision'].invoke(*args)
    Rake::Task['network:provision'].invoke(*args)
    Rake::Task['cluster:provision'].invoke(*args)
    Rake::Task['load_balancer:provision'].invoke(*args)
    Rake::Task['service_registry:provision'].invoke(*args)
  end

  task :destroy, [:deployment_identifier, :domain_name] do |_, args|
    Rake::Task['service_registry:destroy'].invoke(*args)
    Rake::Task['load_balancer:destroy'].invoke(*args)
    Rake::Task['cluster:destroy'].invoke(*args)
    Rake::Task['network:destroy'].invoke(*args)
    Rake::Task['certificate:destroy'].invoke(*args)
    Rake::Task['domain:destroy'].invoke(*args)
    Rake::Task['bootstrap:destroy'].invoke(*args)
  end
end