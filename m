Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A68A331137E
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Feb 2021 22:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbhBEV1U (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 5 Feb 2021 16:27:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbhBEV0J (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 5 Feb 2021 16:26:09 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84606C061786
        for <linux-hyperv@vger.kernel.org>; Fri,  5 Feb 2021 13:25:25 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id r38so5407019pgk.13
        for <linux-hyperv@vger.kernel.org>; Fri, 05 Feb 2021 13:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZfmbarSZCNU0qPCH/wpCrQbKWX3VFOfmXnBYLc7Rsg4=;
        b=VowaO+k7/HSEe5j1XQlUOJ3Ik/DqndbbnwAxsbPXLSXqHPluulqHs+IgpD1NL2L3rF
         Ks0ldw81GqwbVQZJr/cW6e057uE6E6720XGKbuutSxmWlwBiL9p9C3j+S6ILX9d3L78p
         1yJI4PAgM0wsXREKxRWuGvBv49/6iUdVfB6eQuG1Yi6DsxxQaZNzm3x600j0q/ScDdJ/
         5EJhoMwoNQnHu3nmbn7UgpbOSNzl7bFsq4r3SIGrRDE+1B9vog6CJJm1M2VRSBM9QuT6
         qw7oVHo75ulGcInzqY/+jFnWfgMFsmsDGcxjUBk84FyPirAbIkxofNqTeONqBRuJwNvj
         0MGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZfmbarSZCNU0qPCH/wpCrQbKWX3VFOfmXnBYLc7Rsg4=;
        b=KwJELr67xsZJ4vqA8YeFY5SWz5c7ilzC0oeF/MOONjBvcTnY16/E09kwbHT2o1npBT
         RXM2VqhmRpgoUJ93YAJV5c3WUhTSFX0wSOrCMqEJMz8yGd2eOs5Rp3sphrIo+gzXL6Ah
         lu7I7dguKDuOqHhRp46KHphX2LGsoWCNSreHuo+oaTV/bWWpzWlvNrSNXyXSnaRc2YWN
         7RvReJ7rk1OjpK5SfJhxcTFsvA6QTbcF/PDlK0WADeDHAvhCcMZsp+NGWs3XXduOchfc
         LCxpf/7bORHdHDzlDtiydGGsB0YOAtoH0C3X2Tc+5Kap3bzV/aHQw3yNgMPItflwneiY
         w8ng==
X-Gm-Message-State: AOAM533IyDF4RkOui0IPTLWnxdn9bXia1r88PogNjmkK5KBQIwJZuPmI
        gjnvb9me8awONKR2q1smNYlgOq/7a6Q=
X-Google-Smtp-Source: ABdhPJz6cHAaZrDdnUtpHVIlGdjVptDByJQ32ASTxJIr40tMDUVr7+vngpGGqq2V3KxwHx7qtGNjDg==
X-Received: by 2002:a63:f19:: with SMTP id e25mr6182596pgl.220.1612560324970;
        Fri, 05 Feb 2021 13:25:24 -0800 (PST)
Received: from vm-122.slytdz3n204uxoeeqq2h5obquh.xx.internal.cloudapp.net ([51.141.169.192])
        by smtp.gmail.com with ESMTPSA id h15sm7828607pfo.84.2021.02.05.13.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 13:25:24 -0800 (PST)
From:   "Melanie Plageman (Microsoft)" <melanieplageman@gmail.com>
To:     andres@anarazel.de
Cc:     haiyangz@microsoft.com, kys@microsoft.com,
        linux-hyperv@vger.kernel.org, melanieplageman@gmail.com,
        sashal@kernel.org, mikelley@microsoft.com, sthemmin@microsoft.com
Subject: [PATCH 2/2] scsi: storvsc: Make max hw queues updatable
Date:   Fri,  5 Feb 2021 21:24:47 +0000
Message-Id: <20210205212447.3327-3-melanieplageman@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210205212447.3327-1-melanieplageman@gmail.com>
References: <20210203010904.hywx5xmwik52ccao@alap3.anarazel.de>
 <20210205212447.3327-1-melanieplageman@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

- Change name of parameter to storvsc_max_hw_queues
- Make the parameter updatable on a running system
- Change error to warning for an invalid value of the parameter at
  driver init time

Signed-off-by: Melanie Plageman (Microsoft) <melanieplageman@gmail.com>
---

Andres wrote:
>> On 2021-02-02 15:19:08 -0500, Melanie Plageman wrote:
>> diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
>> index 2e4fa77445fd..d72ab6daf9ae 100644
>> --- a/drivers/scsi/storvsc_drv.c
>> +++ b/drivers/scsi/storvsc_drv.c
>> @@ -378,10 +378,14 @@ static u32 max_outstanding_req_per_channel;
>>  static int storvsc_change_queue_depth(struct scsi_device *sdev, int
>>  queue_depth);
>>
>>  static int storvsc_vcpus_per_sub_channel = 4;
>> +static int storvsc_nr_hw_queues = -1;
>>
>>  module_param(storvsc_ringbuffer_size, int, S_IRUGO);
>>  MODULE_PARM_DESC(storvsc_ringbuffer_size, "Ring buffer size
>>  (bytes)");
>>
>> +module_param(storvsc_nr_hw_queues, int, S_IRUGO);
>> +MODULE_PARM_DESC(storvsc_nr_hw_queues, "Number of hardware queues");
>
> Would be nice if the parameter could be changed in a running
> system. Obviously that's only going to affect devices that'll be
> attached in the future (or detached and reattached), but that's still
> nicer than not being able to change at all.

My problem with making it updatable is that the user can set it to an
invalid value and then that is the value he/she/they will see in
/sys/module/hv_storvsc/parameters/storvsc_max_hw_queues at that point.
However, if they had set it as a boot-time kernel parameter, then the
value would have been corrected to a valid value.

On probe of a new device, if the value of storvsc_max_hw_queues is
invalid, the value of nr_hw_queues would be set to NCPUs, but, at that
point, do I also change the value in
/sys/module/hv_storvsc/parameters/storvsc_max_hw_queues?
If so, there is a weird intermediate period where it has a value that
isn't actually used or valid.
If not, you can update it to an invalid value while the system is
running but not if you set it at boot-time. Despite the fact that this
invalid value is not used at any point by the driver, it seems weird
that you can get it into a state where it doesn't reflect reality
depending on how you set it.

Maybe this isn't too big of a deal. I noticed the other module parameter
than can be set on a running system in storvsc is logging_level, and,
because of the do_logging() function, it doesn't really matter if the
user set it to a number higher or lower than one of the pre-defined log
levels. This behavior makes sense to me for logging, but I'm not sure
how I feel about going with a similar strategy for
storvsc_max_hw_queues.

I've gone with making it updatable and not updating the value of
storvsc_max_hw_queues during storvsc_probe(), even if the user had
updated storvsc_max_hw_queues to an invalid value. I just use NCPUs for
the value of nr_hw_queues.

Is there any user facing documentation on any of this? It would be nice
to add a comment there about what this parameter is and note that if you
change it, you need to reinitiate a probe of your device for it to take
effect and with details on the valid values for it and when they will be
reflected in /sys/module...

Andres wrote:
>> @@ -2155,6 +2163,7 @@ static struct fc_function_template
>> fc_transport_functions = {
>>  static int __init storvsc_drv_init(void)
>>  {
>>   int ret;
>> + int ncpus = num_present_cpus();
>>
>>   /*
>>    * Divide the ring buffer data size (which is 1 page less
>> @@ -2169,6 +2178,14 @@ static int __init storvsc_drv_init(void)
>>     vmscsi_size_delta,
>>     sizeof(u64)));
>>
>> + if (storvsc_nr_hw_queues > ncpus || storvsc_nr_hw_queues == 0 ||
>> +     storvsc_nr_hw_queues < -1) {
>> +   printk(KERN_ERR "storvsc: Invalid storvsc_nr_hw_queues value of
>> %d.
>> +           Valid values include -1 and 1-%d.\n",
>> +       storvsc_nr_hw_queues, ncpus);
>> +   return -EINVAL;
>> + }
>> +
>
> I have a mild preference for just capping the effective value to
> num_present_cpus(), rather than erroring out. Would allow you to
> e.g. cap the number of queues to 4, with the same param specified on
> smaller and bigger systems.  Perhaps renaming it to max_hw_queues
> would
> make that more obvious?

I like max_hw_queues -- I've updated the name to that.

I changed it to update storvsc_max_hw_queues to NCPUs if an invalid
value was provided.
I agree that it was pretty nasty to have it error out. I wanted to avoid
unexpected behavior for the user.
I changed the error to a warning, so, provided the sufficient log level,
a user could find out why the value they set storvsc_max_hw_queues to
does not match the one they see in
/sys/module/hv_storvsc/parameters/storvsc_max_hw_queues

 drivers/scsi/storvsc_drv.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index d72ab6daf9ae..e41f2461851e 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -378,13 +378,13 @@ static u32 max_outstanding_req_per_channel;
 static int storvsc_change_queue_depth(struct scsi_device *sdev, int queue_depth);
 
 static int storvsc_vcpus_per_sub_channel = 4;
-static int storvsc_nr_hw_queues = -1;
+static int storvsc_max_hw_queues = -1;
 
 module_param(storvsc_ringbuffer_size, int, S_IRUGO);
 MODULE_PARM_DESC(storvsc_ringbuffer_size, "Ring buffer size (bytes)");
 
-module_param(storvsc_nr_hw_queues, int, S_IRUGO);
-MODULE_PARM_DESC(storvsc_nr_hw_queues, "Number of hardware queues");
+module_param(storvsc_max_hw_queues, int, S_IRUGO|S_IWUSR);
+MODULE_PARM_DESC(storvsc_max_hw_queues, "Maximum number of hardware queues");
 
 module_param(storvsc_vcpus_per_sub_channel, int, S_IRUGO);
 MODULE_PARM_DESC(storvsc_vcpus_per_sub_channel, "Ratio of VCPUs to subchannels");
@@ -1901,6 +1901,7 @@ static int storvsc_probe(struct hv_device *device,
 {
 	int ret;
 	int num_cpus = num_online_cpus();
+	int num_present_cpus = num_present_cpus();
 	struct Scsi_Host *host;
 	struct hv_host_device *host_dev;
 	bool dev_is_ide = ((dev_id->driver_data == IDE_GUID) ? true : false);
@@ -2009,10 +2010,18 @@ static int storvsc_probe(struct hv_device *device,
 	 * Set the number of HW queues we are supporting.
 	 */
 	if (!dev_is_ide) {
-		if (storvsc_nr_hw_queues == -1)
-			host->nr_hw_queues = num_present_cpus();
+		if (storvsc_max_hw_queues == -1)
+			host->nr_hw_queues = num_present_cpus;
+		else if (storvsc_max_hw_queues > num_present_cpus ||
+			 storvsc_max_hw_queues == 0 ||
+			storvsc_max_hw_queues < -1) {
+			storvsc_log(device, STORVSC_LOGGING_WARN,
+				"Setting nr_hw_queues to %d. storvsc_max_hw_queues value %d is invalid.\n",
+				num_present_cpus, storvsc_max_hw_queues);
+			host->nr_hw_queues = num_present_cpus;
+		}
 		else
-			host->nr_hw_queues = storvsc_nr_hw_queues;
+			host->nr_hw_queues = storvsc_max_hw_queues;
 	}
 
 	/*
@@ -2178,12 +2187,11 @@ static int __init storvsc_drv_init(void)
 		vmscsi_size_delta,
 		sizeof(u64)));
 
-	if (storvsc_nr_hw_queues > ncpus || storvsc_nr_hw_queues == 0 ||
-			storvsc_nr_hw_queues < -1) {
-		printk(KERN_ERR "storvsc: Invalid storvsc_nr_hw_queues value of %d.
-						Valid values include -1 and 1-%d.\n",
-				storvsc_nr_hw_queues, ncpus);
-		return -EINVAL;
+	if (storvsc_max_hw_queues > ncpus || storvsc_max_hw_queues == 0 ||
+			storvsc_max_hw_queues < -1) {
+		printk(KERN_WARNING "storvsc: Setting storvsc_max_hw_queues to %d. %d is invalid.\n",
+			ncpus, storvsc_max_hw_queues);
+		storvsc_max_hw_queues = ncpus;
 	}
 
 #if IS_ENABLED(CONFIG_SCSI_FC_ATTRS)
-- 
2.20.1

