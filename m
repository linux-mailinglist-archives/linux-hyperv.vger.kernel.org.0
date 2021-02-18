Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F73731E361
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Feb 2021 01:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbhBRAFn (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 17 Feb 2021 19:05:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhBRAFn (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 17 Feb 2021 19:05:43 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEBADC061574;
        Wed, 17 Feb 2021 16:05:02 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id t62so509406qke.7;
        Wed, 17 Feb 2021 16:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=HNEyoAHDpbqdrYGoVGPXkW1LVSbwCwTNOVWQ4IIz6GI=;
        b=tpUOtYr2HGmErYVSR/H+iWALtk3+OktcHJ5NhdY45+Bq6X5tKq2L75CuqYJIPbSevt
         BvGp70oF7zqhDZMZMEzNPve1jBjDnGqKrooWvzUgihLI6+LwZyxYOMhikCFe5djI1RwG
         OgcyQJDoVHUihl+LvAhb+b50TvP5Vg4naN5A0xMh6qdnMjup+72xRPItB3C2mN/hV+U2
         k4shlHAyCbybvSfQIIv+nHRzWdSQDjZRsYgiVoalZsnkXFh5ZkidkgxUwP1qhsQd4/vY
         RmtwFJRq4bFe3EDfavhRGOl7I5N8psZDjy8GsiS4rVn3aclX0TJXFpFM4T1+J+VuvBNT
         jKLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=HNEyoAHDpbqdrYGoVGPXkW1LVSbwCwTNOVWQ4IIz6GI=;
        b=RkjPGmYX68QOFBBzUdrnMnnCw+OB0lDVDDEqpNLO53hXoKA3Bl+PSBYXdSCunaIXDY
         1ejS8swvJr32nYO6hmmnwkNnDmj6D25ecypGr8e/Zraz8CLYLS4aYA2V1ZvwzwDoEoSk
         sEq9Ley2zrosUe6XUxwvLx18wKwt/7MV4Mz2DFwkDd9DfVCzaacI3fbAN4+mv1Cq0KjZ
         nzrgAafRowcWbY7UqoGukFSK9cpyCsacj6dGTsR4LuowqaZdEWUWhzzsogA7XkiYdOU5
         wAnwaPh1nC+g3Uk9RTonRmxu4pOHCCBliIm5HQnGlTzqSmU3p2iQotfRxgSEW3LPqsrE
         N/YQ==
X-Gm-Message-State: AOAM531WHBmYZmbafsN7jnU4ICdRrfPr2gu6xgEyMeapURNN9hf0JtQG
        K8tY92JQ3/qQV46DVtwUzgo=
X-Google-Smtp-Source: ABdhPJyrtI69nc4qqmry8r7IBltCzUtoI/2MuV626Zi/crlLjsYRjI+IayGDSEbK6sfEe5EJ1vplsw==
X-Received: by 2002:a37:7d07:: with SMTP id y7mr1802558qkc.107.1613606701919;
        Wed, 17 Feb 2021 16:05:01 -0800 (PST)
Received: from goldwasser (pool-96-245-155-29.phlapa.fios.verizon.net. [96.245.155.29])
        by smtp.gmail.com with ESMTPSA id x12sm2680582qkj.20.2021.02.17.16.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 16:05:01 -0800 (PST)
Date:   Wed, 17 Feb 2021 19:04:59 -0500
From:   Melanie Plageman <melanieplageman@gmail.com>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "andres@anarazel.de" <andres@anarazel.de>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] scsi: storvsc: Parameterize number hardware queues
Message-ID: <20210218000459.GA56402@goldwasser>
Mail-Followup-To: Michael Kelley <mikelley@microsoft.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "andres@anarazel.de" <andres@anarazel.de>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210211231803.25463-1-melanieplageman@gmail.com>
 <MWHPR21MB15932F068976333B8D3DCEFCD78B9@MWHPR21MB1593.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR21MB15932F068976333B8D3DCEFCD78B9@MWHPR21MB1593.namprd21.prod.outlook.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Feb 12, 2021 at 04:35:16PM +0000, Michael Kelley wrote:
> From: Melanie Plageman <melanieplageman@gmail.com> Sent: Thursday, February 11, 2021 3:18 PM
> > 
> > Add ability to set the number of hardware queues with new module parameter,
> > storvsc_max_hw_queues. The default value remains the number of CPUs.  This
> > functionality is useful in some environments (e.g. Microsoft Azure) where
> > decreasing the number of hardware queues has been shown to improve
> > performance.
> > 
> > Signed-off-by: Melanie Plageman (Microsoft) <melanieplageman@gmail.com>
> > ---
> >  drivers/scsi/storvsc_drv.c | 28 ++++++++++++++++++++++++++--
> >  1 file changed, 26 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
> > index 2e4fa77445fd..a64e6664c915 100644
> > --- a/drivers/scsi/storvsc_drv.c
> > +++ b/drivers/scsi/storvsc_drv.c
> > @@ -378,10 +378,14 @@ static u32 max_outstanding_req_per_channel;
> >  static int storvsc_change_queue_depth(struct scsi_device *sdev, int queue_depth);
> > 
> >  static int storvsc_vcpus_per_sub_channel = 4;
> > +static int storvsc_max_hw_queues = -1;
> > 
> >  module_param(storvsc_ringbuffer_size, int, S_IRUGO);
> >  MODULE_PARM_DESC(storvsc_ringbuffer_size, "Ring buffer size (bytes)");
> > 
> > +module_param(storvsc_max_hw_queues, int, S_IRUGO|S_IWUSR);
> > +MODULE_PARM_DESC(storvsc_max_hw_queues, "Maximum number of hardware
> > queues");
> > +
> 
> There's been an effort underway to not use the symbolic permissions in
> module_param(), but to just use the octal digits (like 0600 for root only
> access).   But I couldn't immediately find documentation on why this
> change is being made.  And clearly it hasn't been applied to the
> existing module_param() uses here in storvsc_drv.c.  But with this being
> a new parameter, let's use the recommended octal digit format.

Thanks. I will update this in v4.

> 
> >  module_param(storvsc_vcpus_per_sub_channel, int, S_IRUGO);
> >  MODULE_PARM_DESC(storvsc_vcpus_per_sub_channel, "Ratio of VCPUs to
> > subchannels");
> > 
> > @@ -1897,6 +1901,7 @@ static int storvsc_probe(struct hv_device *device,
> >  {
> >  	int ret;
> >  	int num_cpus = num_online_cpus();
> > +	int num_present_cpus = num_present_cpus();
> >  	struct Scsi_Host *host;
> >  	struct hv_host_device *host_dev;
> >  	bool dev_is_ide = ((dev_id->driver_data == IDE_GUID) ? true : false);
> > @@ -2004,8 +2009,19 @@ static int storvsc_probe(struct hv_device *device,
> >  	 * For non-IDE disks, the host supports multiple channels.
> >  	 * Set the number of HW queues we are supporting.
> >  	 */
> > -	if (!dev_is_ide)
> > -		host->nr_hw_queues = num_present_cpus();
> > +	if (!dev_is_ide) {
> > +		if (storvsc_max_hw_queues == -1)
> > +			host->nr_hw_queues = num_present_cpus;
> > +		else if (storvsc_max_hw_queues > num_present_cpus ||
> > +			 storvsc_max_hw_queues == 0 ||
> > +			storvsc_max_hw_queues < -1) {
> > +			storvsc_log(device, STORVSC_LOGGING_WARN,
> > +				"Resetting invalid storvsc_max_hw_queues value to default.\n");
> > +			host->nr_hw_queues = num_present_cpus;
> > +			storvsc_max_hw_queues = -1;
> > +		} else
> > +			host->nr_hw_queues = storvsc_max_hw_queues;
> > +	}
> 
> I have a couple of thoughts about the above logic.  As the code is written,
> valid values are integers from 1 to the number of CPUs, and -1.  The logic
> would be simpler if the module parameter was an unsigned int instead of
> a signed int, and zero was the marker for "use number of CPUs".  Then
> you wouldn't have to check for negative values or have special handling
> for -1.

I used -1 because the linter ./scripts/checkpatch.pl throws an ERROR "do
not initialise statics to 0"

> 
> Second, I think you can avoid intertwining the logic for checking for an
> invalid value, and actually setting host->nr_hw_queues.  Check for an
> invalid value first, then do the setting of host->hr_hw_queues.
> 
> Putting both thoughts together, you could get code like this:
> 
> 	if (!dev_is ide) {
> 		if (storvsc_max_hw_queues > num_present_cpus) {
> 			storvsc_max_hw_queues = 0;
> 			storvsc_log(device, STORVSC_LOGGING_WARN,
> 				"Resetting invalid storvsc_max_hw_queues value to default.\n");
> 		}
> 		if (storvsc_max_hw_queues)
> 			host->nr_hw_queues = storvsc_max_hw_queues
> 		else
> 			host->hr_hw_queues = num_present_cpus;
> 	}

I will update the logic like this.

> 
> > 
> >  	/*
> >  	 * Set the error handler work queue.
> > @@ -2169,6 +2185,14 @@ static int __init storvsc_drv_init(void)
> >  		vmscsi_size_delta,
> >  		sizeof(u64)));
> > 
> > +	if (storvsc_max_hw_queues > num_present_cpus() ||
> > +		storvsc_max_hw_queues == 0 ||
> > +		storvsc_max_hw_queues < -1) {
> > +		pr_warn("Setting storvsc_max_hw_queues to -1. %d is invalid.\n",
> > +			storvsc_max_hw_queues);
> > +		storvsc_max_hw_queues = -1;
> > +	}
> > +
> 
> Is this check really needed?  Any usage of the value will be in
> storvsc_probe() where the same check is performed.  I'm not seeing
> a scenario where this check adds value over what's already being
> done in storvsc_probe(), but maybe I'm missing it.

It is not. I had initially added it because I did not plan on making the
parameter updatable and thought it would be better to only have one
message about the invalid value instead of #device messages (from each
probe()). But, after making it updatable, I had to add invalid value
checking to storvsc_probe() anyway, so, this is definitely unneeded. If
you specify the parameter at boot-time and this is here, you would only
get one instance of the logging message (because it resets the value of
storvsc_max_hw_queues to the default before probe() is called), but, I
don't think that is worth it.

> 
> >  #if IS_ENABLED(CONFIG_SCSI_FC_ATTRS)
> >  	fc_transport_template = fc_attach_transport(&fc_transport_functions);
> >  	if (!fc_transport_template)
> > --
> > 2.20.1
> 
