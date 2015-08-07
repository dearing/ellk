ELLK Cookbook
============

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
- [supermarket]
- [releases]

About
------------
Meditate on the idea that this library is simply providing a common installation and templating for the 4 projects.  It expects you to do all the tweaking and configuring as needed because attempting to account for all is untenable.  The opinion is then that you would want logstash-forwarder on all nodes communicating to your logstash endpoints.  Logstash-forwarder is implemented to accept a hash for the logs it will harvert as a hash making it easy to use in recipes without fumbling with templates. Since the project is written in Go it comes ready to run as a static binary without fuss making it ideal to enable on a variety of platforms.  The logstash endpoints then do work on the forwarded, harvested logs.  Sending the logs with `type` and various `metadata` allows to you to react accordingly parsing and then storing that information at your elasticsearch endpoints.  Finally, Kibana helps interact with that data in a visual manner.

Defaults
------------
[elastic] product | version
------------ | -------------
[elasticsearch] | 1.7.0
[logstash] | 1.5.3
[logstash-forwarder] | 0.4.0
[kibana] | 4.1.1

You can override any of these by passing the url for the zip/tar package, a checksum (sha256) and a version to tag is by. See the resource files in the libraries folder for the accepted attributes.  This allows this library to keep pace with your needs and not be bogged down with upstream asside from [elastic] themselves.

See [ellktest] for examples and flexibility..

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
