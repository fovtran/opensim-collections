### Details of Hypergrid Commands
For full details and explanations of Hypergrid Commands, see the Linking Regions sections of the Installing and Running Hypergrid page.

show hyperlinks

This command will show a list of all hypergrid linked regions.

link-region <Xloc> <Yloc> <host> <port> <location-name>

Use Xloc and Yloc that make sense to your world, i.e. close to your regions, but not adjacent.
replace osl2.nac.uci.edu and 9006 with the domain name / ip address and the port of the region you want to link to
E.g. link-region 8998 8998 osl2.nac.uci.edu 9006 OSGrid Gateway

unlink-region <local region name>

This command will unlink the specified hypergrid linked region - be sure to use the exact local name as reported by the "show hyperlinks" command.

link-mapping - Link a HyperGrid region. Not sure how this differs from link-mapping.