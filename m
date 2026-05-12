Return-Path: <linux-hyperv+bounces-10812-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNfkMda7A2o69gEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10812-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 01:46:30 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E95452B622
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 01:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C4BB9302C32C
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 23:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC4434844C;
	Tue, 12 May 2026 23:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="jVClisg0"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534CA2701D9;
	Tue, 12 May 2026 23:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778629589; cv=none; b=plmlEbQ90em4q5B6qXUqojw89ko1pqFfIVyCbxDKLSspa1Zv3OQQVoB8uQbtdRmi6LVHg8MlL/u8md6EvAz6r2o1jyR0fplfQnSj7AoEF9J4Ealpyqss4JK67D7LbbQrFA0JRrBlWPHJojR0z3kajQJ2Xkxz0P0R/T//yZIIqaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778629589; c=relaxed/simple;
	bh=FTJzMUtpDxMsViv9QqRBnWPgeawjazxvHzHLI5HSyaM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tGIqtuVjZcrhSe3kjPe9n8VaQcfGDTnZ9hoz9wHD/T/liTOf/JymIo0gHEtCTeql9ThSvtdYkV1WvAvjUPpDwJYYM9l9f7n3K5Xb4k4IB0fu1lj0818r2tc6mWOV7IPNDpOgmLKHQJWnP7BK8sYnpNvfF2DRv64M7iVhNtx4V9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=jVClisg0; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from localhost (unknown [20.236.10.120])
	by linux.microsoft.com (Postfix) with ESMTPSA id E180F20B7166;
	Tue, 12 May 2026 16:46:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E180F20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778629583;
	bh=f4N/wfKln7imnALeCnQutar/c2KnFHRrOnxltkjQEgc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jVClisg0i96folTh6S1DuF9lPpJ0SGE8UPnaUlN9nS/TOaFQKIlgmbsBoSFv2bjdw
	 KoA+3M8t/s/LZ8VpxsaoHfToOesSG0zfO4Vj4nfiALtbfzf5aUFkS+me9FxKmw0IHR
	 gSbfgJ4YspiLPcVU/PVyumPHwgSp4ZCiAUSMSIXQ=
Date: Tue, 12 May 2026 16:46:23 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Mukesh R <mrathor@linux.microsoft.com>
Cc: hpa@zytor.com, robin.murphy@arm.com, robh@kernel.org,
 wei.liu@kernel.org, mhklinux@outlook.com, muislam@microsoft.com,
 namjain@linux.microsoft.com, magnuskulke@linux.microsoft.com,
 anbelski@linux.microsoft.com, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org, iommu@lists.linux.dev,
 linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, kys@microsoft.com,
 haiyangz@microsoft.com, decui@microsoft.com, longli@microsoft.com,
 tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, joro@8bytes.org,
 will@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
 bhelgaas@google.com, arnd@arndb.de, jacob.pan@linux.microsoft.com
Subject: Re: [PATCH V3 01/11] iommu/hyperv: Rename hyperv-iommu.c to
 hyperv-irq.c
Message-ID: <20260512164623.0000273f@linux.microsoft.com>
In-Reply-To: <20260512020259.1678627-2-mrathor@linux.microsoft.com>
References: <20260512020259.1678627-1-mrathor@linux.microsoft.com>
	<20260512020259.1678627-2-mrathor@linux.microsoft.com>
