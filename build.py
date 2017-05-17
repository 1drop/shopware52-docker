import urllib, json, os, re, multiprocessing

def buildWorker(dockerfileTmpl, shopwareVersion, isDev):
    dockerfile = 'Dockerfile-' + shopwareVersion + ('-dev' if isDev else '')
    image = '1drop/shopware:' + shopwareVersion + ('-dev' if isDev else '')
    f = open(dockerfile, 'w')
    f.write(dockerfileTmpl.replace('{{SHOPWARE_VERSION}}', shopwareVersion))
    f.close()
    print 'BULDING IMAGE: ' + image
    os.system('docker build -f ' + dockerfile + ' -t ' + image + ' .')
    os.system('docker push ' + image)
    return

if __name__ == '__main__':
    response = urllib.urlopen("https://api.github.com/repos/shopware/shopware/tags")
    data = json.loads(response.read())
    isDev = os.environ.get('IS_DEV', False)
    if isDev:
        dockerfileTmpl = open('Dockerfile.dev.tpl', 'r').read()
    else:
        dockerfileTmpl = open('Dockerfile.prod.tpl', 'r').read()
    jobs = []
    # Warm up cache layers
    buildWorker(dockerfileTmpl, '5.2.0', isDev)
    for version in data:
        m = re.search('^v(\d+\.\d+\.\d+)$', version['name'])
        if m:
            shopwareVersion = m.group(1)
            p = multiprocessing.Process(target=buildWorker, args=(dockerfileTmpl,shopwareVersion,isDev,))
            jobs.append(p)
            p.start()
