Return-Path: <linux-hyperv+bounces-8747-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BkjDNXmhGlf6QMAu9opvQ
	(envelope-from <linux-hyperv+bounces-8747-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 05 Feb 2026 19:52:05 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC68F696B
	for <lists+linux-hyperv@lfdr.de>; Thu, 05 Feb 2026 19:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00E0C3022603
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Feb 2026 18:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A48308F2A;
	Thu,  5 Feb 2026 18:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="zJELxluK"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o55.zoho.com (sender4-of-o55.zoho.com [136.143.188.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A354267B07;
	Thu,  5 Feb 2026 18:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770317409; cv=pass; b=mK0EV5KFV32HFvXhvmGuWe3piDt/DhzkWKDDWzWU/LlPeWXDAna6tuTUPbeYeYE9+HX8EI7EqPTZNDp8uVcHJT8ZFD3/+2339ktJlCj+x6twpkfj5sP3TuDhGcw/93XR6ueoSdQAheuwqwTRWbucV2SBlmjaWObf2jslg4fKz7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770317409; c=relaxed/simple;
	bh=ebQfONrzVZnk56V1w8DGKsIG66VsIGGNTmswm/SYNUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zq79/zXDW6UTGUzS/PhlbdnzKCUxW9vA1g85q448S3LlZnz/NniZYHqaljuT8QeU8XqW5MFZspz8/onl7QzyMt9Bl2W/5Mmt6639o9cE2Xjn+NI7e1u2EzgmMDWJ1iTCvZDIapZ0CRRdw/gZkb3jVBMyO0fDCe1lVckiWuQu/GM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=zJELxluK; arc=pass smtp.client-ip=136.143.188.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1770317326; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=DLjgTy2wycUhNlMH3U19kIj6Pw/2ydCYHIl9vZTP7LPpf8mXzsOifu6giHW/ehqqYejFF8hNUztBGkMvfG3gnPdwXF7xAmCLOy0m3cWe8Sb2mt+8kNwXRVcNuoNhh0n6UFkak8SOpXnvnwcuCoPkNHS/QYRt+EkEIRHTUcUXVjc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1770317326; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=RJdbNFsY9TlOa05vzFHONREoEz/o2CSPjvLyu9KhCYc=; 
	b=C2h8MkmruQAlRleDlRtFISSjbIMlmMEVEFnSjLKnMXeFBiDtWYuFtgiJ7L5qjJ52ClIgGQ4Nz/G8h7abgSs8Bm9ImfDjyG7IeU18fLYKp6I6Q6F94rTxI/Q+lrts+NnpeYm6KqtEXUn8Bl4QRR9Tzjz5IMm6h30mYhPL4snfdsI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1770317326;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=RJdbNFsY9TlOa05vzFHONREoEz/o2CSPjvLyu9KhCYc=;
	b=zJELxluK7gj9saqdX+6tFXDkCkEScqN7AkKaoIUhtO4Hq5bsmyRuGmhqZvZsjDXK
	3yhV7O73n1cS0lMPeXSnbbRrgzwaxWp14SUP3XOyQ4uWp/RNV8T0/heFwrBkAcMrDdR
	LeMmcSn10zrVK2IGSRCamsedJZH6dpdb0gz/z8C4=
Received: by mx.zohomail.com with SMTPS id 1770317322465939.1179981344242;
	Thu, 5 Feb 2026 10:48:42 -0800 (PST)
Date: Fri, 6 Feb 2026 00:18:31 +0530
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Mukesh R <mrathor@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-arch@vger.kernel.org, kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org, 
	decui@microsoft.com, longli@microsoft.com, catalin.marinas@arm.com, will@kernel.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, 
	hpa@zytor.com, joro@8bytes.org, lpieralisi@kernel.org, kwilczynski@kernel.org, 
	mani@kernel.org, robh@kernel.org, bhelgaas@google.com, arnd@arndb.de, 
	nunodasneves@linux.microsoft.com, mhklinux@outlook.com, romank@linux.microsoft.com
Subject: Re: [PATCH v0 01/15] iommu/hyperv: rename hyperv-iommu.c to
 hyperv-irq.c
Message-ID: <ekeis5txhdipwwjlgywonvi43rbut2szihvzl4wkrdqkmh5mlt@udamdt7ff3vo>
References: <20260120064230.3602565-1-mrathor@linux.microsoft.com>
 <20260120064230.3602565-2-mrathor@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120064230.3602565-2-mrathor@linux.microsoft.com>
X-ZohoMailClient: External
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[anirudhrb.com:s=zoho];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[anirudhrb.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8747-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[anirudhrb.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anirudh@anirudhrb.com,linux-hyperv@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,lists.linux.dev,microsoft.com,kernel.org,arm.com,linutronix.de,redhat.com,alien8.de,linux.intel.com,zytor.com,8bytes.org,google.com,arndb.de,linux.microsoft.com,outlook.com];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[anirudhrb.com:email,anirudhrb.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AAC68F696B
X-Rspamd-Action: no action

On Mon, Jan 19, 2026 at 10:42:16PM -0800, Mukesh R wrote:
> From: Mukesh Rathor <mrathor@linux.microsoft.com>
> 
> This file actually implements irq remapping, so rename to more appropriate
> hyperv-irq.c. A new file named hyperv-iommu.c will be introduced later.
> Also, move CONFIG_IRQ_REMAP out of the file and add to Makefile.
> 
> Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>

Reviewed-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>

> ---
>  MAINTAINERS                                    | 2 +-
>  drivers/iommu/Kconfig                          | 1 +
>  drivers/iommu/Makefile                         | 2 +-
>  drivers/iommu/{hyperv-iommu.c => hyperv-irq.c} | 4 ----
>  4 files changed, 3 insertions(+), 6 deletions(-)
>  rename drivers/iommu/{hyperv-iommu.c => hyperv-irq.c} (99%)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5b11839cba9d..381a0e086382 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11741,7 +11741,7 @@ F:	drivers/hid/hid-hyperv.c
>  F:	drivers/hv/
>  F:	drivers/infiniband/hw/mana/
>  F:	drivers/input/serio/hyperv-keyboard.c
> -F:	drivers/iommu/hyperv-iommu.c
> +F:	drivers/iommu/hyperv-irq.c
>  F:	drivers/net/ethernet/microsoft/
>  F:	drivers/net/hyperv/
>  F:	drivers/pci/controller/pci-hyperv-intf.c
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index 99095645134f..b4cc2b42b338 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -355,6 +355,7 @@ config HYPERV_IOMMU
>  	bool "Hyper-V IRQ Handling"
>  	depends on HYPERV && X86
>  	select IOMMU_API
> +	select IRQ_REMAP
>  	default HYPERV
>  	help
>  	  Stub IOMMU driver to handle IRQs to support Hyper-V Linux
> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
> index 8e8843316c4b..598c39558e7d 100644
> --- a/drivers/iommu/Makefile
> +++ b/drivers/iommu/Makefile
> @@ -30,7 +30,7 @@ obj-$(CONFIG_TEGRA_IOMMU_SMMU) += tegra-smmu.o
>  obj-$(CONFIG_EXYNOS_IOMMU) += exynos-iommu.o
>  obj-$(CONFIG_FSL_PAMU) += fsl_pamu.o fsl_pamu_domain.o
>  obj-$(CONFIG_S390_IOMMU) += s390-iommu.o
> -obj-$(CONFIG_HYPERV_IOMMU) += hyperv-iommu.o
> +obj-$(CONFIG_HYPERV_IOMMU) += hyperv-irq.o
>  obj-$(CONFIG_VIRTIO_IOMMU) += virtio-iommu.o
>  obj-$(CONFIG_IOMMU_SVA) += iommu-sva.o
>  obj-$(CONFIG_IOMMU_IOPF) += io-pgfault.o
> diff --git a/drivers/iommu/hyperv-iommu.c b/drivers/iommu/hyperv-irq.c
> similarity index 99%
> rename from drivers/iommu/hyperv-iommu.c
> rename to drivers/iommu/hyperv-irq.c
> index 0961ac805944..1944440a5004 100644
> --- a/drivers/iommu/hyperv-iommu.c
> +++ b/drivers/iommu/hyperv-irq.c
> @@ -24,8 +24,6 @@
>  
>  #include "irq_remapping.h"
>  
> -#ifdef CONFIG_IRQ_REMAP
> -
>  /*
>   * According 82093AA IO-APIC spec , IO APIC has a 24-entry Interrupt
>   * Redirection Table. Hyper-V exposes one single IO-APIC and so define
> @@ -330,5 +328,3 @@ static const struct irq_domain_ops hyperv_root_ir_domain_ops = {
>  	.alloc = hyperv_root_irq_remapping_alloc,
>  	.free = hyperv_root_irq_remapping_free,
>  };
> -
> -#endif
> -- 
> 2.51.2.vfs.0.1
> 

