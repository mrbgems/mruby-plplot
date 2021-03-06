df = PLPlot::DataFrame.new %w(time sin cos)
100.times do |i|
  t = Math::PI / 50 * i
  df << [t, Math::sin(t), Math::cos(t)]
end

l1 = PLPlot::Series.new(df)    # first data series
l2 = PLPlot::Series.new(df)    # second data series

l1.select "time", "sin"
l2.select "time", "cos"

puts "Printing using PLPlot v#{PLPlot.version}"
puts "Available file formats: #{PLPlot::FORMATS}"

PLPlot.set_grid(1,3)           # I want a grid of 1 column, 3 rows of charts
PLPlot.set_page(720, 540)      # make it 720px x 540px (default)

PLPlot.plot("block_plot.png") do |p|  # driver is inferred from file extension
  
  p.load([l1, l2])             # use full range for both l1 and l2
  p.labels("x", "y", "Test Plot from mruby")
  l1.line(:blue, 1, 3)         # thickness 1, line type 3
  l2.line(:red, 2.5)           # thickness 2.5, line type 0 (default)
  p.legend("tr")
  
  p.load([l1, l2])
  p.box = :major               # see PLPlot::BOX_CODES and PLPlot::SCALING_CODES
  p.set_range(*l1.range)       # use only range of l1
  p.labels("x", "y", "Second Test Plot from mruby")
  l1.line(:violet)
  l2.line(:black, 1)
  l2.scale = 1.5               # set points scale to 1.5
  l2.points(:red)
  p.legend("tl")

  p.load([l1, l2])
  p.box = :ticks               # sticky attribute (for next subplots)
  p.scaling = :square          # sticky attribute
  p.set_range(*l1.range)
  p.chr_scale = 1.3            # increase font size by 30%
  p.labels("x", "y", "Square plot")
  l1.line(PLPlot.cycle_color)  # cycles line color from 1 to 15 at every call
  l2.line(PLPlot.cycle_color)
  l1.scale = 1                 # set points scale to 1
  l1.points(:brown)            # brown square points
  p.chr_scale = 1              # back to default font size
  
end
