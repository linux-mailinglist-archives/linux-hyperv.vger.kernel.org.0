Return-Path: <linux-hyperv+bounces-8949-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GQFBz9anGmzEgQAu9opvQ
	(envelope-from <linux-hyperv+bounces-8949-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Feb 2026 14:46:39 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 443B317734F
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Feb 2026 14:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE5FC307CE9F
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Feb 2026 13:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20BE12222A9;
	Mon, 23 Feb 2026 13:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="i000c0pb"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD0B21CC51;
	Mon, 23 Feb 2026 13:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771854080; cv=pass; b=FYaQXXGKKZHn2W0egjWxGaNmhEkCh5Xge3SziDPnrqjnuYlqjnNrjGnxnkFsiNTndtRiiF8lNx734GPhYVxrDWSnkSUogsGc+DOK2W0DlY91ptitRELg6u8vTKVNEKaAZdDa80vIfX+LwE68p63bEiXvdfFBYQPXpOq688uZgss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771854080; c=relaxed/simple;
	bh=ixmWJy+ku7enF/ISdHMrZ4wESkRwadlOFl252uY/uvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UfLsvUzS47LV4MJcMVXICnPh/kItwbUdpt9TJTr9ClY5vWpCTjSOu/QMZUafJ9IBaqRt0uxbNiD2aulLimEjlSyxN/+CPdyU8fMItrug/iTCUvKpW15raqhQi+PZyp1pxEY6pBGCQCDzgjhj5rC0oYKPAR0D+y8+KHm/U6IZAJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=i000c0pb; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1771854069; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=c+UPvEF6G+ch2Qy2wseoli99rtP9xCtBt30v9NiCzCh+6nyoeBmEwrflikQz2y8CrIvBdRd9X+GTg2xXfolH/01Qix6vPieOu0o7TDPBp5rx18ElgQ2LrzgO4u3vY7vi4axSB2S7XEr5LNQkxBkC+hP9E7wah81PHHsgCgNPFu4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1771854069; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=EWEhCqHeWfo30yaEuLKb8B54mAM1iTWEBfaeVj/QuZw=; 
	b=mc3ay8RryHXuBYuwvGDh5h0RuMU//lc/ODpC65sLUOlORDqWYBBdgBukMcPcNK42MrknyaCC4uzaLjSnq7Q7gZKJzGKXqIvBd814Kde1JO4jJBHNDT+u1FsmRvGD2m9MDCIQctDTsGO91cAMCf4ceP3NqBMwdBDwQeU/aKxVgK0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1771854069;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=EWEhCqHeWfo30yaEuLKb8B54mAM1iTWEBfaeVj/QuZw=;
	b=i000c0pb623rkIyyPPajA2g1ovIMXI89Lg207d45G9gkkn0IFGeCdu7I5UYcyJ1J
	z9DE21sqfP7/bxf+D08R6S/uyjKoThcjFaAr7Ldby14RMZTONufFnoyi/aoAhfZN/vh
	J5eTMr7TpJJKr02NCtu/zDhHXlzflzcbmFc8SBXk=
Received: by mx.zohomail.com with SMTPS id 1771854066752873.5767670355301;
	Mon, 23 Feb 2026 05:41:06 -0800 (PST)
Date: Mon, 23 Feb 2026 13:41:02 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"longli@microsoft.com" <longli@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] mshv: add arm64 support for doorbell & intercept
 SINTs
Message-ID: <aZxY7nYU8POomw-t@anirudh-surface.localdomain>
References: <20260211170728.3056226-1-anirudh@anirudhrb.com>
 <20260211170728.3056226-3-anirudh@anirudhrb.com>
 <SN6PR02MB4157B6F44266C4E813D3CF74D46AA@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4157B6F44266C4E813D3CF74D46AA@SN6PR02MB4157.namprd02.prod.outlook.com>
