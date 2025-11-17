Return-Path: <linux-hyperv+bounces-7654-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 35079C663AD
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Nov 2025 22:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B6C5F361568
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Nov 2025 21:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4377E299959;
	Mon, 17 Nov 2025 21:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="BTeBMbtV"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974DC2C027C;
	Mon, 17 Nov 2025 21:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763413945; cv=none; b=BCMdk0bkFzcw7emwZlwpjv0s/If1+RJ/ARZ5c8ktAc3tOXE8yGRSvWE7JBgvnSC9gw0j0I+KhTutQSNeKNqvEp61JuoLlH/HFXkOxNu4QVoMhh43nNouJ28mivkrdBN+FVgrZkp9ab/BOFmXMVqHK+9cA87JLXI7bgrFh/M3Ods=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763413945; c=relaxed/simple;
	bh=CEaiQAGaZsMv8ooU6twxH2IvRIQPDMBvw3yW5NHVEUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fGNlTnoFvi8u+n3F0sB5zkHTzyosnI1knR+pKeE+++VigVQxCPEqY4G17jzFYg0riIfqx7z6yU7xcIORMJK/1IdCS3kcXXmqzAULjLqPTOOSUrYnENCFkiL4btRkw5ymqFH5BThVfUSXUmgb5jzTgrvFzErbkoucknQ11+IwDaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=BTeBMbtV; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1044)
	id 4A901211AA26; Mon, 17 Nov 2025 13:12:23 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4A901211AA26
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1763413943;
	bh=7Qse1fGbxqRmzXNHBpQp7iDFu+P3viMhnaUhwvANKD8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BTeBMbtVoxjzMnNoBtWNrB0xcCbVTslJvnH/arsCz4DJ3/McQXcNF0n/yhTI5eRGR
	 tggwv26I/9JOf0Casq2NW+ETDSYjEXYskND+e46u7HYCfa8V4ccisTQfeIDjxsUdZE
	 N0YTdtj7C9WWC83N5uq5KmwPEHxEsR11WcIF4jFo=
Date: Mon, 17 Nov 2025 13:12:23 -0800
From: Praveen Paladugu <prapal@linux.microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"arnd@arndb.de" <arnd@arndb.de>,
	"anbelski@linux.microsoft.com" <anbelski@linux.microsoft.com>,
	"easwar.hariharan@linux.microsoft.com" <easwar.hariharan@linux.microsoft.com>,
	"nunodasneves@linux.microsoft.com" <nunodasneves@linux.microsoft.com>,
	"skinsburskii@linux.microsoft.com" <skinsburskii@linux.microsoft.com>
Subject: Re: [PATCH v4 3/3] hyperv: Cleanly shutdown root partition with MSHV
Message-ID: <20251117211223.GC24244@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20251107221700.45957-1-prapal@linux.microsoft.com>
 <20251107221700.45957-4-prapal@linux.microsoft.com>
 <SN6PR02MB415764759BCA5070B8303AF2D4CDA@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB415764759BCA5070B8303AF2D4CDA@SN6PR02MB4157.namprd02.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Thu, Nov 13, 2025 at 07:42:10PM +0000, Michael Kelley wrote:
