InterNetworkX DNS updater
==========================

Shell script for updating DNS entries via InterNetworkX’ XMLRPC API (dynamic 
DNS). Based on <http://kromonos.net/server/die-neue-inwx-api.html>.

Basically, it compares your current WAN address to a given FQDN DNS entry. If 
they differ, it calls inwx’ XMLRPC API and updates all entries specified in its 
config file.

Requirements
------------

- `bash`
- `curl`
- `dig`

config file variables
---------------------

<dl>
  <dt>hostname</dt>
  <dd>FQDN to test the WAN address against.</dd>
  <dt>entity_id</dt>
  <dd>Entity IDs of the DNS entries to modify.</dd>
  <dt>username</dt>
  <dd>Your username.</dd>
  <dt>password</dt>
  <dd>Your password.</dd>
  <dt>xmlfile</dt>
  <dd>(optional) XML template used for POSTing the data to the API.</dd>
  <dt>site</dt>
  <dd>(optional) Web site to check for your WAN IP. Must return the IP in the 
  response body, _not_ through fancy javasrcipt.</dd>
</dl>

The entity ID can be determined by editing a DNS entry via the web UI and 
mousing over the „save“ button. It’s in the URL (see image):

![determining the entity ID](http://i.imgur.com/NJGQVYe.png)

Usage
-----

Copy `nsupdate.conf.sample` to `nsupdate.conf` and fill in your details. Then 
run `bash inwx-dns-updater.sh`. You can also copy the config file name to 
somewhere else and supply it via the `-c` swtich.

Contributing
------------

I am using nvie’s
[git branching model](http://nvie.com/posts/a-successful-git-branching-model/ 
"nvie.com: A successfull Git branichng model"). To contribute you should follow 
these steps:

0. Check if your proposed change is already implemented in the `develop` branch
1. Fork the repository on Github
2. Create a named feature branch (like `feature-x`)
3. Write your change
4. Submit a Pull Request against the `develop` branch using Github

License and Authors
-------------------

Authors: ka’imi <kaimi@kaimi.cc>
