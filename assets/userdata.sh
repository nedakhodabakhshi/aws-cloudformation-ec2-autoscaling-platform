 #!/bin/bash
            yum update -y
            yum install -y httpd
            systemctl start httpd
            systemctl enable httpd
            echo "<h1>EC2 Auto Scaling Platform - ${Environment}</h1>" > /var/www/html/index.html
