Return-Path: <linux-hyperv+bounces-7311-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA389BFE518
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Oct 2025 23:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F58E3A394C
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Oct 2025 21:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9662F8BF4;
	Wed, 22 Oct 2025 21:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="N1J6cQBL"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427EB30216F;
	Wed, 22 Oct 2025 21:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761168616; cv=none; b=SMI6qUQbyqRZQ0OLhNQRRfgl9vZT4TACXmdoIRAOG3/mAHSG9ORuUnjFmJs+at69ud/eBlJHEp4/1XgYenGGm/YCmJik6j6ho1m38uJ1+LoPTFUDWKT2UZUG5iqZpLaMPcSB73WSGLIc9o2WXiKU7FUUAH73qArIOlqqGbXNlIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761168616; c=relaxed/simple;
	bh=d64GeTOuq2eaH3df+KTwBxmNDz1zt8aRyPsbngNUoM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZlU1ACogjPmWWe1iUXEUI4LVwyyzg0ICnpcwpelAUVflxvB+YzZWqdPvfUzsoQigmKHaVmegdWjPV8asoR/3PGb4oiWVS41kez2+TzCfvAEO6t0k8GYHjCJzj/PMjXa9p71oM0OMepQFzBREComjqFJe4og9rljPlGsxjiTSWLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=N1J6cQBL; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1044)
	id 819B8211CFB3; Wed, 22 Oct 2025 14:30:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 819B8211CFB3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1761168612;
	bh=3T35t9XBTAZvktKeA4gTfQ7PSvqXrs1BSYjCKitJrhw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N1J6cQBLWkdekMu1CdSngEzK1WO05V5D73s+//eul02IcNnKBT9WpPG1w4+N28us7
	 n2PFRy2AINK0+bQPeAjG16Jur396eA2dPHvO27L1MARjIXVhoL5n2ZpsR9NeEwO89b
	 nqkycwXs34/JZhLoOAqJTrEUUnMZt9wOdrRKZuyc=
Date: Wed, 22 Oct 2025 14:30:12 -0700
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
Subject: Re: [PATCH v2 2/2] hyperv: Enable clean shutdown for root partition
 with MSHV
Message-ID: <20251022213012.GC17482@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20251014164150.6935-1-prapal@linux.microsoft.com>
 <20251014164150.6935-3-prapal@linux.microsoft.com>
 <SN6PR02MB4157FBBE5B77C65B024D3589D4E9A@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4157FBBE5B77C65B024D3589D4E9A@SN6PR02MB4157.namprd02.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Thu, Oct 16, 2025 at 07:29:06PM +0000, Michael Kelley wrote:
