Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 943712EC0EB
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 Jan 2021 17:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbhAFQPr (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 6 Jan 2021 11:15:47 -0500
Received: from mail-wr1-f47.google.com ([209.85.221.47]:42412 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbhAFQPr (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 6 Jan 2021 11:15:47 -0500
Received: by mail-wr1-f47.google.com with SMTP id m5so2915465wrx.9;
        Wed, 06 Jan 2021 08:15:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9He6jPJxRFTTvUrsnfpcbjQnWILgJ4UyfmuL9wRJpCQ=;
        b=FmornEswhCvefraLLzWn5dDCjVEOqHvFrU6kQ2vIGklaN1GFtjGQhd5n31wt1e5G3K
         hzCROOhV91a9gHomV2LfG452XxX/4xXIayDw0Il9NdLmX7PHHpAb5qUjhhiPKsjGvnUw
         rGes7Nma96svLRmpTvYJZEMJfl5IXuwt90vP+kw1WCYQpj/XXzywFyUV4qqQ9+DCtynZ
         KK3xcKO6BSg7FwxbNrRjtXDJLc+5zel2Sn/KYD0/+kw0pm4IGk+IzGNhLS72oP973+Uw
         33JVVV6vL4VVQgT5F0By4+ZF399e/EkwXktO6oEpK5bev/dEOEAjKVJov2o26kXB3SZB
         oQhg==
X-Gm-Message-State: AOAM531f6MaTznybfM/nd4lPk05lDAvdywCth1FHmEql52AN29NztNPt
        aRCXsRnkxJ49SpFlITkZeI8=
X-Google-Smtp-Source: ABdhPJzwPmMjS8iIg10fLcStLvOWOqM327f5LtwDdXPnmZ4ahwwLOskaewaFoEWIc0/WW2/jldvaiw==
X-Received: by 2002:adf:e60f:: with SMTP id p15mr4947541wrm.60.1609949705377;
        Wed, 06 Jan 2021 08:15:05 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id t16sm3954455wmi.3.2021.01.06.08.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 08:15:05 -0800 (PST)
Date:   Wed, 6 Jan 2021 16:15:03 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Matheus Castello <matheus@castello.eng.br>,
        KY Srinivasan <kys@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <liuwe@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>
Subject: Re: [PATCH v2] x86/Hyper-V: Support for free page reporting
Message-ID: <20210106161503.datosn5uopcz2lwi@liuwe-devbox-debian-v2>
References: <SN4PR2101MB08800F9A2F6961A05DAEAE4BC0D19@SN4PR2101MB0880.namprd21.prod.outlook.com>
 <87v9cagpor.fsf@vitty.brq.redhat.com>
 <20210106153523.nbnrkp4papebxqwy@liuwe-devbox-debian-v2>
 <87pn2igi2h.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pn2igi2h.fsf@vitty.brq.redhat.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Jan 06, 2021 at 05:12:54PM +0100, Vitaly Kuznetsov wrote:
> Wei Liu <wei.liu@kernel.org> writes:
> 
> > On Wed, Jan 06, 2021 at 02:28:20PM +0100, Vitaly Kuznetsov wrote:
> > [...]
> >> 
> >> > +bool hv_query_ext_cap(u64 cap_query)
> >> > +{
> >> > +	u64 *cap;
> >> > +	unsigned long flags;
> >> > +	u64 ext_cap = 0;
> >> > +
> >> > +	/*
> >> > +	 * Querying extended capabilities is an extended hypercall. Check if the
> >> > +	 * partition supports extended hypercall, first.
> >> > +	 */
> >> > +	if (!(ms_hyperv.priv_high & HV_ENABLE_EXTENDED_HYPERCALLS))
> >> > +		return 0;
> >> > +
> >> > +	/*
> >> > +	 * Repurpose the input page arg to accept output from Hyper-V for
> >> > +	 * now because this is the only call that needs output from the
> >> > +	 * hypervisor. It should be fixed properly by introducing an
> >> > +	 * output arg once we have more places that require output.
> >> > +	 */
> >> 
> >> I remember there was a patch from Wei (realter to running Linux as root
> >> partition) doing the job, we can probably merge it early to avoid this
> >> re-purposing.
> >> 
> >
> > We want to be frugal regarding memory usage, so in my patch the output
> > page is only allocated when Linux is running as the root partition.
> >
> > This patch is mostly only useful when Linux is running as a child
> > partition. This is a different use case.
> 
> Well, yea, while one 4k page per CPU is probably not much, why
> allocating something we don't really need? The whole 're-purposing' idea
> comes from the misleading 'hyperv_pcpu_input_arg' name, which can be
> just 'hyperv_pcpu_arg' (and we can allocate two pages for root
> partition).

Yes. We can simply renamed it in the future.

Wei.

> 
> All this is not a big deal, we can take a look again after root
> partition support lands and do some cleanup if needed.
> 
> -- 
> Vitaly
> 
