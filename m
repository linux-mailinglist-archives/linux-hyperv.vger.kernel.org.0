Return-Path: <linux-hyperv+bounces-8960-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHbnLi2tnGlyJwQAu9opvQ
	(envelope-from <linux-hyperv+bounces-8960-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Feb 2026 20:40:29 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3EA17C7AD
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Feb 2026 20:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71B8E30A9A85
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Feb 2026 19:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2734E36F426;
	Mon, 23 Feb 2026 19:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="AQgOg3l8"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A9F23AB8D;
	Mon, 23 Feb 2026 19:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771875587; cv=none; b=aEDzWqhxEAJ2Nldx/SQSbQVbY/yuqOofwkWPpQtuep4P0K6V4s8UcnEZqGCLKeysDxMzvV+P5MGD08IgHAryms8RcqqdQnCM7c2IQpe/rsLH1+d6fCi+uZRDrpbspTPD4VkmDG/isvsdsnW28bP7OE7cw+4t7nUYtBz5gH5e2Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771875587; c=relaxed/simple;
	bh=KIswDDSEQ1izmUIwm3ajDaBBk1UlvtUi2hJqzRz0MxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F8gDv2hQiIXcz0zO0CiZK4cHXlsOEYAWs4EuD7+cHGWLaeg3njtdTY3en7sbEERRUvwri2T8+TnYen7f85m8LQ65ImqMXny8RqsoIS3XOrGlk5536hZjVuT2EXBZdpCOdyg1WSjxUUQUczFL4lQlx/UrTX0NtYCVdDLX7/pXH7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=AQgOg3l8; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (unknown [52.148.138.235])
	by linux.microsoft.com (Postfix) with ESMTPSA id DAD9F20B6F00;
	Mon, 23 Feb 2026 11:39:44 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DAD9F20B6F00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1771875585;
	bh=xB2fJTENXbKiIrYCt5rvNzN1rr//PhiFVVCnGSwt4LA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AQgOg3l8dnnRSiERlDKQ8xq7Z90/JK6UFoZxVeX5R3QuEILRPFYZRX6PdGFEdZdtl
	 At+Ue75Bud18OKutijJQCOjm3Bpu7A6jiVqBeh8575zeijqYqMqPe7Ll8oea/5wRX/
	 0kp6buizUAUP3+VEmiwR4P2iUGwLz0bChyQ+gY/I=
Date: Mon, 23 Feb 2026 11:39:43 -0800
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Anirudh Rayabharam <anirudh@anirudhrb.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] mshv: add arm64 support for doorbell & intercept
 SINTs
Message-ID: <aZys_5A657AYq5DQ@skinsburskii.localdomain>
References: <20260223140159.1627229-1-anirudh@anirudhrb.com>
 <20260223140159.1627229-3-anirudh@anirudhrb.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223140159.1627229-3-anirudh@anirudhrb.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8960-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[anirudhrb.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,skinsburskii.localdomain:mid]
