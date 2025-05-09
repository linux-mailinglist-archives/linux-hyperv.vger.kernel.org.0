Return-Path: <linux-hyperv+bounces-5445-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CE3AB1943
	for <lists+linux-hyperv@lfdr.de>; Fri,  9 May 2025 17:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB9DBA26B7D
	for <lists+linux-hyperv@lfdr.de>; Fri,  9 May 2025 15:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3914230BFC;
	Fri,  9 May 2025 15:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dPN+BgY9"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D50323182E;
	Fri,  9 May 2025 15:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746805801; cv=none; b=UJnRHnGHYzyYIhVJt2Mu+Dqx/BWTTBaFrHyGvCHm6gMOeBrypIE9WetvwKhqCGjF0zYSyqfOI9nixU0TwLMxvKAywzTpg86P0xIP6XvRnuREAWTzzANBK02XQ4Tf5YLLF5aOEFGgVyQgz9x1YZdqo1Ot3n8p9nDfrG4EmhIW7pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746805801; c=relaxed/simple;
	bh=zQ1c+z3DU2vCiy7RW7edMeE1/mWOk8neFuh84o59zlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ixjCNH43NgE3GzO3LhXlPCjCV5kW7XNf7jKgjRGNCwEGbfZtZTZR8e5n4IISxD4STOjTSA8KNG0+4N8NcVI0k9Nj+4PDCL7P+wpzUgi690f1CdQwIuZq0pAGoAoXa7ET9iwl2CA9jjNy9UsOKyBLn1E32R2aRTYDoShNZfpOyd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dPN+BgY9; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7423fb98cb1so703155b3a.3;
        Fri, 09 May 2025 08:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746805799; x=1747410599; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6qJxB7qnX5LFLqWFBhUK9DfojI/2BwlgTRn1G+RNsSs=;
        b=dPN+BgY9xLlECYCT6MN9yPd7Wq+GJK+mKCp2qxNxvisCIZldhTDi1LItRogcTnyFKx
         xXeDTLUGcx8SR2gPZwB5WEqg+cJd90ToGass2zj5olThOgVtP4+lGfMamyuh/rcIa2pw
         alyMKaOiOAGDW1Qei4aS+LcaRuzjUA+BXpHWlNBRI2B0qzz0LO7v62KJZTVn4QTJaqbm
         atyBZA4qcXlNHHl+xakCHa0J/C8SZQonKNi63OAAWpKMWBzZr1z8odDPW2EGySsBe14F
         XPBU316xicW6KhoSZbm2zGcWnlcEXqDsCBmMoaptY5yE2GDQFuwWi8YHP0N9uscgFSIs
         hilA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746805799; x=1747410599;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6qJxB7qnX5LFLqWFBhUK9DfojI/2BwlgTRn1G+RNsSs=;
        b=MviphyIpmtLX8QMo0lfMKNbQz+qy3uX/k3PSntXWSGdwvcu9NRXO2b8i8bUA/OZ0Tj
         4QZK66UFFnwbBhv9Q6YrjSUDN0jIFyx97AAKOaWAbaVzuWjADEm7AZa/t7jEDYAf/IUy
         9guW1o0bcU7uMVqndPKYFGXPba+uSVlYJvNczH3Y+K6pPEbkxHF+ffRNsQvxJOjWPbJQ
         tboQEo7HE6wZECeK1gbgrMgAZzEpDr0Y2d6FQoI3bGZXm/FKuFdMDFvVQfla+jLmPeMV
         GK6s/fLhfAJai6vdw9W65EFUm4jZigJcnU1VrxJ6koZSycb0BRARoj3pqjeMO8GhZT4b
         YHtw==
X-Forwarded-Encrypted: i=1; AJvYcCUWy2h7OpMFK241PC6w1V4BNMUHKUx/BEPW0QDaYkV4AR65H1TRBvywHemFZU6V6GUXVRHa1sXHY7wzaA==@vger.kernel.org, AJvYcCUYOtKrTMlCELVcudSN9Bs0aYq8fYPkWDFC+EsxqRubhN3bYBeFcnsdHE2KgJBSPyvBSffcHkyHjFniHVY=@vger.kernel.org, AJvYcCVdF8IXEko5J4037Rc3X3njGQqf6w9jVROsYNz01gh1c3CQIUghLWzH4eSo3db3sXsxGKRVcOb2M6X4t9rq@vger.kernel.org, AJvYcCWUGWoAWTZpENUsHx8yLygSlBPKVsAmLH1aGMXjORYIIi0QHKomhjzaos9f9k4pqgSCjF6p26dC@vger.kernel.org, AJvYcCWpp9TjUPvStyv/r6I7Yvu7NyRZR//RtcgzV8Od9VKj52KJSQo7Rh2dmUI2uaRWwZ4ER5SXZlB4SILF@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt8O1ZjqM+B4btg+fjcsYwJxXhIjuohUR17O7KO1xWqjAUvRXq
	/26a2cxyCP+/RglF0NZTvqsFhOe4Ofl7BpNcs0xgrexXi8X4/rmv
