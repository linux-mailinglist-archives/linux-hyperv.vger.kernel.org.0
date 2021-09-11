Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF868407906
	for <lists+linux-hyperv@lfdr.de>; Sat, 11 Sep 2021 17:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbhIKPZm (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 11 Sep 2021 11:25:42 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:37512 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbhIKPZm (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 11 Sep 2021 11:25:42 -0400
Received: by mail-wr1-f43.google.com with SMTP id t8so2225096wrq.4;
        Sat, 11 Sep 2021 08:24:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CAiPuDJAAVYjx3qqXgXVw9eLdaUeuisrPgsvTgrXXpg=;
        b=keAV9UTFqGKutiCY04kAlxKXLQoFNI+FMXnwRlKGao7WUcZHj7H6zb9eKWTecig5ZO
         /vHzdjhgV9bXcc4xO/ZoqK/auLI3i2h2dnhJECNGiktavV805aRYBgYLE9Owru5kR8aS
         KgebCaJGGNiKTjHmmGNx53YN4H8tBqQ1c9+3mIEeVPWSSZXgjBODoqJBnm76Lpx6r5fc
         49A61RRV6gBv/bdIaWoPJU9r0XuPxXtyxdkvUFu3nkd9g6SwmybDb7YSQT/wT74hBIKa
         kmon5Jppz8jK2avBnqf4ssQtiytEpvPBvsG3FOnCH8Lpo6Hk83gRRdU9I32MgucWRtIj
         6U7Q==
X-Gm-Message-State: AOAM5314pJ99Nb6LZCZzDCc0SCOYnDnNcwvBVU6psuH20tvhFl6+p3gQ
        kwgq9qewZoxYLbprajeTFb0gkfAEjK8=
X-Google-Smtp-Source: ABdhPJyrxF8X1ATjpv4AqR4FS8TolIyCBzN6ZGe4sEA5BO4XFqlkB5sD2qhFDtkkkpfAheFzVHPS6A==
X-Received: by 2002:a5d:404b:: with SMTP id w11mr3555259wrp.437.1631373868609;
        Sat, 11 Sep 2021 08:24:28 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id y1sm1897003wmq.43.2021.09.11.08.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 08:24:28 -0700 (PDT)
Date:   Sat, 11 Sep 2021 15:24:26 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] x86/hyperv: remove on-stack cpumask from
 hv_send_ipi_mask_allbutself
Message-ID: <20210911152426.gq34cigqteqvzms2@liuwe-devbox-debian-v2>
References: <20210910185714.299411-1-wei.liu@kernel.org>
 <20210910185714.299411-3-wei.liu@kernel.org>
 <MWHPR21MB1593DE9DE0A474E2539FFD1BD7D79@MWHPR21MB1593.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR21MB1593DE9DE0A474E2539FFD1BD7D79@MWHPR21MB1593.namprd21.prod.outlook.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sat, Sep 11, 2021 at 03:09:50PM +0000, Michael Kelley wrote:
> From: Wei Liu <wei.liu@kernel.org> Sent: Friday, September 10, 2021 11:57 AM
[...]
> > -static bool __send_ipi_mask(const struct cpumask *mask, int vector)
> > +static bool __send_ipi_mask(const struct cpumask *mask, int vector,
> > +		bool exclude_self)
> >  {
> > -	int cur_cpu, vcpu;
> > +	int cur_cpu, vcpu, this_cpu = smp_processor_id();
> >  	struct hv_send_ipi ipi_arg;
> >  	u64 status;
> > +	unsigned int weight;
> > 
> >  	trace_hyperv_send_ipi_mask(mask, vector);
> > 
> > -	if (cpumask_empty(mask))
> > +	weight = cpumask_weight(mask);
> > +
> > +	/*
> > +	 * Do nothing if
> > +	 *   1. the mask is empty
> > +	 *   2. the mask only contains self when exclude_self is true
> > +	 */
> > +	if (weight == 0 ||
> > +	    (exclude_self && weight == 1 && cpumask_first(mask) == this_cpu))
> 
> Nit:  cpumask_test_cpu(this_cpu, mask) would seem to be a better fit for this
> use case than cpumask_first().  But either works.

I will adjust the code when I commit this patch.

Wei.
