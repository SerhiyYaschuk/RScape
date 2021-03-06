require 'rinruby'

module RScape
  # Class for making plots.
  class Plot
    # An Array of X values.
    attr_accessor :x_data
    # An Array of Y values.
    attr_accessor :y_data
    # Plot's title.
    attr_accessor :title
    # X axis title.
    attr_accessor :x_title
    # Y axis title.
    attr_accessor :y_title
    # Plot type.
    attr_accessor :type
    
    # Creates a new plot.
    #
    # x_data - an Array of X values.
    # y_data - an Array of Y values.
    # type - plot type (+:line+, +:point+ or +:histo+).
    def initialize(x_data: nil, y_data: nil, type: nil)
      @x_data = x_data || []
      @y_data = y_data || []
      @x_title = 'X'
      @y_title = 'Y'
      @title = ''
      @type = type || :line
    end
    
    # Shows plot.
    def show
      if @x_data.size != @y_data.size
        raise(RuntimeError, 'Data sources have different size.')
      end
      
      send_data_to_r
      
      R.eval 'plot(x, y, xlab=x_title, ylab=y_title, main=title, type=plot_type)'
    end
    
    # Exports plot to file.
    def export_to(file, format: nil)
      if format.nil?
        format_from_name = file.scan(/\.\w+$/).first
        
        if format_from_name.nil?
          raise(ArgumentError, 'Undefined file format.')
          
        else
          format = format_from_name[1..-1]
        end
      end
      
      supported_formats = ['png', 'bmp', 'jpeg', 'pdf']
      
      if !supported_formats.include? format
        raise(ArgumentError, 'Unsupported file format.')
      end
      
      R.eval "#{format}('#{file}')"
      show
      R.eval 'dev.off()'
    end
    
    private
    
    # Sends all data to R before making plot.
    def send_data_to_r
      if ![:line, :point, :histo].include? @type
        raise(RuntimeError, 'Unsupported plot type.')
      end
      
      R.assign('x', @x_data)
      R.assign('y', @y_data)
      R.assign('x_title', @x_title)
      R.assign('y_title', @y_title)
      R.assign('title', @title)
      R.assign('plot_type', @type.to_s[0])
    end
  end
end
