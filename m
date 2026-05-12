Return-Path: <linux-hyperv+bounces-10797-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBh5CZ2zAmp2vwEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10797-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 06:59:09 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 971B0519B42
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 06:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 256983025E52
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 04:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22E233122D;
	Tue, 12 May 2026 04:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="CI1ArQZT"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FDFE31B838;
	Tue, 12 May 2026 04:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778561946; cv=none; b=WVwEhq3XEYnzj7vQ4TOa5tBEz4KFEVP/t8PqWg2b5U7eTnD9J5Cap9ZdqcQBVXjvn0cCO1V2wJWSSF8msHvqlDMewRKO4VSvGY+SYm1hIViSlvWcSeK/1jxJ9icTaTs2a+T30mE7qU+/+iDaax5C2Y2az1qGQnNAPctMTIwJO7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778561946; c=relaxed/simple;
	bh=TvQkbCpBAwWmu/+s0/683PQaLuNtS6G4/9C8St/egB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EraGqvQVrJkJgZ0tnnxmEzl9wbK/TQ6DpRbn923qDgOFq1L0vmqz1DHgWkNCTjkqs1a1Dj7/iw5Mgtsj56SBwa+M25chOjKuHj4e4lMKaTZP5P7jIhoYfJ2/3PDcET5SNjDeohXQjqV4cFds/7qk8RphkueQUQY4294NKp5tUqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=CI1ArQZT; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1099)
	id DEA0C20B7166; Mon, 11 May 2026 21:59:01 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DEA0C20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778561941;
	bh=Ct2zox4LNaFQs4SrzFzo0qnDAt+wwOMkCjNjaObBP1w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CI1ArQZT/OgZjHmn5SqzOI3XEf+nL8o+BsRStOnwZlz8wxDQD4IR5dy7KhF3EJ/07
	 CvPNuDOYl3oTa6fNTLp8vxKJqlp5IycfbM3mCaopVnC0m9AZb+ZmGyLfgWW/9ulLps
	 1kWRQAVeDL7y+MELf57k41+iMf4N6Ld0Lj8hdXvQ=
Date: Mon, 11 May 2026 21:59:01 -0700
From: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
To: Mukesh R <mrathor@linux.microsoft.com>
Cc: hpa@zytor.com, robin.murphy@arm.com, robh@kernel.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: Re: [PATCH V1 1/3] mshv: Import declarations for irq remap and add
 irqbypass support
Message-ID: <agKzlfagq4Sh7ua3@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260512021242.1679786-1-mrathor@linux.microsoft.com>
 <20260512021242.1679786-2-mrathor@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512021242.1679786-2-mrathor@linux.microsoft.com>
