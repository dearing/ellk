ELLK Cookbook
============

hack friendly: Elasticsearch, Logstash, Logstash-forwarder and Kibana

*note: expects consumer to install java and handle certs*

Works with anything [ARK](https://github.com/burtlo/ark) and [RUNIT](https://github.com/hw-cookbooks/runit) can handle.

Requirements
------------
- chef 11+
- some kind of java
- see [metadata](https://github.com/dearing/ellk/metadata.rb) for complexity

About
------------
The heavy lifting comes from [ARK](https://github.com/burtlo/ark) and [RUNIT](https://github.com/hw-cookbooks/runit) cookbooks with a focus around being able to pass optional configurations via merged hashsets for templates and environment variable sets.  Meditate on the idea that this library is simply providing a common installation and templating for the 4 projects.  It expects you to do all the tweaking and configuring as needed because attempting to account for all is untenable.  The opinion is then that you would want logstash-forwarder on all nodes communicating to your logstash endpoints.  Logstash-forwarder is overloaded to accept a hash for the logs it will harvert as an attribute making it easy to use in recipes without fumbling with templates. The defaults then expect that logstash would remain resident along all elasticsearch nodes which finally has an interface via kibana.  Beyond this, inheriting templates and customizing the configurations and security is up to you.

The default installations are:
```
  elasticsearch      = 1.7.0 // JAVA
  logstash           = 1.5.3 // RUBY
  logstash-forwarder = 0.4.0 // GO
  kibana             = 4.1.1 // NODEJS
```
You can override any of these by passing the url for the zip/tar package, a checksum (sha256) and a version to tag is by. See the resource files in the libraries folder for the accepted attributes.

See [ellktest](https://github.com/dearing/ellk/test/cookbooks/ellktest/recipes/default.rb) for examples and flexibility..

TODO
------------
see [issues](https://github.com/dearing/ellk/issues)


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
