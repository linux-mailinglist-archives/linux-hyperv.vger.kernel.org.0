Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 285F2331558
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Mar 2021 18:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbhCHR4w (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 8 Mar 2021 12:56:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbhCHR4X (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 8 Mar 2021 12:56:23 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F15C06174A;
        Mon,  8 Mar 2021 09:56:22 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id 2so8210481qtw.1;
        Mon, 08 Mar 2021 09:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=0m8CHhLcUbX1L0n34fq2jhUA8O0HIx6xnmSmWybWykk=;
        b=Uu7C0+3FPBuhHvrg5d9nmKpNDe7JFfTyu4T3jbk0IX+zQ0sApuvPgU4ee8KG+VkznP
         19Nmhb0ADvG186q3JRwCs9XttMjOu/j58+aWsepQ0nZKtcC6IYNn2x70Vu4i49T9mRSB
         DksfLv9vjonqp15jrpJRNswi/XyWGye/wvIY4RYWaWnAwG5iiiaeGnZdk7yqCYN6H8mv
         nbXO+V/Ud/GbNf9GDfIAL7fiTxEoRowN77+pYI6aJo2EM+dYJEjROcbkhlVfXKE3lkr3
         QNPM5oY3No387KncclE9cmBZjmejjlU+lcmfWgAobbY9hYyb7nb+JFikeWjyMwBRZMSU
         KPCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=0m8CHhLcUbX1L0n34fq2jhUA8O0HIx6xnmSmWybWykk=;
        b=KlUlXVuFijQ2EDNIRvhKSL7s8lie7Oa2ckJZ6MMroG/p8NSQmYfZ0hu6cxek0ZMtzh
         6E+IZRNsqu5pLx+7/sDZ8hHj9zxuiP9E6fn/+fob6cXxRJtK4/AUDMMKsMoEimDDzK69
         VJH8fFkbPvOBC6JowH7GMth7WC8ZKGZ0WO1DE/wKsG9xSDR8GOCekfQX13Y6t6cxpfbT
         q8Ufow2pXyPidcCoUep71DV1SpcOyn9GTE4HjnwIBy0Ieq+yacECQnTBNvNRWcCtsm4m
         XcILYkM73qhk49j5Tv+shn9VySAnjzOhhfSof7l+EoMMc0zSjQ0bvWf/oXOcxdfPU+gb
         EIhw==
X-Gm-Message-State: AOAM533SFzpJvYd1qeHB+GcqTHGjlDEY8yruHgW+zzTDWWttgywFSWay
        ljtk1YMmacYTdnjkYAVN1KA=
X-Google-Smtp-Source: ABdhPJzO9wLO43QAi1OgGSn/xqvHdgfa2/BrTgPnV4G6jt9wIu+bSd+HJTfQ4ZkFvr6bv0sruhrl5g==
X-Received: by 2002:ac8:5908:: with SMTP id 8mr21583583qty.66.1615226181717;
        Mon, 08 Mar 2021 09:56:21 -0800 (PST)
Received: from goldwasser (pool-96-245-155-29.phlapa.fios.verizon.net. [96.245.155.29])
        by smtp.gmail.com with ESMTPSA id j26sm1499652qtp.30.2021.03.08.09.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 09:56:20 -0800 (PST)
Date:   Mon, 8 Mar 2021 12:56:18 -0500
From:   Melanie Plageman <melanieplageman@gmail.com>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "andres@anarazel.de" <andres@anarazel.de>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        KY Srinivasan <kys@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>
Subject: Re: [PATCH v1] scsi: storvsc: Cap cmd_per_lun at can_queue
Message-ID: <20210308175618.GA2376@goldwasser>
Mail-Followup-To: Michael Kelley <mikelley@microsoft.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "andres@anarazel.de" <andres@anarazel.de>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        KY Srinivasan <kys@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>
References: <20210305232151.1531-1-melanieplageman@gmail.com>
 <MWHPR21MB1593078007256C5155ED5A86D7939@MWHPR21MB1593.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR21MB1593078007256C5155ED5A86D7939@MWHPR21MB1593.namprd21.prod.outlook.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Mar 08, 2021 at 02:37:40PM +0000, Michael Kelley wrote:
> From: Melanie Plageman (Microsoft) <melanieplageman@gmail.com> Sent: Friday, March 5, 2021 3:22 PM
> > 
> > The scsi_device->queue_depth is set to Scsi_Host->cmd_per_lun during
> > allocation.
> > 
> > Cap cmd_per_lun at can_queue to avoid dispatch errors.
> > 
> > Signed-off-by: Melanie Plageman (Microsoft) <melanieplageman@gmail.com>
> > ---
> >  drivers/scsi/storvsc_drv.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
> > index 6bc5453cea8a..d7953a6e00e6 100644
> > --- a/drivers/scsi/storvsc_drv.c
> > +++ b/drivers/scsi/storvsc_drv.c
> > @@ -1946,6 +1946,8 @@ static int storvsc_probe(struct hv_device *device,
> >  				(max_sub_channels + 1) *
> >  				(100 - ring_avail_percent_lowater) / 100;
> > 
> > +	scsi_driver.cmd_per_lun = min_t(u32, scsi_driver.cmd_per_lun, scsi_driver.can_queue);
> > +
> 
> I'm not sure what you mean by "avoid dispatch errors".  Can you elaborate?

The scsi_driver.cmd_per_lun is set to 2048. Which is then used to set
Scsi_Host->cmd_per_lun in storvsc_probe().

In storvsc_probe(), when doing scsi_scan_host(), scsi_alloc_sdev() is
called and sets the scsi_device->queue_depth to the Scsi_Host's
cmd_per_lun with this code:
    
scsi_change_queue_depth(sdev, sdev->host->cmd_per_lun ?    
                                        sdev->host->cmd_per_lun : 1);

During dispatch, the scsi_device->queue_depth is used in
scsi_dev_queue_ready(), called by scsi_mq_get_budget() to determine
whether or not the device can queue another command.    

On some machines, with the 2048 value of cmd_per_lun that was used to
set the initial scsi_device->queue_depth, commands can be queued that
are later not able to be dispatched after running out of space in the
ringbuffer.

On an 8 core Azure VM with 16GB of memory with a single 1 TiB SSD
(running an fio workload that I can provide if needed), storvsc_do_io()
ends up often returning SCSI_MLQUEUE_DEVICE_BUSY.
                                                                      
This is the call stack: 
    
hv_get_bytes_to_write
hv_ringbuffer_write    
vmbus_send_packet      
storvsc_dio_io      
storvsc_queuecommand
scsi_dispatch_cmd    
scsi_queue_rq       
dispatch_rq_list

> Be aware that the calculation of "can_queue" in this driver is somewhat
> flawed -- it should not be based on the size of the ring buffer, but instead on
> the maximum number of requests Hyper-V will queue.  And even then,
> can_queue doesn't provide the cap you might expect because the blk-mq layer
> allocates can_queue tags for each HW queue, not as a total.


The docs for scsi_mid_low_api document Scsi_Host can_queue this way:

  can_queue    
  - must be greater than 0; do not send more than can_queue    
    commands to the adapter. 
        
I did notice that in scsi_host.h, the comment for can_queue does say
can_queue is the "maximum number of simultaneous commands a single hw
queue in HBA will accept." However, I don't see it being used this way
in the code.
                                                                            
During dispatch, In scsi_target_queue_ready(), there is this code:

        if (busy >= starget->can_queue)
                goto starved;

And the scsi_target->can_queue value should be coming from Scsi_host as
mentioned in the scsi_target definition in scsi_device.h
    /*
      * LLDs should set this in the slave_alloc host template callout.
      * If set to zero then there is not limit.
      */
    unsigned int            can_queue;

So, I don't really see how this would be per hardware queue.

> 
> I agree that the cmd_per_lun setting is also too big, but we should fix that in
> the context of getting all of these different settings working together correctly,
> and not piecemeal.
> 

Capping Scsi_Host->cmd_per_lun to scsi_driver.can_queue during probe
will also prevent the LUN queue_depth from being set to a value that is
higher than it can ever be set to again by the user when
storvsc_change_queue_depth() is invoked. 

Also in scsi_sysfs sdev_store_queue_depth() there is this check:

          if (depth < 1 || depth > sdev->host->can_queue)
                return -EINVAL;

I would also note that VirtIO SCSI in virtscsi_probe(), Scsi_Host->cmd_per_lun
is set to the min of the configured cmd_per_lun and
Scsi_Host->can_queue:

    shost->cmd_per_lun = min_t(u32, cmd_per_lun, shost->can_queue);

Best,
Melanie
