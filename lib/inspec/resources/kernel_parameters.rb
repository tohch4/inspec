require "inspec/resources/command"

module Inspec::Resources
  class KernelParameters < Inspec.resource(1)
    name "kernel_parameters"
    supports platform: "unix"
    desc "Use the kernel_parameters InSpec audit resource to test multiple kernel parameters on Linux platforms."
    example <<~EXAMPLE
      describe kernel_parameters(/net.ipv4.*/) do
        its('values') { should be 0 }
      end
    EXAMPLE

    def initialize(pattern = nil)
      @pattern = pattern

    end

    def value
      cmd = inspec.command("/sbin/sysctl -q -a")
      return "" if cmd.exit_status != 0

      # remove whitespace
      cmd = cmd.stdout.split("\n")
      cmd
    end
  end

end
