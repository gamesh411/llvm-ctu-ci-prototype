#!/bin/bash

### Cleanup.

# Clean VENV.
rm -rf sandbox

# Create new VENV.
virtualenv --no-site-packages sandbox

### Download and install Buildbot.

buildbot_tar='buildbot-0.8.5.tar.gz'
buildbot_dir="${buildbot_tar%%.tar.gz}"
buildbot_url="https://files.pythonhosted.org/packages/d0/74/9f3e0b47c2aa5b64d4f78f6852e59c5b84ed279b8bec563377ce90372716/${buildbot_tar}"

rm -rf "$buildbot_tar"

# Download buildbot.
wget "$buildbot_url"

# Unpack buildbot archive.
tar -xf "$buildbot_tar"

rm -rf "$buildbot_tar"

replacements=(
  "'twisted >= 8.0.0'/'twisted ==11.1.0'"
  "'Jinja2 >= 2.1'/'Jinja2 ==2.8'"
  "'sqlalchemy >= 0.6'/'sqlalchemy ==0.7.1'"
  "'sqlalchemy-migrate ==0.6.0, ==0.6.1, ==0.7.0, ==0.7.1'/'sqlalchemy-migrate ==0.7.1'"
)

for replacement in "${replacements[@]}"; do
  sed -i "s/${replacement}/" "${buildbot_dir}/setup.py"
done

tar -czf "$buildbot_tar" "$buildbot_dir"

rm -rf "$buildbot_dir"

### Install with pip

# Activate VENV.
source sandbox/bin/activate

# Install Buildbot.
pip install "$buildbot_tar"
