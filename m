Return-Path: <linux-hyperv+bounces-2934-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B82A496A6A9
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Sep 2024 20:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 708B22890CD
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Sep 2024 18:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D066191F62;
	Tue,  3 Sep 2024 18:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Grc2ORMg"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4582B15574F;
	Tue,  3 Sep 2024 18:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725388527; cv=none; b=Dd5HDkuTzMwt4PTuJpaqAajb7r7yOY1vr5GamlMofgOM25A8wwBSsQtjdXwGknog8p1KfFI+u2lLwiXkE7NNKfb8qQPPUpO05h/dp0p0T5+/COs7AiTc+x9vgCBlG1X3wCkpCk1kzzEK6bLaZPlf29mO3qrqDIMNvLdEJ9Ofcz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725388527; c=relaxed/simple;
	bh=KI5ezbRLSBf33QZ+IsgEfLM+AcOhRQpChuSdfkscnQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RS7bV6vndsu7RmXeAOaEmi9PkIpEHb/1esUXpvpIarI0imybq8cf+ZRouPshVxQCJtOAekftRJJL4DNshefP+6EwQAq91UTiHQGzHboScu3g5/EQ17ecS6wLJCt7OrbhWjt2PcdtJTR02PazU3qnaMgI8Jv03C3sYfqhP2W4620=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Grc2ORMg; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725388525; x=1756924525;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KI5ezbRLSBf33QZ+IsgEfLM+AcOhRQpChuSdfkscnQ8=;
  b=Grc2ORMgkMsMCq1geI0ZmLC7T4z49qp1Igc7B7QPQXEITxOAWk2/SJo6
   x99Mttzj2vISxAhyWwi4vQemH+bkVLETj00kSqQPVqjjhqZpwKHvLJ/R1
   S7ucWXsZt9CksaA6VEK9+v1IMxH47afeXaj1QIOUa1pt1krggtUcwjVuO
   IRL0CSmzwY8Elkd9+xPDNVm4YZ8CwFjKckVU1R5DRQOc5brohuhTt6R9i
   PUJsRKV5FgzYqFrEwt1FoH1CfBSnxuqFAWQSvh4RNprgjn2PN8WA0TKfL
   gGo64dlIZD8+MSkhiHGiRpjHkdyEO5LltxHVcmAhuHFVNnmS0R1UEiABO
   w==;
X-CSE-ConnectionGUID: j/QM27udTu6gyGSjI1Iyrw==
X-CSE-MsgGUID: lDhLAB3uQQGOuIujJlCu5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="24172952"
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="24172952"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 11:35:24 -0700
X-CSE-ConnectionGUID: dT3gioxVSNi6aBqsrEamBQ==
X-CSE-MsgGUID: xC9Kh55TS+qNRWU1cq9EIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="95737163"
Received: from unknown (HELO localhost) ([10.79.232.150])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 11:35:24 -0700
Date: Tue, 3 Sep 2024 11:35:23 -0700
From: Yunhong Jiang <yunhong.jiang@linux.intel.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"rafael@kernel.org" <rafael@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v2 3/9] x86/dt: Support the ACPI multiprocessor wakeup
 for device tree
Message-ID: <20240903183523.GA105@yjiang5-mobl.amr.corp.intel.com>
References: <20240823232327.2408869-1-yunhong.jiang@linux.intel.com>
 <20240823232327.2408869-4-yunhong.jiang@linux.intel.com>
 <BN7PR02MB4148C25575F1C98531B6164CD4922@BN7PR02MB4148.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN7PR02MB4148C25575F1C98531B6164CD4922@BN7PR02MB4148.namprd02.prod.outlook.com>

