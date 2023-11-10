Return-Path: <linux-hyperv+bounces-854-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF0F7E869F
	for <lists+linux-hyperv@lfdr.de>; Sat, 11 Nov 2023 00:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 530F6280E90
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Nov 2023 23:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A76B3D969;
	Fri, 10 Nov 2023 23:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3D020308
	for <linux-hyperv@vger.kernel.org>; Fri, 10 Nov 2023 23:38:47 +0000 (UTC)
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC1CAC;
	Fri, 10 Nov 2023 15:38:46 -0800 (PST)
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6ce37683cf6so1368460a34.3;
        Fri, 10 Nov 2023 15:38:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699659524; x=1700264324;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eAjrV2+2HnFfMZzicJ2ewp4WfLmj5X0QU83KI4wR4Ew=;
        b=QxUlDfYTAzkj3gao7wFnyev0YxEFQdG4Ro3nW5CJX1DWN8RXvdPUAKANugwI3zoDom
         878mbIipQFOx2DQQsA7LlHQkW1rWetLnhriaIeE9o0DM9OX6/Hxg2YRTYiQ8gELYw5We
         ylobhSd2d6+bs1vYGx3Kf3b9R2YbYND959cQ5/e/jc2ogusJds0reDZN8wwuwMxwH3Lg
         PssTpsc32mJa5/7RC656oy268J47hcVWYg9mlz1o0yd3nSdx00v3ZGd6QS8Gu+pKOeob
         xM8+H/eD+Al3vNbd/Qknyyv3tsljOdfnr8FVFexzIebPvpLOb3yHP3e7x4Nb2eQygTyX
         dmJg==
X-Gm-Message-State: AOJu0YyBEQv8u/QPurRftoAy0r2ikieeMVPqAuA4EqpnmJaK6E9bKyVI
	ROQcsAEHEwcB2JNlKV2G0Fg=
X-Google-Smtp-Source: AGHT+IHHhsEelbv/NET9tN/Vrjk7s8UbszKD1dor2hZ3c0G+L982WazoRGjnDCrT7y0fkvB7euBv7Q==
X-Received: by 2002:a05:6830:4490:b0:6bd:b5f7:187a with SMTP id r16-20020a056830449000b006bdb5f7187amr765025otv.20.1699659524631;
        Fri, 10 Nov 2023 15:38:44 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id 37-20020a631365000000b00578afd8e012sm237451pgt.92.2023.11.10.15.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 15:38:44 -0800 (PST)
Date: Fri, 10 Nov 2023 23:38:42 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
Cc: Dexuan Cui <decui@microsoft.com>, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	linux-hyperv@vger.kernel.org, hpa@zytor.com, x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/hyperv: Fix the detection of E820_TYPE_PRAM in a
 Gen2 VM
Message-ID: <ZU6_ArCG2Si3ZuLZ@liuwe-devbox-debian-v2>
References: <20230811053137.2789-1-decui@microsoft.com>
 <20230919053647.GA23290@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919053647.GA23290@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>

On Mon, Sep 18, 2023 at 10:36:47PM -0700, Saurabh Singh Sengar wrote:
> On Thu, Aug 10, 2023 at 10:31:37PM -0700, Dexuan Cui wrote:
> > A Gen2 VM doesn't support legacy PCI/PCIe, so both raw_pci_ops and
> > raw_pci_ext_ops are NULL, and pci_subsys_init() -> pcibios_init()
> > doesn't call pcibios_resource_survey() -> e820__reserve_resources_late();
> > as a result, any emulated persistent memory of E820_TYPE_PRAM (12) via
> > the kernel parameter memmap=nn[KMG]!ss is not added into iomem_resource
> > and hence can't be detected by register_e820_pmem().
> > 
> > Fix this by directly calling e820__reserve_resources_late() in
> > hv_pci_init(), which is called from arch_initcall(pci_arch_init).
> > 
> > It's ok to move a Gen2 VM's e820__reserve_resources_late() from
> > subsys_initcall(pci_subsys_init) to arch_initcall(pci_arch_init) because
> > the code in-between doesn't depend on the E820 resources.
> > e820__reserve_resources_late() depends on e820__reserve_resources(),
> > which has been called earlier from setup_arch().
> > 
> > For a Gen-2 VM, the new hv_pci_init() also adds any memory of
> > E820_TYPE_PMEM (7) into iomem_resource, and acpi_nfit_register_region() ->
> > acpi_nfit_insert_resource() -> region_intersects() returns
> > REGION_INTERSECTS, so the memory of E820_TYPE_PMEM won't get added twice.
> > 
> > Changed the local variable "int gen2vm" to "bool gen2vm".
> > 
> > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> > Signed-off-by: Dexuan Cui <decui@microsoft.com>
> > ---
> >  arch/x86/hyperv/hv_init.c | 25 +++++++++++++++++++++----
> >  1 file changed, 21 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> > index b004370d3b01..6b22d49aee7b 100644
> > --- a/arch/x86/hyperv/hv_init.c
> > +++ b/arch/x86/hyperv/hv_init.c
> > @@ -13,6 +13,7 @@
> >  #include <linux/io.h>
> >  #include <asm/apic.h>
> >  #include <asm/desc.h>
> > +#include <asm/e820/api.h>
> >  #include <asm/sev.h>
> >  #include <asm/hypervisor.h>
> >  #include <asm/hyperv-tlfs.h>
> > @@ -282,15 +283,31 @@ static int hv_cpu_die(unsigned int cpu)
> >  
> >  static int __init hv_pci_init(void)
> >  {
> > -	int gen2vm = efi_enabled(EFI_BOOT);
> > +	bool gen2vm = efi_enabled(EFI_BOOT);
> >  
> >  	/*
> > -	 * For Generation-2 VM, we exit from pci_arch_init() by returning 0.
> > -	 * The purpose is to suppress the harmless warning:
> > +	 * A Generation-2 VM doesn't support legacy PCI/PCIe, so both
> > +	 * raw_pci_ops and raw_pci_ext_ops are NULL, and pci_subsys_init() ->
> > +	 * pcibios_init() doesn't call pcibios_resource_survey() ->
> > +	 * e820__reserve_resources_late(); as a result, any emulated persistent
> > +	 * memory of E820_TYPE_PRAM (12) via the kernel parameter
> > +	 * memmap=nn[KMG]!ss is not added into iomem_resource and hence can't be
> > +	 * detected by register_e820_pmem(). Fix this by directly calling
> > +	 * e820__reserve_resources_late() here: e820__reserve_resources_late()
> > +	 * depends on e820__reserve_resources(), which has been called earlier
> > +	 * from setup_arch(). Note: e820__reserve_resources_late() also adds
> > +	 * any memory of E820_TYPE_PMEM (7) into iomem_resource, and
> > +	 * acpi_nfit_register_region() -> acpi_nfit_insert_resource() ->
> > +	 * region_intersects() returns REGION_INTERSECTS, so the memory of
> > +	 * E820_TYPE_PMEM won't get added twice.
> > +	 *
> > +	 * We return 0 here so that pci_arch_init() won't print the warning:
> >  	 * "PCI: Fatal: No config space access function found"
> >  	 */
> > -	if (gen2vm)
> > +	if (gen2vm) {
> > +		e820__reserve_resources_late();
> >  		return 0;
> > +	}
> 
> 
> Kind reminder to review this.
> 

I tried to applied this patch to hyperv-fixes, but it doesn't apply
cleanly.

Please resend.

Thanks,
Wei.