> From: Praveen K Paladugu <prapal@linux.microsoft.com> Sent: Tuesday, October 14, 2025 9:41 AM
> > 
> > When a shutdown is initiated in the root partition without configuring
> > sleep states, the call to `hv_call_enter_sleep_state` fails. In such cases
> > the root falls back to using legacy ACPI mechanisms to poweroff. This call
> > is intercepted by MSHV and will result in a Machine Check Exception (MCE).
> > 
> > Root panics with a trace similar to:
> > 
> > [   81.306348] reboot: Power down
> > [   81.314709] mce: [Hardware Error]: CPU 0: Machine Check Exception: 4 Bank 0: b2000000c0060001
> > [   81.314711] mce: [Hardware Error]: TSC 3b8cb60a66 PPIN 11d98332458e4ea9
> > [   81.314713] mce: [Hardware Error]: PROCESSOR 0:606a6 TIME 1759339405 SOCKET 0 APIC 0 microcode ffffffff
> > [   81.314715] mce: [Hardware Error]: Run the above through 'mcelog --ascii'
> > [   81.314716] mce: [Hardware Error]: Machine check: Processor context corrupt
> > [   81.314717] Kernel panic - not syncing: Fatal machine check
> > 
> > To prevent this, properly configure sleep states within MSHV, allowing
> > the root partition to shut down cleanly without triggering a panic.
> > 
> > Signed-off-by: Praveen K Paladugu <prapal@linux.microsoft.com>
> > Co-developed-by: Anatol Belski <anbelski@linux.microsoft.com>
> > Signed-off-by: Anatol Belski <anbelski@linux.microsoft.com>
> > ---
> >  arch/x86/hyperv/hv_init.c       |   7 ++
> >  arch/x86/include/asm/mshyperv.h |   1 +
> >  drivers/hv/hv_common.c          | 119 ++++++++++++++++++++++++++++++++
> >  3 files changed, 127 insertions(+)
> > 
> > diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> > index afdbda2dd7b7..57bd96671ead 100644
> > --- a/arch/x86/hyperv/hv_init.c
> > +++ b/arch/x86/hyperv/hv_init.c
> > @@ -510,6 +510,13 @@ void __init hyperv_init(void)
> >  		memunmap(src);
> > 
> >  		hv_remap_tsc_clocksource();
> > +		/*
> > +		 * The notifier registration might fail at various hops.
> > +		 * Corresponding error messages will land in dmesg. There is
> > +		 * otherwise nothing that can be specifically done to handle
> > +		 * failures here.
> > +		 */
> > +		(void)hv_sleep_notifiers_register();
> >  	} else {
> >  		hypercall_msr.guest_physical_address = vmalloc_to_pfn(hv_hypercall_pg);
> >  		wrmsrq(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
> > diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> > index abc4659f5809..fb8d691193df 100644
> > --- a/arch/x86/include/asm/mshyperv.h
> > +++ b/arch/x86/include/asm/mshyperv.h
> > @@ -236,6 +236,7 @@ int hyperv_fill_flush_guest_mapping_list(
> >  void hv_apic_init(void);
> >  void __init hv_init_spinlocks(void);
> >  bool hv_vcpu_is_preempted(int vcpu);
> > +int hv_sleep_notifiers_register(void);
> >  #else
> >  static inline void hv_apic_init(void) {}
> >  #endif
> > diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> > index e109a620c83f..cfba9ded7bcb 100644
> > --- a/drivers/hv/hv_common.c
> > +++ b/drivers/hv/hv_common.c
> > @@ -837,3 +837,122 @@ const char *hv_result_to_string(u64 status)
> >  	return "Unknown";
> >  }
> >  EXPORT_SYMBOL_GPL(hv_result_to_string);
> > +
> > +#if IS_ENABLED(CONFIG_ACPI)
> > +/*
> > + * Corresponding sleep states have to be initialized in order for a subsequent
> > + * HVCALL_ENTER_SLEEP_STATE call to succeed. Currently only S5 state as per
> > + * ACPI 6.4 chapter 7.4.2 is relevant, while S1, S2 and S3 can be supported.
> > + *
> > + * ACPI should be initialized and should support S5 sleep state when this method
> > + * is called, so that it can extract correct PM values and pass them to hv.
> > + */
> > +static int hv_initialize_sleep_states(void)
> > +{
> > +	u64 status;
> > +	unsigned long flags;
> > +	struct hv_input_set_system_property *in;
> > +	acpi_status acpi_status;
> > +	u8 sleep_type_a, sleep_type_b;
> > +
> > +	if (!acpi_sleep_state_supported(ACPI_STATE_S5)) {
> > +		pr_err("%s: S5 sleep state not supported.\n", __func__);
> > +		return -ENODEV;
> > +	}
> > +
> > +	acpi_status = acpi_get_sleep_type_data(ACPI_STATE_S5,
> > +						&sleep_type_a, &sleep_type_b);
> > +	if (ACPI_FAILURE(acpi_status))
> > +		return -ENODEV;
> > +
> > +	local_irq_save(flags);
> > +	in = *this_cpu_ptr(hyperv_pcpu_input_arg);
> > +	memset(in, 0, sizeof(*in));
> > +
> > +	in->property_id = HV_SYSTEM_PROPERTY_SLEEP_STATE;
> > +	in->set_sleep_state_info.sleep_state = HV_SLEEP_STATE_S5;
> > +	in->set_sleep_state_info.pm1a_slp_typ = sleep_type_a;
> > +	in->set_sleep_state_info.pm1b_slp_typ = sleep_type_b;
> > +
> > +	status = hv_do_hypercall(HVCALL_SET_SYSTEM_PROPERTY, in, NULL);
> > +	local_irq_restore(flags);
> > +
> > +	if (!hv_result_success(status)) {
> > +		hv_status_err(status, "\n");
> > +		return hv_result_to_errno(status);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int hv_call_enter_sleep_state(u32 sleep_state)
> > +{
> > +	u64 status;
> > +	int ret;
> > +	unsigned long flags;
> > +	struct hv_input_enter_sleep_state *in;
> > +
> > +	ret = hv_initialize_sleep_states();
> > +	if (ret)
> > +		return ret;
> > +
> > +	local_irq_save(flags);
> > +	in = *this_cpu_ptr(hyperv_pcpu_input_arg);
> > +	in->sleep_state = sleep_state;
> > +
> > +	status = hv_do_hypercall(HVCALL_ENTER_SLEEP_STATE, in, NULL);
> 
> If this hypercall succeeds, does the root partition (which is the caller) go
> to sleep in S5, such that the hypercall never returns? If that's not the case,
> what is the behavior of this hypercall?
> 
> > +	local_irq_restore(flags);
> > +
> > +	if (!hv_result_success(status)) {
> > +		hv_status_err(status, "\n");
> > +		return hv_result_to_errno(status);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int hv_reboot_notifier_handler(struct notifier_block *this,
> > +				      unsigned long code, void *another)
> > +{
> > +	int ret = 0;
> > +
> > +	if (code == SYS_HALT || code == SYS_POWER_OFF)
> > +		ret = hv_call_enter_sleep_state(HV_SLEEP_STATE_S5);
> 
> If hv_call_enter_sleep_state() never returns, here's an issue. There may be
> multiple entries on the reboot notifier chain. For example,
> mshv_root_partition_init() puts an entry on the reboot notifier chain. At
> reboot time, the entries are executed in some order, with the expectation
> that all entries will be executed prior to the reboot actually happening. But
> if this hypercall never returns, some entries may never be executed.
> 
> Notifier chains support a notion of priority to control the order in
> which they are executed, but that priority isn't set in hv_reboot_notifier
> below, or in mshv_reboot_nb. And most other reboot notifiers throughout
> Linux appear to not set it. So the ordering is unspecified, and having
> this notifier never return may be problematic.
> 
> > +
> > +	return ret ? NOTIFY_DONE : NOTIFY_OK;
> > +}
> > +
> > +static struct notifier_block hv_reboot_notifier = {
> > +	.notifier_call  = hv_reboot_notifier_handler,
> > +};
> > +
> > +static int hv_acpi_sleep_handler(u8 sleep_state, u32 pm1a_cnt, u32 pm1b_cnt)
> > +{
> > +	int ret = 0;
> > +
> > +	if (sleep_state == ACPI_STATE_S5)
> > +		ret = hv_call_enter_sleep_state(HV_SLEEP_STATE_S5);
> > +
> > +	return ret == 0 ? 1 : -1;
> > +}
> > +
> > +static int hv_acpi_extended_sleep_handler(u8 sleep_state, u32 val_a, u32 val_b)
> > +{
> > +	return hv_acpi_sleep_handler(sleep_state, val_a, val_b);
> > +}
> 
> Is this function needed? The function signature is identical to hv_acpi_sleep_handler().
> So it seems like acpi_os_set_prepare_extended_sleep() could just use
> hv_acpi_sleep_handler() directly.
>

I confirmed that hv_acpi_xxx_handler methods are not really necessary.
They are usually invoked by `pm_suspend`, when the host is be put into a
non-S5 sleep state. As non-S5 sleep states are not supported by mshv, I
will drop these handlers in next revision.

> > +
> > +int hv_sleep_notifiers_register(void)
> > +{
> > +	int ret;
> > +
> > +	acpi_os_set_prepare_sleep(&hv_acpi_sleep_handler);
> > +	acpi_os_set_prepare_extended_sleep(&hv_acpi_extended_sleep_handler);
> 
> I'm not clear on why these handlers are set. If the hv_reboot_notifier is
> called, are these ACPI handlers ever called? Or are these to catch any cases
> where the hv_reboot_notifier is somehow bypassed? Or maybe I'm just
> not understanding something .... :-)
> 
> > +
> > +	ret = register_reboot_notifier(&hv_reboot_notifier);
> > +	if (ret)
> > +		pr_err("%s: cannot register reboot notifier %d\n",
> > +			__func__, ret);
> > +
> > +	return ret;
> > +}
> > +#endif
> 
> I'm wondering if all this code belongs in hv_common.c, since it is only needed
> for Linux in the root partition. Couldn't it go in mshv_common.c? It would still
> be built-in code (i.e., not in a loadable module), but only if CONFIG_MSHV_ROOT
> is set.
> 
> Michael
> 
> > --
> > 2.51.0
> > 

