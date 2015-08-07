ELLK Cookbook
============

[![forthebadge](http://forthebadge.com/images/badges/built-with-love.svg)](http://forthebadge.com)

[![Cookbook Version](https://img.shields.io/cookbook/v/ELLk.svg)](https://supermarket.chef.io/cookbooks/ellk)
[![Circle CI](https://circleci.com/gh/dearing/ellk/tree/master.svg?style=svg)](https://circleci.com/gh/dearing/ellk/tree/master)

Hack friendly, Chef library to manage Elasticsearch, Logstash, Logstash-forwarder and Kibana

*note: expects consumer to install java and handle certs and manipulate firewalls*

Requirements
------------
- [chef] 11+
- works with anything [ark] and [runit] can handle
- see [metadata] for complexity

Published
---------
- [changelog]
- [releases]
- [supermarket]

About
------------
This cookbook provides a modern Chef approach to installing and configuring the four [elastic] products that make up an ELK stack with the company's binary artifacts.  Using [ark] to fetch those remote artifacts and [runit] to handle the service allows us to side step the nuanced vulgarity of competing package managers, driving down the complexity of this cookbook.  This means faster updates, less angles for bugs and a guard against feature creep.  So the flexibity is that this library won't be upset if you don't use the whole stack or any combination within.  Call what you need, configure how you like and get back to [#chefops], your way.

The opinion of this design is then that remote systems get a shipper in the form of [logstash-forwarder] that does nothing but harvest logs and forward them to logstash endpoints.  It is a Go static binary so there is no fuss for the host OS.  Simply unpack, configure and run.  The `logstash-forwarder` resource is designed to accept a hash that is eventually converted to the json configuration for the program.  This allows you to simply call it in a scope of a node for its logs.

```ruby
## install LOGSTASH-FORWARDER and configure to watch various logs
logstash_forwarder 'default' do
  crt_location '/tmp/logstash.crt'
  logstash_servers ['localhost:5043']
  files [{
  'paths' => ['/var/log/messages', '/var/log/*log'],
    'fields' => { 
      'type' => 'syslog', 
      'chef_node' => node.name, 
      'chef_env' => node.chef_environment 
    }
  }]
end
```
The clever will note that this allows one to build up a array that finally can be passed as an attribute for [logstash-forwarder] to be configured by for harvesting.

```
logstash_forwarder 'default' do
  crt_location '/tmp/logstash.crt'
  logstash_servers ['localhost:5043']
  files node['my_fancy_log_collection']
end
```

>The power is yours!
>> Captain Planet

Should you want them, standing up logstash and elasticsearch is just as easy with everything exposed to override defaults:

```ruby
## install ELASTICSEARCH and configure to use tmp for data storage
elasticsearch 'default' do
  datadir '/tmp/es_datadir'
end
```

```ruby
## install LOGSTASH and source my awesome_cookbook's templates instead
logstash 'default' do
  crt_location '/tmp/logstash.crt'
  key_location '/tmp/logstash.key'
  source 'awesome_cookbook'
end
```

The logstash endpoint should then be configured with templates to react to shipped logs by the type:

```
filter {
 if [type] == "syslog-dev" {
    drop { }
 }
 if [type] == "syslog-staging" {
    grok {
      overwrite => "message"
      match => [
        "message",
        "%{SYSLOGTIMESTAMP:timestamp} %{IPORHOST:host} (?:%{PROG:program}(?:\[%{POSINT:pid}\])?: )?%{GREEDYDATA:message}"
      ]
    }
    syslog_pri { }
  }
}
```

Want to use a [service] (http://objectrocket.com/elasticsearch) for your endpoint?  Just tell it in your config, otherwise we'll go with our default localhost install.

```
output {
  elasticsearch { host => localhost}
  stdout { codec => json }
}
```
Finally, Kibana interfaces with elasticsearch to perform queries against it creating those gorgeous charts and graphs everyone swoons over.  The defaults roll out executing elasticsearch queries with localhost but everything is availiable to configure from provided attributes should you need them.

```ruby
## install KIBANA and configure for port 8080
# !FIXME: Nginx with some auth_basic & expensive certificate from VeriSign
# !TODO: restrict ips to office and my home networks...
kibana 'default' do
  port 8080
end
```

Default installed versions
------------
[elastic] product | version
------------ | -------------
[elasticsearch] | 1.7.0
[logstash] | 1.5.3
[logstash-forwarder] | 0.4.0
[kibana] | 4.1.1

You can override any of these by passing the url for the zip/tar package, a checksum (sha256) and a version to tag it by. See the resource files in the libraries folder for the accepted attributes and [ellktest] for examples and flexibility..

TODO & Help Wanted
------------
 - see [issues]

Contributing
------------
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Author: Jacob Dearing // jacob.dearing@gmail.com

```
The MIT License (MIT)

Copyright (c) 2015 Jacob Dearing

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
```

[#chefops]: https://twitter.com/hashtag/chefops
[ark]: https://github.com/burtlo/ark
[changelog]: https://github.com/dearing/ellk/blob/master/CHANGELOG.md
[chef]: https://www.chef.io/
[elastic]: https://www.elastic.co/
[elasticsearch]: https://www.elastic.co/guide/en/elasticsearch/reference/current/index.html
[ellktest]: https://github.com/dearing/ellk/blob/master/test/cookbooks/ellktest/recipes/default.rb
[issues]: https://github.com/dearing/ellk/issues
[kibana]: https://github.com/elastic/kibana
[logstash-forwarder]: https://github.com/elastic/logstash-forwarder
[logstash]: https://www.elastic.co/guide/en/logstash/current/index.html
[metadata]: https://github.com/dearing/ellk/blob/master/metadata.rb
[releases]: https://github.com/dearing/ellk/releases
[runit]: https://github.com/hw-cookbooks/runit
[supermarket]: https://supermarket.chef.io/cookbooks/ellk
