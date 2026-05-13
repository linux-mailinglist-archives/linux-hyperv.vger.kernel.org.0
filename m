Return-Path: <linux-hyperv+bounces-10846-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Gv0DFvIBGodOgIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10846-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 20:52:11 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 799DC5394E3
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 20:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26282311A78E
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 18:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57313AA1BC;
	Wed, 13 May 2026 18:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="kR8gBKXa"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300A13A872A;
	Wed, 13 May 2026 18:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778697605; cv=none; b=diSNmCk3BxGHXnMxbgRO1zDcvnNGYH09R26Cw3V1wsVrfeZfPokQI0aJudmnWaVYrmjsBfZhhiSo4nGsEgjsOQ3DPkU0oI5v4Xm7HmCeJasSCq3xZlCWUuqN3qyB/5sNCXNHCPIAsNNMSKSDiVAioEFX6RsDTYZ641RaIzBo2iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778697605; c=relaxed/simple;
	bh=cizw8cQck414Ez6F0oEkUs/bhUG4ryKaxoGc5iV8C3I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p5LDspojWCZhEzN8Le+oiCUhq6iHRpzPT+EOU0Rd/XCYP9ooiOe4mj8LmMa6pLdJfR6cNpBmczxpKbox7B5QaWFlWCW4zZa4c2dOaXOrdRnd2h4qdMVKV+JEBHeekPq3TaX9Lrg+RDC31E4RUkezycQkNe2Ne9VLyLmB15NYejw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=kR8gBKXa; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from localhost (unknown [20.236.11.102])
	by linux.microsoft.com (Postfix) with ESMTPSA id 189EC20B7166;
	Wed, 13 May 2026 11:39:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 189EC20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778697590;
	bh=luHpL9J7elgxelQ9wGg+OvNRGgFlTPkDKcczRfK3UBY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kR8gBKXaYcvCnIdPdU9tKgy4upvK6NEWMXIzvxgWb+KBUaICIhEbCJHBOsK8pELaC
	 koGOhDvNDYTYGgmZHV6lHuwg7tURPrKwdWafbm934M5c7g6DGvuUsPbAJ+WWky3Jpj
	 pWjUMMgxGzKCLBjm98emb+6nf5wIJxx0cwi4yl14=
Date: Wed, 13 May 2026 11:39:52 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Yu Zhang <zhangyu1@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
 iommu@lists.linux.dev, linux-pci@vger.kernel.org,
 linux-arch@vger.kernel.org, wei.liu@kernel.org, kys@microsoft.com,
 haiyangz@microsoft.com, decui@microsoft.com, longli@microsoft.com,
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 bhelgaas@google.com, kwilczynski@kernel.org, lpieralisi@kernel.org,
 mani@kernel.org, robh@kernel.org, arnd@arndb.de, jgg@ziepe.ca,
 mhklinux@outlook.com, tgopinath@linux.microsoft.com,
 easwar.hariharan@linux.microsoft.com, jacob.pan@linux.microsoft.com
Subject: Re: [PATCH v1 3/4] iommu/hyperv: Add para-virtualized IOMMU support
 for Hyper-V guest
Message-ID: <20260513113952.00005b20@linux.microsoft.com>
In-Reply-To: <20260511162408.1180069-4-zhangyu1@linux.microsoft.com>
References: <20260511162408.1180069-1-zhangyu1@linux.microsoft.com>
	<20260511162408.1180069-4-zhangyu1@linux.microsoft.com>
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
X-Rspamd-Queue-Id: 799DC5394E3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10846-lists,linux-hyperv=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,kernel.org,microsoft.com,8bytes.org,arm.com,google.com,arndb.de,ziepe.ca,outlook.com,linux.microsoft.com];
	RCPT_COUNT_TWELVE(0.00)[25];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.microsoft.com:mid,linux.microsoft.com:dkim]
X-Rspamd-Action: no action

Hi Yu,

On Tue, 12 May 2026 00:24:07 +0800
Yu Zhang <zhangyu1@linux.microsoft.com> wrote:

