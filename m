Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC7B2EC07B
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 Jan 2021 16:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbhAFPgH (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 6 Jan 2021 10:36:07 -0500
Received: from mail-wr1-f42.google.com ([209.85.221.42]:46526 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbhAFPgH (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 6 Jan 2021 10:36:07 -0500
Received: by mail-wr1-f42.google.com with SMTP id d13so2762010wrc.13;
        Wed, 06 Jan 2021 07:35:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5wCpaYTXc1DTEy50SRBqT/5oaJ4kJbKZj5sevS6a4ng=;
        b=on6fvsWBLq0WxjNHsSeI3AXrAOGEhVYRGjGN80YFbuUW/cIgPRT0n5DadcO9lgT41A
         ts250n0PDVGutJtTx7UW4QDairE3kD8MyiUmwd03urKzjIqBaRD0RfujuB37zD06MA0s
         I/h1SXTURbQvdA4wAiA/mAlERKNPc3uqb2VtcutzhU3qfLDymT1WDOESsRyPs2SiD97L
         uZUw8aZLwMXeoWHWHGTLQvOVkG898tcUaWVPXgX4IccvZrq5cQfCeRNAzc52zMvLzjWt
         1egK84XCuXbTLoPSYX9G3BqkqpXhPMWPafUBrvEA7JjOvHCvC0hg2Adq6s77j95APYZP
         TH7g==
X-Gm-Message-State: AOAM531Kw13v/BcRicQNiwWbk1MAienQ1txpm3NUYCr8WVsiquHTFBA/
        5UwXcEawlT2Sb0jJM7vqcsA=
X-Google-Smtp-Source: ABdhPJzZRUFn7Hds/BJh3z+Q52yp5rmShwWSJU94kZ3DC5JcOHdsGKv1JFrGbob5lCG7cz/iEGy7LQ==
X-Received: by 2002:adf:f590:: with SMTP id f16mr4991330wro.40.1609947325228;
        Wed, 06 Jan 2021 07:35:25 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id h9sm3497210wre.24.2021.01.06.07.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 07:35:24 -0800 (PST)
Date:   Wed, 6 Jan 2021 15:35:23 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Sunil Muthuswamy <sunilmut@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Matheus Castello <matheus@castello.eng.br>,
        KY Srinivasan <kys@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <liuwe@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH v2] x86/Hyper-V: Support for free page reporting
Message-ID: <20210106153523.nbnrkp4papebxqwy@liuwe-devbox-debian-v2>
References: <SN4PR2101MB08800F9A2F6961A05DAEAE4BC0D19@SN4PR2101MB0880.namprd21.prod.outlook.com>
 <87v9cagpor.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v9cagpor.fsf@vitty.brq.redhat.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Jan 06, 2021 at 02:28:20PM +0100, Vitaly Kuznetsov wrote:
[...]
> 
> > +bool hv_query_ext_cap(u64 cap_query)
> > +{
> > +	u64 *cap;
> > +	unsigned long flags;
> > +	u64 ext_cap = 0;
> > +
> > +	/*
> > +	 * Querying extended capabilities is an extended hypercall. Check if the
> > +	 * partition supports extended hypercall, first.
> > +	 */
> > +	if (!(ms_hyperv.priv_high & HV_ENABLE_EXTENDED_HYPERCALLS))
> > +		return 0;
> > +
> > +	/*
> > +	 * Repurpose the input page arg to accept output from Hyper-V for
> > +	 * now because this is the only call that needs output from the
> > +	 * hypervisor. It should be fixed properly by introducing an
> > +	 * output arg once we have more places that require output.
> > +	 */
> 
> I remember there was a patch from Wei (realter to running Linux as root
> partition) doing the job, we can probably merge it early to avoid this
> re-purposing.
> 

We want to be frugal regarding memory usage, so in my patch the output
page is only allocated when Linux is running as the root partition.

This patch is mostly only useful when Linux is running as a child
partition. This is a different use case.

Wei.
