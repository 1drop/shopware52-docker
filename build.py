import urllib, json, os, re

response = urllib.urlopen("https://api.github.com/repos/shopware/shopware/tags")
data = json.loads(response.read())

isDev = os.environ.get('IS_DEV', False)

if isDev:
    dockerfile = open('Dockerfile.dev.tpl', 'r').read()
else:
    dockerfile = open('Dockerfile.prod.tpl', 'r').read()

for version in data:
    m = re.search('^v(\d+\.\d+\.\d+)$', version['name'])
    if m:
        shopwareVersion = m.group(1)
        f = open('Dockerfile', 'w')
        f.write(dockerfile.replace('{{SHOPWARE_VERSION}}', shopwareVersion))
        f.close
        image = '1drop/shopware:' + shopwareVersion + ('-dev' if isDev else '')
        print 'BULDING IMAGE: ' + image
        os.system('docker build -t ' + image + ' .')
        os.system('docker push ' + image)