X-ZohoMailClient: External
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[anirudhrb.com,none];
	R_DKIM_ALLOW(-0.20)[anirudhrb.com:s=zoho];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[outlook.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-8949-lists,linux-hyperv=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anirudh@anirudhrb.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[anirudhrb.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[anirudhrb.com:email,anirudhrb.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,anirudh-surface.localdomain:mid]
X-Rspamd-Queue-Id: 443B317734F
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 04:17:29AM +0000, Michael Kelley wrote:
> From: Anirudh Rayabharam <anirudh@anirudhrb.com> Sent: Wednesday, February 11, 2026 9:07 AM
> > 
> > On x86, the HYPERVISOR_CALLBACK_VECTOR is used to receive synthetic
> > interrupts (SINTs) from the hypervisor for doorbells and intercepts.
> > There is no such vector reserved for arm64.
> > 
> > On arm64, the hypervisor exposes a synthetic register that can be read
> > to find the INTID that should be used for SINTs. This INTID is in the
> > PPI range.
> > 
> > To better unify the code paths, introduce mshv_sint_vector_init() that
> > either reads the synthetic register and obtains the INTID (arm64) or
> > just uses HYPERVISOR_CALLBACK_VECTOR as the interrupt vector (x86).
> > 
> > Signed-off-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
> > ---
> >  drivers/hv/mshv_synic.c     | 112 +++++++++++++++++++++++++++++++++---
> >  include/hyperv/hvgdk_mini.h |   2 +
> >  2 files changed, 107 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/hv/mshv_synic.c b/drivers/hv/mshv_synic.c
> > index 074e37c48876..7957ad0328dd 100644
> > --- a/drivers/hv/mshv_synic.c
> > +++ b/drivers/hv/mshv_synic.c
> > @@ -10,17 +10,24 @@
> >  #include <linux/kernel.h>
> >  #include <linux/slab.h>
> >  #include <linux/mm.h>
> > +#include <linux/interrupt.h>
> >  #include <linux/io.h>
> >  #include <linux/random.h>
> >  #include <linux/cpuhotplug.h>
> >  #include <linux/reboot.h>
> >  #include <asm/mshyperv.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/acpi.h>
> > 
> >  #include "mshv_eventfd.h"
> >  #include "mshv.h"
> > 
> >  static int synic_cpuhp_online;
> >  static struct hv_synic_pages __percpu *synic_pages;
> > +static int mshv_sint_vector = -1; /* hwirq for the SynIC SINTs */
> 
> With the introduction of this variable, the call to add_interrupt_randomness()
> in mshv_isr() should be updated to pass mshv_sint_vector as the argument,
> and the #ifdef HYPERVISOR_CALLBACK_VECTOR can be dropped (yea!).  My
> previous comment about the generic Linux IRQ handling doing the call
> to add_interrupt_randomness() is true for "normal" IRQs but not for per-CPU
> IRQs like these. So the call to add_interrupt_randomness() in mshv_isr() is
> needed on both x86 and ARM64.
> 
> > +#ifndef HYPERVISOR_CALLBACK_VECTOR
> > +static int mshv_sint_irq = -1; /* Linux IRQ for mshv_sint_vector */
> > +#endif
> 
> Documentation/process/coding-style.rst says the following in Section 21:
> 
> If you have a function or variable which may potentially go unused in a
> particular configuration, and the compiler would warn about its definition
> going unused, mark the definition as __maybe_unused rather than wrapping it in
> a preprocessor conditional.
> 
> You could tag mshv_sint_irq with "__maybe_unused" and avoid the #ifndef. But
> see further comments below.
> 
> > 
> >  static u32 synic_event_ring_get_queued_port(u32 sint_index)
> >  {
> > @@ -456,9 +463,7 @@ static int mshv_synic_cpu_init(unsigned int cpu)
> >  	union hv_synic_simp simp;
> >  	union hv_synic_siefp siefp;
> >  	union hv_synic_sirbp sirbp;
> > -#ifdef HYPERVISOR_CALLBACK_VECTOR
> >  	union hv_synic_sint sint;
> > -#endif
> >  	union hv_synic_scontrol sctrl;
> >  	struct hv_synic_pages *spages = this_cpu_ptr(synic_pages);
> >  	struct hv_message_page **msg_page = &spages->hyp_synic_message_page;
> > @@ -501,10 +506,13 @@ static int mshv_synic_cpu_init(unsigned int cpu)
> > 
> >  	hv_set_non_nested_msr(HV_MSR_SIRBP, sirbp.as_uint64);
> > 
> > -#ifdef HYPERVISOR_CALLBACK_VECTOR
> > +#ifndef HYPERVISOR_CALLBACK_VECTOR
> > +	enable_percpu_irq(mshv_sint_irq, 0);
> > +#endif
> > +
> 
> Using IS_ENABLED() would be better than the #ifndef. (See Section 21
> of coding-style.rst about this as well.) You would need to drop the #ifndef
> around mshv_sint_irq, which is fine.
> 
> 	if (!IS_ENABLED(HYPERVISOR_CALLBACK_VECTOR))
> 		enable_percpu_irq(mshv_sint_irq, 0);
> 
> That said, I prefer the approach in v1 of your series where basically
> the code says "if we have a sint irq, enable it". This links the enablement
> most closely to what it directly depends on.
> 
> 	if (mshv_sint_irq != -1)
> 		enable_percpu_irq(mshv_sint_irq, 0);
> 
> But I realize the approach is somewhat a matter of personal preference so either
> way is acceptable.
> 
> >  	/* Enable intercepts */
> >  	sint.as_uint64 = 0;
> > -	sint.vector = HYPERVISOR_CALLBACK_VECTOR;
> > +	sint.vector = mshv_sint_vector;
> >  	sint.masked = false;
> >  	sint.auto_eoi = hv_recommend_using_aeoi();
> >  	hv_set_non_nested_msr(HV_MSR_SINT0 + HV_SYNIC_INTERCEPTION_SINT_INDEX,
> > @@ -512,13 +520,12 @@ static int mshv_synic_cpu_init(unsigned int cpu)
> > 
> >  	/* Doorbell SINT */
> >  	sint.as_uint64 = 0;
> > -	sint.vector = HYPERVISOR_CALLBACK_VECTOR;
> > +	sint.vector = mshv_sint_vector;
> >  	sint.masked = false;
> >  	sint.as_intercept = 1;
> >  	sint.auto_eoi = hv_recommend_using_aeoi();
> >  	hv_set_non_nested_msr(HV_MSR_SINT0 + HV_SYNIC_DOORBELL_SINT_INDEX,
> >  			      sint.as_uint64);
> > -#endif
> > 
> >  	/* Enable global synic bit */
> >  	sctrl.as_uint64 = hv_get_non_nested_msr(HV_MSR_SCONTROL);
> > @@ -573,6 +580,10 @@ static int mshv_synic_cpu_exit(unsigned int cpu)
> >  	hv_set_non_nested_msr(HV_MSR_SINT0 + HV_SYNIC_DOORBELL_SINT_INDEX,
> >  			      sint.as_uint64);
> > 
> > +#ifndef HYPERVISOR_CALLBACK_VECTOR
> > +	disable_percpu_irq(mshv_sint_irq);
> > +#endif
> > +
> 
> Same here.
> 
> >  	/* Disable Synic's event ring page */
> >  	sirbp.as_uint64 = hv_get_non_nested_msr(HV_MSR_SIRBP);
> >  	sirbp.sirbp_enabled = false;
> > @@ -683,14 +694,98 @@ static struct notifier_block mshv_synic_reboot_nb = {
> >  	.notifier_call = mshv_synic_reboot_notify,
> >  };
> > 
> > +#ifndef HYPERVISOR_CALLBACK_VECTOR
> > +#ifdef CONFIG_ACPI
> > +static long __percpu *mshv_evt;
> > +#endif
> 
> Same comment here about the coding-style.rst guidelines.
> 
> Furthermore, mshv_evt could be directly defined here as a per-cpu "long",
> rather than a pointer to a long. Then you don't need to do a runtime
> per-cpu allocation with all the attendant error checking and cleanup, which
> saves about 10 lines of code. So
> 
> static DEFINE_PER_CPU(long, mshv_evt);
> 
> drivers/clocksource/hyperv_timer.c does the definition for stimer0_evt this
> way. I looked through all kernel code and found several other places doing
> the direct definition. I don't remember why I didn't do the direct method for
> vmbus_evt, but I'm planning to submit a patch to change it, which will drop
> a few lines of code.
> 
> > +
> > +static irqreturn_t mshv_percpu_isr(int irq, void *dev_id)
> > +{
> > +	mshv_isr();
> > +	return IRQ_HANDLED;
> > +}
> 
> This function generates a warning about being unused when !CONFIG_ACPI.
> But see further comments below.
> 
> > +
> > +static int __init mshv_sint_vector_init(void)
> > +{
> > +#ifdef CONFIG_ACPI
> > +	int ret;
> > +	struct hv_register_assoc reg = {
> > +		.name = HV_ARM64_REGISTER_SINT_RESERVED_INTERRUPT_ID,
> > +	};
> > +	union hv_input_vtl input_vtl = { 0 };
> > +
> > +	ret = hv_call_get_vp_registers(HV_VP_INDEX_SELF, HV_PARTITION_ID_SELF,
> > +				1, input_vtl, &reg);
> > +	if (ret || !reg.value.reg64)
> > +		return -ENODEV;
> > +
> > +	mshv_sint_vector = reg.value.reg64;
> > +	ret  = acpi_register_gsi(NULL, mshv_sint_vector, ACPI_EDGE_SENSITIVE,
> > +					ACPI_ACTIVE_HIGH);
> > +	if (ret < 0)
> > +		goto out_fail;
> > +
> > +	mshv_sint_irq = ret;
> > +
> > +	mshv_evt = alloc_percpu(long);
> > +	if (!mshv_evt) {
> > +		ret = -ENOMEM;
> > +		goto out_unregister;
> > +	}
> > +
> > +	ret = request_percpu_irq(mshv_sint_irq, mshv_percpu_isr, "MSHV",
> > +		mshv_evt);
> > +	if (ret)
> > +		goto free_evt;
> > +
> > +	return 0;
> > +
> > +free_evt:
> > +	free_percpu(mshv_evt);
> > +out_unregister:
> > +	acpi_unregister_gsi(mshv_sint_vector);
> > +out_fail:
> > +	return ret;
> > +#else
> > +	return -ENODEV;
> > +#endif
> > +}
> 
> I have several thoughts about the #ifdef CONFIG_ACPI.
> 
> The coding-style.rst guidelines in Section 21 also say:
> 
> Prefer to compile out entire functions, rather than portions of functions or
> portions of expressions.  Rather than putting an ifdef in an expression, factor
> out part or all of the expression into a separate helper function and apply the
> conditional to that function.
> 
> But more fundamentally, it looks like the #ifdef CONFIG_ACPI is there
> solely because acpi_register_gsi() exists only when CONFIG_ACPI is set.
> The rest of the code doesn't depend on ACPI. In the !CONFIG_ACPI case,
> your stub code returns -ENODEV, so doorbell & intercept SINTs just don't
> work, and pretty much everything is non-functional.
> 
> This patch doesn't allude to any future DeviceTree case that parallels ACPI,
> so I'm unsure what's expected in the future.  If such a future DT case is
> murky, perhaps drivers/hv/Kconfig should give MSHV_ROOT a dependency
> on ACPI. Then the #ifdef CONFIG_ACPI could be dropped, along with the
> #else stub code. When/if the DT use case comes along, the dependency
> can be removed and the code structured to handle both ACPI and DT.
> The code to fetch the INTID via the hypervisor synthetic register, and the
> request_percpu_irq() would be applicable to both. It's only the GSI
> registration that would be different, and that could be pulled out into a
> helper function that handles the difference in ACPI and DT. I haven't looked
> to see how DT does the equivalent of GSI registration.

The DT case will materialize in the future. Making MSHV_ROOT depend on
ACPI seems a bit drastic to me when all we want to do is follow the
coding style guideline that says "prefer to compile out entire
functions...".

> 
> Another approach would be to add stubs for acpi_register_gsi() and
> acpi_unregister_gsi() in include/linux/acpi.h.  A number of such stubs
> have been added over the years. Saurabh got one added in 2023
> (commit 1f6277bf716cc). Then the above code would compile even
> with !CONFIG_ACPI.  acpi_register_gsi() would fail, and you would get
> an error return. This approach produces cleaner code and is consistent
> with similar use cases that depend on stubs provided by include/linux/acpi.h
> rather than #ifdefs.

I'll send out a v5 which takes a simpler approach to conform to the
coding guidelines. I'll also address all the other comments from above.

Thanks,
Anirudh.


