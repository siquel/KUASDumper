# KUASDumper
Dumps schedule from Kajaani University of Applied Sciences as XML

# Usage
Login to KUAS website and get your cookie.
Cookie should be something like: __asio_s=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
```sh
echo your_cookie > cookie
./get_lukkarid <output_file>
```

Edit get_lukkarid.sh if to your approriate group. eg. -g TTV14SA

# Dependencies
* curl
* perl
