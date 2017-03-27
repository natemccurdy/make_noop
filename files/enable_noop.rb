module MCollective
  class Application
    class Enable_noop < MCollective::Application
      description 'Can enable or disable noop on nodes'

      def main
        mc = rpcclient('make_noop')

        output = mc.enable_noop()

        if !output.empty?

          sender_width = output.map{|s| s[:sender]}.map{|s| s.length}.max + 3

          output.each do |result|
            pattern = "%%%ds: %%s" % sender_width
	          if result[:data][:out] == true
              out = "Noop Enabled"
            else
              out = "Noop Still Disabled!"
            end
            puts(pattern % [result[:sender], out])
          end
        end

        printrpcstats
      end
    end
  end
end
