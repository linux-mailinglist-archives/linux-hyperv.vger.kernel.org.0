Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F79630C7E7
	for <lists+linux-hyperv@lfdr.de>; Tue,  2 Feb 2021 18:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237586AbhBBRer (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 2 Feb 2021 12:34:47 -0500
Received: from mail-wm1-f51.google.com ([209.85.128.51]:52535 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236422AbhBBRcg (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 2 Feb 2021 12:32:36 -0500
Received: by mail-wm1-f51.google.com with SMTP id l12so2164360wmq.2;
        Tue, 02 Feb 2021 09:32:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AxHa8gVy5I8JiheSXEMxWWe4GAPhI1nPaKd06/laDjc=;
        b=XG4rjlGEVQwBFRztp83ZOkNVJI60AQYsPXRLAk23PWfQG9c67AuMMK/qq6hLsQR04u
         LBCen1n3Wq9H51hQbLmUDBGmWfEp9ey/y41hIxfxhvDqCZgvZJBR9IMChz9p2OEsnrz5
         PkU8ySiO0RooO+EhMf8H6A3LZtvvkMt7PTatn8F0RmYfK7fK9cl2hzQF3E1OeUGAQwpW
         L6HbpEnLzu4aZYQAUfWVcXzj9QDizwZyNnKNXhYNWM+gH2zbduBgiXiY1O6pzTlApc0t
         rPACRfL/tK87CUv7OCjlyzSg07gz9TUP7gynXBBy3iWBJY5a/UMxO31QZ5vONWP1Mpys
         GFNA==
X-Gm-Message-State: AOAM533F2qAZ0EPW/b4hbPZWKPrn2KwY+fxfNAsQX94mdcY5RgyJKTUL
        P3g3NAy5QfDyRke5zgo1x7Y=
X-Google-Smtp-Source: ABdhPJzudy9fk3s3hULrbLTuN8gEKplHol+8bC7aGvTzi86KznKqg49/MlQHqXZRMrG2RstBZmQcFQ==
X-Received: by 2002:a1c:25c2:: with SMTP id l185mr4649522wml.62.1612287115021;
        Tue, 02 Feb 2021 09:31:55 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id r124sm4166233wmr.16.2021.02.02.09.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 09:31:54 -0800 (PST)
Date:   Tue, 2 Feb 2021 17:31:53 +0000
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
Subject: Re: [PATCH v5 15/16] x86/hyperv: implement an MSI domain for root
 partition
Message-ID: <20210202173153.jkbvwck2vsjlbjbz@liuwe-devbox-debian-v2>
References: <20210120120058.29138-1-wei.liu@kernel.org>
 <20210120120058.29138-16-wei.liu@kernel.org>
 <MWHPR21MB1593FFC6005966A3D9BEA3EFD7BB9@MWHPR21MB1593.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR21MB1593FFC6005966A3D9BEA3EFD7BB9@MWHPR21MB1593.namprd21.prod.outlook.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Jan 27, 2021 at 05:47:04AM +0000, Michael Kelley wrote:
> From: Wei Liu <wei.liu@kernel.org> Sent: Wednesday, January 20, 2021 4:01 AM
> > 
> > When Linux runs as the root partition on Microsoft Hypervisor, its
> > interrupts are remapped.  Linux will need to explicitly map and unmap
> > interrupts for hardware.
> > 
> > Implement an MSI domain to issue the correct hypercalls. And initialize
> > this irqdomain as the default MSI irq domain.
> > 
> > Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> > Co-Developed-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> > Signed-off-by: Wei Liu <wei.liu@kernel.org>
> > ---
> > v4: Fix compilation issue when CONFIG_PCI_MSI is not set.
> > v3: build irqdomain.o for 32bit as well.
> 
> I'm not clear on the intent for 32-bit builds.  Given that hv_proc.c is built
> only for 64-bit, I'm assuming running Linux in the root partition
> is only functional for 64-bit builds.  So is the goal simply that 32-bit
> builds will compile correctly?  Seems like maybe there should be
> a CONFIG option for running Linux in the root partition, and that
> option would force 64-bit.

To ensure 32 bit kernel builds and 32 bit guests still work.

The config option ROOT_API is to be introduced by Nuno's /dev/mshv
series. We can use that option to gate some objects when that's
available.

> 
[...]
> > diff --git a/arch/x86/hyperv/irqdomain.c b/arch/x86/hyperv/irqdomain.c
> > new file mode 100644
> > index 000000000000..19637cd60231
> > --- /dev/null
> > +++ b/arch/x86/hyperv/irqdomain.c
> > @@ -0,0 +1,332 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +//
> > +// Irqdomain for Linux to run as the root partition on Microsoft Hypervisor.
> > +//
> > +// Authors:
> > +//   Sunil Muthuswamy <sunilmut@microsoft.com>
> > +//   Wei Liu <wei.liu@kernel.org>
> 
> I think the // comment style should only be used for the SPDX line.

Fixed.

> 
> > +
> > +#include <linux/pci.h>
> > +#include <linux/irq.h>
> > +#include <asm/mshyperv.h>
> > +
[...]
> > +static int hv_map_msi_interrupt(struct pci_dev *dev, int vcpu, int vector,
> > +				struct hv_interrupt_entry *entry)
> > +{
> > +	struct hv_input_map_device_interrupt *input;
> > +	struct hv_output_map_device_interrupt *output;
> > +	struct hv_device_interrupt_descriptor *intr_desc;
> > +	unsigned long flags;
> > +	u16 status;
> > +
> > +	local_irq_save(flags);
> > +
> > +	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
> > +	output = *this_cpu_ptr(hyperv_pcpu_output_arg);
> > +
> > +	intr_desc = &input->interrupt_descriptor;
> > +	memset(input, 0, sizeof(*input));
> > +	input->partition_id = hv_current_partition_id;
> > +	input->device_id = hv_build_pci_dev_id(dev).as_uint64;
> > +	intr_desc->interrupt_type = HV_X64_INTERRUPT_TYPE_FIXED;
> > +	intr_desc->trigger_mode = HV_INTERRUPT_TRIGGER_MODE_EDGE;
> > +	intr_desc->vector_count = 1;
> > +	intr_desc->target.vector = vector;
> > +	__set_bit(vcpu, (unsigned long*)&intr_desc->target.vp_mask);
> 
> This is using the CPU bitmap format that supports up to 64 vCPUs.  Any reason not
> to use the format that supports a larger number of CPUs?   In either case, perhaps
> a check for the value of vcpu against the max of 64 (or the larger number if you
> change the bitmap format) would be appropriate.
> 

This is mostly due to we didn't have a suitably large machine during
development.

I will see if this can use vpset instead.

> > +
> > +	status = hv_do_rep_hypercall(HVCALL_MAP_DEVICE_INTERRUPT, 0, 0, input, output) &
> > +			 HV_HYPERCALL_RESULT_MASK;
> > +	*entry = output->interrupt_entry;
> > +
> > +	local_irq_restore(flags);
> > +
> > +	if (status != HV_STATUS_SUCCESS)
> > +		pr_err("%s: hypercall failed, status %d\n", __func__, status);
> > +
> > +	return status;
> > +}
> > +
[...]
> > +static int hv_unmap_msi_interrupt(struct pci_dev *dev, struct hv_interrupt_entry
> > *old_entry)
> > +{
> > +	return hv_unmap_interrupt(hv_build_pci_dev_id(dev).as_uint64, old_entry)
> > +		& HV_HYPERCALL_RESULT_MASK;
> 
> The masking with HV_HYPERCALL_RESULT_MASK is already done in
> hv_unmap_interrupt().
> 

Fixed.

Wei.
