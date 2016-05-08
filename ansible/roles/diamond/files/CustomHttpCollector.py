
import diamond.collector
import requests

class CustomHttpCollector(diamond.collector.Collector):


    def collect(self):
        for url_key in self.config.keys():
            if url_key[:7] == "target_":
                url = self.config[url_key]
                metric_name = url_key[7:]
                self.log.debug("collecting %s", str(url))
                try:
                    req = requests.get(url)
                    self.publish_gauge( metric_name + '.code', req.status_code)
                except:
                    # If there isn't a valid response code return 0
                    self.publish_gauge( metric_name + '.code', 1000)
