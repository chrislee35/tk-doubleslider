# Tk::Doubleslider

A double-headed slider widget allows for a range to be specified.  This implementation works for Ruby Tk and provides ways to provide customized formatting of values, non-linear values, and log-based sliders (i.e., lots of accuracy for low values, but not for high values).

This has been tested in:
* ruby-1.8.7-p371
* ruby-1.9.3-p392
* ruby-2.0.0-p0
	
RVM install command example (rvm doesn't install with tk or tcl by default):

	rvm reinstall 1.9.3 --enable-shared --enable-pthread --with-tk --with-tcl

## Installation

Add this line to your application's Gemfile:

    gem 'tk-doubleslider'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tk-doubleslider

## Usage

Within a Tk project, you'll need to have a Window with a Frame to place the Doubleslider within.  Here is a minimalistic example:

	require 'tk'
	
	def minimal_example()
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
	

Great, so what options can Tk::Doubleslider take and what are their defaults?

	height = 36.0    # height in pixels
	width = 360.0    # width in pixel
	min = 0.0        # minimum possible value
	max = 0.0        # maximum possible value
	low = 0.0        # the current minimum value
	high = 0.0       # the current high value
	ballsize = 5     # the size in pixels of the header (the knob)
	snap = false     # snap increments in value
	logbase = false  # use logirithms to scale the slider (pretty cool stuff)
	# colors for the slider
	colors = {
		:background => 'grey20',
		:line => 'grey75',
		:low_head => '#996666',
		:high_head => '#996666',
		:text => 'white',
		:delta => 'white',
	}
	# margins
	left_margin = 10.0
	right_margin = 20.0
	top_margin = 6.0
	bottom_margin = 4.0
	change_cb = nil  # callback to call when a selection has changed, object must have a method called, "call", which must accept a low and high value (see example below)
	# how to format the value
	valuefmt = proc { |x| sprintf "%d", x }
	# how to format the delta (defaults to valuefmt)
	deltafmt = nil
	# the label to display on the slider, a string
	label = nil

Now, how about that callback that I promised you?

	class TkDS_Callback
		def call(low, high)
			puts "#{low} #{high}"
			if low < 90
				puts "Maybe you should reconsider your answer"
			end
		end
	end
	
	timeslide = Tk::Doubleslider.new( left_frame, :min => 0, :max => 100, :low => 90, :high => 100,
		:cb => TkDS_Callback.new, :label => 'your love for TkDS')



## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Copyright

Copyright (c) 2011 Chris Lee, PhD. See LICENSE.txt for
further details.
