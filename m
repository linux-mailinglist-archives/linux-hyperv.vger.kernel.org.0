Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40F822D066A
	for <lists+linux-hyperv@lfdr.de>; Sun,  6 Dec 2020 18:55:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbgLFRzN (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 6 Dec 2020 12:55:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgLFRzN (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 6 Dec 2020 12:55:13 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF01C0613D0;
        Sun,  6 Dec 2020 09:54:32 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id g185so11586489wmf.3;
        Sun, 06 Dec 2020 09:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8hPz3fXD4d18hl2wdf9fe7bSAOyqTTVMV/KSC4uywkY=;
        b=uBK0NQxE8iF0KwU+lcMnKiKiBhUVCD1VpC8jl07R8gba9N5baU4BggiCv/J+Iaf9wT
         7rDTbQtAzAfS6x4kiiHwUfodAHPWJVcC3dpUlO+a2P4+kOXU/0lzY/1emIZQxnUqdhge
         yjOJovOvA8aNukFIyIICu09dTO3nQuIWHCNZc04FTedXjTJiTY8bVoP2vRz7H4aHJR1r
         HSS6S6eZljo4E2T9PeYzJ9mM6YLtQLFlQIgBZrtSwefP4YaLmX4+fADJoy8Q684eYOi9
         t8DdkLaCNgjvubqTj93Pf+5ezsZt1mOAa2QcJnAts9OU4gX4WOP+K4cl43E9zQGisUjk
         vWnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8hPz3fXD4d18hl2wdf9fe7bSAOyqTTVMV/KSC4uywkY=;
        b=A2iWaSLFnfcgcHw+LNFhaswadpPEh/b0c6fPifjp67LkgZw5GCtzeGgzmbhsiYs5AZ
         JV7aiG7FFpCh4CSFTz7g1oZJjF+lyiOtn3tffdE4yy542BYUKZu+uHW1uZHeu51gePW8
         YAD6Z1g4EfJJt3bOSzPTziYzfjzucARIu3NPTpUqNIaFparswq8lu7+Ig5OaFUWlKmAV
         8Yrre1+Mn00Ac/RZfwP8fosWrUDN5gJEp8UnIIfJ87jxnIlWulfHK6kwMBlU8f956wPo
         aKDbm06MfHIGY/PY8Rj2cVDrK64MQC3CMy3DDSQ97NPauoQzTgolT6bV3IuPU/a0l9Aa
         iLkw==
X-Gm-Message-State: AOAM532eJ2n1XrJuHWsM/g+yzxf9PNQnFiyFoeR7oNumipqDElw8CSOW
        wnthM4vNL56SVm9qOQ2MHhk=
X-Google-Smtp-Source: ABdhPJwsetfYWf68hfPKK4uHA4S1B2zNJ7705A7RWG+hDh+MtcbaApWNuQsqOQR6B3SfBIYkx4ZPjw==
X-Received: by 2002:a1c:f60b:: with SMTP id w11mr10372604wmc.180.1607277271305;
        Sun, 06 Dec 2020 09:54:31 -0800 (PST)
Received: from andrea (host-95-239-64-30.retail.telecomitalia.it. [95.239.64.30])
        by smtp.gmail.com with ESMTPSA id q25sm13008690wmq.37.2020.12.06.09.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Dec 2020 09:54:30 -0800 (PST)
Date:   Sun, 6 Dec 2020 18:54:22 +0100
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
Subject: Re: [PATCH 1/6] Drivers: hv: vmbus: Initialize memory to be sent to
 the host
Message-ID: <20201206175422.GA3256@andrea>
References: <20201118143649.108465-1-parri.andrea@gmail.com>
 <20201118143649.108465-2-parri.andrea@gmail.com>
 <MW2PR2101MB1052B9BAFF7876427746F596D7CF1@MW2PR2101MB1052.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW2PR2101MB1052B9BAFF7876427746F596D7CF1@MW2PR2101MB1052.namprd21.prod.outlook.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sun, Dec 06, 2020 at 04:59:32PM +0000, Michael Kelley wrote:
> From: Andrea Parri (Microsoft) <parri.andrea@gmail.com> Sent: Wednesday, November 18, 2020 6:37 AM
> > 
> > __vmbus_open() and vmbus_teardown_gpadl() do not inizialite the memory
> > for the vmbus_channel_open_channel and the vmbus_channel_gpadl_teardown
> > objects they allocate respectively.  These objects contain padding bytes
> > and fields that are left uninitialized and that are later sent to the
> > host, potentially leaking guest data.  Zero initialize such fields to
> > avoid leaking sensitive information to the host.
> > 
> > Reported-by: Juan Vazquez <juvazq@microsoft.com>
> > Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> > ---
> >  drivers/hv/channel.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
> > index 0d63862d65518..9aa789e5f22bb 100644
> > --- a/drivers/hv/channel.c
> > +++ b/drivers/hv/channel.c
> > @@ -621,7 +621,7 @@ static int __vmbus_open(struct vmbus_channel *newchannel,
> >  		goto error_clean_ring;
> > 
> >  	/* Create and init the channel open message */
> > -	open_info = kmalloc(sizeof(*open_info) +
> > +	open_info = kzalloc(sizeof(*open_info) +
> >  			   sizeof(struct vmbus_channel_open_channel),
> >  			   GFP_KERNEL);
> >  	if (!open_info) {
> > @@ -748,7 +748,7 @@ int vmbus_teardown_gpadl(struct vmbus_channel *channel, u32
> > gpadl_handle)
> >  	unsigned long flags;
> >  	int ret;
> > 
> > -	info = kmalloc(sizeof(*info) +
> > +	info = kzalloc(sizeof(*info) +
> >  		       sizeof(struct vmbus_channel_gpadl_teardown), GFP_KERNEL);
> >  	if (!info)
> >  		return -ENOMEM;
> > --
> > 2.25.1
> 
> This change is actually zero'ing more memory than is necessary.  Only the
> 'msg' portion is sent to Hyper-V, so that's all that needs to be zero'ed.
> But this code is not performance sensitive, and doing the tighter zero'ing
> would add lines of code with no real value.  So,
> 
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>

Thank you for the review.

Please notice that I posted a v2 of this series:

  https://lkml.kernel.org/r/20201202092214.13520-1-parri.andrea@gmail.com

Thanks,
  Andrea
