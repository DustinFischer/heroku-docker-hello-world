# heroku-docker-hello-world

#### Heroku deploy
Heroku and docker-compose don't really play well together. Heroku is only capable of supporting Dockerfile.

- Use `docker-compose` for local development.  

- Dockerfile and docker-compose must therefore take this into consideration.  

- Heroku will only build the image from Dockerfile.  

- Heroku does not support Docker `volumes`.

#### Deploying Docker container from `heroku.yml`
[Reference](https://devcenter.heroku.com/articles/build-docker-images-heroku-yml)

Ideally, `heroku.yml` is defined before creating the Heroku project. This **should** provision addons correctly.
Not 100% on this. See above reference.

1. Clone git repo:
        
        $ git clone <app-repo>
      
2. Create Heroku app in root of repo (creates `heroku` remote):
    
        $ heroku create [app-name]
        
3. Set the stack of your app to `container`. This informs heroku to build from `heroku.yml`:

        $ heroku stack:set container [app-name]

4. Once you are happy with your Docker image in local dev, push to Heroku:
        
        $ git push heroku master

5. This will trigger the deployment build which will take a few minutes. 
   You can follow the build process in the console to see if the build succeeded.

6. If something went wrong during deployment, you can tail the logs to see what happened:

        $ heroku logs --tail [app-name]

7. **NB:** If you have added resources to `setup` in `heroku.yml`, don't trust this. It's in beta.  
   Check if the resource has been provisioned in Heroku console, under app -> resources tab.
   If it's not been provisioned, then provision using cli. For example `postgres`:
    
        $ heroku addons:create heroku-postgresql:hobby-dev [--app <app-name>] 
