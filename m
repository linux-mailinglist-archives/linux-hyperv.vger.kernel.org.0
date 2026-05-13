Return-Path: <linux-hyperv+bounces-10813-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGRPHH3UA2ol/AEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10813-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 03:31:41 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2169552BE5A
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 03:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 06285301F361
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 01:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205AB356778;
	Wed, 13 May 2026 01:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ZqYJyYOv"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FCA37C101;
	Wed, 13 May 2026 01:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778635898; cv=none; b=bMsvXElgIt2QT9x4CZSDPe76Mx4rlOW+7nvAa+CSLQOFICYILrj7WewzE6+GHgfBX7ZQy6WW0I1Zx6CXYAyJHsH1S4CsvZYYrV0+RGO9ZT37G7f9ECdmUOrhYYci1GXJG13xX6fHOCmrYmWad34xB3OHM8fZsbka9Y0qgR6e5ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778635898; c=relaxed/simple;
	bh=H/di9LyEpiVEUN8fxJ5PF/SzJf2jvuHtmB37+wS3jvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pKuUx4oENw9+NEyucEauHdeHMB5i00L/H3IHxE8bKf7U9VSnOCOrkC9IxjytAgIh++gbT2XsWTbedtwBnTXu7qzu0c6Dv0Xk+myKjtflsSipaimKQn+7sjP1TOaCC/B3LqlQkQ8quRK89BjlS7STTX0SM3WMtI8rPy20CpiiMpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ZqYJyYOv; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.0.88] (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id A4C2020B7166;
	Tue, 12 May 2026 18:31:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A4C2020B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778635890;
	bh=5q9rABfO0Gt/Q6Q3CrN73o4OycY5uJbilUt6FU0JSwI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZqYJyYOvPj+UHa/jWI4PsDmDD5HCuVDNxuPcN1m3CAsdwhUsrIfpnnpQjzdM7z5Qy
	 chKuGoqKEcjc+pQY40Wiii7Ze3QJhBv9q3Joe+LCwRcOwoU0pTvZwKHnbvfEqewRIe
	 v9p/A0syWXxuKg6nZGqzUWN0H09hyXTolArvoUWs=
Message-ID: <79f714df-c072-989a-c95d-989ea6b6f08b@linux.microsoft.com>
Date: Tue, 12 May 2026 18:31:31 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH V3 01/11] iommu/hyperv: Rename hyperv-iommu.c to
 hyperv-irq.c
Content-Language: en-US
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: hpa@zytor.com, robin.murphy@arm.com, robh@kernel.org, wei.liu@kernel.org,
 mhklinux@outlook.com, muislam@microsoft.com, namjain@linux.microsoft.com,
 magnuskulke@linux.microsoft.com, anbelski@linux.microsoft.com,
 linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
 iommu@lists.linux.dev, linux-pci@vger.kernel.org,
 linux-arch@vger.kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
 decui@microsoft.com, longli@microsoft.com, tglx@kernel.org,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
 joro@8bytes.org, will@kernel.org, lpieralisi@kernel.org,
 kwilczynski@kernel.org, bhelgaas@google.com, arnd@arndb.de
References: <20260512020259.1678627-1-mrathor@linux.microsoft.com>
 <20260512020259.1678627-2-mrathor@linux.microsoft.com>
 <20260512164623.0000273f@linux.microsoft.com>
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <20260512164623.0000273f@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 2169552BE5A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10813-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[zytor.com,arm.com,kernel.org,outlook.com,microsoft.com,linux.microsoft.com,vger.kernel.org,lists.linux.dev,redhat.com,alien8.de,linux.intel.com,8bytes.org,google.com,arndb.de];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mrathor@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,anirudhrb.com:email]
X-Rspamd-Action: no action

On 5/12/26 16:46, Jacob Pan wrote:
> Hi Mukesh,
> 
> On Mon, 11 May 2026 19:02:49 -0700
> Mukesh R <mrathor@linux.microsoft.com> wrote:
> 
>> This file actually implements irq remapping, so rename to more
>> appropriate hyperv-irq.c. A new file to implement hyperv iommu will
>> be introduced later.  Also, it should not be tied to HYPERV_IOMMU,
>> but to CONFIG_HYPERV and IRQ_REMAP. The file already has #ifdef
>> CONFIG_IRQ_REMAP.
>>
>> Reviewed-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
>> Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
>> ---
>>   MAINTAINERS                                    | 2 +-
>>   drivers/iommu/Makefile                         | 2 +-
>>   drivers/iommu/{hyperv-iommu.c => hyperv-irq.c} | 6 +++---
> Given that we have multiple Hyper-V IOMMU-related files ? this renamed
> hyperv-irq.c, the existing hyperv-iommu code, iommu-root (this
> series) and the recently posted guest pvIOMMU driver ? should we create
> a drivers/iommu/hyperv/ directory to consolidate them?

