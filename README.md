# Labs from CSA-P Course

For the terraform, install it
 - `sudo snap install terraform` (or from their website)
 - create AWS account and account with Access Keys
 - configure with:
 - `~/.aws/credentials`:
   ```
   [default]
   aws_access_key_id=<replace-me>
   aws_secret_access_key=<replace-me>
   ```
 - `~/.aws/config`:
   ```
   [default]
   region=us-west-2
   output=json
   ```

I also have `awscli` (apt-get).

NOTE
	I couldn't get terraform to read the credentail file.
	The documentation for it seems to be... well... incorrect.
	Anyways, I ended up setting the environment variables,
	which seems to do the trick...

## Initialisation

I want to store my state remotely to avoid all sorts of problems.
  I chose S3 as it seems to be the easiest to set up.  I need
  a bucket, which can either be created manually or terraformed.