> From: Praveen K Paladugu <prapal@linux.microsoft.com>
> > 
> > When a root partition running on MSHV is powered off, the default
> > behavior is to write ACPI registers to power-off. However, this ACPI
> > write is intercepted by MSHV and will result in a Machine Check
> > Exception(MCE).
> > 
> > The root partition eventually panics with a trace similar to:
> > 
> >   [   81.306348] reboot: Power down
> >   [   81.314709] mce: [Hardware Error]: CPU 0: Machine Check Exception: 4 Bank 0: b2000000c0060001
> >   [   81.314711] mce: [Hardware Error]: TSC 3b8cb60a66 PPIN 11d98332458e4ea9
> >   [   81.314713] mce: [Hardware Error]: PROCESSOR 0:606a6 TIME 1759339405 SOCKET 0 APIC 0 microcode ffffffff
> >   [   81.314715] mce: [Hardware Error]: Run the above through 'mcelog --ascii'
> >   [   81.314716] mce: [Hardware Error]: Machine check: Processor context corrupt
> >   [   81.314717] Kernel panic - not syncing: Fatal machine check
> > 
> > To correctly shutdown a root partition running on MSHV, sleep state
> > information has be configured within mshv. Later HVCALL_ENTER_SLEEP_STATE
> 
> s/has be/has to be/    --or--   s/has be/must be/
> 
> Nit: Be consistent in capitalizing "MSHV" (or not capitalizing it).
> 
> > should be invoked as the last step in the shutdown sequence.
> > 
> > The previous patch configures the sleep state information and this patch
> > invokes HVCALL_ENTER_SLEEP_STATE to cleanly shutdown the root partition.
> > 
> > Signed-off-by: Praveen K Paladugu <prapal@linux.microsoft.com>
> > Co-developed-by: Anatol Belski <anbelski@linux.microsoft.com>
> > Signed-off-by: Anatol Belski <anbelski@linux.microsoft.com>
> > ---
> >  arch/x86/hyperv/hv_init.c       |  2 ++
> >  arch/x86/include/asm/mshyperv.h |  2 ++
> >  drivers/hv/mshv_common.c        | 19 +++++++++++++++++++
> >  3 files changed, 23 insertions(+)
> > 
> > diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> > index 645b52dd732e..24824534ff8d 100644
> > --- a/arch/x86/hyperv/hv_init.c
> > +++ b/arch/x86/hyperv/hv_init.c
> > @@ -34,6 +34,7 @@
> >  #include <clocksource/hyperv_timer.h>
> >  #include <linux/highmem.h>
> >  #include <linux/export.h>
> > +#include <asm/reboot.h>
> > 
> >  void *hv_hypercall_pg;
> > 
> > @@ -562,6 +563,7 @@ void __init hyperv_init(void)
> >  		 * failures here.
> >  		 */
> >  		hv_sleep_notifiers_register();
> > +		machine_ops.power_off = hv_machine_power_off;
> >  	} else {
> >  		hypercall_msr.guest_physical_address = vmalloc_to_pfn(hv_hypercall_pg);
> >  		wrmsrq(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
> > diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> > index fbc1233175ce..9082d56103ce 100644
> > --- a/arch/x86/include/asm/mshyperv.h
> > +++ b/arch/x86/include/asm/mshyperv.h
> > @@ -182,9 +182,11 @@ void hv_apic_init(void);
> >  void __init hv_init_spinlocks(void);
> >  bool hv_vcpu_is_preempted(int vcpu);
> >  void hv_sleep_notifiers_register(void);
> > +void hv_machine_power_off(void);
> >  #else
> >  static inline void hv_apic_init(void) {}
> >  static inline void hv_sleep_notifiers_register(void) {};
> > +static inline void hv_machine_power_off(void) {};
> >  #endif
> > 
> >  struct irq_domain *hv_create_pci_msi_domain(void);
> > diff --git a/drivers/hv/mshv_common.c b/drivers/hv/mshv_common.c
> > index d1a1daa52b65..0588d293a92a 100644
> > --- a/drivers/hv/mshv_common.c
> > +++ b/drivers/hv/mshv_common.c
> > @@ -217,4 +217,23 @@ void hv_sleep_notifiers_register(void)
> >  		pr_err("%s: cannot register reboot notifier %d\n", __func__,
> >  		       ret);
> >  }
> > +
> > +/*
> > + * Power off the machine by entering S5 sleep state via Hyper-V hypercall.
> > + * This call does not return if successful.
> > + */
> > +void hv_machine_power_off(void)
> > +{
> > +	u64 status;
> > +	unsigned long flags;
> > +	struct hv_input_enter_sleep_state *in;
> > +
> > +	local_irq_save(flags);
> > +	in = *this_cpu_ptr(hyperv_pcpu_input_arg);
> > +	in->sleep_state = HV_SLEEP_STATE_S5;
> > +
> > +	status = hv_do_hypercall(HVCALL_ENTER_SLEEP_STATE, in, NULL);
> 
> As flagged by the kernel test robot, this should be
> 
> 	(void)hv_do_hypercall(HVCALL_ENTER_SLEEP_STATE, in, NULL);
> 
> so that the intent to ignore the return value is explicit. And the local
> variable "status" can be removed.
>

Thanks for the feedback. I addressed it in v5.

> > +	local_irq_restore(flags);
> > +
> > +}
> >  #endif
> > --
> > 2.51.0

