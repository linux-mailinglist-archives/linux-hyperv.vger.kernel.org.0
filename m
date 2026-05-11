Return-Path: <linux-hyperv+bounces-10758-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGhkFtYLAmrpnQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10758-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 May 2026 19:03:18 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 63767512F07
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 May 2026 19:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3924330BD7C4
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 May 2026 16:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FED427A06;
	Mon, 11 May 2026 16:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="W61HjHBm"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9A542EEC8;
	Mon, 11 May 2026 16:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778516675; cv=none; b=EyRLluSjnfrw6zpMnjv3aRVrm78mwHH8/6zFx0kPGFH9vHXhq/B6GeHCEWDHNoOWNf6s+LP7c+5AFcKGxRMnVm72crbmNYM3cVJhWzhS0XxBa9b1K8VVvN0WQmuL60VnUo1kOAmpGL0qAGqLG6KP41Q/ZNmxbKfCOIdkCCVtldA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778516675; c=relaxed/simple;
	bh=Jd8opqo9YYTuqmGoSNUJk/SX4mpnZkx9T5d0H292RxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gunh1FpvAbWkTo4gGrEXj8mG0R6MPOTDkj+S4tuA9ay+Qixfcn/+vHnUEXd4RxGKGazTZLuF/4/027AhtQE95ck3qhVGBhK+R4OJRv47oOETyUh4h8KucV3BwNyFwE7sN34ko9D8tyT+/K6CCNpvHhGY9cgSNVB40ln6eCO3dok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=W61HjHBm; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from zhangyu-hyperv.mshome.net (unknown [167.220.233.27])
	by linux.microsoft.com (Postfix) with ESMTPSA id 12D8D20B7167;
	Mon, 11 May 2026 09:24:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 12D8D20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778516669;
	bh=SRDReITBWCZdD7EIURha4yQpuwTZhGWXz+sNdp80uEc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W61HjHBmWyDZxvcCWilccxsNCYrs69TCZbYOUtzvFXjRkFo36Y6WkK7567X+YijIz
	 3s3uMkye+M+jYNtj3hGgJPVuVQ3Xz9oaQR3MluDNNV5t8EqgvyJt2KN0ocVaOWOMVq
	 4hlWWqFhnpHe5DLyWbZP5CufRmBd0GqhA/Sp0Viw=
From: Yu Zhang <zhangyu1@linux.microsoft.com>
To: linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org
Cc: wei.liu@kernel.org,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	decui@microsoft.com,
	longli@microsoft.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	bhelgaas@google.com,
	kwilczynski@kernel.org,
	lpieralisi@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	arnd@arndb.de,
	jgg@ziepe.ca,
	mhklinux@outlook.com,
	jacob.pan@linux.microsoft.com,
	tgopinath@linux.microsoft.com,
	easwar.hariharan@linux.microsoft.com
Subject: [PATCH v1 3/4] iommu/hyperv: Add para-virtualized IOMMU support for Hyper-V guest
Date: Tue, 12 May 2026 00:24:07 +0800
Message-ID: <20260511162408.1180069-4-zhangyu1@linux.microsoft.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260511162408.1180069-1-zhangyu1@linux.microsoft.com>
References: <20260511162408.1180069-1-zhangyu1@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 63767512F07
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,microsoft.com,8bytes.org,arm.com,google.com,arndb.de,ziepe.ca,outlook.com,linux.microsoft.com];
	TAGGED_FROM(0.00)[bounces-10758-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[24];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhangyu1@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.microsoft.com:mid,linux.microsoft.com:dkim]
X-Rspamd-Action: no action

Add a para-virtualized IOMMU driver for Linux guests running on Hyper-V.
This driver implements stage-1 IO translation within the guest OS.
It integrates with the Linux IOMMU core, utilizing Hyper-V hypercalls
for:
 - Capability discovery
 - Domain allocation, configuration, and deallocation
 - Device attachment and detachment
 - IOTLB invalidation

The driver constructs x86-compatible stage-1 IO page tables in the
guest memory using consolidated IO page table helpers. This allows
the guest to manage stage-1 translations independently of vendor-
specific drivers (like Intel VT-d or AMD IOMMU).

Hyper-V consumes this stage-1 IO page table when a device domain is
created and configured, and nests it with the host's stage-2 IO page
tables, therefore eliminating the VM exits for guest IOMMU mapping
operations. For unmapping operations, VM exits to perform the IOTLB
flush are still unavoidable.

Hyper-V identifies each PCI pass-thru device by a logical device ID
in its hypercall interface. The vPCI driver (pci-hyperv) registers the
per-bus portion of this ID with the pvIOMMU driver during bus probe.
The pvIOMMU driver stores this mapping and combines it with the function
number of the endpoint PCI device to form the complete ID for hypercalls.

