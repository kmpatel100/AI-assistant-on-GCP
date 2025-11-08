# AI-assistant-on-GCP

This is a hands-on demo from my **DevFest Windsor** talk: **Building Your Own AI Assistant - Web Automation with Gemini.**  
This project demonstrates how to combine Gemini with browser automation to create a personal AI assistant that can perform real web tasks such as searching, extracting data, and summarizing content.  

This is a continuation of my previous **DevFest London** talk, where I showed how to set up an AI assistant on your local machine.  


---

## Prerequisites

- Windows, macOS, or Linux laptop
- [Google Cloud Plateform](https://console.cloud.google.com/)
- [Google AI Studio](https://aistudio.google.com/) for a Gemini API key

---

## Step 1: Free Credits
To get free credits for the session, go to [Access Credits](https://trygcp.dev/claim/devfest-windsor),
and you can follow this presentation 👉️ [How To Get Free Cloud Credits](https://github.com/kmpatel100/AI-assistant-on-GCP/blob/main/Slides/How%20To%20Get%20Free%20Cloud%20Credits.pdf) If you have problems getting the credits.

**Note:** This might not work after the DevFest since it's available for a limited time.

## Step 2: Create project in GCP
- Go to [Google Cloud Console](https://console.cloud.google.com/)
- Select **My First Project** or create a new project called **ai-assistant**  
- Once the project is created, create a VM  
- If it asks for a Billing account, select **Google Cloud Platform Trial Billing Account**  
- If prompted to enable **Compute Engine API**, enable it  
- If you have trouble, you can refer to the video steps provided below 👇️

![Alt Text](https://github.com/kmpatel100/AI-assistant-on-GCP/blob/main/Resources/create_project.gif)


## Step 3: Create a VM
- Click **Create VM**  
- Choose a name for your VM  

**Machine configuration:**  
- Select **E2 instance** with **e2-medium (2 vCPU, 1 core, 4 GB memory)**  

**OS and storage:**  
- Operating System: **Ubuntu**  
- Boot disk type: **Standard persistent disk**  
- Size: **30 GB**  

**Data protection:**  
- Select **No backups** (only for testing)  

**Advanced:**  
- Under **Automation (Startup script)**, copy the shell script below 👇  
```
#! /bin/bash
curl -sSL https://raw.githubusercontent.com/kmpatel100/AI-assistant-on-GCP/refs/heads/main/gcp_startup_script.sh | bash
```
If you have trouble, refer to the video instructions provided below 👇️

![Alt Text](https://github.com/kmpatel100/AI-assistant-on-GCP/blob/main/Resources/create_VM.gif)

## Step 4: Configure the network
**Note:** This setup is only for testing. Do not use it in production as is.  
For production, the best and easiest way is through VPN tunnels such as **Cloudflare Tunnels** or **ngrok**.  
If you know what you are doing, you can also use a reverse proxy with a domain.  

- Search for **VPC networks**  
- Select **Firewall** from the left menu  
- Create a new firewall rule  
  - **Name:** `ai-assistant-rule`  
  - **Target tags:** `ai`  
  - **Source IPv4 ranges:** `0.0.0.0/0`  
  - **Protocols and ports:**  
    - Select **TCP** and add these ports: `5901, 6080, 7788, 9222`  
- Click **Create** to save the firewall rule

![Alt Text](https://github.com/kmpatel100/AI-assistant-on-GCP/blob/main/Resources/configure_network_1.gif)

Once the rule is created:  
- Search for **VM instances**  
- Select the VM you created and click **Edit**  
- Under **Networking**, find **Network tags**  
- Type the name of the network tag you created (e.g., `ai`)  
- Save the settings

![Alt Text](https://github.com/kmpatel100/AI-assistant-on-GCP/blob/main/Resources/configure_network_2.gif)

## Step 5: Explore the Interface  

- Copy the VM’s **External IP**  

**Access the WebUI:**  [http://External-IP:7788](http://External-IP:7788)  
  - Use port **7788** for the interface  
    - This is where you can give tasks to your assistant and select which LLM model to use  
- Use port **6080** for the VNC machine  
    - This is where you can observe how your assistant operates and performs tasks  

![Alt Text](https://github.com/kmpatel100/AI-assistant-on-GCP/blob/main/Resources/Explore_Interface.gif)

---

Once you can access the web interface, try a few examples on your own.  

 ---
## General Examples

**1. current stock price and latest quaterly earnings**

**Prompt:** Find the current stock price and a summary of the latest quarterly earnings report for Apple, Tesla, and Microsoft. Put the data in a bulleted list.

**2. write a summary**

**Prompt:** find out today's tech news and summarize it in 300 words.


## Examples for AI assisntant

**1. Add items to my grocery list**

**Prompt:** Go to ubereats.com and add 2% milk and table salt to my cart from walmart.

**2. Job hunting assistant**

**Prompt:**

You are a job-hunt assistant.  
1. Go to https://www.linkedin.com/jobs/  
2. Find the first “Top job picks for you” listing.  
3. Open its job description.  
4. Extract the “Responsibilities” section (or equivalent).  
5. Summarize those responsibilities in a few sentences.  
6. Compose an email message to me that includes:
   - A short subject line  
   - A greeting  
   - The summary of the responsibilities  
   - The link to the job posting  
   - A polite closing  

Send me only the email text (subject + body) on abcd@gmail.com

## Advance Examples

Check out demo section of orginal repo: https://github.com/browser-use/browser-use?tab=readme-ov-file#demos
