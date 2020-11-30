Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0B92C7DEB
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Nov 2020 06:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725880AbgK3FoT (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 30 Nov 2020 00:44:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgK3FoT (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 30 Nov 2020 00:44:19 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097FAC0613D2
        for <linux-hyperv@vger.kernel.org>; Sun, 29 Nov 2020 21:43:33 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id t3so9405093pgi.11
        for <linux-hyperv@vger.kernel.org>; Sun, 29 Nov 2020 21:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bdS70gXd6NjO8SbeScRYWAUs0FvLky5tBnpx1qPIKhg=;
        b=v0/iAOyYNNDCrOXv0Yl+FIoz5ptSm+333Uec0gAeGaU69pZ+FfMinBs02PIIWf0lpY
         i/p8JzzlUxVkyPd8+7VqjzK4GKPQ7cba81HNCWCCrMczZs9Vk2xMJ8GGEDlIbBnseQNC
         quf+iP3yMpZnbstOPZ1IVjN7BcFHUmDdQTR8n9hGxc3rMZgp4RR4BESMRNNbrC8UHkHX
         K5Dp6XAnMy9G5YRQcrfZ7aDAhbiZWS0qExr6TJGMB8QqY3r99K1lYwRaLWymyEplLK/D
         1RT9nmyBv5U8muMLfQpEm1S3o32zGqzuBNoR4kghsvep593XjE2lvT0GHKqOh0RROfd8
         KyOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bdS70gXd6NjO8SbeScRYWAUs0FvLky5tBnpx1qPIKhg=;
        b=MeO9swKZn1PlGDl4O32MEKptywe5yO1uXXgjKCBlCpvrHQdBgQoFby1FCIJwh74MVe
         xEFdrQKO8Af+oPmpg5APE25qN0WqO55tmxnu7dwrswUnfr7uKtHjYbPq4MMsJR1/ZUlM
         A8fsrqxwHBKIEw/ZHvBa0HMltF8oZXG3xepmvymayYth3NRvKBM95RWpBFrb5l+3+DPK
         XKEOu7lzsPgzwvfF8sh3pq6X/ZDMNQWaKYw+uPd9Tqg2JGm0oiLgesrfXtfm6Xa3bRWZ
         nMoaCJhFZVV316rULeqrN9kX8HrcBDk4zDQ5VAbDRZEAGd47DSqQyw5S/9AGaJRsa62m
         fQSA==
X-Gm-Message-State: AOAM531R7R/4tq6VDdEpHxuTdFxA4wp/rhK7++s1z0nnZKoBMFzQt4u3
        9ctvu58UYMfGp6pvUkF8MZLpZg==
X-Google-Smtp-Source: ABdhPJyAiIq9jWnDUWHukbS7FYdlKSkjk/g4ix3xqVXCFtBrFlXfw0RcPXQJGe7A++oybATvWwYsbw==
X-Received: by 2002:aa7:86d8:0:b029:18b:585b:3b16 with SMTP id h24-20020aa786d80000b029018b585b3b16mr16955307pfo.72.1606715012561;
        Sun, 29 Nov 2020 21:43:32 -0800 (PST)
Received: from hermes.local (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id nk11sm16135432pjb.26.2020.11.29.21.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Nov 2020 21:43:32 -0800 (PST)
Date:   Sun, 29 Nov 2020 21:43:28 -0800
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     "Michael Kelley" <mikelley@microsoft.com>
Cc:     "Matheus Castello" <matheus@castello.eng.br>, <wei.liu@kernel.org>,
        <joe@perches.com>, "KY Srinivasan" <kys@microsoft.com>,
        "Haiyang Zhang" <haiyangz@microsoft.com>,
        "Stephen Hemminger" <sthemmin@microsoft.com>, <sashal@kernel.org>,
        "Tianyu Lan" <Tianyu.Lan@microsoft.com>,
        "Dexuan Cui" <decui@microsoft.com>,
        "Sunil Muthuswamy" <sunilmut@microsoft.com>,
        <linux-hyperv@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/6] drivers: hv: vmbus: Fix checkpatch SPLIT_STRING
Message-ID: <20201129214328.254372dd@hermes.local>
In-Reply-To: <MW2PR2101MB105245D2BF9C9B5995D0188ED7F61@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20201125032926.17002-1-matheus@castello.eng.br>
        <MW2PR2101MB105245D2BF9C9B5995D0188ED7F61@MW2PR2101MB1052.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sun, 29 Nov 2020 08:51:47 -0800
"Michael Kelley" <mikelley@microsoft.com> wrote:

> From: Matheus Castello <matheus@castello.eng.br> Sent: Tuesday, November
> 24, 2020 7:29 PM
> > 
> > Checkpatch emits WARNING: quoted string split across lines.
> > To keep the code clean and with the 80 column length indentation the
> > check and registration code for kmsg_dump_register has been transferred
> > to a new function hv_kmsg_dump_register.
> > 
> > Signed-off-by: Matheus Castello <matheus@castello.eng.br>
> > ---
> > This is the V3 of patch 4 of the series "Add improvements suggested by
> > checkpatch for vmbus_drv" with the changes suggested by Michael Kelley  
> and
> > Joe Perches. Thanks!
> > ---
> >  drivers/hv/vmbus_drv.c | 35 ++++++++++++++++++++---------------
> >  1 file changed, 20 insertions(+), 15 deletions(-)
> > 
> > diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> > index 61d28c743263..edcc419ba328 100644
> > --- a/drivers/hv/vmbus_drv.c
> > +++ b/drivers/hv/vmbus_drv.c
> > @@ -1387,6 +1387,24 @@ static struct kmsg_dumper hv_kmsg_dumper = {
> >  	.dump = hv_kmsg_dump,
> >  };
> > 
> > +static void hv_kmsg_dump_register(void)
> > +{
> > +	int ret;
> > +
> > +	hv_panic_page = (void *)hv_alloc_hyperv_zeroed_page();

I know you just copy/pasted the original code, but one other thing.

Doesn't it already return void *?
arch/x86/include/asm/mshyperv.h:void *hv_alloc_hyperv_zeroed_page(void);

> > +	if (!hv_panic_page) {
> > +		pr_err("Hyper-V: panic message page memory allocation  
> failed\n");
> > +		return;
> > +	}
> > +
> > +	ret = kmsg_dump_register(&hv_kmsg_dumper);
> > +	if (ret) {
> > +		pr_err("Hyper-V: kmsg dump register error 0x%x\n", ret);
> > +		hv_free_hyperv_page((unsigned long)hv_panic_page);
> > +		hv_panic_page = NULL;
> > +	}
> > +}
> > +
> >  static struct ctl_table_header *hv_ctl_table_hdr;
> > 
> >  /*
> > @@ -1477,21 +1495,8 @@ static int vmbus_bus_init(void)
> >  		 * capability is supported by the hypervisor.
> >  		 */
> >  		hv_get_crash_ctl(hyperv_crash_ctl);
> > -		if (hyperv_crash_ctl & HV_CRASH_CTL_CRASH_NOTIFY_MSG) {
> > -			hv_panic_page = (void  
> *)hv_alloc_hyperv_zeroed_page();
> > -			if (hv_panic_page) {
> > -				ret = kmsg_dump_register(&hv_kmsg_dumper);
> > -				if (ret) {
> > -					pr_err("Hyper-V: kmsg dump  
> register "
> > -						"error 0x%x\n", ret);
> > -					hv_free_hyperv_page(
> > -					    (unsigned long)hv_panic_page);
> > -					hv_panic_page = NULL;
> > -				}
> > -			} else
> > -				pr_err("Hyper-V: panic message page memory  
> "
> > -					"allocation failed");
> > -		}
> > +		if (hyperv_crash_ctl & HV_CRASH_CTL_CRASH_NOTIFY_MSG)
> > +			hv_kmsg_dump_register();
> > 
> >  		register_die_notifier(&hyperv_die_block);
> >  	}
> > --
> > 2.29.2  
> 
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> 