On Mon, Sep 02, 2024 at 03:35:06AM +0000, Michael Kelley wrote:
> From: Yunhong Jiang <yunhong.jiang@linux.intel.com> Sent: Friday, August 23, 2024 4:23 PM
> > 
> > When a TDX guest boots with the device tree instead of ACPI, it can
> > reuse the ACPI multiprocessor wakeup mechanism to wake up application
> > processors(AP), without introducing a new mechanism from scrach.
> > 
> > In the ACPI spec, two structures are defined to wake up the APs: the
> > multiprocessor wakeup structure and the multiprocessor wakeup mailbox
> > structure. The multiprocessor wakeup structure is passed to OS through a
> > Multiple APIC Description Table(MADT), one field specifying the physical
> > address of the multiprocessor wakeup mailbox structure. The OS sends
> > a message to firmware through the multiprocessor wakeup mailbox
> > structure, to bring up the APs.
> > 
> > In device tree environment, the multiprocessor wakeup structure is not
> > used, to reduce the dependency on the generic ACPI table. The
> > information defined in this structure is defined in the properties of
> > cpus node in the device tree. The "wakeup-mailbox-addr" property
> > specifies the physical address of the multiprocessor wakeup mailbox
> > structure. The OS will follow the ACPI spec to send the message to the
> > firmware to bring up the APs.
> > 
> > Signed-off-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
> > ---
> >  MAINTAINERS                        |  1 +
> >  arch/x86/Kconfig                   |  2 +-
> >  arch/x86/include/asm/acpi.h        |  1 -
> >  arch/x86/include/asm/madt_wakeup.h | 16 +++++++++++++
> >  arch/x86/kernel/madt_wakeup.c      | 38 ++++++++++++++++++++++++++++++
> >  5 files changed, 56 insertions(+), 2 deletions(-)
> >  create mode 100644 arch/x86/include/asm/madt_wakeup.h
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 5555a3bbac5f..900de6501eba 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -288,6 +288,7 @@ T:	git
> > git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
> >  F:	Documentation/ABI/testing/configfs-acpi
> >  F:	Documentation/ABI/testing/sysfs-bus-acpi
> >  F:	Documentation/firmware-guide/acpi/
> > +F:	arch/x86/include/asm/madt_wakeup.h
> >  F:	arch/x86/kernel/acpi/
> >  F:	arch/x86/kernel/madt_playdead.S
> >  F:	arch/x86/kernel/madt_wakeup.c
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index d422247b2882..dba46dd30049 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -1123,7 +1123,7 @@ config X86_LOCAL_APIC
> >  config ACPI_MADT_WAKEUP
> >  	def_bool y
> >  	depends on X86_64
> > -	depends on ACPI
> > +	depends on ACPI || OF
> >  	depends on SMP
> >  	depends on X86_LOCAL_APIC
> > 
> > diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
> > index 21bc53f5ed0c..0e082303ca26 100644
> > --- a/arch/x86/include/asm/acpi.h
> > +++ b/arch/x86/include/asm/acpi.h
> > @@ -83,7 +83,6 @@ union acpi_subtable_headers;
> >  int __init acpi_parse_mp_wake(union acpi_subtable_headers *header,
> >  			      const unsigned long end);
> > 
> > -void asm_acpi_mp_play_dead(u64 reset_vector, u64 pgd_pa);
> > 
> >  /*
> >   * Check if the CPU can handle C2 and deeper
> > diff --git a/arch/x86/include/asm/madt_wakeup.h
> > b/arch/x86/include/asm/madt_wakeup.h
> > new file mode 100644
> > index 000000000000..a8cd50af581a
> > --- /dev/null
> > +++ b/arch/x86/include/asm/madt_wakeup.h
> > @@ -0,0 +1,16 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef __ASM_X86_MADT_WAKEUP_H
> > +#define __ASM_X86_MADT_WAKEUP_H
> > +
> > +void asm_acpi_mp_play_dead(u64 reset_vector, u64 pgd_pa);
> > +
> > +#if defined(CONFIG_OF) && defined(CONFIG_ACPI_MADT_WAKEUP)
> > +u64 dtb_parse_mp_wake(void);
> > +#else
> > +static inline u64 dtb_parse_mp_wake(void)
> > +{
> > +	return 0;
> > +}
> > +#endif
> > +
> > +#endif /* __ASM_X86_MADT_WAKEUP_H */
> > diff --git a/arch/x86/kernel/madt_wakeup.c b/arch/x86/kernel/madt_wakeup.c
> > index d5ef6215583b..7257e7484569 100644
> > --- a/arch/x86/kernel/madt_wakeup.c
> > +++ b/arch/x86/kernel/madt_wakeup.c
> > @@ -14,6 +14,8 @@
> >  #include <asm/nmi.h>
> >  #include <asm/processor.h>
> >  #include <asm/reboot.h>
> > +#include <asm/madt_wakeup.h>
> > +#include <asm/prom.h>
> > 
> >  /* Physical address of the Multiprocessor Wakeup Structure mailbox */
> >  static u64 acpi_mp_wake_mailbox_paddr __ro_after_init;
> > @@ -122,6 +124,7 @@ static int __init init_transition_pgtable(pgd_t *pgd)
> >  	return 0;
> >  }
> > 
> > +#ifdef CONFIG_ACPI
> >  static int __init acpi_mp_setup_reset(u64 reset_vector)
> >  {
> >  	struct x86_mapping_info info = {
> > @@ -168,6 +171,7 @@ static int __init acpi_mp_setup_reset(u64 reset_vector)
> > 
> >  	return 0;
> >  }
> > +#endif
> 
> When acpi_mp_setup_reset() is #ifdef'ed out because of CONFIG_ACPI
> not being set, doesn't this generate compile warnings about
> init_transition_pgtable(), alloc_pgt_page(), free_pgt_page(), etc. being
> unused?
> 
> It appears that the only code in madt_wakeup.c that is shared between
> the ACPI and OF cases is acpi_wakeup_cpu()? Is that correct?

Yes, the acpi_wakeup_cpu() is the only code. Interestingly that I don't see
compilation warning for the functions you listed like
alloc_pgt_page()/free_pgt_page() etc when built with CONFIG_ACPI disabled.
Will check in deep and figure out the reason.
> 
> > 
> >  static int acpi_wakeup_cpu(u32 apicid, unsigned long start_ip)
> >  {
> > @@ -226,6 +230,7 @@ static int acpi_wakeup_cpu(u32 apicid, unsigned long start_ip)
> >  	return 0;
> >  }
> > 
> > +#ifdef CONFIG_ACPI
> >  static void acpi_mp_disable_offlining(struct acpi_madt_multiproc_wakeup *mp_wake)
> >  {
> >  	cpu_hotplug_disable_offlining();
> > @@ -290,3 +295,36 @@ int __init acpi_parse_mp_wake(union acpi_subtable_headers *header,
> > 
> >  	return 0;
> >  }
> > +#endif /* CONFIG_ACPI */
> > +
> > +#ifdef CONFIG_OF
> > +u64 __init dtb_parse_mp_wake(void)
> > +{
> > +	struct device_node *node;
> > +	u64 mailaddr = 0;
> > +
> > +	node = of_find_node_by_path("/cpus");
> > +	if (!node)
> > +		return 0;
> > +
> > +	if (of_property_match_string(node, "enable-method", "acpi-wakeup-mailbox") < 0) {
> > +		pr_err("No acpi wakeup mailbox enable-method\n");
> > +		goto done;
> 
> Patch 4 of this series unconditionally calls dtb_parse_mp_wake(),
> so it will be called in normal VMs, as a well as SEV-SNP and TDX
> kernels built for VTL 2 (assuming CONFIG_OF is set). Normal VMs
> presumably won't be using DT and won't have the "/cpus" node,
> so this function will silently do nothing, which is fine. But do you
> expect the DT "/cpus" node to be present in an SEV-SNP VTL 2
> environment? If so, this function will either output some spurious
> error messages, or SEV-SNP will use the ACPI wakeup mailbox
> method, which is probably not what you want.
> 
> Michael

Yes, will fix the spurios error messages. Thank you for pointing out this.

Thanks
--jyh
> 
> > +	}
> > +
> > +	if (of_property_read_u64(node, "wakeup-mailbox-addr", &mailaddr)) {
> > +		pr_err("Invalid wakeup mailbox addr\n");
> > +		goto done;
> > +	}
> > +	acpi_mp_wake_mailbox_paddr = mailaddr;
> > +	pr_info("dt wakeup-mailbox: addr 0x%llx\n", mailaddr);
> > +
> > +	/* No support for the MADT reset vector yet */
> > +	cpu_hotplug_disable_offlining();
> > +	apic_update_callback(wakeup_secondary_cpu_64, acpi_wakeup_cpu);
> > +
> > +done:
> > +	of_node_put(node);
> > +	return mailaddr;
> > +}
> > +#endif /* CONFIG_OF */
> > --
> > 2.25.1
> > 
> 