X-Rspamd-Queue-Id: 971B0519B42
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10797-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[schakrabarti@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.microsoft.com:dkim,linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net:mid]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 07:12:40PM -0700, Mukesh R wrote:
> For the irq map/remap hypercalls, copy relevant data structures from
> hypervisor public headers into Linux equivalents. Also, update Kconfig and
> mshv_irqfd for irqbypass. Please note, irqbypass is required for doing
> passthru on MSHV. This because there is really no way of knowing the linux
> irq in the mshv_irqfd_assign and mshv_irqfd_update paths without it. The
> linux irq is setup upfront by VFIO before irqfd assign/update happens.
> 
Reviewed-by: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
> Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
> ---
>  drivers/hv/Kconfig          |  1 +
>  drivers/hv/mshv_eventfd.h   |  3 +++
>  include/hyperv/hvgdk_mini.h |  3 +++
>  include/hyperv/hvhdk.h      | 17 +++++++++++++++++
>  4 files changed, 24 insertions(+)
> 
> diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> index 7937ac0cbd0f..c831fe25ca2b 100644
> --- a/drivers/hv/Kconfig
> +++ b/drivers/hv/Kconfig
> @@ -75,6 +75,7 @@ config MSHV_ROOT
>  	# no particular order, making it impossible to reassemble larger pages
>  	depends on PAGE_SIZE_4KB
>  	select EVENTFD
> +	select IRQ_BYPASS_MANAGER
>  	select VIRT_XFER_TO_GUEST_WORK
>  	select HMM_MIRROR
>  	select MMU_NOTIFIER
> diff --git a/drivers/hv/mshv_eventfd.h b/drivers/hv/mshv_eventfd.h
> index 464c6b81ab33..ff4dd24b8ad4 100644
> --- a/drivers/hv/mshv_eventfd.h
> +++ b/drivers/hv/mshv_eventfd.h
> @@ -9,6 +9,7 @@
>  #define __LINUX_MSHV_EVENTFD_H
>  
>  #include <linux/poll.h>
> +#include <linux/irqbypass.h>
>  
>  #include "mshv.h"
>  #include "mshv_root.h"
> @@ -37,6 +38,8 @@ struct mshv_irqfd {
>  	struct mshv_irqfd_resampler	    *irqfd_resampler;
>  	struct eventfd_ctx		    *irqfd_resamplefd;
>  	struct hlist_node		     irqfd_resampler_hnode;
> +	struct irq_bypass_consumer	     irqfd_bypass_cons;
> +	struct irq_bypass_producer	    *irqfd_bypass_prod;
>  };
>  
>  void mshv_eventfd_init(struct mshv_partition *partition);
> diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
> index da622fb06440..1ef480825705 100644
> --- a/include/hyperv/hvgdk_mini.h
> +++ b/include/hyperv/hvgdk_mini.h
> @@ -59,6 +59,8 @@ struct hv_u128 {
>  #define HV_PARTITION_ID_INVALID		((u64)0)
>  #define HV_PARTITION_ID_SELF		((u64)-1)
>  
> +#define HV_MAX_VPS    256               /* HV_MAXIMUM_PROCESSORS */
> +
>  /* Hyper-V specific model specific registers (MSRs) */
>  
>  #if defined(CONFIG_X86)
> @@ -508,6 +510,7 @@ union hv_vp_assist_msr_contents {	 /* HV_REGISTER_VP_ASSIST_PAGE */
>  #define HVCALL_UNMAP_VP_STATE_PAGE			0x00e2
>  #define HVCALL_GET_VP_STATE				0x00e3
>  #define HVCALL_SET_VP_STATE				0x00e4
> +#define HVCALL_GET_VPSET_FROM_MDA                       0x00e5
>  #define HVCALL_GET_VP_CPUID_VALUES			0x00f4
>  #define HVCALL_GET_PARTITION_PROPERTY_EX		0x0101
>  #define HVCALL_MMIO_READ				0x0106
> diff --git a/include/hyperv/hvhdk.h b/include/hyperv/hvhdk.h
> index 5e83d3714966..d0a892347ab1 100644
> --- a/include/hyperv/hvhdk.h
> +++ b/include/hyperv/hvhdk.h
> @@ -952,4 +952,21 @@ struct hv_input_modify_sparse_spa_page_host_access {
>  #define HV_MODIFY_SPA_PAGE_HOST_ACCESS_LARGE_PAGE      0x4
>  #define HV_MODIFY_SPA_PAGE_HOST_ACCESS_HUGE_PAGE       0x8
>  
> +#ifdef CONFIG_X86
> +
> +struct hv_input_get_vp_set_from_mda {   /* HV_OUTPUT_GET_VP_SET_FROM_MDA */
> +	u64 target_partid;
> +	u64 dest_address;
> +	u8  input_vtl;
> +	u8  destmode_logical;         /* true => mode is logical */
> +	u16 reserved0;                /* mbz */
> +	u32 reserved1;                /* mbz */
> +} __packed;
> +
> +union hv_output_get_vp_set_from_mda {  /* HV_OUTPUT_GET_VP_SET_FROM_MDA */
> +	struct hv_vpset target_vpset;
> +	u64 bitset_buffer[HV_GENERIC_SET_QWORD_COUNT(HV_MAX_VPS)];
> +} __packed;
> +
> +#endif /* CONFIG_X86 */
>  #endif /* _HV_HVHDK_H */
> -- 
> 2.51.2.vfs.0.1
> 

