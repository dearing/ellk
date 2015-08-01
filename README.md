ELLK Cookbook
============

[![forthebadge](http://forthebadge.com/images/badges/built-with-love.svg)](http://forthebadge.com)

hack friendly: Elasticsearch, Logstash, Logstash-forwarder and Kibana

*note: expects consumer to install java and handle certs*

Support and Tested
------------
centos66

Requirements
------------
- chef 11+
- some kind of java
- see [metadata](/metadata.rb) for complexity

About
------------
The mindset for this creation is that logstash-forwarder is pleasant enough
to cast out to all your resident nodes and since messing with templates is a pain,
it allows you to just provide a hash to template out the configuration.  Making
recipes easier to configure with.

Next in the chain are the `logstash` nodes.  Typically, I'd imagine them to be 1:1 with all
`elasticsearch` nodes also created by this LWRP; so `localhost` is a default output.  Otherwise,
the matra of this design is if defaults don't work, `source` your consuming cookbook with your own
templates copied from this cookbook.  Pass any optional config vars you want in your templaes with 
`conf_options` attribute and hack away.

This is hack friendly and mainly focused on getting you a framework
to work by.  The heavy lifting comes from ARK and RUNIT cookbooks; everything else is template 
manipulation.  Any discovery trickeness should be handled at the consuming recipe.

See [ellktest](/test/cookbooks/ellktest/recipes/default.rb) as an example.

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
