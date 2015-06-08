require_relative 'sugarscape_params.rb'
require_relative 'sugar_params.rb'
require_relative 'agent_params.rb'
require_relative 'statistic.rb'
require_relative 'log.rb'

module RScape
  module GUI
    class WDPreset < Qt::Widget
      STAT_AGENTS_NUM = 'Agents N.'
      STAT_AVG_AGE = 'Avg. age'
      STAT_AVG_VISION = 'Avg. vision'

      STAT_AVG_WEALTH = 'Avg. wealth'
      STAT_GINI = 'Gini coef.'
      
      PARAMS_MAXIMUM_WIDTH = 250
      BUTTONS_MAXIMUM_WIDTH = 100
      
      attr_reader :start_button, :stop_button, :sugarscape_params,
      :sugar_params, :agent_params, :social_statistic, :economical_statistic,
      :log
      
      def initialize
        super
        
        @sugarscape_params = SugarscapeParams.new
        @sugar_params = SugarParams.new
        @agent_params = AgentParams.new
        @social_statistic = Statistic.new('Social', {
          STAT_AGENTS_NUM => 0,
          STAT_AVG_AGE => 0,
          STAT_AVG_VISION => 0
          })
        @economical_statistic = Statistic.new('Economical', {
          STAT_AVG_WEALTH => 0,
          STAT_GINI => 0
          })
        @log = Log.new
        
        @start_button = Qt::PushButton.new 'Start'
        @stop_button = Qt::PushButton.new 'Stop'
        show_log_flag = Qt::CheckBox.new 'Show log'
        
        params_layout = Qt::VBoxLayout.new
        statistic_layout = Qt::VBoxLayout.new
        help_layout = Qt::HBoxLayout.new
        controls_layout = Qt::HBoxLayout.new
        log_layout = Qt::VBoxLayout.new
        main_layout = Qt::VBoxLayout.new
        
        @sugarscape_params.setMaximumWidth PARAMS_MAXIMUM_WIDTH
        @sugar_params.setMaximumWidth PARAMS_MAXIMUM_WIDTH
        @agent_params.setMaximumWidth PARAMS_MAXIMUM_WIDTH
        
        show_log_flag.setChecked true
        @log.setVisible show_log_flag.isChecked
        
        @start_button.setMaximumWidth BUTTONS_MAXIMUM_WIDTH
        @stop_button.setMaximumWidth BUTTONS_MAXIMUM_WIDTH
        
        params_layout.addWidget @sugarscape_params
        params_layout.addWidget @sugar_params
        params_layout.addWidget @agent_params
        params_layout.addStretch
        statistic_layout.addWidget @social_statistic
        statistic_layout.addWidget @economical_statistic
        controls_layout.addStretch
        controls_layout.addWidget @start_button
        controls_layout.addWidget @stop_button
        controls_layout.addStretch
        log_layout.addWidget show_log_flag
        log_layout.addStretch
        log_layout.addWidget @log
        help_layout.addLayout params_layout
        help_layout.addLayout statistic_layout
        main_layout.addLayout help_layout
        main_layout.addLayout controls_layout
        main_layout.addLayout log_layout
        setLayout main_layout
        
        connect(show_log_flag, SIGNAL('toggled(bool)'),
                @log, SLOT('setVisible(bool)'))
      end
    end
  end
end