Co-developed-by: Wei Liu <wei.liu@kernel.org>
Signed-off-by: Wei Liu <wei.liu@kernel.org>
Co-developed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Signed-off-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Signed-off-by: Yu Zhang <zhangyu1@linux.microsoft.com>
---
 arch/x86/hyperv/hv_init.c           |   4 +
 arch/x86/include/asm/mshyperv.h     |   4 +
 drivers/iommu/hyperv/Kconfig        |  17 +
 drivers/iommu/hyperv/Makefile       |   1 +
 drivers/iommu/hyperv/iommu.c        | 705 ++++++++++++++++++++++++++++
 drivers/iommu/hyperv/iommu.h        |  54 +++
 drivers/pci/controller/pci-hyperv.c |  19 +-
 include/asm-generic/mshyperv.h      |  12 +
 8 files changed, 815 insertions(+), 1 deletion(-)
 create mode 100644 drivers/iommu/hyperv/iommu.c
 create mode 100644 drivers/iommu/hyperv/iommu.h

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 323adc93f2dc..2c8ff8e06249 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -578,6 +578,10 @@ void __init hyperv_init(void)
 	old_setup_percpu_clockev = x86_init.timers.setup_percpu_clockev;
 	x86_init.timers.setup_percpu_clockev = hv_stimer_setup_percpu_clockev;
 
+#ifdef CONFIG_HYPERV_PVIOMMU
+	x86_init.iommu.iommu_init = hv_iommu_init;
+#endif
+
 	hv_apic_init();
 
 	x86_init.pci.arch_init = hv_pci_init;
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index f64393e853ee..20d947c2c758 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -313,6 +313,10 @@ static inline void mshv_vtl_return_hypercall(void) {}
 static inline void __mshv_vtl_return_call(struct mshv_vtl_cpu_context *vtl0) {}
 #endif
 
+#ifdef CONFIG_HYPERV_PVIOMMU
+int __init hv_iommu_init(void);
+#endif
+
 #include <asm-generic/mshyperv.h>
 
 #endif
diff --git a/drivers/iommu/hyperv/Kconfig b/drivers/iommu/hyperv/Kconfig
index 30f40d867036..9e658d5c9a77 100644
--- a/drivers/iommu/hyperv/Kconfig
+++ b/drivers/iommu/hyperv/Kconfig
@@ -8,3 +8,20 @@ config HYPERV_IOMMU
 	help
 	  Stub IOMMU driver to handle IRQs to support Hyper-V Linux
 	  guest and root partitions.