> Add a para-virtualized IOMMU driver for Linux guests running on
> Hyper-V. This driver implements stage-1 IO translation within the
> guest OS. It integrates with the Linux IOMMU core, utilizing Hyper-V
> hypercalls for:
>  - Capability discovery
>  - Domain allocation, configuration, and deallocation
>  - Device attachment and detachment
>  - IOTLB invalidation
>=20
> The driver constructs x86-compatible stage-1 IO page tables in the
> guest memory using consolidated IO page table helpers. This allows
> the guest to manage stage-1 translations independently of vendor-
> specific drivers (like Intel VT-d or AMD IOMMU).
>=20
> Hyper-V consumes this stage-1 IO page table when a device domain is
> created and configured, and nests it with the host's stage-2 IO page
> tables, therefore eliminating the VM exits for guest IOMMU mapping
> operations. For unmapping operations, VM exits to perform the IOTLB
> flush are still unavoidable.
>=20
> Hyper-V identifies each PCI pass-thru device by a logical device ID
> in its hypercall interface. The vPCI driver (pci-hyperv) registers the
> per-bus portion of this ID with the pvIOMMU driver during bus probe.
> The pvIOMMU driver stores this mapping and combines it with the
> function number of the endpoint PCI device to form the complete ID
> for hypercalls.
>=20
> Co-developed-by: Wei Liu <wei.liu@kernel.org>
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> Co-developed-by: Easwar Hariharan
> <easwar.hariharan@linux.microsoft.com> Signed-off-by: Easwar
> Hariharan <easwar.hariharan@linux.microsoft.com> Signed-off-by: Yu
> Zhang <zhangyu1@linux.microsoft.com> ---
>  arch/x86/hyperv/hv_init.c           |   4 +
>  arch/x86/include/asm/mshyperv.h     |   4 +
>  drivers/iommu/hyperv/Kconfig        |  17 +
>  drivers/iommu/hyperv/Makefile       |   1 +
>  drivers/iommu/hyperv/iommu.c        | 705
> ++++++++++++++++++++++++++++ drivers/iommu/hyperv/iommu.h        |
> 54 +++ drivers/pci/controller/pci-hyperv.c |  19 +-
>  include/asm-generic/mshyperv.h      |  12 +
>  8 files changed, 815 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/iommu/hyperv/iommu.c
>  create mode 100644 drivers/iommu/hyperv/iommu.h
>=20
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 323adc93f2dc..2c8ff8e06249 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -578,6 +578,10 @@ void __init hyperv_init(void)
>  	old_setup_percpu_clockev =3D
> x86_init.timers.setup_percpu_clockev;
> x86_init.timers.setup_percpu_clockev =3D
> hv_stimer_setup_percpu_clockev; +#ifdef CONFIG_HYPERV_PVIOMMU
> +	x86_init.iommu.iommu_init =3D hv_iommu_init;
> +#endif
> +
>  	hv_apic_init();
> =20
>  	x86_init.pci.arch_init =3D hv_pci_init;
> diff --git a/arch/x86/include/asm/mshyperv.h
> b/arch/x86/include/asm/mshyperv.h index f64393e853ee..20d947c2c758
> 100644 --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -313,6 +313,10 @@ static inline void
> mshv_vtl_return_hypercall(void) {} static inline void
> __mshv_vtl_return_call(struct mshv_vtl_cpu_context *vtl0) {} #endif
> =20
> +#ifdef CONFIG_HYPERV_PVIOMMU
> +int __init hv_iommu_init(void);
> +#endif
> +
>  #include <asm-generic/mshyperv.h>
> =20
>  #endif
> diff --git a/drivers/iommu/hyperv/Kconfig
> b/drivers/iommu/hyperv/Kconfig index 30f40d867036..9e658d5c9a77 100644
> --- a/drivers/iommu/hyperv/Kconfig
> +++ b/drivers/iommu/hyperv/Kconfig
> @@ -8,3 +8,20 @@ config HYPERV_IOMMU
>  	help
>  	  Stub IOMMU driver to handle IRQs to support Hyper-V Linux
>  	  guest and root partitions.
> +
> +if HYPERV_IOMMU
> +config HYPERV_PVIOMMU
> +	bool "Microsoft Hypervisor para-virtualized IOMMU support"
> +	depends on X86 && HYPERV
> +	select IOMMU_API
> +	select GENERIC_PT
> +	select IOMMU_PT
> +	select IOMMU_PT_X86_64
nit:
If HYPERV_PVIOMMU is enabled on a (hypothetical) platform with
GENERIC_ATOMIC64=3Dy, the select would force-enable IOMMU_PT_X86_64 even
though its depends on is unsatisfied =E2=80=94 leading to a build failure.

In practice this can't happen today because HYPERV_PVIOMMU already
depends on X86 && HYPERV, and x86 never sets GENERIC_ATOMIC64. But
adding the explicit guard is more defensive.
i.e.
       depends on !GENERIC_ATOMIC64    # for cmpxchg64 in IOMMU_PT

