## Project Name

Brief description or introduction of the project.

### Creating Deploy User without Password Authentication

To create a deploy user for the VM without password authentication, follow the steps below:

1. Log in to the virtual machine using an administrator or root account.

2. Open a terminal or SSH into the VM.

3. Create a new deploy user by running the following command:
   ```bash
   sudo adduser deploy
   ```

4. Grant sudo privileges to the deploy user by adding them to the sudoers file:
   ```bash
   sudo usermod -aG sudo deploy
   ```

5. Generate an SSH key pair on your local machine if you haven't done so already:
   ```bash
   ssh-keygen
   ```

   This will create a public key (`id_rsa.pub`) and a private key (`id_rsa`) in your local `~/.ssh` directory.

6. Switch to the deploy user account:
   ```bash
   su - deploy
   ```

7. Create an `.ssh` directory in the home directory of the deploy user:
   ```bash
   mkdir ~/.ssh
   ```

8. Copy the content of your local machine's public key (`id_rsa.pub`) and paste it into a new file called `authorized_keys` in the `.ssh` directory on the virtual machine:
   ```bash
   nano ~/.ssh/authorized_keys
   ```

   Paste the public key content into this file and save it.

9. Set the appropriate permissions for the `.ssh` directory and the `authorized_keys` file to ensure proper security:
   ```bash
   chmod 700 ~/.ssh
   chmod 600 ~/.ssh/authorized_keys
   ```

10. Open the SSH configuration file:
    ```bash
    sudo nano /etc/ssh/sshd_config
    ```

11. Locate the line that starts with `PasswordAuthentication` and change its value to `no`:
    ```
    PasswordAuthentication no
    ```

12. Save the changes to the SSH configuration file and exit the editor.

13. Restart the SSH service to apply the changes:
    ```bash
    sudo service ssh restart
    ```

After completing these steps, the deploy user will be created on the VM, and password authentication will be disabled. The deploy user can now authenticate using the SSH key pair instead.
