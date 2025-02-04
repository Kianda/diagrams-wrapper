## Description

This is just a low-effort wrapper built for [Diagrams](https://github.com/mingrammer/diagrams)

## Getting Started

1. Clone this repo
2. Run the *control_panel.sh* file and *"Start"* to launch this wrapper
3. Write your code inside *data/code* folder
4. Automagically find your generated images inside *data/images* (after every file save)

> NOTE: Once the container has been started just forget about it and focus on the code.

## The *control_panel.sh*

```sh
chmod +x control_panel.sh
./control_panel.sh
```

1. **Start** - *this will start/restart the container*
2. **Tail logs** - *show the logs of the container*
3. **Update** - *update if new image is available*
4. **Connect** - *go inside the container to debug issues or do nasty stuff*
5. **Generate all** - *regenerate all images*
6. **Stop** - *stop the container*
7. **Exit** - *flawlessly do... absolute... nothing!*

## Notes
- Only *.py* files are processed
- Files are processed at every **file-save**
- There's no need to commit the images, just the *.py* code
- The output image filename is defined inside the *.py* file (*check examples*)
- Path of *.py* files inside **data/code** is preserved and replicated inside **data/images** folder
- Filenames and folders with spaces are **allowed** but please... really... DON'T BE THAT GUY!

## Provided docker image

The *control_panel.sh* is working with my provided image (*kianda/diagrams-wrapper*) but, if you want, you can build your own!

## Build your own image

*The **Dockerfile** will always build the latest version available!*

```sh
# STANDARD VERSION

# check latest release number -> https://github.com/mingrammer/diagrams/releases
# example: v0.24.1

cd docker_build

docker build -f Dockerfile --no-cache -t yourusername/diagrams-wrapper:v0.24.1 .
docker build -f Dockerfile --no-cache -t yourusername/diagrams-wrapper:latest .

docker push yourusername/diagrams-wrapper:v0.24.1
docker push yourusername/diagrams-wrapper:latest
```

```sh
# ONESHOT VERSION

# ensure 'docker login' is done

cd docker_build

VER=$(curl -s "https://api.github.com/repos/mingrammer/diagrams/releases" | jq -r '.[0].name') && \
echo "Latest version is: $VER" && echo "I will proceed in 4 seconds!" && sleep 4 && \
docker build -f Dockerfile --no-cache -t yourusername/diagrams-wrapper:$VER . && \
docker build -f Dockerfile -t yourusername/diagrams-wrapper:latest . && \
docker push yourusername/diagrams-wrapper:$VER && \
docker push yourusername/diagrams-wrapper:latest

```

## Support

[!["Buy Me A Coffee"](https://buymeacoffee.com/assets/img/custom_images/yellow_img.png)](https://buymeacoffee.com/kianda)
