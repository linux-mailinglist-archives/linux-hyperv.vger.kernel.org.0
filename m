Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1446A1B6119
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Apr 2020 18:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729676AbgDWQhg (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 23 Apr 2020 12:37:36 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41200 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729446AbgDWQhg (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 23 Apr 2020 12:37:36 -0400
Received: by mail-pl1-f194.google.com with SMTP id d24so2556392pll.8;
        Thu, 23 Apr 2020 09:37:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=br9/LwqtnbGmKBWFw4TNRCW1diyiAINb0Mjvmd0b2kg=;
        b=UdSwy1MgeNNsav1aTRPwhMDgfk31r4tbUhvv+5LfXeTuEdZCVJ8I55tumpEUn1t7pU
         4eLfATvcLHq9wTgqtpRVq8wNa4Ea8GDKns5K7zYH6KkdJnbTX0A8g+hYtXs9egyRcgv1
         m9ISaz1v8mWr4ZYc6HhpoqCX4RjGQeBtz0b16nykl0pzNt4aYuiSeG1bruBVns/LmptD
         ka8wUFu1QLO0ElKvjgLjQcLoxtR85ITjlO2r8fFLW4Rts4KzTZDbrcaE/xYAPwApllOj
         lX+ktgaKa9kIz1LIjWVy5mSyizMoIlDs9YLwQz2R0Sgul/JtMcppI8DHLgzH47nm3+yU
         fGQA==
X-Gm-Message-State: AGi0PuYIlCochgUk9ehOniWlm+6HBMf+3bnZzjQop+8hTE11au4IlRlv
        dsw8hmzhLpWsqLu+1oG8zpg=
X-Google-Smtp-Source: APiQypLppeneOJYmadAENAmOGLqG9q7ggz3SIM23BMCXkROCwJMeo+psXucBZUDdztyAKgvEOmJHkg==
X-Received: by 2002:a17:902:b709:: with SMTP id d9mr4486836pls.118.1587659854793;
        Thu, 23 Apr 2020 09:37:34 -0700 (PDT)
Received: from [100.124.9.89] ([104.129.198.55])
        by smtp.gmail.com with ESMTPSA id c3sm2975513pfa.160.2020.04.23.09.37.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2020 09:37:33 -0700 (PDT)
Subject: Re: [PATCH] scsi: storvsc: Fix a panic in the hibernation procedure
To:     Dexuan Cui <decui@microsoft.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>, "hare@suse.de" <hare@suse.de>,
        Michael Kelley <mikelley@microsoft.com>,
        Long Li <longli@microsoft.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        Balsundar P <Balsundar.P@microchip.com>
Cc:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>
References: <1587514644-47058-1-git-send-email-decui@microsoft.com>
 <1b6de3b0-4e0c-4b46-df1a-db531bd2c888@acm.org>
 <HK0P153MB027395755C14233F09A8F352BFD20@HK0P153MB0273.APCP153.PROD.OUTLOOK.COM>
 <c55d643c-c13f-70f1-7a44-608f94fbfd5f@acm.org>
 <HK0P153MB02737524F120829405C6DE68BFD30@HK0P153MB0273.APCP153.PROD.OUTLOOK.COM>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <ade7f096-4a09-4d4e-753a-f9e4acb7b550@acm.org>
Date:   Thu, 23 Apr 2020 09:37:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <HK0P153MB02737524F120829405C6DE68BFD30@HK0P153MB0273.APCP153.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 4/23/20 12:04 AM, Dexuan Cui wrote:
> It looks the sd suspend callbacks are only for the I/O from the disk, e.g.
> from the file system that lives in some partition of some disk.
> 
> The panic I'm seeing is not from sd. I think it's from a kernel thread
> that tries to detect the status of the SCSI CDROM. This is the snipped
> messages (the full version is at https://lkml.org/lkml/2020/4/10/47): here
> the suspend callbacks of the sd, sr and scsi_bus_type.pm have been called,
> and later the storvsc LLD's suspend callback is also called, but
> sr_block_check_events() can still try to submit SCSI commands to storvsc:
> 
> [   11.668741] sr 0:0:0:1: bus quiesce
> [   11.668804] sd 0:0:0:0: bus quiesce
> [   11.698082] scsi target0:0:0: bus quiesce
> [   11.703296] scsi host0: bus quiesce
> [   11.781730] hv_storvsc bf78936f-7d8f-45ce-ab03-6c341452e55d: noirq bus quiesce
> [   11.796479] hv_netvsc dda5a2be-b8b8-4237-b330-be8a516a72c0: noirq bus quiesce
> [   11.804042] BUG: kernel NULL pointer dereference, address: 0000000000000090
> [   11.804996] Workqueue: events_freezable_power_ disk_events_workfn
> [   11.804996] RIP: 0010:storvsc_queuecommand+0x261/0x714 [hv_storvsc]
> [   11.804996] Call Trace:
> [   11.804996]  scsi_queue_rq+0x593/0xa10
> [   11.804996]  blk_mq_dispatch_rq_list+0x8d/0x510
> [   11.804996]  blk_mq_sched_dispatch_requests+0xed/0x170
> [   11.804996]  __blk_mq_run_hw_queue+0x55/0x110
> [   11.804996]  __blk_mq_delay_run_hw_queue+0x141/0x160
> [   11.804996]  blk_mq_sched_insert_request+0xc3/0x170
> [   11.804996]  blk_execute_rq+0x4b/0xa0
> [   11.804996]  __scsi_execute+0xeb/0x250
> [   11.804996]  sr_check_events+0x9f/0x270 [sr_mod]
> [   11.804996]  cdrom_check_events+0x1a/0x30 [cdrom]
> [   11.804996]  sr_block_check_events+0xcc/0x110 [sr_mod]
> [   11.804996]  disk_check_events+0x68/0x160
> [   11.804996]  process_one_work+0x20c/0x3d0
> [   11.804996]  worker_thread+0x2d/0x3e0
> [   11.804996]  kthread+0x10c/0x130
> [   11.804996]  ret_from_fork+0x35/0x40
> 
> It looks the issue is: scsi_bus_freeze() -> ... -> scsi_dev_type_suspend ->
> scsi_device_quiesce() does not guarantee the device is totally quiescent:

During hibernation processes are frozen before devices are quiesced. 
freeze_processes() calls try_to_freeze_tasks() and that function in turn 
calls freeze_workqueues_begin() and freeze_workqueues_busy(). 
freeze_workqueues_busy() freezes all freezable workqueues including 
system_freezable_power_efficient_wq, the workqueue from which 
check_events functions are called. Some time after freezable workqueues 
are frozen dpm_suspend(PMSG_FREEZE) is called. That last call triggers 
the pm_ops.freeze callbacks, including the pm_ops.freeze callbacks 
defined in the SCSI core.

The above trace seems to indicate that freezing workqueues has not 
happened before devices were frozen. How about doing the following to 
retrieve more information about what is going on?
* Enable CONFIG_PM_DEBUG in the kernel configuration.
* Run echo 1 > /sys/power/pm_print_times and echo 1 > 
/sys/power/pm_debug_messages before hibernation starts.

>> Documentation/driver-api/device_link.rst: "By default, the driver core
>> only enforces dependencies between devices that are borne out of a
>> parent/child relationship within the device hierarchy: When suspending,
>> resuming or shutting down the system, devices are ordered based on this
>> relationship, i.e. children are always suspended before their parent,
>> and the parent is always resumed before its children." Is there a single
>> storvsc_drv instance for all SCSI devices supported by storvsc_drv? Has
>> it been considered to make storvsc_drv the parent device of all SCSI
>> devices created by the storvsc driver?
> 
> Yes, I think so:
> 
> root@localhost:~# ls -rtl  /sys/bus/vmbus/devices/9be03cb2-d37b-409f-b09b-81059b4f6943/host3/target3:0:0/3:0:0:0/driver
> lrwxrwxrwx 1 root root 0 Apr 22 01:10 /sys/bus/vmbus/devices/9be03cb2-d37b-409f-b09b-81059b4f6943/host3/target3:0:0/3:0:0:0/driver -> ../../../../../../../../../../bus/scsi/drivers/sd
> 
> Here the driver of /sys/bus/vmbus/devices/9be03cb2-d37b-409f-b09b-81059b4f6943
> is storvsc, which creates host3/target3:0:0/3:0:0:0.
> 
> So it looks there is no ordering issue.

Right, I had overlooked the code in storvsc_probe() that associates SCSI 
devices with storvsc_drv.

Bart.