+
+if HYPERV_IOMMU
+config HYPERV_PVIOMMU
+	bool "Microsoft Hypervisor para-virtualized IOMMU support"
+	depends on X86 && HYPERV
+	select IOMMU_API
+	select GENERIC_PT
+	select IOMMU_PT
+	select IOMMU_PT_X86_64
+	select IOMMU_IOVA
+	default HYPERV
+	help
+	  Para-virtualized IOMMU driver for Linux guests running on
+	  Microsoft Hyper-V. Provides DMA remapping and IOTLB
+	  flush support to enable DMA isolation for devices
+	  assigned to the guest.
+endif
diff --git a/drivers/iommu/hyperv/Makefile b/drivers/iommu/hyperv/Makefile
index 9f557bad94ff..8669741c0a51 100644
--- a/drivers/iommu/hyperv/Makefile
+++ b/drivers/iommu/hyperv/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_HYPERV_IOMMU) += irq_remapping.o
+obj-$(CONFIG_HYPERV_PVIOMMU) += iommu.o
diff --git a/drivers/iommu/hyperv/iommu.c b/drivers/iommu/hyperv/iommu.c
new file mode 100644
index 000000000000..e5fc625314b5
--- /dev/null
+++ b/drivers/iommu/hyperv/iommu.c
@@ -0,0 +1,705 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Hyper-V IOMMU driver.
+ *
+ * Copyright (C) 2019, 2024-2026 Microsoft, Inc.
+ */
+
+#define pr_fmt(fmt) "Hyper-V pvIOMMU: " fmt
+#define dev_fmt(fmt) pr_fmt(fmt)
+
+#include <linux/iommu.h>
+#include <linux/pci.h>
+#include <linux/dma-map-ops.h>
+#include <linux/generic_pt/iommu.h>
+#include <linux/pci-ats.h>
+
+#include <asm/iommu.h>
+#include <asm/hypervisor.h>
+#include <asm/mshyperv.h>
+
+#include "iommu.h"
+#include "../iommu-pages.h"
+
+struct hv_iommu_dev *hv_iommu_device;
+
+/*
+ * Identity and blocking domains are static singletons: identity is a 1:1
+ * passthrough with no page table, blocking rejects all DMA. Neither holds
+ * per-IOMMU state, so one instance suffices even with multiple vIOMMUs.
+ */
+static struct hv_iommu_domain hv_identity_domain;
+static struct hv_iommu_domain hv_blocking_domain;
+static const struct iommu_domain_ops hv_iommu_identity_domain_ops;
+static const struct iommu_domain_ops hv_iommu_blocking_domain_ops;
+static struct iommu_ops hv_iommu_ops;
+static LIST_HEAD(hv_iommu_pci_bus_list);
+static DEFINE_SPINLOCK(hv_iommu_pci_bus_lock);
+
+#define hv_iommu_present(iommu_cap) (iommu_cap & HV_IOMMU_CAP_PRESENT)
+#define hv_iommu_s1_domain_supported(iommu_cap) (iommu_cap & HV_IOMMU_CAP_S1)
+#define hv_iommu_5lvl_supported(iommu_cap) (iommu_cap & HV_IOMMU_CAP_S1_5LVL)
+#define hv_iommu_ats_supported(iommu_cap) (iommu_cap & HV_IOMMU_CAP_ATS)
+
+int hv_iommu_register_pci_bus(int pci_domain_nr, u32 logical_dev_id_prefix)
+{
+	struct hv_pci_busdata *bus, *new;
+	int ret = 0;
+
+	if (no_iommu || !iommu_detected)
+		return 0;
+
+	new = kzalloc_obj(*new, GFP_KERNEL);
+	if (!new)
+		return -ENOMEM;
+
+	spin_lock(&hv_iommu_pci_bus_lock);
+	list_for_each_entry(bus, &hv_iommu_pci_bus_list, list) {
+		if (bus->pci_domain_nr != pci_domain_nr)
+			continue;
+
+		if (bus->logical_dev_id_prefix != logical_dev_id_prefix) {
+			pr_err("stale registration for PCI domain %d (old prefix 0x%08x, new 0x%08x)\n",
+			       pci_domain_nr, bus->logical_dev_id_prefix,
+			       logical_dev_id_prefix);
+			ret = -EEXIST;
+		}
+
+		goto out_free;
+	}
+
+	new->pci_domain_nr = pci_domain_nr;
+	new->logical_dev_id_prefix = logical_dev_id_prefix;
+	list_add(&new->list, &hv_iommu_pci_bus_list);
+	spin_unlock(&hv_iommu_pci_bus_lock);
+	return 0;
+
+out_free:
+	spin_unlock(&hv_iommu_pci_bus_lock);
+	kfree(new);
+	return ret;
+}
+EXPORT_SYMBOL_FOR_MODULES(hv_iommu_register_pci_bus, "pci-hyperv");
+
+void hv_iommu_unregister_pci_bus(int pci_domain_nr)
+{
+	struct hv_pci_busdata *bus, *tmp;
+
+	spin_lock(&hv_iommu_pci_bus_lock);
+	list_for_each_entry_safe(bus, tmp, &hv_iommu_pci_bus_list, list) {
+		if (bus->pci_domain_nr == pci_domain_nr) {
+			list_del(&bus->list);
+			kfree(bus);
+			break;
+		}
+	}
+	spin_unlock(&hv_iommu_pci_bus_lock);
+}
+EXPORT_SYMBOL_FOR_MODULES(hv_iommu_unregister_pci_bus, "pci-hyperv");
+
+/*
+ * Look up the logical device ID for a vPCI device. Returns 0 on success
+ * with *logical_id filled in; -ENODEV if no entry registered for this
+ * device's vPCI bus.
+ */
+static int hv_iommu_lookup_logical_dev_id(struct pci_dev *pdev, u64 *logical_id)
+{
+	struct hv_pci_busdata *bus;
+	int domain = pci_domain_nr(pdev->bus);
+	int ret = -ENODEV;
+
+	spin_lock(&hv_iommu_pci_bus_lock);
+	list_for_each_entry(bus, &hv_iommu_pci_bus_list, list) {
+		if (bus->pci_domain_nr == domain) {
+			*logical_id = (u64)bus->logical_dev_id_prefix |
+				      PCI_FUNC(pdev->devfn);
+			ret = 0;
+			break;
+		}
+	}
+	spin_unlock(&hv_iommu_pci_bus_lock);
+	return ret;
+}
+
+static int hv_create_device_domain(struct hv_iommu_domain *hv_domain, u32 domain_stage)
+{
+	int ret;
+	u64 status;
+	unsigned long flags;
+	struct hv_input_create_device_domain *input;
+
+	ret = ida_alloc_range(&hv_iommu_device->domain_ids,
+			hv_iommu_device->first_domain, hv_iommu_device->last_domain,
+			GFP_KERNEL);
+	if (ret < 0)
+		return ret;
+
+	hv_domain->device_domain.partition_id = HV_PARTITION_ID_SELF;
+	hv_domain->device_domain.domain_id.type = domain_stage;
+	hv_domain->device_domain.domain_id.id = ret;
+	hv_domain->hv_iommu = hv_iommu_device;
+
+	local_irq_save(flags);
+
+	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
+	memset(input, 0, sizeof(*input));
+	input->device_domain = hv_domain->device_domain;
+	input->create_device_domain_flags.forward_progress_required = 1;
+	input->create_device_domain_flags.inherit_owning_vtl = 0;
+	status = hv_do_hypercall(HVCALL_CREATE_DEVICE_DOMAIN, input, NULL);
+
+	local_irq_restore(flags);
+
+	if (!hv_result_success(status)) {
+		pr_err("HVCALL_CREATE_DEVICE_DOMAIN failed, status %lld\n", status);
+		ida_free(&hv_iommu_device->domain_ids, hv_domain->device_domain.domain_id.id);
+	}
+
+	return hv_result_to_errno(status);
+}
+
+static void hv_delete_device_domain(struct hv_iommu_domain *hv_domain)
+{
+	u64 status;
+	unsigned long flags;
+	struct hv_input_delete_device_domain *input;
+
+	local_irq_save(flags);
+
+	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
+	memset(input, 0, sizeof(*input));
+	input->device_domain = hv_domain->device_domain;
+	status = hv_do_hypercall(HVCALL_DELETE_DEVICE_DOMAIN, input, NULL);
+
+	local_irq_restore(flags);
+
+	if (!hv_result_success(status))
+		pr_err("HVCALL_DELETE_DEVICE_DOMAIN failed, status %lld\n", status);
+
+	ida_free(&hv_domain->hv_iommu->domain_ids, hv_domain->device_domain.domain_id.id);
+}
+
+static bool hv_iommu_capable(struct device *dev, enum iommu_cap cap)
+{
+	switch (cap) {
+	case IOMMU_CAP_CACHE_COHERENCY:
+		return true;
+	case IOMMU_CAP_DEFERRED_FLUSH:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static void hv_flush_device_domain(struct hv_iommu_domain *hv_domain)
+{
+	u64 status;
+	unsigned long flags;
+	struct hv_input_flush_device_domain *input;
+
+	local_irq_save(flags);
+
+	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
+	memset(input, 0, sizeof(*input));
+	input->device_domain = hv_domain->device_domain;
+	status = hv_do_hypercall(HVCALL_FLUSH_DEVICE_DOMAIN, input, NULL);
+
+	local_irq_restore(flags);
+
+	if (!hv_result_success(status))
+		pr_err("HVCALL_FLUSH_DEVICE_DOMAIN failed, status %lld\n", status);
+}
+
+static void hv_iommu_detach_dev(struct iommu_domain *domain, struct device *dev)
+{
+	u64 status;
+	unsigned long flags;
+	struct hv_input_detach_device_domain *input;
+	struct pci_dev *pdev;
+	struct hv_iommu_domain *hv_domain = to_hv_iommu_domain(domain);
+	struct hv_iommu_endpoint *vdev = dev_iommu_priv_get(dev);
+
+	/* See the attach function, only PCI devices for now */
+	if (!dev_is_pci(dev) || vdev->hv_domain != hv_domain)
+		return;
+
+	pdev = to_pci_dev(dev);
+
+	dev_dbg(dev, "detaching from domain %d\n", hv_domain->device_domain.domain_id.id);
+
+	local_irq_save(flags);
+
+	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
+	memset(input, 0, sizeof(*input));
+	input->partition_id = HV_PARTITION_ID_SELF;
+	if (hv_iommu_lookup_logical_dev_id(pdev, &input->device_id.as_uint64)) {
+		local_irq_restore(flags);
+		dev_warn(&pdev->dev, "no IOMMU registration for vPCI bus on detach\n");
+		return;
+	}
+	status = hv_do_hypercall(HVCALL_DETACH_DEVICE_DOMAIN, input, NULL);
+
+	local_irq_restore(flags);
+
+	if (!hv_result_success(status))
+		pr_err("HVCALL_DETACH_DEVICE_DOMAIN failed, status %lld\n", status);
+
+	hv_flush_device_domain(hv_domain);
+
+	vdev->hv_domain = NULL;
+}
+
+static int hv_iommu_attach_dev(struct iommu_domain *domain, struct device *dev,
+			       struct iommu_domain *old)
+{
+	u64 status;
+	unsigned long flags;
+	struct pci_dev *pdev;
+	struct hv_input_attach_device_domain *input;
+	struct hv_iommu_endpoint *vdev = dev_iommu_priv_get(dev);
+	struct hv_iommu_domain *hv_domain = to_hv_iommu_domain(domain);
+	int ret;
+
+	/* Only allow PCI devices for now */
+	if (!dev_is_pci(dev))
+		return -EINVAL;
+
+	if (vdev->hv_domain == hv_domain)
+		return 0;
+
+	if (vdev->hv_domain)
+		hv_iommu_detach_dev(&vdev->hv_domain->domain, dev);
+
+	pdev = to_pci_dev(dev);
+	dev_dbg(dev, "attaching to domain %d\n",
+		hv_domain->device_domain.domain_id.id);
+
+	local_irq_save(flags);
+
+	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
+	memset(input, 0, sizeof(*input));
+	input->device_domain = hv_domain->device_domain;
+	ret = hv_iommu_lookup_logical_dev_id(pdev, &input->device_id.as_uint64);
+	if (ret) {
+		local_irq_restore(flags);
+		dev_err(&pdev->dev, "no IOMMU registration for vPCI bus\n");
+		return ret;
+	}
+	status = hv_do_hypercall(HVCALL_ATTACH_DEVICE_DOMAIN, input, NULL);
+
+	local_irq_restore(flags);
+
+	if (!hv_result_success(status))
+		pr_err("HVCALL_ATTACH_DEVICE_DOMAIN failed, status %lld\n", status);
+	else
+		vdev->hv_domain = hv_domain;
+
+	return hv_result_to_errno(status);
+}
+
+static int hv_iommu_get_logical_device_property(struct device *dev,
+					u32 code,
+					struct hv_output_get_logical_device_property *property)
+{
+	u64 status, lid;
+	unsigned long flags;
+	int ret;
+	struct hv_input_get_logical_device_property *input;
+	struct hv_output_get_logical_device_property *output;
+
+	local_irq_save(flags);
+
+	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
+	output = *this_cpu_ptr(hyperv_pcpu_input_arg) + sizeof(*input);
+	memset(input, 0, sizeof(*input));
+	input->partition_id = HV_PARTITION_ID_SELF;
+	ret = hv_iommu_lookup_logical_dev_id(to_pci_dev(dev), &lid);
+	if (ret) {
+		local_irq_restore(flags);
+		return ret;
+	}
+	input->logical_device_id = lid;
+	input->code = code;
+	status = hv_do_hypercall(HVCALL_GET_LOGICAL_DEVICE_PROPERTY, input, output);
+	*property = *output;
+
+	local_irq_restore(flags);
+
+	if (!hv_result_success(status))
+		pr_err("HVCALL_GET_LOGICAL_DEVICE_PROPERTY failed, status %lld\n", status);
+
+	return hv_result_to_errno(status);
+}
+
+static struct iommu_device *hv_iommu_probe_device(struct device *dev)
+{
+	struct pci_dev *pdev;
+	struct hv_iommu_endpoint *vdev;
+	struct hv_output_get_logical_device_property device_iommu_property = {0};
+
+	if (!dev_is_pci(dev))
+		return ERR_PTR(-ENODEV);
+
+	pdev = to_pci_dev(dev);
+
+	if (hv_iommu_get_logical_device_property(dev,
+						 HV_LOGICAL_DEVICE_PROPERTY_PVIOMMU,
+						 &device_iommu_property) ||
+	    !(device_iommu_property.device_iommu & HV_DEVICE_IOMMU_ENABLED))
+		return ERR_PTR(-ENODEV);
+
+	vdev = kzalloc_obj(*vdev, GFP_KERNEL);
+	if (!vdev)
+		return ERR_PTR(-ENOMEM);
+
+	vdev->dev = dev;
+	vdev->hv_iommu = hv_iommu_device;
+	dev_iommu_priv_set(dev, vdev);
+
+	if (hv_iommu_ats_supported(hv_iommu_device->cap) &&
+	    pci_ats_supported(pdev))
+		pci_enable_ats(pdev, __ffs(hv_iommu_device->pgsize_bitmap));
+
+	return &vdev->hv_iommu->iommu;
+}
+
+static void hv_iommu_release_device(struct device *dev)
+{
+	struct hv_iommu_endpoint *vdev = dev_iommu_priv_get(dev);
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	if (pdev->ats_enabled)
+		pci_disable_ats(pdev);
+
+	dev_iommu_priv_set(dev, NULL);
+	set_dma_ops(dev, NULL);
+
+	kfree(vdev);
+}
+
+static struct iommu_group *hv_iommu_device_group(struct device *dev)
+{
+	if (dev_is_pci(dev))
+		return pci_device_group(dev);
+	else
+		return generic_device_group(dev);
+}
+
+static int hv_configure_device_domain(struct hv_iommu_domain *hv_domain, u32 domain_type)
+{
+	u64 status;
+	unsigned long flags;
+	struct pt_iommu_x86_64_hw_info pt_info;
+	struct hv_input_configure_device_domain *input;
+
+	local_irq_save(flags);
+
+	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
+	memset(input, 0, sizeof(*input));
+	input->device_domain = hv_domain->device_domain;
+	input->settings.flags.blocked = (domain_type == IOMMU_DOMAIN_BLOCKED);
+	input->settings.flags.translation_enabled = (domain_type != IOMMU_DOMAIN_IDENTITY);
+
+	if (domain_type & __IOMMU_DOMAIN_PAGING) {
+		pt_iommu_x86_64_hw_info(&hv_domain->pt_iommu_x86_64, &pt_info);
+		input->settings.page_table_root = pt_info.gcr3_pt;
+		input->settings.flags.first_stage_paging_mode =
+			pt_info.levels == 5;
+	}
+	status = hv_do_hypercall(HVCALL_CONFIGURE_DEVICE_DOMAIN, input, NULL);
+
+	local_irq_restore(flags);
+
+	if (!hv_result_success(status))
+		pr_err("HVCALL_CONFIGURE_DEVICE_DOMAIN failed, status %lld\n", status);
+
+	return hv_result_to_errno(status);
+}
+
+static int __init hv_initialize_static_domains(void)
+{
+	int ret;
+	struct hv_iommu_domain *hv_domain;
+
+	/* Default stage-1 identity domain */
+	hv_domain = &hv_identity_domain;
+
+	ret = hv_create_device_domain(hv_domain, HV_DEVICE_DOMAIN_TYPE_S1);
+	if (ret)
+		return ret;
+
+	ret = hv_configure_device_domain(hv_domain, IOMMU_DOMAIN_IDENTITY);
+	if (ret)
+		goto delete_identity_domain;
+
+	hv_domain->domain.type = IOMMU_DOMAIN_IDENTITY;
+	hv_domain->domain.ops = &hv_iommu_identity_domain_ops;
+	hv_domain->domain.owner = &hv_iommu_ops;
+	hv_domain->domain.geometry = hv_iommu_device->geometry;
+	hv_domain->domain.pgsize_bitmap = hv_iommu_device->pgsize_bitmap;
+
+	/* Default stage-1 blocked domain */
+	hv_domain = &hv_blocking_domain;
+
+	ret = hv_create_device_domain(hv_domain, HV_DEVICE_DOMAIN_TYPE_S1);
+	if (ret)
+		goto delete_identity_domain;
+
+	ret = hv_configure_device_domain(hv_domain, IOMMU_DOMAIN_BLOCKED);
+	if (ret)
+		goto delete_blocked_domain;
+
+	hv_domain->domain.type = IOMMU_DOMAIN_BLOCKED;
+	hv_domain->domain.ops = &hv_iommu_blocking_domain_ops;
+	hv_domain->domain.owner = &hv_iommu_ops;
+	hv_domain->domain.geometry = hv_iommu_device->geometry;
+	hv_domain->domain.pgsize_bitmap = hv_iommu_device->pgsize_bitmap;
+
+	return 0;
+
+delete_blocked_domain:
+	hv_delete_device_domain(&hv_blocking_domain);
+delete_identity_domain:
+	hv_delete_device_domain(&hv_identity_domain);
+	return ret;
+}
+
+#define INTERRUPT_RANGE_START	(0xfee00000)
+#define INTERRUPT_RANGE_END	(0xfeefffff)
+static void hv_iommu_get_resv_regions(struct device *dev,
+		struct list_head *head)
+{
+	struct iommu_resv_region *region;
+
+	region = iommu_alloc_resv_region(INTERRUPT_RANGE_START,
+				      INTERRUPT_RANGE_END - INTERRUPT_RANGE_START + 1,
+				      0, IOMMU_RESV_MSI, GFP_KERNEL);
+	if (!region)
+		return;
+
+	list_add_tail(&region->list, head);
+}
+
+static void hv_iommu_flush_iotlb_all(struct iommu_domain *domain)
+{
+	hv_flush_device_domain(to_hv_iommu_domain(domain));
+}
+
+static void hv_iommu_iotlb_sync(struct iommu_domain *domain,
+				struct iommu_iotlb_gather *iotlb_gather)
+{
+	hv_flush_device_domain(to_hv_iommu_domain(domain));
+
+	iommu_put_pages_list(&iotlb_gather->freelist);
+}
+
+static void hv_iommu_paging_domain_free(struct iommu_domain *domain)
+{
+	struct hv_iommu_domain *hv_domain = to_hv_iommu_domain(domain);
+
+	/* Free all remaining mappings */
+	pt_iommu_deinit(&hv_domain->pt_iommu);
+
+	hv_delete_device_domain(hv_domain);
+
+	kfree(hv_domain);
+}
+
+static const struct iommu_domain_ops hv_iommu_identity_domain_ops = {
+	.attach_dev	= hv_iommu_attach_dev,
+};
+
+static const struct iommu_domain_ops hv_iommu_blocking_domain_ops = {
+	.attach_dev	= hv_iommu_attach_dev,
+};
+
+static const struct iommu_domain_ops hv_iommu_paging_domain_ops = {
+	.attach_dev	= hv_iommu_attach_dev,
+	IOMMU_PT_DOMAIN_OPS(x86_64),
+	.flush_iotlb_all = hv_iommu_flush_iotlb_all,
+	.iotlb_sync = hv_iommu_iotlb_sync,
+	.free = hv_iommu_paging_domain_free,
+};
+
+static struct iommu_domain *hv_iommu_domain_alloc_paging(struct device *dev)
+{
+	int ret;
+	struct hv_iommu_domain *hv_domain;
+	struct pt_iommu_x86_64_cfg cfg = {};
+
+	hv_domain = kzalloc_obj(*hv_domain, GFP_KERNEL);
+	if (!hv_domain)
+		return ERR_PTR(-ENOMEM);
+
+	ret = hv_create_device_domain(hv_domain, HV_DEVICE_DOMAIN_TYPE_S1);
+	if (ret) {
+		kfree(hv_domain);
+		return ERR_PTR(ret);
+	}
+
+	hv_domain->domain.geometry = hv_iommu_device->geometry;
+	hv_domain->pt_iommu.nid = dev_to_node(dev);
+
+	cfg.common.hw_max_vasz_lg2 = hv_iommu_device->max_iova_width;
+	cfg.common.hw_max_oasz_lg2 = 52;
+	cfg.top_level = (hv_iommu_device->max_iova_width > 48) ? 4 : 3;
+
+	ret = pt_iommu_x86_64_init(&hv_domain->pt_iommu_x86_64, &cfg, GFP_KERNEL);
+	if (ret) {
+		hv_delete_device_domain(hv_domain);
+		kfree(hv_domain);
+		return ERR_PTR(ret);
+	}
+
+	/* Constrain to page sizes the hypervisor supports */
+	hv_domain->domain.pgsize_bitmap &= hv_iommu_device->pgsize_bitmap;
+
+	hv_domain->domain.ops = &hv_iommu_paging_domain_ops;
+
+	ret = hv_configure_device_domain(hv_domain, __IOMMU_DOMAIN_PAGING);
+	if (ret) {
+		pt_iommu_deinit(&hv_domain->pt_iommu);
+		hv_delete_device_domain(hv_domain);
+		kfree(hv_domain);
+		return ERR_PTR(ret);
+	}
+
+	return &hv_domain->domain;
+}
+
+static struct iommu_ops hv_iommu_ops = {
+	.capable		  = hv_iommu_capable,
+	.domain_alloc_paging	  = hv_iommu_domain_alloc_paging,
+	.probe_device		  = hv_iommu_probe_device,
+	.release_device		  = hv_iommu_release_device,
+	.device_group		  = hv_iommu_device_group,
+	.get_resv_regions	  = hv_iommu_get_resv_regions,
+	.owner			  = THIS_MODULE,
+	.identity_domain	  = &hv_identity_domain.domain,
+	.blocked_domain		  = &hv_blocking_domain.domain,
+	.release_domain		  = &hv_blocking_domain.domain,
+};
+
+static int hv_iommu_detect(struct hv_output_get_iommu_capabilities *hv_iommu_cap)
+{
+	u64 status;
+	unsigned long flags;
+	struct hv_input_get_iommu_capabilities *input;
+	struct hv_output_get_iommu_capabilities *output;
+
+	local_irq_save(flags);
+
+	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
+	output = *this_cpu_ptr(hyperv_pcpu_input_arg) + sizeof(*input);
+	memset(input, 0, sizeof(*input));
+	input->partition_id = HV_PARTITION_ID_SELF;
+	status = hv_do_hypercall(HVCALL_GET_IOMMU_CAPABILITIES, input, output);
+	*hv_iommu_cap = *output;
+
+	local_irq_restore(flags);
+
+	if (!hv_result_success(status))
+		pr_err("HVCALL_GET_IOMMU_CAPABILITIES failed, status %lld\n", status);
+
+	return hv_result_to_errno(status);
+}
+
+static void __init hv_init_iommu_device(struct hv_iommu_dev *hv_iommu,
+			struct hv_output_get_iommu_capabilities *hv_iommu_cap)
+{
+	ida_init(&hv_iommu->domain_ids);
+
+	hv_iommu->cap = hv_iommu_cap->iommu_cap;
+	hv_iommu->max_iova_width = hv_iommu_cap->max_iova_width;
+	if (!hv_iommu_5lvl_supported(hv_iommu->cap) &&
+	    hv_iommu->max_iova_width > 48) {
+		pr_info("5-level paging not supported, limiting iova width to 48.\n");
+		hv_iommu->max_iova_width = 48;
+	}
+
+	hv_iommu->geometry = (struct iommu_domain_geometry) {
+		.aperture_start = 0,
+		.aperture_end = (((u64)1) << hv_iommu->max_iova_width) - 1,
+		.force_aperture = true,
+	};
+
+	hv_iommu->first_domain = HV_DEVICE_DOMAIN_ID_DEFAULT + 1;
+	hv_iommu->last_domain = HV_DEVICE_DOMAIN_ID_NULL - 1;
+	/* Only x86 page sizes (4K/2M/1G) are supported */
+	hv_iommu->pgsize_bitmap = hv_iommu_cap->pgsize_bitmap &
+				  (SZ_4K | SZ_2M | SZ_1G);
+	if (hv_iommu->pgsize_bitmap != hv_iommu_cap->pgsize_bitmap)
+		pr_warn("unsupported page sizes masked: 0x%llx -> 0x%llx\n",
+			hv_iommu_cap->pgsize_bitmap, hv_iommu->pgsize_bitmap);
+	if (!hv_iommu->pgsize_bitmap) {
+		pr_warn("no supported page sizes, defaulting to 4K\n");
+		hv_iommu->pgsize_bitmap = SZ_4K;
+	}
+	hv_iommu_device = hv_iommu;
+}
+
+int __init hv_iommu_init(void)
+{
+	int ret = 0;
+	struct hv_iommu_dev *hv_iommu = NULL;
+	struct hv_output_get_iommu_capabilities hv_iommu_cap = {0};
+
+	if (no_iommu || iommu_detected)
+		return -ENODEV;
+
+	if (!hv_is_hyperv_initialized())
+		return -ENODEV;
+
+	ret = hv_iommu_detect(&hv_iommu_cap);
+	if (ret) {
+		pr_err("HVCALL_GET_IOMMU_CAPABILITIES failed: %d\n", ret);
+		return -ENODEV;
+	}
+
+	if (!hv_iommu_present(hv_iommu_cap.iommu_cap) ||
+	    !hv_iommu_s1_domain_supported(hv_iommu_cap.iommu_cap)) {
+		pr_err("IOMMU capabilities not sufficient: cap=0x%llx\n",
+		       hv_iommu_cap.iommu_cap);
+		return -ENODEV;
+	}
+
+	iommu_detected = 1;
+	pci_request_acs();
+
+	hv_iommu = kzalloc_obj(*hv_iommu, GFP_KERNEL);
+	if (!hv_iommu)
+		return -ENOMEM;
+
+	hv_init_iommu_device(hv_iommu, &hv_iommu_cap);
+
+	ret = hv_initialize_static_domains();
+	if (ret) {
+		pr_err("static domains init failed: %d\n", ret);
+		goto err_free;
+	}
+
+	ret = iommu_device_sysfs_add(&hv_iommu->iommu, NULL, NULL, "%s", "hv-iommu");
+	if (ret) {
+		pr_err("iommu_device_sysfs_add failed: %d\n", ret);
+		goto err_delete_static_domains;
+	}
+
+	ret = iommu_device_register(&hv_iommu->iommu, &hv_iommu_ops, NULL);
+	if (ret) {
+		pr_err("iommu_device_register failed: %d\n", ret);
+		goto err_sysfs_remove;
+	}
+
+	pr_info("successfully initialized\n");
+	return 0;
+
+err_sysfs_remove:
+	iommu_device_sysfs_remove(&hv_iommu->iommu);
+err_delete_static_domains:
+	hv_delete_device_domain(&hv_blocking_domain);
+	hv_delete_device_domain(&hv_identity_domain);
+err_free:
+	kfree(hv_iommu);
+	return ret;
+}
diff --git a/drivers/iommu/hyperv/iommu.h b/drivers/iommu/hyperv/iommu.h
new file mode 100644
index 000000000000..43f20d371245
--- /dev/null
+++ b/drivers/iommu/hyperv/iommu.h
@@ -0,0 +1,54 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Hyper-V IOMMU driver.
+ *
+ * Copyright (C) 2024-2025, Microsoft, Inc.
+ *
+ */
+
+#ifndef _HYPERV_IOMMU_H
+#define _HYPERV_IOMMU_H
+
+struct hv_iommu_dev {
+	struct iommu_device iommu;
+	struct ida domain_ids;
+
+	/* Device configuration */
+	u8  max_iova_width;
+	u8  max_pasid_width;
+	u64 cap;
+	u64 pgsize_bitmap;
+
+	struct iommu_domain_geometry geometry;
+	u64 first_domain;
+	u64 last_domain;
+};
+
+struct hv_iommu_domain {
+	union {
+		struct iommu_domain    domain;
+		struct pt_iommu        pt_iommu;
+		struct pt_iommu_x86_64 pt_iommu_x86_64;
+	};
+	struct hv_iommu_dev *hv_iommu;
+	struct hv_input_device_domain device_domain;
+	u64		pgsize_bitmap;
+};
+
+struct hv_pci_busdata {
+	int               pci_domain_nr;
+	u32               logical_dev_id_prefix;
+	struct list_head  list;
+};
+
+struct hv_iommu_endpoint {
+	struct device *dev;
+	struct hv_iommu_dev *hv_iommu;
+	struct hv_iommu_domain *hv_domain;
+};
+
+#define to_hv_iommu_domain(d) \
+	container_of(d, struct hv_iommu_domain, domain)
+
+#endif /* _HYPERV_IOMMU_H */
diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index cfc8fa403dad..a4af9c8c2220 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -3715,6 +3715,7 @@ static int hv_pci_probe(struct hv_device *hdev,
 	struct hv_pcibus_device *hbus;
 	int ret, dom;
 	u16 dom_req;
+	u32 prefix;
 	char *name;
 
 	bridge = devm_pci_alloc_host_bridge(&hdev->device, 0);
@@ -3857,13 +3858,25 @@ static int hv_pci_probe(struct hv_device *hdev,
 
 	hbus->state = hv_pcibus_probed;
 
-	ret = create_root_hv_pci_bus(hbus);
+	/* Notify pvIOMMU before any device on the bus is scanned. */
+	prefix = (hdev->dev_instance.b[5] << 24) |
+		 (hdev->dev_instance.b[4] << 16) |
+		 (hdev->dev_instance.b[7] <<  8) |
+		 (hdev->dev_instance.b[6] & 0xf8);
+
+	ret = hv_iommu_register_pci_bus(dom, prefix);
 	if (ret)
 		goto free_windows;
 
+	ret = create_root_hv_pci_bus(hbus);
+	if (ret)
+		goto unregister_pviommu;
+
 	mutex_unlock(&hbus->state_lock);
 	return 0;
 
+unregister_pviommu:
+	hv_iommu_unregister_pci_bus(dom);
 free_windows:
 	hv_pci_free_bridge_windows(hbus);
 exit_d0:
@@ -3974,8 +3987,10 @@ static int hv_pci_bus_exit(struct hv_device *hdev, bool keep_devs)
 static void hv_pci_remove(struct hv_device *hdev)
 {
 	struct hv_pcibus_device *hbus;
+	int dom;
 
 	hbus = hv_get_drvdata(hdev);
+	dom = hbus->bridge->domain_nr;
 	if (hbus->state == hv_pcibus_installed) {
 		tasklet_disable(&hdev->channel->callback_event);
 		hbus->state = hv_pcibus_removing;
@@ -3994,6 +4009,8 @@ static void hv_pci_remove(struct hv_device *hdev)
 		hv_pci_remove_slots(hbus);
 		pci_remove_root_bus(hbus->bridge->bus);
 		pci_unlock_rescan_remove();
+
+		hv_iommu_unregister_pci_bus(dom);
 	}
 
 	hv_pci_bus_exit(hdev, false);
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index bf601d67cecb..b71345c74568 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -73,6 +73,18 @@ extern enum hv_partition_type hv_curr_partition_type;
 extern void * __percpu *hyperv_pcpu_input_arg;
 extern void * __percpu *hyperv_pcpu_output_arg;
 
+#ifdef CONFIG_HYPERV_PVIOMMU
+int  hv_iommu_register_pci_bus(int pci_domain_nr, u32 logical_dev_id_prefix);
+void hv_iommu_unregister_pci_bus(int pci_domain_nr);
+#else
+static inline int hv_iommu_register_pci_bus(int pci_domain_nr,
+					    u32 logical_dev_id_prefix)
+{
+	return 0;
+}
+static inline void hv_iommu_unregister_pci_bus(int pci_domain_nr) { }
+#endif
+
 u64 hv_do_hypercall(u64 control, void *inputaddr, void *outputaddr);
 u64 hv_do_fast_hypercall8(u16 control, u64 input8);
 u64 hv_do_fast_hypercall16(u16 control, u64 input1, u64 input2);
-- 
2.52.0


