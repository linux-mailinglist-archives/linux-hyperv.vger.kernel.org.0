Return-Path: <linux-hyperv+bounces-10800-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cILTB64BA2pczgEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10800-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 12:32:14 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 879B951E9DF
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 12:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 406793050267
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 10:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0FA255F2C;
	Tue, 12 May 2026 10:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="bKog0cPf"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4AC7395AD7;
	Tue, 12 May 2026 10:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778581576; cv=none; b=o0CFFvPjQAWCQSCvw0dq927zKUFdEfSQR6zhJBnHuEdRNLGwhECOJ3T2LXMTTyi0QtJbJjkzT6E30ygBNS5yfJfSxIsmiZ11fBf5xAdKgkeibonzW5T29O8juVzKlxonH5FNuMYYMrbt8+dlxqPCmdcdkKDb14b3LbPTVK6RuRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778581576; c=relaxed/simple;
	bh=p2px6H+WTEk/NCl9roM9isjrVup2rBnxKf5K7cPz+1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dSdgfipbHOeQFXS/KxHHH5fF/6kmBAIC73We9rB7KvpOQFlGxOdGTVD50r7O/nUCDYWQO35NjI2mWGqFj5Nu6+rwDK2Du//2Vnxn+pHj9Z10CCCx/oHK6vSKFo8pOgpTqoBEZOssFb2duMnyvvf/zTEDddqsadIhZ+6O+2iz4Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=bKog0cPf; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1099)
	id 52D5C20B7166; Tue, 12 May 2026 03:26:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 52D5C20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778581572;
	bh=A3fdTJavZcamyWjE/iWjcMnfv2Zd92fLhKuCUIKfZB0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bKog0cPfmxc/YHvPjQ/jWyN0newyW9ui6x3e20xbi6xQ+BpUdZy5Yh9z/eorOYtBm
	 vLTg9j+Vp7KQj0497z94XKR8bMrJEixzBr+0+nW9N62QQ3QVFCuWEYnApYmsdbIOp4
	 E15RVLhktN4Fw5j7ulpQ5bWYl5Z8lb4VxMgmwyGE=
Date: Tue, 12 May 2026 03:26:12 -0700
From: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
To: Mukesh R <mrathor@linux.microsoft.com>
Cc: hpa@zytor.com, robin.murphy@arm.com, robh@kernel.org,
	wei.liu@kernel.org, mhklinux@outlook.com, muislam@microsoft.com,
	namjain@linux.microsoft.com, magnuskulke@linux.microsoft.com,
	anbelski@linux.microsoft.com, linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org, iommu@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
	longli@microsoft.com, tglx@kernel.org, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	joro@8bytes.org, will@kernel.org, lpieralisi@kernel.org,
	kwilczynski@kernel.org, bhelgaas@google.com, arnd@arndb.de,
	jacob.pan@linux.microsoft.com
Subject: Re: [PATCH V3 01/11] iommu/hyperv: Rename hyperv-iommu.c to
 hyperv-irq.c
Message-ID: <agMARN3DHTFPeHFH@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260512020259.1678627-1-mrathor@linux.microsoft.com>
 <20260512020259.1678627-2-mrathor@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512020259.1678627-2-mrathor@linux.microsoft.com>
