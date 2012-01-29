Requirements and installation

Ruby
This uses ruby v1.9.x

If you don't have ruby I'd recommend rvm.
Type the following commands to install:
``bash -s stable < <(curl -s https://raw.github.com/wayneeseguin/rvm/master/binscripts/rvm-installer )``

To use it type:
``source ~/.profile``

Install the ruby requirements. See rvm instructions. Type:
``rvm requirements``

After that install ruby and use it afterwards
``rvm install 1.9.2 && rvm use --default 1.9.2``

And bundler
``gem install bundle``

Clone repo and prepare to run

Clone the repository:
``git clone git@github.com:master-lincoln/WG-Tool.git``
Install dependencies 
``cd WG-Tool && bundle install``

Now you can run the server with:
``rails s``