This came up briefly during synup with arm64 devs whether to split
the file into arch specific and common. We decided to wait till arm is
working so we can tell how intrusive the #ifdefs are. We can decide as
part of the arm port patches. I am ok also if you want to do it as part
of the pv-iommu patches as follow up once this is merged.

Thanks,
-Mukesh

>>   drivers/iommu/irq_remapping.c                  | 2 +-
>>   4 files changed, 6 insertions(+), 6 deletions(-)
>>   rename drivers/iommu/{hyperv-iommu.c => hyperv-irq.c} (99%)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index d1cc0e12fe1f..f803a6a38fee 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -11914,7 +11914,7 @@ F:	drivers/clocksource/hyperv_timer.c
>>   F:	drivers/hid/hid-hyperv.c
>>   F:	drivers/hv/
>>   F:	drivers/input/serio/hyperv-keyboard.c
>> -F:	drivers/iommu/hyperv-iommu.c
>> +F:	drivers/iommu/hyperv-irq.c
>>   F:	drivers/net/ethernet/microsoft/
>>   F:	drivers/net/hyperv/
>>   F:	drivers/pci/controller/pci-hyperv-intf.c
>> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
>> index 0275821f4ef9..335ea77cced6 100644
>> --- a/drivers/iommu/Makefile
>> +++ b/drivers/iommu/Makefile
>> @@ -30,7 +30,7 @@ obj-$(CONFIG_TEGRA_IOMMU_SMMU) += tegra-smmu.o
>>   obj-$(CONFIG_EXYNOS_IOMMU) += exynos-iommu.o
>>   obj-$(CONFIG_FSL_PAMU) += fsl_pamu.o fsl_pamu_domain.o
>>   obj-$(CONFIG_S390_IOMMU) += s390-iommu.o
>> -obj-$(CONFIG_HYPERV_IOMMU) += hyperv-iommu.o
>> +obj-$(CONFIG_HYPERV) += hyperv-irq.o
>>   obj-$(CONFIG_VIRTIO_IOMMU) += virtio-iommu.o
>>   obj-$(CONFIG_IOMMU_SVA) += iommu-sva.o
>>   obj-$(CONFIG_IOMMU_IOPF) += io-pgfault.o
>> diff --git a/drivers/iommu/hyperv-iommu.c b/drivers/iommu/hyperv-irq.c
>> similarity index 99%
>> rename from drivers/iommu/hyperv-iommu.c
>> rename to drivers/iommu/hyperv-irq.c
>> index 479103261ae6..d11076f906fb 100644
>> --- a/drivers/iommu/hyperv-iommu.c
>> +++ b/drivers/iommu/hyperv-irq.c
>> @@ -8,6 +8,8 @@
>>    * Author : Lan Tianyu <Tianyu.Lan@microsoft.com>
>>    */
>>   
>> +#ifdef CONFIG_IRQ_REMAP
>> +
>>   #include <linux/types.h>
>>   #include <linux/interrupt.h>
>>   #include <linux/irq.h>
>> @@ -24,8 +26,6 @@
>>   
>>   #include "irq_remapping.h"
>>   
>> -#ifdef CONFIG_IRQ_REMAP
>> -
>>   /*
>>    * According 82093AA IO-APIC spec , IO APIC has a 24-entry Interrupt
>>    * Redirection Table. Hyper-V exposes one single IO-APIC and so
>> define @@ -331,4 +331,4 @@ static const struct irq_domain_ops
>> hyperv_root_ir_domain_ops = { .free = hyperv_root_irq_remapping_free,
>>   };
>>   
>> -#endif
>> +#endif  /* CONFIG_IRQ_REMAP */
>> diff --git a/drivers/iommu/irq_remapping.c
>> b/drivers/iommu/irq_remapping.c index c2443659812a..41bf65e4ea88
>> 100644 --- a/drivers/iommu/irq_remapping.c
>> +++ b/drivers/iommu/irq_remapping.c
>> @@ -108,7 +108,7 @@ int __init irq_remapping_prepare(void)
>>   	else if (IS_ENABLED(CONFIG_AMD_IOMMU) &&
>>   		 amd_iommu_irq_ops.prepare() == 0)
>>   		remap_ops = &amd_iommu_irq_ops;
>> -	else if (IS_ENABLED(CONFIG_HYPERV_IOMMU) &&
>> +	else if (IS_ENABLED(CONFIG_HYPERV) &&
>>   		 hyperv_irq_remap_ops.prepare() == 0)
>>   		remap_ops = &hyperv_irq_remap_ops;
>>   	else