X-Rspamd-Queue-Id: 879B951E9DF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10800-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[zytor.com,arm.com,kernel.org,outlook.com,microsoft.com,linux.microsoft.com,vger.kernel.org,lists.linux.dev,redhat.com,alien8.de,linux.intel.com,8bytes.org,google.com,arndb.de];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[schakrabarti@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,anirudhrb.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 07:02:49PM -0700, Mukesh R wrote:
> This file actually implements irq remapping, so rename to more appropriate
> hyperv-irq.c. A new file to implement hyperv iommu will be introduced
> later.  Also, it should not be tied to HYPERV_IOMMU, but to CONFIG_HYPERV
> and IRQ_REMAP. The file already has #ifdef CONFIG_IRQ_REMAP.
> 
> Reviewed-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
Reviewed-by: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
> Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
> ---
>  MAINTAINERS                                    | 2 +-
>  drivers/iommu/Makefile                         | 2 +-
>  drivers/iommu/{hyperv-iommu.c => hyperv-irq.c} | 6 +++---
>  drivers/iommu/irq_remapping.c                  | 2 +-
>  4 files changed, 6 insertions(+), 6 deletions(-)
>  rename drivers/iommu/{hyperv-iommu.c => hyperv-irq.c} (99%)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d1cc0e12fe1f..f803a6a38fee 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11914,7 +11914,7 @@ F:	drivers/clocksource/hyperv_timer.c
>  F:	drivers/hid/hid-hyperv.c
>  F:	drivers/hv/
>  F:	drivers/input/serio/hyperv-keyboard.c
> -F:	drivers/iommu/hyperv-iommu.c
> +F:	drivers/iommu/hyperv-irq.c
>  F:	drivers/net/ethernet/microsoft/
>  F:	drivers/net/hyperv/
>  F:	drivers/pci/controller/pci-hyperv-intf.c
> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
> index 0275821f4ef9..335ea77cced6 100644
> --- a/drivers/iommu/Makefile
> +++ b/drivers/iommu/Makefile
> @@ -30,7 +30,7 @@ obj-$(CONFIG_TEGRA_IOMMU_SMMU) += tegra-smmu.o
>  obj-$(CONFIG_EXYNOS_IOMMU) += exynos-iommu.o
>  obj-$(CONFIG_FSL_PAMU) += fsl_pamu.o fsl_pamu_domain.o
>  obj-$(CONFIG_S390_IOMMU) += s390-iommu.o
> -obj-$(CONFIG_HYPERV_IOMMU) += hyperv-iommu.o
> +obj-$(CONFIG_HYPERV) += hyperv-irq.o
>  obj-$(CONFIG_VIRTIO_IOMMU) += virtio-iommu.o
>  obj-$(CONFIG_IOMMU_SVA) += iommu-sva.o
>  obj-$(CONFIG_IOMMU_IOPF) += io-pgfault.o
> diff --git a/drivers/iommu/hyperv-iommu.c b/drivers/iommu/hyperv-irq.c
> similarity index 99%
> rename from drivers/iommu/hyperv-iommu.c
> rename to drivers/iommu/hyperv-irq.c
> index 479103261ae6..d11076f906fb 100644
> --- a/drivers/iommu/hyperv-iommu.c
> +++ b/drivers/iommu/hyperv-irq.c
> @@ -8,6 +8,8 @@
>   * Author : Lan Tianyu <Tianyu.Lan@microsoft.com>
>   */
>  
> +#ifdef CONFIG_IRQ_REMAP
> +
>  #include <linux/types.h>
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
> @@ -24,8 +26,6 @@
>  
>  #include "irq_remapping.h"
>  
> -#ifdef CONFIG_IRQ_REMAP
> -
>  /*
>   * According 82093AA IO-APIC spec , IO APIC has a 24-entry Interrupt
>   * Redirection Table. Hyper-V exposes one single IO-APIC and so define
> @@ -331,4 +331,4 @@ static const struct irq_domain_ops hyperv_root_ir_domain_ops = {
>  	.free = hyperv_root_irq_remapping_free,
>  };
>  
> -#endif
> +#endif  /* CONFIG_IRQ_REMAP */
> diff --git a/drivers/iommu/irq_remapping.c b/drivers/iommu/irq_remapping.c
> index c2443659812a..41bf65e4ea88 100644
> --- a/drivers/iommu/irq_remapping.c
> +++ b/drivers/iommu/irq_remapping.c
> @@ -108,7 +108,7 @@ int __init irq_remapping_prepare(void)
>  	else if (IS_ENABLED(CONFIG_AMD_IOMMU) &&
>  		 amd_iommu_irq_ops.prepare() == 0)
>  		remap_ops = &amd_iommu_irq_ops;
> -	else if (IS_ENABLED(CONFIG_HYPERV_IOMMU) &&
> +	else if (IS_ENABLED(CONFIG_HYPERV) &&
>  		 hyperv_irq_remap_ops.prepare() == 0)
>  		remap_ops = &hyperv_irq_remap_ops;
>  	else
> -- 
> 2.51.2.vfs.0.1
> 

