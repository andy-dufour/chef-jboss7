# jboss7-cookbook

This is a JBoss 7 cookbook. It's still in development. Feel free to contribute.

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
    <td><tt>['jboss7']['bacon']</tt></td>
    <td>Boolean</td>
    <td>whether to include bacon</td>
    <td><tt>true</tt></td>
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
