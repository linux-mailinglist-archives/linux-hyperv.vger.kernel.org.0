Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF1C72B1E20
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Nov 2020 16:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgKMPFs (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 13 Nov 2020 10:05:48 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40943 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbgKMPFs (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 13 Nov 2020 10:05:48 -0500
Received: by mail-wm1-f66.google.com with SMTP id a3so8751627wmb.5;
        Fri, 13 Nov 2020 07:05:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bVaU10leUNBpSZ8QLekWuqLmBxn7RuMG1m+hwrLuz6g=;
        b=orWZs6ro18hpOjpeQeq74jyJDjhRWpehrf9Y5a0oNqXW23q4EFC8E4IQCxP0M3ndFw
         P8JOrKsQEdnkt6blk6TN72nqPJKI1FyzdR/nVm5nIJxgRcVxBpk2fphLrKaVDmqJ6p/h
         x7vzCD4HlSqxea8BivJ37LEj6cfX8WosY+tuTgKhwIg3PFvCGTdCyqANi81F0uJdLDUA
         39Bw2locTn2YlpESC1cHoW0nmISdMND0MeJFqr9JMUxKLkR9Zzp+IDnTh0lnC2CFZ8iv
         MaV7VYjr58xmB8e33etf/SM0S2KB7nT+3oxlYB5FOUBN0qnHrvoB9gRdMmBRprT9OkV2
         tU9A==
X-Gm-Message-State: AOAM533IhOohGzUw7YVB7uc5RoRLy9AiZHBqvBGSCigi1S6El8o/YXfK
        EPoWRo5/9Qwuu+DxiG+JwWw=
X-Google-Smtp-Source: ABdhPJyt09W3jXfPJxn0KjzPJUsp/JJ3bB4BaSGATWAC3rkRQ65MiVyRh5JtcpvI5BLhcx5njZISfw==
X-Received: by 2002:a1c:7e8e:: with SMTP id z136mr3108670wmc.46.1605279946339;
        Fri, 13 Nov 2020 07:05:46 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id q12sm9984512wrx.86.2020.11.13.07.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 07:05:45 -0800 (PST)
Date:   Fri, 13 Nov 2020 15:05:44 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        Lillian Grassin-Drake <ligrassi@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 06/17] x86/hyperv: allocate output arg pages if
 required
Message-ID: <20201113150544.drm4qk4jlchewukg@liuwe-devbox-debian-v2>
References: <20201105165814.29233-1-wei.liu@kernel.org>
 <20201105165814.29233-7-wei.liu@kernel.org>
 <87a6vmy4dn.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a6vmy4dn.fsf@vitty.brq.redhat.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Nov 12, 2020 at 04:35:48PM +0100, Vitaly Kuznetsov wrote:
> Wei Liu <wei.liu@kernel.org> writes:
[...]
> > @@ -209,14 +219,23 @@ static int hv_cpu_die(unsigned int cpu)
> >  	unsigned int new_cpu;
> >  	unsigned long flags;
> >  	void **input_arg;
> > -	void *input_pg = NULL;
> > +	void *pg;
> >  
> >  	local_irq_save(flags);
> >  	input_arg = (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
> > -	input_pg = *input_arg;
> > +	pg = *input_arg;
> >  	*input_arg = NULL;
> > +
> > +	if (hv_root_partition) {
> > +		void **output_arg;
> > +
> > +		output_arg = (void **)this_cpu_ptr(hyperv_pcpu_output_arg);
> > +		*output_arg = NULL;
> > +	}
> > +
> >  	local_irq_restore(flags);
> > -	free_page((unsigned long)input_pg);
> > +
> > +	free_page((unsigned long)pg);
> >  
> 
> Hm, but in case we've allocated output_arg, don't we need to do
> 	free_pages((unsigned long)pg, 1);
> 
> instead?

Indeed. This has been fixed with:

    free_pages((unsigned long)pg, hv_root_partition ? 1 : 0);

Wei.
