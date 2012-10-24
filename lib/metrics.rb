require 'tdev_metrics'

module Lestrade
  class Metrics

    def self.send_metric( metric )
      if ENV['LESTRADE_SHOULD_SEND_METRICS']
        m = TotenDev::Metric.new
        m.project_id = ENV['LESTRADE_METRICS_PROJECT_ID']
        m.name       = "Status #{metric[:status]}"
        m.place      = metric[:route]
        m.type       = 'Info'
        m.info       = metric.to_s

        tdm = TotenDev::Metrics.new do |c|
          c.username = ENV['LESTRADE_METRICS_USERNAME']
          c.password = ENV['LESTRADE_METRICS_PASSWORD']
          c.base_url = ENV['LESTRADE_METRICS_URL']
        end
        tdm.metric.create m
      end
    end

  end
end
