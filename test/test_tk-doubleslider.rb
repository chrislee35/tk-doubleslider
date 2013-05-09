unless Kernel.respond_to?(:require_relative)
  module Kernel
    def require_relative(path)
      require File.join(File.dirname(caller[0]), path.to_str)
    end
  end
end

require_relative 'helper'

class TestDoubleslider < Test::Unit::TestCase
	def test_display_double_headed_slider_with_linear_scale_and_custom_value_and_delta_formatters
		# create the root window for this Tk app
		root = TkRoot.new() {
			title "Tk::DoubleSlider Test"
			protocol('WM_DELETE_WINDOW', proc{ exit })
		}
		# bind ctrl-c to exit
		root.bind('Control-c', proc{ exit })
		# create a frame to place the Doubleslider within
		left_frame = TkFrame.new(root)
		left_frame.grid(:row=>0,:column=>0,:sticky=>'new')
		# create a "time window" from 7 days ago until now
		time_min = Time.now.to_i - (7*24*60*60)
		time_max = Time.now.to_i
		# create a "time slider" with a value formatter in HH:MM format and a delta formatter of 0.00 hours.
		timeslide = Tk::Doubleslider.new( left_frame, 
			:min=>time_min, # what's the minimal possible value
			:max=>time_max, # what's the maximum possible value
			:low=>time_min, # what's the current minimum value
			:high=>time_max, # what's the current max
			:snap => 300, # when you slide the slider, by what increments (for this example, it's every 5 minutes)
			:label=>'Time', # what do you call this slider
			:valuefmt => proc { |x| Time.at(x).strftime("%H:%M") }, # how shall we format the values
			:deltafmt => proc { |x| sprintf("%0.2f hours", (x/3600.0)) } # how shall we format the delta
		)
		# pack everything together
		timeslide.pack()
		# enter the main loop
		Tk.mainloop()
	end
end