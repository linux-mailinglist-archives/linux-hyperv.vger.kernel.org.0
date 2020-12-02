Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28D962CBC1E
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Dec 2020 12:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgLBLzs (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Dec 2020 06:55:48 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44132 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbgLBLzs (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Dec 2020 06:55:48 -0500
Received: by mail-wr1-f67.google.com with SMTP id 64so3523687wra.11;
        Wed, 02 Dec 2020 03:55:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gFwDdijdfZXw9pgLlpOsSk7GU0YwZboaXWl7s3vdJ1g=;
        b=CGy3UA1Koo63bCpqBoS3Ujh4k2+Ya1Tpx6ftSSWdShCwax3j2fSAjpy0BLPGU5mG6z
         HglqHRxuywTWmAmqpczrMXa5YbDEZdje2NfZitbfsyCBBuLPXtiPv86qahilqLa+cbIa
         2L8ghLwYbDN8yZjL9fv/hkErR5Hxy6nWYnm3PEVt7yxuHasdx6ntd+4G+MTiPcLffFZM
         Ef6Quorz0KeS0ow1LQtlsZVmjkGZuZtF/4kI9CvqzmSAtBDPHS9XzqLDhvXLi1I9SCJM
         HqSOpbVBA+0th+t861/9Ckcd66nNMNLi9kFbwOAGJt+XbQVsqveSQqj/MmLVTPjYzGfX
         DfQw==
X-Gm-Message-State: AOAM53031mTomJuMdrjEJJOa8mmqiRWpNWrm4E+k7O9NzIl2iJ1cB544
        B+v+TBbzPWD91mI7P58IOVvNczXTk+A=
X-Google-Smtp-Source: ABdhPJz6L3WR4Agb08ZXO2ntujV+zGhkzAm9gZxK87sm4Tfcu32A9coFHnrp9jWwPUFWrktDdTitBQ==
X-Received: by 2002:a5d:4c4d:: with SMTP id n13mr3022501wrt.356.1606910106876;
        Wed, 02 Dec 2020 03:55:06 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id l8sm1768437wro.46.2020.12.02.03.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 03:55:06 -0800 (PST)
Date:   Wed, 2 Dec 2020 11:55:04 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Stephen Hemminger <stephen@networkplumber.org>
Cc:     Michael Kelley <mikelley@microsoft.com>,
        Matheus Castello <matheus@castello.eng.br>, wei.liu@kernel.org,
        joe@perches.com, KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>, sashal@kernel.org,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/6] drivers: hv: vmbus: Fix checkpatch SPLIT_STRING
Message-ID: <20201202115504.w52yeixpg7nbzw2v@liuwe-devbox-debian-v2>
References: <20201125032926.17002-1-matheus@castello.eng.br>
 <MW2PR2101MB105245D2BF9C9B5995D0188ED7F61@MW2PR2101MB1052.namprd21.prod.outlook.com>
 <20201129214328.254372dd@hermes.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201129214328.254372dd@hermes.local>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sun, Nov 29, 2020 at 09:43:28PM -0800, Stephen Hemminger wrote:
> On Sun, 29 Nov 2020 08:51:47 -0800
> "Michael Kelley" <mikelley@microsoft.com> wrote:
> 
> > From: Matheus Castello <matheus@castello.eng.br> Sent: Tuesday, November
> > 24, 2020 7:29 PM
> > > 
> > > Checkpatch emits WARNING: quoted string split across lines.
> > > To keep the code clean and with the 80 column length indentation the
> > > check and registration code for kmsg_dump_register has been transferred
> > > to a new function hv_kmsg_dump_register.
> > > 
> > > Signed-off-by: Matheus Castello <matheus@castello.eng.br>
> > > ---
> > > This is the V3 of patch 4 of the series "Add improvements suggested by
> > > checkpatch for vmbus_drv" with the changes suggested by Michael Kelley  
> > and
> > > Joe Perches. Thanks!
> > > ---
> > >  drivers/hv/vmbus_drv.c | 35 ++++++++++++++++++++---------------
> > >  1 file changed, 20 insertions(+), 15 deletions(-)
> > > 
> > > diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> > > index 61d28c743263..edcc419ba328 100644
> > > --- a/drivers/hv/vmbus_drv.c
> > > +++ b/drivers/hv/vmbus_drv.c
> > > @@ -1387,6 +1387,24 @@ static struct kmsg_dumper hv_kmsg_dumper = {
> > >  	.dump = hv_kmsg_dump,
> > >  };
> > > 
> > > +static void hv_kmsg_dump_register(void)
> > > +{
> > > +	int ret;
> > > +
> > > +	hv_panic_page = (void *)hv_alloc_hyperv_zeroed_page();
> 
> I know you just copy/pasted the original code, but one other thing.
> 
> Doesn't it already return void *?
> arch/x86/include/asm/mshyperv.h:void *hv_alloc_hyperv_zeroed_page(void);

Good catch.

I have amended this patch and applied it to hyperv-next.

Wei.