Organization: LSG
X-Mailer: Claws Mail 3.21.0 (GTK+ 2.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 6E95452B622
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	TAGGED_FROM(0.00)[bounces-10812-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	FREEMAIL_CC(0.00)[zytor.com,arm.com,kernel.org,outlook.com,microsoft.com,linux.microsoft.com,vger.kernel.org,lists.linux.dev,redhat.com,alien8.de,linux.intel.com,8bytes.org,google.com,arndb.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.pan@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,anirudhrb.com:email]
X-Rspamd-Action: no action

Hi Mukesh,

On Mon, 11 May 2026 19:02:49 -0700
Mukesh R <mrathor@linux.microsoft.com> wrote:

> This file actually implements irq remapping, so rename to more
> appropriate hyperv-irq.c. A new file to implement hyperv iommu will
> be introduced later.  Also, it should not be tied to HYPERV_IOMMU,
> but to CONFIG_HYPERV and IRQ_REMAP. The file already has #ifdef
> CONFIG_IRQ_REMAP.
>=20
> Reviewed-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
> Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
> ---
>  MAINTAINERS                                    | 2 +-
>  drivers/iommu/Makefile                         | 2 +-
>  drivers/iommu/{hyperv-iommu.c =3D> hyperv-irq.c} | 6 +++---
Given that we have multiple Hyper-V IOMMU-related files =E2=80=94 this rena=
med
hyperv-irq.c, the existing hyperv-iommu code, iommu-root (this
series) and the recently posted guest pvIOMMU driver =E2=80=94 should we cr=
eate
a drivers/iommu/hyperv/ directory to consolidate them?

>  drivers/iommu/irq_remapping.c                  | 2 +-
>  4 files changed, 6 insertions(+), 6 deletions(-)
>  rename drivers/iommu/{hyperv-iommu.c =3D> hyperv-irq.c} (99%)
>=20
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
> @@ -30,7 +30,7 @@ obj-$(CONFIG_TEGRA_IOMMU_SMMU) +=3D tegra-smmu.o
>  obj-$(CONFIG_EXYNOS_IOMMU) +=3D exynos-iommu.o
>  obj-$(CONFIG_FSL_PAMU) +=3D fsl_pamu.o fsl_pamu_domain.o
>  obj-$(CONFIG_S390_IOMMU) +=3D s390-iommu.o
> -obj-$(CONFIG_HYPERV_IOMMU) +=3D hyperv-iommu.o
> +obj-$(CONFIG_HYPERV) +=3D hyperv-irq.o
>  obj-$(CONFIG_VIRTIO_IOMMU) +=3D virtio-iommu.o
>  obj-$(CONFIG_IOMMU_SVA) +=3D iommu-sva.o
>  obj-$(CONFIG_IOMMU_IOPF) +=3D io-pgfault.o
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
> =20
> +#ifdef CONFIG_IRQ_REMAP
> +
>  #include <linux/types.h>
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
> @@ -24,8 +26,6 @@
> =20
>  #include "irq_remapping.h"
> =20
> -#ifdef CONFIG_IRQ_REMAP
> -
>  /*
>   * According 82093AA IO-APIC spec , IO APIC has a 24-entry Interrupt
>   * Redirection Table. Hyper-V exposes one single IO-APIC and so
> define @@ -331,4 +331,4 @@ static const struct irq_domain_ops
> hyperv_root_ir_domain_ops =3D { .free =3D hyperv_root_irq_remapping_free,
>  };
> =20
> -#endif
> +#endif  /* CONFIG_IRQ_REMAP */
> diff --git a/drivers/iommu/irq_remapping.c
> b/drivers/iommu/irq_remapping.c index c2443659812a..41bf65e4ea88
> 100644 --- a/drivers/iommu/irq_remapping.c
> +++ b/drivers/iommu/irq_remapping.c
> @@ -108,7 +108,7 @@ int __init irq_remapping_prepare(void)
>  	else if (IS_ENABLED(CONFIG_AMD_IOMMU) &&
>  		 amd_iommu_irq_ops.prepare() =3D=3D 0)
>  		remap_ops =3D &amd_iommu_irq_ops;
> -	else if (IS_ENABLED(CONFIG_HYPERV_IOMMU) &&
> +	else if (IS_ENABLED(CONFIG_HYPERV) &&
>  		 hyperv_irq_remap_ops.prepare() =3D=3D 0)
>  		remap_ops =3D &hyperv_irq_remap_ops;
>  	else


