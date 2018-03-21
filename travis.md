# travis local build

default image: `travisci/ci-garnet:packer-1512502276-986baf0`

```bash
docker run --name travis-debug -dit travisci/ci-garnet:packer-1490989530 /sbin/init
docker exec -it travis-debug bash -l
su - travis
git clone --depth=50 --branch=master {your repo URL}
```