X-Rspamd-Queue-Id: 1E3EA17C7AD
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 02:01:59PM +0000, Anirudh Rayabharam wrote:
> From: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
> 
> On x86, the HYPERVISOR_CALLBACK_VECTOR is used to receive synthetic
> interrupts (SINTs) from the hypervisor for doorbells and intercepts.
> There is no such vector reserved for arm64.
> 
> On arm64, the hypervisor exposes a synthetic register that can be read
> to find the INTID that should be used for SINTs. This INTID is in the
> PPI range.
> 
> To better unify the code paths, introduce mshv_sint_vector_init() that
> either reads the synthetic register and obtains the INTID (arm64) or
> just uses HYPERVISOR_CALLBACK_VECTOR as the interrupt vector (x86).
> 
> Signed-off-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
> ---
>  drivers/hv/mshv_synic.c     | 120 +++++++++++++++++++++++++++++++++---
>  include/hyperv/hvgdk_mini.h |   2 +
>  2 files changed, 112 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/hv/mshv_synic.c b/drivers/hv/mshv_synic.c
> index 074e37c48876..75ef2160b3e0 100644
> --- a/drivers/hv/mshv_synic.c
> +++ b/drivers/hv/mshv_synic.c
> @@ -10,17 +10,22 @@
>  #include <linux/kernel.h>
>  #include <linux/slab.h>
>  #include <linux/mm.h>
> +#include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/random.h>
>  #include <linux/cpuhotplug.h>
>  #include <linux/reboot.h>
>  #include <asm/mshyperv.h>
> +#include <linux/platform_device.h>
> +#include <linux/acpi.h>
>  
>  #include "mshv_eventfd.h"
>  #include "mshv.h"
>  
>  static int synic_cpuhp_online;
>  static struct hv_synic_pages __percpu *synic_pages;
> +static int mshv_sint_vector = -1; /* hwirq for the SynIC SINTs */
> +static int mshv_sint_irq = -1; /* Linux IRQ for mshv_sint_vector */
>  
>  static u32 synic_event_ring_get_queued_port(u32 sint_index)
>  {
> @@ -442,9 +447,7 @@ void mshv_isr(void)
>  		if (msg->header.message_flags.msg_pending)
>  			hv_set_non_nested_msr(HV_MSR_EOM, 0);
>  
> -#ifdef HYPERVISOR_CALLBACK_VECTOR
> -		add_interrupt_randomness(HYPERVISOR_CALLBACK_VECTOR);
> -#endif
> +		add_interrupt_randomness(mshv_sint_vector);
>  	} else {
>  		pr_warn_once("%s: unknown message type 0x%x\n", __func__,
>  			     msg->header.message_type);
> @@ -456,9 +459,7 @@ static int mshv_synic_cpu_init(unsigned int cpu)
>  	union hv_synic_simp simp;
>  	union hv_synic_siefp siefp;
>  	union hv_synic_sirbp sirbp;
> -#ifdef HYPERVISOR_CALLBACK_VECTOR
>  	union hv_synic_sint sint;
> -#endif
>  	union hv_synic_scontrol sctrl;
>  	struct hv_synic_pages *spages = this_cpu_ptr(synic_pages);
>  	struct hv_message_page **msg_page = &spages->hyp_synic_message_page;
> @@ -501,10 +502,12 @@ static int mshv_synic_cpu_init(unsigned int cpu)
>  
>  	hv_set_non_nested_msr(HV_MSR_SIRBP, sirbp.as_uint64);
>  
> -#ifdef HYPERVISOR_CALLBACK_VECTOR
> +	if (mshv_sint_irq != -1)
> +		enable_percpu_irq(mshv_sint_irq, 0);
> +
>  	/* Enable intercepts */
>  	sint.as_uint64 = 0;
> -	sint.vector = HYPERVISOR_CALLBACK_VECTOR;
> +	sint.vector = mshv_sint_vector;
>  	sint.masked = false;
>  	sint.auto_eoi = hv_recommend_using_aeoi();
>  	hv_set_non_nested_msr(HV_MSR_SINT0 + HV_SYNIC_INTERCEPTION_SINT_INDEX,
> @@ -512,13 +515,12 @@ static int mshv_synic_cpu_init(unsigned int cpu)
>  
>  	/* Doorbell SINT */
>  	sint.as_uint64 = 0;
> -	sint.vector = HYPERVISOR_CALLBACK_VECTOR;
> +	sint.vector = mshv_sint_vector;
>  	sint.masked = false;
>  	sint.as_intercept = 1;
>  	sint.auto_eoi = hv_recommend_using_aeoi();
>  	hv_set_non_nested_msr(HV_MSR_SINT0 + HV_SYNIC_DOORBELL_SINT_INDEX,
>  			      sint.as_uint64);
> -#endif
>  
>  	/* Enable global synic bit */
>  	sctrl.as_uint64 = hv_get_non_nested_msr(HV_MSR_SCONTROL);
> @@ -573,6 +575,9 @@ static int mshv_synic_cpu_exit(unsigned int cpu)
>  	hv_set_non_nested_msr(HV_MSR_SINT0 + HV_SYNIC_DOORBELL_SINT_INDEX,
>  			      sint.as_uint64);
>  
> +	if (mshv_sint_irq != -1)
> +		disable_percpu_irq(mshv_sint_irq);
> +
>  	/* Disable Synic's event ring page */
>  	sirbp.as_uint64 = hv_get_non_nested_msr(HV_MSR_SIRBP);
>  	sirbp.sirbp_enabled = false;
> @@ -683,14 +688,106 @@ static struct notifier_block mshv_synic_reboot_nb = {
>  	.notifier_call = mshv_synic_reboot_notify,
>  };
>  
> +#ifndef HYPERVISOR_CALLBACK_VECTOR
> +static DEFINE_PER_CPU(long, mshv_evt);
> +
> +static irqreturn_t mshv_percpu_isr(int irq, void *dev_id)
> +{
> +	mshv_isr();
> +	return IRQ_HANDLED;
> +}
> +
> +#ifdef CONFIG_ACPI
> +static int __init mshv_acpi_setup_sint_irq(void)
> +{
> +	return acpi_register_gsi(NULL, mshv_sint_vector, ACPI_EDGE_SENSITIVE,
> +					ACPI_ACTIVE_HIGH);
> +}
> +
> +static void mshv_acpi_cleanup_sint_irq(void)
> +{
> +	acpi_unregister_gsi(mshv_sint_vector);
> +}
> +#else
> +static int __init mshv_acpi_setup_sint_irq(void)
> +{
> +	return -ENODEV;
> +}
> +
> +static void mshv_acpi_cleanup_sint_irq(void)
> +{
> +}
> +#endif
> +
> +static int __init mshv_sint_vector_init(void)
> +{
> +	int ret;
> +	struct hv_register_assoc reg = {
> +		.name = HV_ARM64_REGISTER_SINT_RESERVED_INTERRUPT_ID,
> +	};
> +	union hv_input_vtl input_vtl = { 0 };
> +
> +	if (acpi_disabled)
> +		return -ENODEV;
> +
> +	ret = hv_call_get_vp_registers(HV_VP_INDEX_SELF, HV_PARTITION_ID_SELF,
> +				1, input_vtl, &reg);
> +	if (ret || !reg.value.reg64)
> +		return -ENODEV;
> +
> +	mshv_sint_vector = reg.value.reg64;
> +	ret = mshv_acpi_setup_sint_irq();
> +	if (ret <= 0) {
> +		pr_err("Failed to setup IRQ for MSHV SINT vector %d: %d\n",
> +			mshv_sint_vector, ret);
> +		goto out_fail;
> +	}
> +
> +	mshv_sint_irq = ret;

nit: given that mshv_sint_irq can't be zero, the logic can be simplified by
using 0 instead of -1.



> +
> +	ret = request_percpu_irq(mshv_sint_irq, mshv_percpu_isr, "MSHV",
> +		&mshv_evt);
> +	if (ret)
> +		goto out_unregister;
> +
> +	return 0;
> +
> +out_unregister:
> +	mshv_acpi_cleanup_sint_irq();
> +out_fail:
> +	return ret;
> +}
> +
> +static void mshv_sint_vector_cleanup(void)
> +{
> +	free_percpu_irq(mshv_sint_irq, &mshv_evt);
> +	mshv_acpi_cleanup_sint_irq();
> +}
> +#else /* !HYPERVISOR_CALLBACK_VECTOR */
> +static int __init mshv_sint_vector_init(void)

nit: `init` is usually paired with `exit` or `fini`, so maybe `cleanup` can be
renamed to `exit` as well for better consistency?

Reviewed-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>

> +{
> +	mshv_sint_vector = HYPERVISOR_CALLBACK_VECTOR;
> +	return 0;
> +}
> +
> +static void mshv_sint_vector_cleanup(void)
> +{
> +}
> +#endif /* HYPERVISOR_CALLBACK_VECTOR */
> +
>  int __init mshv_synic_init(struct device *dev)
>  {
>  	int ret = 0;
>  
> +	ret = mshv_sint_vector_init();
> +	if (ret)
> +		return ret;
> +
>  	synic_pages = alloc_percpu(struct hv_synic_pages);
>  	if (!synic_pages) {
>  		dev_err(dev, "Failed to allocate percpu synic page\n");
> -		return -ENOMEM;
> +		ret = -ENOMEM;
> +		goto sint_vector_cleanup;
>  	}
>  
>  	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "mshv_synic",
> @@ -713,6 +810,8 @@ int __init mshv_synic_init(struct device *dev)
>  	cpuhp_remove_state(synic_cpuhp_online);
>  free_synic_pages:
>  	free_percpu(synic_pages);
> +sint_vector_cleanup:
> +	mshv_sint_vector_cleanup();
>  	return ret;
>  }
>  
> @@ -721,4 +820,5 @@ void mshv_synic_cleanup(void)
>  	unregister_reboot_notifier(&mshv_synic_reboot_nb);
>  	cpuhp_remove_state(synic_cpuhp_online);
>  	free_percpu(synic_pages);
> +	mshv_sint_vector_cleanup();
>  }
> diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
> index 30fbbde81c5c..7676f78e0766 100644
> --- a/include/hyperv/hvgdk_mini.h
> +++ b/include/hyperv/hvgdk_mini.h
> @@ -1117,6 +1117,8 @@ enum hv_register_name {
>  	HV_X64_REGISTER_MSR_MTRR_FIX4KF8000	= 0x0008007A,
>  
>  	HV_X64_REGISTER_REG_PAGE	= 0x0009001C,
> +#elif defined(CONFIG_ARM64)
> +	HV_ARM64_REGISTER_SINT_RESERVED_INTERRUPT_ID	= 0x00070001,
>  #endif
>  };
>  
> -- 
> 2.34.1
> 