> +	select IOMMU_IOVA
> +	default HYPERV
> +	help
> +	  Para-virtualized IOMMU driver for Linux guests running on
> +	  Microsoft Hyper-V. Provides DMA remapping and IOTLB
> +	  flush support to enable DMA isolation for devices
> +	  assigned to the guest.
> +endif
> diff --git a/drivers/iommu/hyperv/Makefile
> b/drivers/iommu/hyperv/Makefile index 9f557bad94ff..8669741c0a51
> 100644 --- a/drivers/iommu/hyperv/Makefile
> +++ b/drivers/iommu/hyperv/Makefile
> @@ -1,2 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_HYPERV_IOMMU) +=3D irq_remapping.o
> +obj-$(CONFIG_HYPERV_PVIOMMU) +=3D iommu.o
> diff --git a/drivers/iommu/hyperv/iommu.c
> b/drivers/iommu/hyperv/iommu.c new file mode 100644
> index 000000000000..e5fc625314b5
> --- /dev/null
> +++ b/drivers/iommu/hyperv/iommu.c
> @@ -0,0 +1,705 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Hyper-V IOMMU driver.
> + *
> + * Copyright (C) 2019, 2024-2026 Microsoft, Inc.
> + */
> +
> +#define pr_fmt(fmt) "Hyper-V pvIOMMU: " fmt
> +#define dev_fmt(fmt) pr_fmt(fmt)
> +
> +#include <linux/iommu.h>
> +#include <linux/pci.h>
> +#include <linux/dma-map-ops.h>
> +#include <linux/generic_pt/iommu.h>
> +#include <linux/pci-ats.h>
> +
> +#include <asm/iommu.h>
> +#include <asm/hypervisor.h>
> +#include <asm/mshyperv.h>
> +
> +#include "iommu.h"
> +#include "../iommu-pages.h"
> +
> +struct hv_iommu_dev *hv_iommu_device;
> +
> +/*
> + * Identity and blocking domains are static singletons: identity is
> a 1:1
> + * passthrough with no page table, blocking rejects all DMA. Neither
> holds
> + * per-IOMMU state, so one instance suffices even with multiple
> vIOMMUs.
> + */
> +static struct hv_iommu_domain hv_identity_domain;
> +static struct hv_iommu_domain hv_blocking_domain;
> +static const struct iommu_domain_ops hv_iommu_identity_domain_ops;
> +static const struct iommu_domain_ops hv_iommu_blocking_domain_ops;
> +static struct iommu_ops hv_iommu_ops;
> +static LIST_HEAD(hv_iommu_pci_bus_list);
> +static DEFINE_SPINLOCK(hv_iommu_pci_bus_lock);
> +
> +#define hv_iommu_present(iommu_cap) (iommu_cap &
> HV_IOMMU_CAP_PRESENT) +#define
> hv_iommu_s1_domain_supported(iommu_cap) (iommu_cap & HV_IOMMU_CAP_S1)
> +#define hv_iommu_5lvl_supported(iommu_cap) (iommu_cap &
> HV_IOMMU_CAP_S1_5LVL) +#define hv_iommu_ats_supported(iommu_cap)
> (iommu_cap & HV_IOMMU_CAP_ATS) + +int hv_iommu_register_pci_bus(int
> pci_domain_nr, u32 logical_dev_id_prefix) +{
> +	struct hv_pci_busdata *bus, *new;
> +	int ret =3D 0;
> +
> +	if (no_iommu || !iommu_detected)
> +		return 0;
> +
> +	new =3D kzalloc_obj(*new, GFP_KERNEL);
> +	if (!new)
> +		return -ENOMEM;
> +
> +	spin_lock(&hv_iommu_pci_bus_lock);
> +	list_for_each_entry(bus, &hv_iommu_pci_bus_list, list) {
> +		if (bus->pci_domain_nr !=3D pci_domain_nr)
> +			continue;
> +
> +		if (bus->logical_dev_id_prefix !=3D
> logical_dev_id_prefix) {
> +			pr_err("stale registration for PCI domain %d
> (old prefix 0x%08x, new 0x%08x)\n",
> +			       pci_domain_nr,
> bus->logical_dev_id_prefix,
> +			       logical_dev_id_prefix);
> +			ret =3D -EEXIST;
> +		}
> +
> +		goto out_free;
> +	}
> +
> +	new->pci_domain_nr =3D pci_domain_nr;
> +	new->logical_dev_id_prefix =3D logical_dev_id_prefix;
> +	list_add(&new->list, &hv_iommu_pci_bus_list);
> +	spin_unlock(&hv_iommu_pci_bus_lock);
> +	return 0;
> +
> +out_free:
> +	spin_unlock(&hv_iommu_pci_bus_lock);
> +	kfree(new);
> +	return ret;
> +}
> +EXPORT_SYMBOL_FOR_MODULES(hv_iommu_register_pci_bus, "pci-hyperv");
> +
> +void hv_iommu_unregister_pci_bus(int pci_domain_nr)
> +{
> +	struct hv_pci_busdata *bus, *tmp;
> +
> +	spin_lock(&hv_iommu_pci_bus_lock);
> +	list_for_each_entry_safe(bus, tmp, &hv_iommu_pci_bus_list,
> list) {
> +		if (bus->pci_domain_nr =3D=3D pci_domain_nr) {
> +			list_del(&bus->list);
> +			kfree(bus);
> +			break;
> +		}
> +	}
> +	spin_unlock(&hv_iommu_pci_bus_lock);
> +}
> +EXPORT_SYMBOL_FOR_MODULES(hv_iommu_unregister_pci_bus, "pci-hyperv");
> +
> +/*
> + * Look up the logical device ID for a vPCI device. Returns 0 on
> success
> + * with *logical_id filled in; -ENODEV if no entry registered for
> this
> + * device's vPCI bus.
> + */
> +static int hv_iommu_lookup_logical_dev_id(struct pci_dev *pdev, u64
> *logical_id) +{
> +	struct hv_pci_busdata *bus;
> +	int domain =3D pci_domain_nr(pdev->bus);
> +	int ret =3D -ENODEV;
> +
> +	spin_lock(&hv_iommu_pci_bus_lock);
this is called under local_irq_save, should use  raw_spinlock_t for RT
kernel?

> +	list_for_each_entry(bus, &hv_iommu_pci_bus_list, list) {
> +		if (bus->pci_domain_nr =3D=3D domain) {
> +			*logical_id =3D
> (u64)bus->logical_dev_id_prefix |
> +				      PCI_FUNC(pdev->devfn);
> +			ret =3D 0;
> +			break;
> +		}
> +	}
> +	spin_unlock(&hv_iommu_pci_bus_lock);
> +	return ret;
> +}
> +
> +static int hv_create_device_domain(struct hv_iommu_domain
> *hv_domain, u32 domain_stage) +{
> +	int ret;
> +	u64 status;
> +	unsigned long flags;
> +	struct hv_input_create_device_domain *input;
> +
> +	ret =3D ida_alloc_range(&hv_iommu_device->domain_ids,
> +			hv_iommu_device->first_domain,
> hv_iommu_device->last_domain,
> +			GFP_KERNEL);
> +	if (ret < 0)
> +		return ret;
> +
> +	hv_domain->device_domain.partition_id =3D HV_PARTITION_ID_SELF;
> +	hv_domain->device_domain.domain_id.type =3D domain_stage;
> +	hv_domain->device_domain.domain_id.id =3D ret;
> +	hv_domain->hv_iommu =3D hv_iommu_device;
> +
> +	local_irq_save(flags);
> +
> +	input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	memset(input, 0, sizeof(*input));
> +	input->device_domain =3D hv_domain->device_domain;
> +	input->create_device_domain_flags.forward_progress_required
> =3D 1;
> +	input->create_device_domain_flags.inherit_owning_vtl =3D 0;
> +	status =3D hv_do_hypercall(HVCALL_CREATE_DEVICE_DOMAIN, input,
> NULL); +
> +	local_irq_restore(flags);
> +
> +	if (!hv_result_success(status)) {
> +		pr_err("HVCALL_CREATE_DEVICE_DOMAIN failed, status
> %lld\n", status);
> +		ida_free(&hv_iommu_device->domain_ids,
> hv_domain->device_domain.domain_id.id);
> +	}
> +
> +	return hv_result_to_errno(status);
> +}
> +
> +static void hv_delete_device_domain(struct hv_iommu_domain
> *hv_domain) +{
> +	u64 status;
> +	unsigned long flags;
> +	struct hv_input_delete_device_domain *input;
> +
> +	local_irq_save(flags);
> +
> +	input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	memset(input, 0, sizeof(*input));
> +	input->device_domain =3D hv_domain->device_domain;
> +	status =3D hv_do_hypercall(HVCALL_DELETE_DEVICE_DOMAIN, input,
> NULL); +
> +	local_irq_restore(flags);
> +
> +	if (!hv_result_success(status))
> +		pr_err("HVCALL_DELETE_DEVICE_DOMAIN failed, status
> %lld\n", status); +
> +	ida_free(&hv_domain->hv_iommu->domain_ids,
> hv_domain->device_domain.domain_id.id); +}
> +
> +static bool hv_iommu_capable(struct device *dev, enum iommu_cap cap)
> +{
> +	switch (cap) {
> +	case IOMMU_CAP_CACHE_COHERENCY:
> +		return true;
> +	case IOMMU_CAP_DEFERRED_FLUSH:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static void hv_flush_device_domain(struct hv_iommu_domain *hv_domain)
> +{
> +	u64 status;
> +	unsigned long flags;
> +	struct hv_input_flush_device_domain *input;
> +
> +	local_irq_save(flags);
> +
> +	input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	memset(input, 0, sizeof(*input));
> +	input->device_domain =3D hv_domain->device_domain;
> +	status =3D hv_do_hypercall(HVCALL_FLUSH_DEVICE_DOMAIN, input,
> NULL); +
> +	local_irq_restore(flags);
> +
> +	if (!hv_result_success(status))
> +		pr_err("HVCALL_FLUSH_DEVICE_DOMAIN failed, status
> %lld\n", status); +}
> +
> +static void hv_iommu_detach_dev(struct iommu_domain *domain, struct
> device *dev) +{
> +	u64 status;
> +	unsigned long flags;
> +	struct hv_input_detach_device_domain *input;
> +	struct pci_dev *pdev;
> +	struct hv_iommu_domain *hv_domain =3D
> to_hv_iommu_domain(domain);
> +	struct hv_iommu_endpoint *vdev =3D dev_iommu_priv_get(dev);
> +
> +	/* See the attach function, only PCI devices for now */
> +	if (!dev_is_pci(dev) || vdev->hv_domain !=3D hv_domain)
> +		return;
> +
> +	pdev =3D to_pci_dev(dev);
> +
> +	dev_dbg(dev, "detaching from domain %d\n",
> hv_domain->device_domain.domain_id.id); +
> +	local_irq_save(flags);
> +
> +	input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	memset(input, 0, sizeof(*input));
> +	input->partition_id =3D HV_PARTITION_ID_SELF;
> +	if (hv_iommu_lookup_logical_dev_id(pdev,
> &input->device_id.as_uint64)) {
> +		local_irq_restore(flags);
> +		dev_warn(&pdev->dev, "no IOMMU registration for vPCI
> bus on detach\n");
> +		return;
> +	}
> +	status =3D hv_do_hypercall(HVCALL_DETACH_DEVICE_DOMAIN, input,
> NULL); +
> +	local_irq_restore(flags);
> +
> +	if (!hv_result_success(status))
> +		pr_err("HVCALL_DETACH_DEVICE_DOMAIN failed, status
> %lld\n", status); +
> +	hv_flush_device_domain(hv_domain);
> +
> +	vdev->hv_domain =3D NULL;
> +}
> +
> +static int hv_iommu_attach_dev(struct iommu_domain *domain, struct
> device *dev,
> +			       struct iommu_domain *old)
> +{
> +	u64 status;
> +	unsigned long flags;
> +	struct pci_dev *pdev;
> +	struct hv_input_attach_device_domain *input;
> +	struct hv_iommu_endpoint *vdev =3D dev_iommu_priv_get(dev);
> +	struct hv_iommu_domain *hv_domain =3D
> to_hv_iommu_domain(domain);
> +	int ret;
> +
> +	/* Only allow PCI devices for now */
> +	if (!dev_is_pci(dev))
> +		return -EINVAL;
> +
> +	if (vdev->hv_domain =3D=3D hv_domain)
> +		return 0;
> +
> +	if (vdev->hv_domain)
> +		hv_iommu_detach_dev(&vdev->hv_domain->domain, dev);
> +
> +	pdev =3D to_pci_dev(dev);
> +	dev_dbg(dev, "attaching to domain %d\n",
> +		hv_domain->device_domain.domain_id.id);
> +
> +	local_irq_save(flags);
> +
> +	input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	memset(input, 0, sizeof(*input));
> +	input->device_domain =3D hv_domain->device_domain;
> +	ret =3D hv_iommu_lookup_logical_dev_id(pdev,
> &input->device_id.as_uint64);
> +	if (ret) {
> +		local_irq_restore(flags);
> +		dev_err(&pdev->dev, "no IOMMU registration for vPCI
> bus\n");
> +		return ret;
> +	}
> +	status =3D hv_do_hypercall(HVCALL_ATTACH_DEVICE_DOMAIN, input,
> NULL); +
> +	local_irq_restore(flags);
> +
> +	if (!hv_result_success(status))
> +		pr_err("HVCALL_ATTACH_DEVICE_DOMAIN failed, status
> %lld\n", status);
> +	else
> +		vdev->hv_domain =3D hv_domain;
> +
> +	return hv_result_to_errno(status);
> +}
> +
> +static int hv_iommu_get_logical_device_property(struct device *dev,
> +					u32 code,
> +					struct
> hv_output_get_logical_device_property *property) +{
> +	u64 status, lid;
> +	unsigned long flags;
> +	int ret;
> +	struct hv_input_get_logical_device_property *input;
> +	struct hv_output_get_logical_device_property *output;
> +
> +	local_irq_save(flags);
> +
> +	input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	output =3D *this_cpu_ptr(hyperv_pcpu_input_arg) +
> sizeof(*input);
> +	memset(input, 0, sizeof(*input));
> +	input->partition_id =3D HV_PARTITION_ID_SELF;
> +	ret =3D hv_iommu_lookup_logical_dev_id(to_pci_dev(dev), &lid);
> +	if (ret) {
> +		local_irq_restore(flags);
> +		return ret;
> +	}
> +	input->logical_device_id =3D lid;
> +	input->code =3D code;
> +	status =3D hv_do_hypercall(HVCALL_GET_LOGICAL_DEVICE_PROPERTY,
> input, output);
> +	*property =3D *output;
> +
> +	local_irq_restore(flags);
> +
> +	if (!hv_result_success(status))
> +		pr_err("HVCALL_GET_LOGICAL_DEVICE_PROPERTY failed,
> status %lld\n", status); +
> +	return hv_result_to_errno(status);
> +}
> +
> +static struct iommu_device *hv_iommu_probe_device(struct device *dev)
> +{
> +	struct pci_dev *pdev;
> +	struct hv_iommu_endpoint *vdev;
> +	struct hv_output_get_logical_device_property
> device_iommu_property =3D {0}; +
> +	if (!dev_is_pci(dev))
> +		return ERR_PTR(-ENODEV);
> +
> +	pdev =3D to_pci_dev(dev);
> +
> +	if (hv_iommu_get_logical_device_property(dev,
> +
> HV_LOGICAL_DEVICE_PROPERTY_PVIOMMU,
> +
> &device_iommu_property) ||
> +	    !(device_iommu_property.device_iommu &
> HV_DEVICE_IOMMU_ENABLED))
> +		return ERR_PTR(-ENODEV);
> +
> +	vdev =3D kzalloc_obj(*vdev, GFP_KERNEL);
> +	if (!vdev)
> +		return ERR_PTR(-ENOMEM);
> +
> +	vdev->dev =3D dev;
> +	vdev->hv_iommu =3D hv_iommu_device;
> +	dev_iommu_priv_set(dev, vdev);
> +
> +	if (hv_iommu_ats_supported(hv_iommu_device->cap) &&
> +	    pci_ats_supported(pdev))
> +		pci_enable_ats(pdev,
> __ffs(hv_iommu_device->pgsize_bitmap)); +
> +	return &vdev->hv_iommu->iommu;
> +}
> +
> +static void hv_iommu_release_device(struct device *dev)
> +{
> +	struct hv_iommu_endpoint *vdev =3D dev_iommu_priv_get(dev);
> +	struct pci_dev *pdev =3D to_pci_dev(dev);
> +
> +	if (pdev->ats_enabled)
> +		pci_disable_ats(pdev);
> +
> +	dev_iommu_priv_set(dev, NULL);
> +	set_dma_ops(dev, NULL);
I don't think this is necessary.

> +
> +	kfree(vdev);
> +}
> +
> +static struct iommu_group *hv_iommu_device_group(struct device *dev)
> +{
> +	if (dev_is_pci(dev))
> +		return pci_device_group(dev);
> +	else
> +		return generic_device_group(dev);
non pci device already rejected during attach, maybe we should warn
here?
        WARN_ON_ONCE(1);
        return generic_device_group(dev);

> +}
> +
> +static int hv_configure_device_domain(struct hv_iommu_domain
> *hv_domain, u32 domain_type) +{
> +	u64 status;
> +	unsigned long flags;
> +	struct pt_iommu_x86_64_hw_info pt_info;
> +	struct hv_input_configure_device_domain *input;
> +
> +	local_irq_save(flags);
> +
> +	input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	memset(input, 0, sizeof(*input));
> +	input->device_domain =3D hv_domain->device_domain;
> +	input->settings.flags.blocked =3D (domain_type =3D=3D
> IOMMU_DOMAIN_BLOCKED);
> +	input->settings.flags.translation_enabled =3D (domain_type !=3D
> IOMMU_DOMAIN_IDENTITY); +
Should this be:
input->settings.flags.translation_enabled =3D
     (domain_type & __IOMMU_DOMAIN_PAGING);
Otherwise, blocked domain will have translation enabled. Maybe add some
explanation of what HV expects.

> +	if (domain_type & __IOMMU_DOMAIN_PAGING) {
> +		pt_iommu_x86_64_hw_info(&hv_domain->pt_iommu_x86_64,
> &pt_info);
> +		input->settings.page_table_root =3D pt_info.gcr3_pt;
> +		input->settings.flags.first_stage_paging_mode =3D
> +			pt_info.levels =3D=3D 5;
> +	}
> +	status =3D hv_do_hypercall(HVCALL_CONFIGURE_DEVICE_DOMAIN,
> input, NULL); +
> +	local_irq_restore(flags);
> +
> +	if (!hv_result_success(status))
> +		pr_err("HVCALL_CONFIGURE_DEVICE_DOMAIN failed,
> status %lld\n", status); +
> +	return hv_result_to_errno(status);
> +}
> +
> +static int __init hv_initialize_static_domains(void)
> +{
> +	int ret;
> +	struct hv_iommu_domain *hv_domain;
> +
> +	/* Default stage-1 identity domain */
> +	hv_domain =3D &hv_identity_domain;
> +
> +	ret =3D hv_create_device_domain(hv_domain,
> HV_DEVICE_DOMAIN_TYPE_S1);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D hv_configure_device_domain(hv_domain,
> IOMMU_DOMAIN_IDENTITY);
> +	if (ret)
> +		goto delete_identity_domain;
> +
> +	hv_domain->domain.type =3D IOMMU_DOMAIN_IDENTITY;
> +	hv_domain->domain.ops =3D &hv_iommu_identity_domain_ops;
> +	hv_domain->domain.owner =3D &hv_iommu_ops;
> +	hv_domain->domain.geometry =3D hv_iommu_device->geometry;
> +	hv_domain->domain.pgsize_bitmap =3D
> hv_iommu_device->pgsize_bitmap; +
> +	/* Default stage-1 blocked domain */
> +	hv_domain =3D &hv_blocking_domain;
> +
> +	ret =3D hv_create_device_domain(hv_domain,
> HV_DEVICE_DOMAIN_TYPE_S1);
> +	if (ret)
> +		goto delete_identity_domain;
> +
> +	ret =3D hv_configure_device_domain(hv_domain,
> IOMMU_DOMAIN_BLOCKED);
> +	if (ret)
> +		goto delete_blocked_domain;
> +
> +	hv_domain->domain.type =3D IOMMU_DOMAIN_BLOCKED;
> +	hv_domain->domain.ops =3D &hv_iommu_blocking_domain_ops;
> +	hv_domain->domain.owner =3D &hv_iommu_ops;
> +	hv_domain->domain.geometry =3D hv_iommu_device->geometry;
> +	hv_domain->domain.pgsize_bitmap =3D
> hv_iommu_device->pgsize_bitmap; +
> +	return 0;
> +
> +delete_blocked_domain:
> +	hv_delete_device_domain(&hv_blocking_domain);
> +delete_identity_domain:
> +	hv_delete_device_domain(&hv_identity_domain);
> +	return ret;
> +}
> +
> +#define INTERRUPT_RANGE_START	(0xfee00000)
> +#define INTERRUPT_RANGE_END	(0xfeefffff)
> +static void hv_iommu_get_resv_regions(struct device *dev,
> +		struct list_head *head)
> +{
> +	struct iommu_resv_region *region;
> +
> +	region =3D iommu_alloc_resv_region(INTERRUPT_RANGE_START,
> +				      INTERRUPT_RANGE_END -
> INTERRUPT_RANGE_START + 1,
> +				      0, IOMMU_RESV_MSI, GFP_KERNEL);
> +	if (!region)
> +		return;
> +
> +	list_add_tail(&region->list, head);
> +}
> +
> +static void hv_iommu_flush_iotlb_all(struct iommu_domain *domain)
> +{
> +	hv_flush_device_domain(to_hv_iommu_domain(domain));
> +}
> +
> +static void hv_iommu_iotlb_sync(struct iommu_domain *domain,
> +				struct iommu_iotlb_gather
> *iotlb_gather) +{
> +	hv_flush_device_domain(to_hv_iommu_domain(domain));
> +
> +	iommu_put_pages_list(&iotlb_gather->freelist);
> +}
> +
> +static void hv_iommu_paging_domain_free(struct iommu_domain *domain)
> +{
> +	struct hv_iommu_domain *hv_domain =3D
> to_hv_iommu_domain(domain); +
> +	/* Free all remaining mappings */
> +	pt_iommu_deinit(&hv_domain->pt_iommu);
> +
> +	hv_delete_device_domain(hv_domain);
> +
> +	kfree(hv_domain);
> +}
> +
> +static const struct iommu_domain_ops hv_iommu_identity_domain_ops =3D {
> +	.attach_dev	=3D hv_iommu_attach_dev,
> +};
> +
> +static const struct iommu_domain_ops hv_iommu_blocking_domain_ops =3D {
> +	.attach_dev	=3D hv_iommu_attach_dev,
> +};
> +
> +static const struct iommu_domain_ops hv_iommu_paging_domain_ops =3D {
> +	.attach_dev	=3D hv_iommu_attach_dev,
> +	IOMMU_PT_DOMAIN_OPS(x86_64),
> +	.flush_iotlb_all =3D hv_iommu_flush_iotlb_all,
> +	.iotlb_sync =3D hv_iommu_iotlb_sync,
> +	.free =3D hv_iommu_paging_domain_free,
> +};
> +
> +static struct iommu_domain *hv_iommu_domain_alloc_paging(struct
> device *dev) +{
> +	int ret;
> +	struct hv_iommu_domain *hv_domain;
> +	struct pt_iommu_x86_64_cfg cfg =3D {};
> +
> +	hv_domain =3D kzalloc_obj(*hv_domain, GFP_KERNEL);
> +	if (!hv_domain)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ret =3D hv_create_device_domain(hv_domain,
> HV_DEVICE_DOMAIN_TYPE_S1);
> +	if (ret) {
> +		kfree(hv_domain);
> +		return ERR_PTR(ret);
> +	}
> +
> +	hv_domain->domain.geometry =3D hv_iommu_device->geometry;
> +	hv_domain->pt_iommu.nid =3D dev_to_node(dev);
> +
> +	cfg.common.hw_max_vasz_lg2 =3D hv_iommu_device->max_iova_width;
> +	cfg.common.hw_max_oasz_lg2 =3D 52;
> +	cfg.top_level =3D (hv_iommu_device->max_iova_width > 48) ? 4 :
> 3; +
> +	ret =3D pt_iommu_x86_64_init(&hv_domain->pt_iommu_x86_64,
> &cfg, GFP_KERNEL);
> +	if (ret) {
> +		hv_delete_device_domain(hv_domain);
> +		kfree(hv_domain);
> +		return ERR_PTR(ret);
> +	}
> +
> +	/* Constrain to page sizes the hypervisor supports */
> +	hv_domain->domain.pgsize_bitmap &=3D
> hv_iommu_device->pgsize_bitmap; +
> +	hv_domain->domain.ops =3D &hv_iommu_paging_domain_ops;
> +
> +	ret =3D hv_configure_device_domain(hv_domain,
> __IOMMU_DOMAIN_PAGING);
> +	if (ret) {
> +		pt_iommu_deinit(&hv_domain->pt_iommu);
> +		hv_delete_device_domain(hv_domain);
> +		kfree(hv_domain);
> +		return ERR_PTR(ret);
> +	}
> +
> +	return &hv_domain->domain;
> +}
> +
> +static struct iommu_ops hv_iommu_ops =3D {
> +	.capable		  =3D hv_iommu_capable,
> +	.domain_alloc_paging	  =3D hv_iommu_domain_alloc_paging,
> +	.probe_device		  =3D hv_iommu_probe_device,
> +	.release_device		  =3D hv_iommu_release_device,
> +	.device_group		  =3D hv_iommu_device_group,
> +	.get_resv_regions	  =3D hv_iommu_get_resv_regions,
> +	.owner			  =3D THIS_MODULE,
> +	.identity_domain	  =3D &hv_identity_domain.domain,
> +	.blocked_domain		  =3D
> &hv_blocking_domain.domain,
> +	.release_domain		  =3D
> &hv_blocking_domain.domain, +};
> +
> +static int hv_iommu_detect(struct hv_output_get_iommu_capabilities
> *hv_iommu_cap) +{
> +	u64 status;
> +	unsigned long flags;
> +	struct hv_input_get_iommu_capabilities *input;
> +	struct hv_output_get_iommu_capabilities *output;
> +
> +	local_irq_save(flags);
> +
> +	input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	output =3D *this_cpu_ptr(hyperv_pcpu_input_arg) +
> sizeof(*input);
> +	memset(input, 0, sizeof(*input));
> +	input->partition_id =3D HV_PARTITION_ID_SELF;
> +	status =3D hv_do_hypercall(HVCALL_GET_IOMMU_CAPABILITIES,
> input, output);
> +	*hv_iommu_cap =3D *output;
> +
> +	local_irq_restore(flags);
> +
> +	if (!hv_result_success(status))
> +		pr_err("HVCALL_GET_IOMMU_CAPABILITIES failed, status
> %lld\n", status); +
> +	return hv_result_to_errno(status);
> +}
> +
> +static void __init hv_init_iommu_device(struct hv_iommu_dev
> *hv_iommu,
> +			struct hv_output_get_iommu_capabilities
> *hv_iommu_cap) +{
> +	ida_init(&hv_iommu->domain_ids);
> +
> +	hv_iommu->cap =3D hv_iommu_cap->iommu_cap;
> +	hv_iommu->max_iova_width =3D hv_iommu_cap->max_iova_width;
> +	if (!hv_iommu_5lvl_supported(hv_iommu->cap) &&
> +	    hv_iommu->max_iova_width > 48) {
> +		pr_info("5-level paging not supported, limiting iova
> width to 48.\n");
> +		hv_iommu->max_iova_width =3D 48;
> +	}
> +
> +	hv_iommu->geometry =3D (struct iommu_domain_geometry) {
> +		.aperture_start =3D 0,
> +		.aperture_end =3D (((u64)1) <<
> hv_iommu->max_iova_width) - 1,
> +		.force_aperture =3D true,
> +	};
> +
> +	hv_iommu->first_domain =3D HV_DEVICE_DOMAIN_ID_DEFAULT + 1;
> +	hv_iommu->last_domain =3D HV_DEVICE_DOMAIN_ID_NULL - 1;
> +	/* Only x86 page sizes (4K/2M/1G) are supported */
> +	hv_iommu->pgsize_bitmap =3D hv_iommu_cap->pgsize_bitmap &
> +				  (SZ_4K | SZ_2M | SZ_1G);
> +	if (hv_iommu->pgsize_bitmap !=3D hv_iommu_cap->pgsize_bitmap)
> +		pr_warn("unsupported page sizes masked: 0x%llx ->
> 0x%llx\n",
> +			hv_iommu_cap->pgsize_bitmap,
> hv_iommu->pgsize_bitmap);
> +	if (!hv_iommu->pgsize_bitmap) {
> +		pr_warn("no supported page sizes, defaulting to
> 4K\n");
> +		hv_iommu->pgsize_bitmap =3D SZ_4K;
> +	}
> +	hv_iommu_device =3D hv_iommu;
> +}
> +
> +int __init hv_iommu_init(void)
> +{
> +	int ret =3D 0;
> +	struct hv_iommu_dev *hv_iommu =3D NULL;
> +	struct hv_output_get_iommu_capabilities hv_iommu_cap =3D {0};
> +
> +	if (no_iommu || iommu_detected)
> +		return -ENODEV;
> +
> +	if (!hv_is_hyperv_initialized())
> +		return -ENODEV;
> +
> +	ret =3D hv_iommu_detect(&hv_iommu_cap);
> +	if (ret) {
> +		pr_err("HVCALL_GET_IOMMU_CAPABILITIES failed: %d\n",
> ret);
> +		return -ENODEV;
> +	}
> +
> +	if (!hv_iommu_present(hv_iommu_cap.iommu_cap) ||
> +	    !hv_iommu_s1_domain_supported(hv_iommu_cap.iommu_cap)) {
> +		pr_err("IOMMU capabilities not sufficient:
> cap=3D0x%llx\n",
> +		       hv_iommu_cap.iommu_cap);
> +		return -ENODEV;
> +	}
> +
> +	iommu_detected =3D 1;
> +	pci_request_acs();
> +
> +	hv_iommu =3D kzalloc_obj(*hv_iommu, GFP_KERNEL);
> +	if (!hv_iommu)
> +		return -ENOMEM;
> +
> +	hv_init_iommu_device(hv_iommu, &hv_iommu_cap);
> +
> +	ret =3D hv_initialize_static_domains();
> +	if (ret) {
> +		pr_err("static domains init failed: %d\n", ret);
> +		goto err_free;
> +	}
> +
> +	ret =3D iommu_device_sysfs_add(&hv_iommu->iommu, NULL, NULL,
> "%s", "hv-iommu");
> +	if (ret) {
> +		pr_err("iommu_device_sysfs_add failed: %d\n", ret);
> +		goto err_delete_static_domains;
> +	}
> +
> +	ret =3D iommu_device_register(&hv_iommu->iommu, &hv_iommu_ops,
> NULL);
> +	if (ret) {
> +		pr_err("iommu_device_register failed: %d\n", ret);
> +		goto err_sysfs_remove;
> +	}
> +
> +	pr_info("successfully initialized\n");
> +	return 0;
> +
> +err_sysfs_remove:
> +	iommu_device_sysfs_remove(&hv_iommu->iommu);
> +err_delete_static_domains:
> +	hv_delete_device_domain(&hv_blocking_domain);
> +	hv_delete_device_domain(&hv_identity_domain);
> +err_free:
> +	kfree(hv_iommu);
> +	return ret;
> +}
> diff --git a/drivers/iommu/hyperv/iommu.h
> b/drivers/iommu/hyperv/iommu.h new file mode 100644
> index 000000000000..43f20d371245
> --- /dev/null
> +++ b/drivers/iommu/hyperv/iommu.h
> @@ -0,0 +1,54 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/*
> + * Hyper-V IOMMU driver.
> + *
> + * Copyright (C) 2024-2025, Microsoft, Inc.
> + *
> + */
> +
> +#ifndef _HYPERV_IOMMU_H
> +#define _HYPERV_IOMMU_H
> +
> +struct hv_iommu_dev {
> +	struct iommu_device iommu;
> +	struct ida domain_ids;
> +
> +	/* Device configuration */
> +	u8  max_iova_width;
> +	u8  max_pasid_width;
> +	u64 cap;
> +	u64 pgsize_bitmap;
> +
> +	struct iommu_domain_geometry geometry;
> +	u64 first_domain;
> +	u64 last_domain;
> +};
> +
> +struct hv_iommu_domain {
> +	union {
> +		struct iommu_domain    domain;
> +		struct pt_iommu        pt_iommu;
> +		struct pt_iommu_x86_64 pt_iommu_x86_64;
> +	};
> +	struct hv_iommu_dev *hv_iommu;
> +	struct hv_input_device_domain device_domain;
> +	u64		pgsize_bitmap;
> +};
> +
> +struct hv_pci_busdata {
> +	int               pci_domain_nr;
> +	u32               logical_dev_id_prefix;
> +	struct list_head  list;
> +};
> +
> +struct hv_iommu_endpoint {
> +	struct device *dev;
> +	struct hv_iommu_dev *hv_iommu;
> +	struct hv_iommu_domain *hv_domain;
> +};
> +
> +#define to_hv_iommu_domain(d) \
> +	container_of(d, struct hv_iommu_domain, domain)
> +
> +#endif /* _HYPERV_IOMMU_H */
> diff --git a/drivers/pci/controller/pci-hyperv.c
> b/drivers/pci/controller/pci-hyperv.c index
> cfc8fa403dad..a4af9c8c2220 100644 ---
> a/drivers/pci/controller/pci-hyperv.c +++
> b/drivers/pci/controller/pci-hyperv.c @@ -3715,6 +3715,7 @@ static
> int hv_pci_probe(struct hv_device *hdev, struct hv_pcibus_device
> *hbus; int ret, dom;
>  	u16 dom_req;
> +	u32 prefix;
>  	char *name;
> =20
>  	bridge =3D devm_pci_alloc_host_bridge(&hdev->device, 0);
> @@ -3857,13 +3858,25 @@ static int hv_pci_probe(struct hv_device
> *hdev,=20
>  	hbus->state =3D hv_pcibus_probed;
> =20
> -	ret =3D create_root_hv_pci_bus(hbus);
> +	/* Notify pvIOMMU before any device on the bus is scanned. */
> +	prefix =3D (hdev->dev_instance.b[5] << 24) |
> +		 (hdev->dev_instance.b[4] << 16) |
> +		 (hdev->dev_instance.b[7] <<  8) |
> +		 (hdev->dev_instance.b[6] & 0xf8);
> +
> +	ret =3D hv_iommu_register_pci_bus(dom, prefix);
>  	if (ret)
>  		goto free_windows;
> =20
> +	ret =3D create_root_hv_pci_bus(hbus);
> +	if (ret)
> +		goto unregister_pviommu;
> +
>  	mutex_unlock(&hbus->state_lock);
>  	return 0;
> =20
> +unregister_pviommu:
> +	hv_iommu_unregister_pci_bus(dom);
>  free_windows:
>  	hv_pci_free_bridge_windows(hbus);
>  exit_d0:
> @@ -3974,8 +3987,10 @@ static int hv_pci_bus_exit(struct hv_device
> *hdev, bool keep_devs) static void hv_pci_remove(struct hv_device
> *hdev) {
>  	struct hv_pcibus_device *hbus;
> +	int dom;
> =20
>  	hbus =3D hv_get_drvdata(hdev);
> +	dom =3D hbus->bridge->domain_nr;
>  	if (hbus->state =3D=3D hv_pcibus_installed) {
>  		tasklet_disable(&hdev->channel->callback_event);
>  		hbus->state =3D hv_pcibus_removing;
> @@ -3994,6 +4009,8 @@ static void hv_pci_remove(struct hv_device
> *hdev) hv_pci_remove_slots(hbus);
>  		pci_remove_root_bus(hbus->bridge->bus);
>  		pci_unlock_rescan_remove();
> +
> +		hv_iommu_unregister_pci_bus(dom);
>  	}
> =20
>  	hv_pci_bus_exit(hdev, false);
> diff --git a/include/asm-generic/mshyperv.h
> b/include/asm-generic/mshyperv.h index bf601d67cecb..b71345c74568
> 100644 --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -73,6 +73,18 @@ extern enum hv_partition_type
> hv_curr_partition_type; extern void * __percpu *hyperv_pcpu_input_arg;
>  extern void * __percpu *hyperv_pcpu_output_arg;
> =20
> +#ifdef CONFIG_HYPERV_PVIOMMU
> +int  hv_iommu_register_pci_bus(int pci_domain_nr, u32
> logical_dev_id_prefix); +void hv_iommu_unregister_pci_bus(int
> pci_domain_nr); +#else
> +static inline int hv_iommu_register_pci_bus(int pci_domain_nr,
> +					    u32
> logical_dev_id_prefix) +{
> +	return 0;
> +}
> +static inline void hv_iommu_unregister_pci_bus(int pci_domain_nr) { }
> +#endif
> +
>  u64 hv_do_hypercall(u64 control, void *inputaddr, void *outputaddr);
>  u64 hv_do_fast_hypercall8(u16 control, u64 input8);
>  u64 hv_do_fast_hypercall16(u16 control, u64 input1, u64 input2);


