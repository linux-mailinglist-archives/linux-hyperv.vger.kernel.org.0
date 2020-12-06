Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF6D2D0673
	for <lists+linux-hyperv@lfdr.de>; Sun,  6 Dec 2020 19:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgLFSGp (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 6 Dec 2020 13:06:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgLFSGo (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 6 Dec 2020 13:06:44 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4F8C0613D0;
        Sun,  6 Dec 2020 10:06:04 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id 91so6579739wrj.7;
        Sun, 06 Dec 2020 10:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2A6meXGNkVt1Fe33c9tcz09/j0hGHozY31HBfki/CMs=;
        b=V9IhW55fK0hMQjIpf5N6276bMVNXWT3MruBo2+7U5L0ZUiiKOn3JbEPyRuE0d7ztUJ
         3kmqEg3Zt8og/B3O1WupoFyTnVIZrGy9/2FMtnDBHkeH7P0pHLbFwLaKMMh1csF1Nklo
         Bdqyn4lSEaKStOmzTkUOczqdaTYK/gFsLxq0b/d+NvwZFgdQy/kt0I2qu0PSIxxlNEH0
         Xwd1krEgI44ftiEbBgDRzfSWROIuo9D9BZDo1HXrVcUzk3TKoOGUe8eU5saRzr2RLGbu
         s0MXrUegYJN9uNYNap8yAetjbNaP3xdv2YiquUvnj3TTiYoL6y0Bhb5gbsu5/FWbKo20
         LjFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2A6meXGNkVt1Fe33c9tcz09/j0hGHozY31HBfki/CMs=;
        b=ZRyX8m6FRcHR5w6OoC4yV+DS8+iTTHlBvnZHnGzZGlNUJQhGbvyNviJqV511w+5ldK
         koc9Pj7diwXS3SR4mjTzK3iis2dtZbS6gzroSMg/b4kdciOq9XnN9uPpqr7iX2E9EiPz
         UYjDMJtNtQYrw2AmV3IJ2UPak3ep72+d7nUBvPeMEUia+XOOHSPk6Qoe6mrk2BIgUt3W
         pU0VWcDiTN5z8YNN6xYIJJuIKVrkV2fuQNiowPrRFGlGBFfyNPbSpLLPAaOOrsXX+acr
         prcR1aVFF7lFeEtB9yPV2NC6ro0gZ+vN+VZ+ktthTUwjwp+/aIIxFLyI+VoIEGROZr9l
         XErw==
X-Gm-Message-State: AOAM5308NVEuLwkSEe/ta1En0a1c6SwWl/shnF+SfU1LEv8F1VkJrN0R
        YmjptezmtNJMls6SxbHY34I=
X-Google-Smtp-Source: ABdhPJzJlPSAdWci4KwFJiRYKUcUIUmbZDvWqx/jepJUrOA5sEumwDWzH6w5XkeHBQtbhjo7eUw+zg==
X-Received: by 2002:adf:f085:: with SMTP id n5mr15331601wro.371.1607277962842;
        Sun, 06 Dec 2020 10:06:02 -0800 (PST)
Received: from andrea (host-95-239-64-30.retail.telecomitalia.it. [95.239.64.30])
        by smtp.gmail.com with ESMTPSA id y130sm11491603wmc.22.2020.12.06.10.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Dec 2020 10:06:02 -0800 (PST)
Date:   Sun, 6 Dec 2020 19:05:59 +0100
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Juan Vazquez <juvazq@microsoft.com>,
        Saruhan Karademir <skarade@microsoft.com>
Subject: Re: [PATCH 2/6] Drivers: hv: vmbus: Avoid double fetch of msgtype in
 vmbus_on_msg_dpc()
Message-ID: <20201206180559.GB3256@andrea>
References: <20201118143649.108465-1-parri.andrea@gmail.com>
 <20201118143649.108465-3-parri.andrea@gmail.com>
 <MW2PR2101MB10528F278B1BD5FA060D7F5AD7CF1@MW2PR2101MB1052.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW2PR2101MB10528F278B1BD5FA060D7F5AD7CF1@MW2PR2101MB1052.namprd21.prod.outlook.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sun, Dec 06, 2020 at 05:10:26PM +0000, Michael Kelley wrote:
> From: Andrea Parri (Microsoft) <parri.andrea@gmail.com> Sent: Wednesday, November 18, 2020 6:37 AM
> > 
> > vmbus_on_msg_dpc() double fetches from msgtype.  The double fetch can
> > lead to an out-of-bound access when accessing the channel_message_table
> > array.  In turn, the use of the out-of-bound entry could lead to code
> > execution primitive (entry->message_handler()).  Avoid the double fetch
> > by saving the value of msgtype into a local variable.
> 
> The commit message is missing some context.  Why is a double fetch a
> problem?  The comments below in the code explain why, but the why
> should also be briefly explained in the commit message.

I'll integrate the commit message as suggested.


> > diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> > index 0a2711aa63a15..82b23baa446d7 100644
> > --- a/drivers/hv/vmbus_drv.c
> > +++ b/drivers/hv/vmbus_drv.c
> > @@ -1057,6 +1057,7 @@ void vmbus_on_msg_dpc(unsigned long data)
> >  	struct hv_message *msg = (struct hv_message *)page_addr +
> >  				  VMBUS_MESSAGE_SINT;
> >  	struct vmbus_channel_message_header *hdr;
> > +	enum vmbus_channel_message_type msgtype;
> >  	const struct vmbus_channel_message_table_entry *entry;
> >  	struct onmessage_work_context *ctx;
> >  	u32 message_type = msg->header.message_type;
> > @@ -1072,12 +1073,19 @@ void vmbus_on_msg_dpc(unsigned long data)
> >  		/* no msg */
> >  		return;
> > 
> > +	/*
> > +	 * The hv_message object is in memory shared with the host.  The host
> > +	 * could erroneously or maliciously modify such object.  Make sure to
> > +	 * validate its fields and avoid double fetches whenever feasible.
> 
> The "when feasible" phrase sounds like not doing double fetches is optional in
> some circumstances.  But I think we always have to protect against modification
> of memory shared with the host.  So perhaps the comment should be more
> precise.

I guess I was imagining situations where "avoiding the double fetch"
could just not be the most "convenient" option and where we may want
to instead opt for a "full re-validation" of the data at stake (say,
fetches separated by some "complex" call chain?).  We're certainly
in sync with the general principle of protecting the guest against
modification of memory shared with the host/hypervisor.  ;-)  I'll
amend the comment accordingly.

  Andrea
