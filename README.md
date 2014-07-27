# jboss7-cookbook

This is a JBoss 7 cookbook. It's still in development. Feel free to contribute.

V. 0.10.2 - I realize I forgot to include sane defaults for the port numbers. Now added.

## Supported Platforms

Ubuntu 12.04

TODO: CentOS, Windows

## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['jboss7']['jboss_home']</tt></td>
    <td>String</td>
    <td>Path to the parent directory where JBoss will be installed. E.g., if you want JBoss installed in /opt/jboss, this would be /opt/</td>
    <td><tt>/opt/jboss/</tt></td>
  </tr>
    <tr>
    <td><tt>['jboss7']['jboss_user']</tt></td>
    <td>String</td>
    <td>User for JBoss to run as.</td>
    <td><tt>web</tt></td>
  </tr>
  <tr>
    <td><tt>['jboss7']['dl_url']</tt></td>
    <td>String</td>
    <td>URL to download the JBoss tarball from.</td>
    <td><tt>http://download.jboss.org/jbossas/7.1/jboss-as-7.1.1.Final/jboss-as-7.1.1.Final.tar.gz</tt></td>
  </tr>
  <tr>
    <td><tt>['jboss7']['jvm_min_mem']</tt></td>
    <td>String</td>
    <td>Sets your Xms JVM parameter</td>
    <td><tt>512m</tt></td>
  </tr>
  <tr>
    <td><tt>['jboss7']['jvm_max_mem']</tt></td>
    <td>String</td>
    <td>Sets your Xmx JVM parameter</td>
    <td><tt>1024m</tt></td>
  </tr>
  <tr>
    <td><tt>['jboss7']['jvm_perm_mem']</tt></td>
    <td>String</td>
    <td>Sets your PermGenSpace JVM parameter</td>
    <td><tt>256m</tt></td>
  </tr>
  <tr>
    <td><tt>['jboss7']['ajp_port']</tt></td>
    <td>String</td>
    <td>Sets your AJP port in standalone.xml</td>
    <td><tt>8009</tt></td>
  </tr>
  <tr>
    <td><tt>['jboss7']['http_port']</tt></td>
    <td>String</td>
    <td>Sets your HTTP port in standalone.xml</td>
    <td><tt>8080</tt></td>
  </tr>
  <tr>
    <td><tt>['jboss7']['https_port']</tt></td>
    <td>String</td>
    <td>Sets your HTTPS port in standalone.xml</td>
    <td><tt>8443</tt></td>
  </tr>
</table>

## Usage

### jboss7::default

Include `jboss7` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[jboss7::default]"
  ]
}
```

## Contributing

1. Fork the repository on Github
2. Create a named feature branch (i.e. `add-new-recipe`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request

## License and Authors

Author:: Andrew DuFour (andy.k.dufour@gmail.com)
