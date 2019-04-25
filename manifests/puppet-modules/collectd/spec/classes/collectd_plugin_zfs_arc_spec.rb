require 'spec_helper'

describe 'collectd::plugin::zfs_arc', type: :class do
  on_supported_os(baseline_os_hash).each do |os, facts|
    context "on #{os} " do
      let :facts do
        facts.merge(collectd_version: '4.8')
      end

      options = os_specific_options(facts)
      context ':ensure => present' do
        it 'Will create 10-zfs_arc.conf' do
          is_expected.to contain_file('zfs_arc.load').with(
            ensure: 'present',
            path: "#{options[:plugin_conf_dir]}/10-zfs_arc.conf",
            content: %r{\#\ Generated by Puppet\nLoadPlugin zfs_arc\n}
          )
        end
      end

      context ':ensure => absent' do
        let :params do
          { ensure: 'absent' }
        end

        it 'Will not create 10-zfs_arc.conf' do
          is_expected.to contain_file('zfs_arc.load').with(
            ensure: 'absent',
            path: "#{options[:plugin_conf_dir]}/10-zfs_arc.conf"
          )
        end
      end
    end
  end
end