X-Gm-Gg: ASbGncv3yK2xLMdTrxwDKM/7rCj6On1dk1hWZqc2mT2HUey7whvuJLnhyM7+OPtsgcX
	LgLMY60RtL2SDH0KSHu/HMXfo1pd7hI0M4E2YEFWS/uBHFY3UImeJb+hWvSugig/+Aii0+3PjsV
	Gc6wwkDj6NkHOEt3Lhb7knib/KQBHm41oZYlJOj+eWHeeTjm3CKHA0ROz0ADFz+re2oHGpd4A9l
	CNTU8HDYOrDfVETUoCU3a+Nl2roOcjxkQ9sQ8gnA0EL93iZMwRCMqvTxCXDrDwZ+BW1qDDW0jib
	JvR4DXoTknUx9SjXJ8jXSk+OD2rx2WsECVdmbU5W
X-Google-Smtp-Source: AGHT+IFIh0uHRzJCT7/GnkTq7w++wVD/1lCTkum2tABfnk4IkfODFcEQ0pNzHdqudOyEjI24/Mih9A==
X-Received: by 2002:a17:903:1787:b0:216:393b:23d4 with SMTP id d9443c01a7336-22fc8b193ebmr64273025ad.11.1746805799099;
        Fri, 09 May 2025 08:49:59 -0700 (PDT)
Received: from localhost ([216.228.127.129])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc7741d9fsm18904205ad.81.2025.05.09.08.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 08:49:58 -0700 (PDT)
Date: Fri, 9 May 2025 11:49:56 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Simon Horman <horms@kernel.org>, Leon Romanovsky <leon@kernel.org>,
	Maxim Levitsky <mlevitsk@redhat.com>,
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	Peter Zijlstra <peterz@infradead.org>, linux-hyperv@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Nipun Gupta <nipun.gupta@amd.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan Cameron <Jonathan.Cameron@huwei.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Kevin Tian <kevin.tian@intel.com>, Long Li <longli@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=EF=BF=BD~Dski?= <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, Paul Rosswurm <paulros@microsoft.com>,
	Shradha Gupta <shradhagupta@microsoft.com>
Subject: Re: [PATCH v3 3/4] net: mana: Allow irq_setup() to skip cpus for
 affinity
Message-ID: <aB4kJNG2duAsP8bK@yury>
References: <1746785566-4337-1-git-send-email-shradhagupta@linux.microsoft.com>
 <1746785625-4753-1-git-send-email-shradhagupta@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1746785625-4753-1-git-send-email-shradhagupta@linux.microsoft.com>

On Fri, May 09, 2025 at 03:13:45AM -0700, Shradha Gupta wrote:
> In order to prepare the MANA driver to allocate the MSI-X IRQs
> dynamically, we need to prepare the irq_setup() to allow skipping
> affinitizing IRQs to first CPU sibling group.
> 
> This would be for cases when number of IRQs is less than or equal
> to number of online CPUs. In such cases for dynamically added IRQs
> the first CPU sibling group would already be affinitized with HWC IRQ
> 
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
>  drivers/net/ethernet/microsoft/mana/gdma_main.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> index 4ffaf7588885..2de42ce43373 100644
> --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> @@ -1288,7 +1288,8 @@ void mana_gd_free_res_map(struct gdma_resource *r)
>  	r->size = 0;
>  }
>  
> -static int irq_setup(unsigned int *irqs, unsigned int len, int node)
> +static int irq_setup(unsigned int *irqs, unsigned int len, int node,
> +		     bool skip_first_cpu)
>  {
>  	const struct cpumask *next, *prev = cpu_none_mask;
>  	cpumask_var_t cpus __free(free_cpumask_var);
> @@ -1303,9 +1304,20 @@ static int irq_setup(unsigned int *irqs, unsigned int len, int node)
>  		while (weight > 0) {
>  			cpumask_andnot(cpus, next, prev);
>  			for_each_cpu(cpu, cpus) {
> +				/*
> +				 * if the CPU sibling set is to be skipped we
> +				 * just move on to the next CPUs without len--
> +				 */
> +				if (unlikely(skip_first_cpu)) {
> +					skip_first_cpu = false;
> +					goto next_cpumask;
> +				}
> +
>  				if (len-- == 0)
>  					goto done;
> +
>  				irq_set_affinity_and_hint(*irqs++, topology_sibling_cpumask(cpu));
> +next_cpumask:
>  				cpumask_andnot(cpus, cpus, topology_sibling_cpumask(cpu));
>  				--weight;
>  			}
> @@ -1403,7 +1415,7 @@ static int mana_gd_setup_irqs(struct pci_dev *pdev)
>  		}
>  	}
>  
> -	err = irq_setup(irqs, (nvec - start_irq_index), gc->numa_node);
> +	err = irq_setup(irqs, (nvec - start_irq_index), gc->numa_node, false);

What for the 2nd parameter is parenthesized?

>  	if (err)
>  		goto free_irq;
>  
> -- 
> 2.34.1


Reviewed-by: Yury Norov [NVIDIA] <yury.norov@gmail.com>

