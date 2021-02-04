Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 948D730FA77
	for <lists+linux-hyperv@lfdr.de>; Thu,  4 Feb 2021 19:01:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238768AbhBDR56 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 4 Feb 2021 12:57:58 -0500
Received: from mail-wm1-f52.google.com ([209.85.128.52]:34435 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238234AbhBDR5Z (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 4 Feb 2021 12:57:25 -0500
Received: by mail-wm1-f52.google.com with SMTP id o10so6407220wmc.1;
        Thu, 04 Feb 2021 09:57:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9qa0Q6as6yv89x3GmsWvsZH1y46ZMh2uUbv+ovOA/44=;
        b=BkypIh7P8FKFgZXM1SmFtZ81ujzw8p/QmTA0/O3Qh1rW8WlwD6nWNHrtuj+KMB6KMW
         /jTJ3fWnuejgJX1xyIqECiQNZW0ArANemwbIZQTdSL34iyQIEJuIIIvqNifSRPB1BJ5K
         0ndawLW1Mz7T0LAxsG96NYUxMuuoWzsSrip55IFqcT6C6O1aZgq8dG2YHsPXXHLLH1Pn
         yf1Zb53Ju9jbp381uUwfxGYlxYiMr+LiXylG/V8Feau5/uzB1oALBoOwGJ7j0Pt0lReM
         aNLAgJU14Z+VMC/kfmWtvB3IuVlIYizSzcrY/VBoNeFnV/lcFQkfL4EBrhzCAR17/SbQ
         68pg==
X-Gm-Message-State: AOAM531mgLeKjZPQTWtx9kuVgMKDuqf69bEgPSdGbF6/f57zsllL3wst
        wxA+hlJp+jEpPe6nimmVuJw=
X-Google-Smtp-Source: ABdhPJxtTbtDfvGZetjXqClkxgzmnR7cmouqoXEfNgjaGpEC8905RtICYozojetmaRaMNXfuogUtDw==
X-Received: by 2002:a1c:7507:: with SMTP id o7mr289922wmc.165.1612461402824;
        Thu, 04 Feb 2021 09:56:42 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id t18sm8945483wrr.56.2021.02.04.09.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 09:56:42 -0800 (PST)
Date:   Thu, 4 Feb 2021 17:56:41 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        "pasha.tatashin@soleen.com" <pasha.tatashin@soleen.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v6 15/16] x86/hyperv: implement an MSI domain for root
 partition
Message-ID: <20210204175641.pzonxqrqlo7uvvze@liuwe-devbox-debian-v2>
References: <20210203150435.27941-1-wei.liu@kernel.org>
 <20210203150435.27941-16-wei.liu@kernel.org>
 <MWHPR21MB15932010E9CF5975EBAD1EDAD7B39@MWHPR21MB1593.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR21MB15932010E9CF5975EBAD1EDAD7B39@MWHPR21MB1593.namprd21.prod.outlook.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Feb 04, 2021 at 05:43:16PM +0000, Michael Kelley wrote:
[...]
> >  remove_cpuhp_state:
> > diff --git a/arch/x86/hyperv/irqdomain.c b/arch/x86/hyperv/irqdomain.c
> > new file mode 100644
> > index 000000000000..117f17e8c88a
> > --- /dev/null
> > +++ b/arch/x86/hyperv/irqdomain.c
> > @@ -0,0 +1,362 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +/*
> > + * for Linux to run as the root partition on Microsoft Hypervisor.
> 
> Nit:  Looks like the initial word "Irqdomain" got dropped from the above
> comment line.  But don't respin just for this.
> 

I've added it back. Thanks.

> > +static int hv_map_interrupt(union hv_device_id device_id, bool level,
> > +		int cpu, int vector, struct hv_interrupt_entry *entry)
> > +{
> > +	struct hv_input_map_device_interrupt *input;
> > +	struct hv_output_map_device_interrupt *output;
> > +	struct hv_device_interrupt_descriptor *intr_desc;
> > +	unsigned long flags;
> > +	u64 status;
> > +	cpumask_t mask = CPU_MASK_NONE;
> > +	int nr_bank, var_size;
> > +
> > +	local_irq_save(flags);
> > +
> > +	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
> > +	output = *this_cpu_ptr(hyperv_pcpu_output_arg);
> > +
> > +	intr_desc = &input->interrupt_descriptor;
> > +	memset(input, 0, sizeof(*input));
> > +	input->partition_id = hv_current_partition_id;
> > +	input->device_id = device_id.as_uint64;
> > +	intr_desc->interrupt_type = HV_X64_INTERRUPT_TYPE_FIXED;
> > +	intr_desc->vector_count = 1;
> > +	intr_desc->target.vector = vector;
> > +
> > +	if (level)
> > +		intr_desc->trigger_mode = HV_INTERRUPT_TRIGGER_MODE_LEVEL;
> > +	else
> > +		intr_desc->trigger_mode = HV_INTERRUPT_TRIGGER_MODE_EDGE;
> > +
> > +	cpumask_set_cpu(cpu, &mask);
> > +	intr_desc->target.vp_set.valid_bank_mask = 0;
> > +	intr_desc->target.vp_set.format = HV_GENERIC_SET_SPARSE_4K;
> > +	nr_bank = cpumask_to_vpset(&(intr_desc->target.vp_set), &mask);
> 
> There's a function get_cpu_mask() that returns a pointer to a cpumask with only
> the specified cpu set in the mask.  It returns a const pointer to the correct entry
> in a pre-allocated array of all such cpumasks, so it's a lot more efficient than
> allocating and initializing a local cpumask instance on the stack.
> 

That's nice.

I've got the following diff to fix both issues. If you're happy with the
changes, can you give your Reviewed-by? That saves a round of posting.

diff --git a/arch/x86/hyperv/irqdomain.c b/arch/x86/hyperv/irqdomain.c
index 0cabc9aece38..fa71db798465 100644
--- a/arch/x86/hyperv/irqdomain.c
+++ b/arch/x86/hyperv/irqdomain.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0

 /*
- * for Linux to run as the root partition on Microsoft Hypervisor.
+ * Irqdomain for Linux to run as the root partition on Microsoft Hypervisor.
  *
  * Authors:
  *  Sunil Muthuswamy <sunilmut@microsoft.com>
@@ -20,7 +20,7 @@ static int hv_map_interrupt(union hv_device_id device_id, bool level,
        struct hv_device_interrupt_descriptor *intr_desc;
        unsigned long flags;
        u64 status;
-       cpumask_t mask = CPU_MASK_NONE;
+       const cpumask_t *mask;
        int nr_bank, var_size;

        local_irq_save(flags);
@@ -41,10 +41,10 @@ static int hv_map_interrupt(union hv_device_id device_id, bool level,
        else
                intr_desc->trigger_mode = HV_INTERRUPT_TRIGGER_MODE_EDGE;

-       cpumask_set_cpu(cpu, &mask);
+       mask = cpumask_of(cpu);
        intr_desc->target.vp_set.valid_bank_mask = 0;
        intr_desc->target.vp_set.format = HV_GENERIC_SET_SPARSE_4K;
-       nr_bank = cpumask_to_vpset(&(intr_desc->target.vp_set), &mask);
+       nr_bank = cpumask_to_vpset(&(intr_desc->target.vp_set), mask);
        if (nr_bank < 0) {
                local_irq_restore(flags);
                pr_err("%s: unable to generate VP set\n", __func__);
