Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED7D73C2318
	for <lists+linux-hyperv@lfdr.de>; Fri,  9 Jul 2021 13:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbhGILqg (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 9 Jul 2021 07:46:36 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:42549 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbhGILqf (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 9 Jul 2021 07:46:35 -0400
Received: by mail-wr1-f43.google.com with SMTP id r11so6500424wro.9;
        Fri, 09 Jul 2021 04:43:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K7Hau9Jzl0ePYTrd4qdH09LYrF9z9LqJmxCujJiNlPY=;
        b=G4mf17D/cYNjXbp+f2j725rtvlcr11O8K/j044mqeDCNcb0hVDnENvRwcGKNHPyVgl
         mzJKTFJ/NWde6cCFJ5GWKQek+xBwh9TtIehCnfbqlItx81seQNb3n1QyvhfJ21U41vR3
         55NTx0HHo/Aallr2K6/jFIEa5igiBZEqfRHS5dXXCyVPQPBWzCEx9yGe2ArkHXpuLHSq
         fWHPwx9Y/xx1dWWJbm+xnn9AGtHFkwk6dIKW16Ci1GNi6hRklp7r1Ii+K7GP/J2fB1nS
         iUkVasDKjjVOnka+kBKQyOWk4scI35jLxIJAtIb9RGjOV744gL/Mau1pqGcJSRGdLLRW
         DGKw==
X-Gm-Message-State: AOAM532+HKrqYlS1Zs+w4/cpiCvRtFGVkF8Jg3SE8ecXXQKAw73TOOFr
        J+ra1sBja4qa6Ku2GVCIfrpcSr3Qk54=
X-Google-Smtp-Source: ABdhPJy5w14GWKipwcTipyDgDi83c5TegPP6+IcxYvRG6ozm6cUUDS/FYHgl+blqU/VX4jUP7/xrrw==
X-Received: by 2002:adf:9466:: with SMTP id 93mr41507955wrq.340.1625831029648;
        Fri, 09 Jul 2021 04:43:49 -0700 (PDT)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id z12sm4896849wrs.39.2021.07.09.04.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 04:43:49 -0700 (PDT)
From:   Wei Liu <wei.liu@kernel.org>
To:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        kumarpraveen@linux.microsoft.com, pasha.tatashin@soleen.com,
        Wei Liu <wei.liu@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        iommu@lists.linux-foundation.org (open list:IOMMU DRIVERS)
Subject: [RFC v1 5/8] mshv: add paravirtualized IOMMU support
Date:   Fri,  9 Jul 2021 11:43:36 +0000
Message-Id: <20210709114339.3467637-6-wei.liu@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210709114339.3467637-1-wei.liu@kernel.org>
References: <20210709114339.3467637-1-wei.liu@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Microsoft Hypervisor provides a set of hypercalls to manage device
domains. Implement a type-1 IOMMU using those hypercalls.

Implement DMA remapping as the first step for this driver. Interrupt
remapping will come in a later stage.

Signed-off-by: Wei Liu <wei.liu@kernel.org>
---
 drivers/iommu/Kconfig        |  14 +
 drivers/iommu/hyperv-iommu.c | 628 +++++++++++++++++++++++++++++++++++
 2 files changed, 642 insertions(+)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 1f111b399bca..e230c4536825 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -397,6 +397,20 @@ config HYPERV_IOMMU
 	  Stub IOMMU driver to handle IRQs as to allow Hyper-V Linux
 	  guests to run with x2APIC mode enabled.
 
+config HYPERV_ROOT_PVIOMMU
+	bool "Microsoft Hypervisor paravirtualized IOMMU support"
+	depends on HYPERV && X86
+	select IOMMU_API
+	select IOMMU_DMA
+	select DMA_OPS
+	select IOMMU_IOVA
+	select INTEL_IOMMU
+	select DMAR_TABLE
+	default HYPERV
+	help
+	  A paravirtualized IOMMU for Microsoft Hypervisor. It supports DMA
+	  remapping.
+
 config VIRTIO_IOMMU
 	tristate "Virtio IOMMU driver"
 	depends on VIRTIO
diff --git a/drivers/iommu/hyperv-iommu.c b/drivers/iommu/hyperv-iommu.c
index e285a220c913..043dcff06511 100644
--- a/drivers/iommu/hyperv-iommu.c
+++ b/drivers/iommu/hyperv-iommu.c
@@ -12,7 +12,12 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/iommu.h>
+#include <linux/dma-iommu.h>
 #include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/interval_tree.h>
+#include <linux/dma-map-ops.h>
+#include <linux/dmar.h>
 
 #include <asm/apic.h>
 #include <asm/cpu.h>
@@ -21,6 +26,9 @@
 #include <asm/irq_remapping.h>
 #include <asm/hypervisor.h>
 #include <asm/mshyperv.h>
+#include <asm/iommu_table.h>
+
+#include <linux/intel-iommu.h>
 
 #include "irq_remapping.h"
 
@@ -338,3 +346,623 @@ static const struct irq_domain_ops hyperv_root_ir_domain_ops = {
 };
 
 #endif
+
+#ifdef CONFIG_HYPERV_ROOT_PVIOMMU
+
+/* DMA remapping support */
+struct hv_iommu_domain {
+	struct iommu_domain domain;
+	struct hv_iommu_dev *hv_iommu;
+
+	struct hv_input_device_domain device_domain;
+
+	spinlock_t mappings_lock;
+	struct rb_root_cached mappings;
+
+	u32 map_flags;
+	u64 pgsize_bitmap;
+};
+
+/* What hardware IOMMU? */
+enum {
+	INVALID = 0,
+	INTEL, /* Only Intel for now */
+} hw_iommu_type = { INVALID };
+
+static struct hv_iommu_domain hv_identity_domain, hv_null_domain;
+
+#define to_hv_iommu_domain(d) \
+	container_of(d, struct hv_iommu_domain, domain)
+
+struct hv_iommu_mapping {
+	phys_addr_t paddr;
+	struct interval_tree_node iova;
+	u32 flags;
+};
+
+struct hv_iommu_dev {
+	struct iommu_device iommu;
+
+	struct ida domain_ids;
+
+	/* Device configuration */
+	struct iommu_domain_geometry geometry;
+	u64 first_domain;
+	u64 last_domain;
+
+	u32 map_flags;
+	u64 pgsize_bitmap;
+};
+
+static struct hv_iommu_dev *hv_iommu_device;
+
+struct hv_iommu_endpoint {
+	struct device *dev;
+	struct hv_iommu_dev *hv_iommu;
+	struct hv_iommu_domain *domain;
+};
+
+static void __init hv_initialize_special_domains(void)
+{
+	struct hv_iommu_domain *domain;
+
+	/* Default passthrough domain */
+	domain = &hv_identity_domain;
+
+	memset(domain, 0, sizeof(*domain));
+
+	domain->device_domain.partition_id = HV_PARTITION_ID_SELF;
+	domain->device_domain.domain_id.type = HV_DEVICE_DOMAIN_TYPE_S2;
+	domain->device_domain.domain_id.id = HV_DEVICE_DOMAIN_ID_S2_DEFAULT;
+
+	domain->domain.geometry = hv_iommu_device->geometry;
+
+	/* NULL domain that blocks all DMA transactions */
+	domain = &hv_null_domain;
+
+	memset(domain, 0, sizeof(*domain));
+
+	domain->device_domain.partition_id = HV_PARTITION_ID_SELF;
+	domain->device_domain.domain_id.type = HV_DEVICE_DOMAIN_TYPE_S2;
+	domain->device_domain.domain_id.id = HV_DEVICE_DOMAIN_ID_S2_NULL;
+
+	domain->domain.geometry = hv_iommu_device->geometry;
+}
+
+static bool is_identity_domain(struct hv_iommu_domain *d)
+{
+	return d->device_domain.domain_id.id == HV_DEVICE_DOMAIN_ID_S2_DEFAULT;
+}
+
+static bool is_null_domain(struct hv_iommu_domain *d)
+{
+	return d->device_domain.domain_id.id == HV_DEVICE_DOMAIN_ID_S2_NULL;
+}
+
+static struct iommu_domain *hv_iommu_domain_alloc(unsigned type)
+{
+	struct hv_iommu_domain *domain;
+	int ret;
+	u64 status;
+	unsigned long flags;
+	struct hv_input_create_device_domain *input;
+
+	if (type == IOMMU_DOMAIN_IDENTITY)
+		return &hv_identity_domain.domain;
+
+	if (type == IOMMU_DOMAIN_BLOCKED)
+		return &hv_null_domain.domain;
+
+	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
+	if (!domain)
+		goto out;
+
+	spin_lock_init(&domain->mappings_lock);
+	domain->mappings = RB_ROOT_CACHED;
+
+	if (type == IOMMU_DOMAIN_DMA &&
+		iommu_get_dma_cookie(&domain->domain)) {
+		goto out_free;
+	}
+
+	ret = ida_alloc_range(&hv_iommu_device->domain_ids,
+			hv_iommu_device->first_domain, hv_iommu_device->last_domain,
+			GFP_KERNEL);
+	if (ret < 0)
+		goto out_put_cookie;
+
+	domain->device_domain.partition_id = HV_PARTITION_ID_SELF;
+	domain->device_domain.domain_id.type = HV_DEVICE_DOMAIN_TYPE_S2;
+	domain->device_domain.domain_id.id = ret;
+
+	domain->hv_iommu = hv_iommu_device;
+	domain->map_flags = hv_iommu_device->map_flags;
+
+	local_irq_save(flags);
+
+	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
+	memset(input, 0, sizeof(*input));
+
+	input->device_domain = domain->device_domain;
+
+	input->create_device_domain_flags.forward_progress_required = 1;
+	input->create_device_domain_flags.inherit_owning_vtl = 0;
+
+	status = hv_do_hypercall(HVCALL_CREATE_DEVICE_DOMAIN, input, NULL);
+
+	local_irq_restore(flags);
+
+	if (!hv_result_success(status)) {
+		pr_err("%s: hypercall failed, status %lld\n", __func__, status);
+		goto out_free_id;
+	}
+
+	domain->domain.pgsize_bitmap = hv_iommu_device->pgsize_bitmap;
+	domain->domain.geometry = hv_iommu_device->geometry;
+
+	return &domain->domain;
+
+out_free_id:
+	ida_free(&hv_iommu_device->domain_ids, domain->device_domain.domain_id.id);
+out_put_cookie:
+	iommu_put_dma_cookie(&domain->domain);
+out_free:
+	kfree(domain);
+out:
+	return NULL;
+}
+
+static void hv_iommu_domain_free(struct iommu_domain *d)
+{
+	struct hv_iommu_domain *domain = to_hv_iommu_domain(d);
+	unsigned long flags;
+	u64 status;
+	struct hv_input_delete_device_domain *input;
+
+	if (is_identity_domain(domain) || is_null_domain(domain))
+		return;
+
+	local_irq_save(flags);
+	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
+	memset(input, 0, sizeof(*input));
+
+	input->device_domain= domain->device_domain;
+
+	status = hv_do_hypercall(HVCALL_DELETE_DEVICE_DOMAIN, input, NULL);
+
+	local_irq_restore(flags);
+
+	if (!hv_result_success(status))
+		pr_err("%s: hypercall failed, status %lld\n", __func__, status);
+
+	ida_free(&domain->hv_iommu->domain_ids, domain->device_domain.domain_id.id);
+
+	iommu_put_dma_cookie(d);
+
+	kfree(domain);
+}
+
+static int hv_iommu_attach_dev(struct iommu_domain *d, struct device *dev)
+{
+	struct hv_iommu_domain *domain = to_hv_iommu_domain(d);
+	u64 status;
+	unsigned long flags;
+	struct hv_input_attach_device_domain *input;
+	struct pci_dev *pdev;
+	struct hv_iommu_endpoint *vdev = dev_iommu_priv_get(dev);
+
+	/* Only allow PCI devices for now */
+	if (!dev_is_pci(dev))
+		return -EINVAL;
+
+	pdev = to_pci_dev(dev);
+
+	dev_dbg(dev, "Attaching (%strusted) to %d\n", pdev->untrusted ? "un" : "",
+		domain->device_domain.domain_id.id);
+
+	local_irq_save(flags);
+	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
+	memset(input, 0, sizeof(*input));
+
+	input->device_domain = domain->device_domain;
+	input->device_id = hv_build_pci_dev_id(pdev);
+
+	status = hv_do_hypercall(HVCALL_ATTACH_DEVICE_DOMAIN, input, NULL);
+	local_irq_restore(flags);
+
+	if (!hv_result_success(status))
+		pr_err("%s: hypercall failed, status %lld\n", __func__, status);
+	else
+		vdev->domain = domain;
+
+	return hv_status_to_errno(status);
+}
+
+static void hv_iommu_detach_dev(struct iommu_domain *d, struct device *dev)
+{
+	u64 status;
+	unsigned long flags;
+	struct hv_input_detach_device_domain *input;
+	struct pci_dev *pdev;
+	struct hv_iommu_domain *domain = to_hv_iommu_domain(d);
+	struct hv_iommu_endpoint *vdev = dev_iommu_priv_get(dev);
+
+	/* See the attach function, only PCI devices for now */
+	if (!dev_is_pci(dev))
+		return;
+
+	pdev = to_pci_dev(dev);
+
+	dev_dbg(dev, "Detaching from %d\n", domain->device_domain.domain_id.id);
+
+	local_irq_save(flags);
+	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
+	memset(input, 0, sizeof(*input));
+
+	input->partition_id = HV_PARTITION_ID_SELF;
+	input->device_id = hv_build_pci_dev_id(pdev);
+
+	status = hv_do_hypercall(HVCALL_DETACH_DEVICE_DOMAIN, input, NULL);
+	local_irq_restore(flags);
+
+	if (!hv_result_success(status))
+		pr_err("%s: hypercall failed, status %lld\n", __func__, status);
+
+	vdev->domain = NULL;
+}
+
+static int hv_iommu_add_mapping(struct hv_iommu_domain *domain, unsigned long iova,
+		phys_addr_t paddr, size_t size, u32 flags)
+{
+	unsigned long irqflags;
+	struct hv_iommu_mapping *mapping;
+
+	mapping = kzalloc(sizeof(*mapping), GFP_ATOMIC);
+	if (!mapping)
+		return -ENOMEM;
+
+	mapping->paddr = paddr;
+	mapping->iova.start = iova;
+	mapping->iova.last = iova + size - 1;
+	mapping->flags = flags;
+
+	spin_lock_irqsave(&domain->mappings_lock, irqflags);
+	interval_tree_insert(&mapping->iova, &domain->mappings);
+	spin_unlock_irqrestore(&domain->mappings_lock, irqflags);
+
+	return 0;
+}
+
+static size_t hv_iommu_del_mappings(struct hv_iommu_domain *domain,
+		unsigned long iova, size_t size)
+{
+	unsigned long flags;
+	size_t unmapped = 0;
+	unsigned long last = iova + size - 1;
+	struct hv_iommu_mapping *mapping = NULL;
+	struct interval_tree_node *node, *next;
+
+	spin_lock_irqsave(&domain->mappings_lock, flags);
+	next = interval_tree_iter_first(&domain->mappings, iova, last);
+	while (next) {
+		node = next;
+		mapping = container_of(node, struct hv_iommu_mapping, iova);
+		next = interval_tree_iter_next(node, iova, last);
+
+		/* Trying to split a mapping? Not supported for now. */
+		if (mapping->iova.start < iova)
+			break;
+
+		unmapped += mapping->iova.last - mapping->iova.start + 1;
+
+		interval_tree_remove(node, &domain->mappings);
+		kfree(mapping);
+	}
+	spin_unlock_irqrestore(&domain->mappings_lock, flags);
+
+	return unmapped;
+}
+
+static int hv_iommu_map(struct iommu_domain *d, unsigned long iova,
+			phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
+{
+	u32 map_flags;
+	unsigned long flags, pfn, npages;
+	int ret, i;
+	struct hv_iommu_domain *domain = to_hv_iommu_domain(d);
+	struct hv_input_map_device_gpa_pages *input;
+	u64 status;
+
+	/* Reject size that's not a whole page */
+	if (size & ~HV_HYP_PAGE_MASK)
+		return -EINVAL;
+
+	map_flags = HV_MAP_GPA_READABLE; /* Always required */
+	map_flags |= prot & IOMMU_WRITE ? HV_MAP_GPA_WRITABLE : 0;
+
+	ret = hv_iommu_add_mapping(domain, iova, paddr, size, flags);
+	if (ret)
+		return ret;
+
+	npages = size >> HV_HYP_PAGE_SHIFT;
+
+	local_irq_save(flags);
+	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
+	memset(input, 0, sizeof(*input));
+
+	input->device_domain = domain->device_domain;
+	input->map_flags = map_flags;
+	input->target_device_va_base = iova;
+
+	pfn = paddr >> HV_HYP_PAGE_SHIFT;
+	for (i = 0; i < npages; i++) {
+		input->gpa_page_list[i] = pfn;
+		pfn += 1;
+	}
+
+	status = hv_do_rep_hypercall(HVCALL_MAP_DEVICE_GPA_PAGES, npages, 0,
+			input, NULL);
+
+	local_irq_restore(flags);
+
+	if (!hv_result_success(status)) {
+		pr_err("%s: hypercall failed, status %lld\n", __func__, status);
+		hv_iommu_del_mappings(domain, iova, size);
+	}
+
+	return hv_status_to_errno(status);
+}
+
+static size_t hv_iommu_unmap(struct iommu_domain *d, unsigned long iova,
+			   size_t size, struct iommu_iotlb_gather *gather)
+{
+	size_t unmapped;
+	struct hv_iommu_domain *domain = to_hv_iommu_domain(d);
+	unsigned long flags, npages;
+	struct hv_input_unmap_device_gpa_pages *input;
+	u64 status;
+
+	unmapped = hv_iommu_del_mappings(domain, iova, size);
+	if (unmapped < size)
+		return 0;
+
+	npages = size >> HV_HYP_PAGE_SHIFT;
+
+	local_irq_save(flags);
+	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
+	memset(input, 0, sizeof(*input));
+
+	input->device_domain = domain->device_domain;
+	input->target_device_va_base = iova;
+
+	/* Unmap `npages` pages starting from VA base */
+	status = hv_do_rep_hypercall(HVCALL_UNMAP_DEVICE_GPA_PAGES, npages,
+			0, input, NULL);
+
+	local_irq_restore(flags);
+
+	if (!hv_result_success(status))
+		pr_err("%s: hypercall failed, status %lld\n", __func__, status);
+
+	return hv_result_success(status) ? unmapped : 0;
+}
+
+static phys_addr_t hv_iommu_iova_to_phys(struct iommu_domain *d,
+				       dma_addr_t iova)
+{
+	u64 paddr = 0;
+	unsigned long flags;
+	struct hv_iommu_mapping *mapping;
+	struct interval_tree_node *node;
+	struct hv_iommu_domain *domain = to_hv_iommu_domain(d);
+
+	spin_lock_irqsave(&domain->mappings_lock, flags);
+	node = interval_tree_iter_first(&domain->mappings, iova, iova);
+	if (node) {
+		mapping = container_of(node, struct hv_iommu_mapping, iova);
+		paddr = mapping->paddr + (iova - mapping->iova.start);
+	}
+	spin_unlock_irqrestore(&domain->mappings_lock, flags);
+
+	return paddr;
+}
+
+static struct iommu_device *hv_iommu_probe_device(struct device *dev)
+{
+	struct hv_iommu_endpoint *vdev;
+
+	if (!dev_is_pci(dev))
+		return ERR_PTR(-ENODEV);
+
+	vdev = kzalloc(sizeof(*vdev), GFP_KERNEL);
+	if (!vdev)
+		return ERR_PTR(-ENOMEM);
+
+	vdev->dev = dev;
+	vdev->hv_iommu = hv_iommu_device;
+	dev_iommu_priv_set(dev, vdev);
+
+	return &vdev->hv_iommu->iommu;
+}
+
+static void hv_iommu_probe_finalize(struct device *dev)
+{
+	struct iommu_domain *d = iommu_get_domain_for_dev(dev);
+
+	if (d && d->type == IOMMU_DOMAIN_DMA)
+		iommu_setup_dma_ops(dev, 1 << PAGE_SHIFT, 0);
+	else
+		set_dma_ops(dev, NULL);
+}
+
+static void hv_iommu_release_device(struct device *dev)
+{
+	struct hv_iommu_endpoint *vdev = dev_iommu_priv_get(dev);
+
+	/* Need to detach device from device domain if necessary. */
+	if (vdev->domain)
+		hv_iommu_detach_dev(&vdev->domain->domain, dev);
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
+/*
+ * This bitmap is used to advertise the page sizes our hardware support to the
+ * IOMMU core, which will then use this information to split physically
+ * contiguous memory regions it is mapping into page sizes that we support.
+ *
+ * Given the size of the PFN array we can accommodate less than 512 4KiB pages.
+ */
+#define HV_IOMMU_PGSIZES (SZ_4K | SZ_1M)
+
+static void hv_iommu_get_resv_regions(struct device *dev,
+		struct list_head *head)
+{
+	switch (hw_iommu_type) {
+	case INTEL:
+		intel_iommu_get_resv_regions(dev, head);
+		break;
+	default:
+		/* Do nothing */;
+	}
+}
+
+static int hv_iommu_def_domain_type(struct device *dev)
+{
+	/* The hypervisor has created a default passthrough domain */
+	return IOMMU_DOMAIN_IDENTITY;
+}
+
+static struct iommu_ops hv_iommu_ops = {
+	.domain_alloc     = hv_iommu_domain_alloc,
+	.domain_free      = hv_iommu_domain_free,
+	.attach_dev       = hv_iommu_attach_dev,
+	.detach_dev       = hv_iommu_detach_dev,
+	.map              = hv_iommu_map,
+	.unmap            = hv_iommu_unmap,
+	.iova_to_phys     = hv_iommu_iova_to_phys,
+	.probe_device     = hv_iommu_probe_device,
+	.probe_finalize   = hv_iommu_probe_finalize,
+	.release_device   = hv_iommu_release_device,
+	.def_domain_type  = hv_iommu_def_domain_type,
+	.device_group     = hv_iommu_device_group,
+	.get_resv_regions = hv_iommu_get_resv_regions,
+	.put_resv_regions = generic_iommu_put_resv_regions,
+	.pgsize_bitmap    = HV_IOMMU_PGSIZES,
+	.owner            = THIS_MODULE,
+};
+
+static void __init hv_initalize_resv_regions_intel(void)
+{
+	int ret;
+
+	down_write(&dmar_global_lock);
+	if (dmar_table_init(false, true)) {
+		pr_err("Failed to initialize DMAR table\n");
+		up_write(&dmar_global_lock);
+		return;
+	}
+
+	ret = dmar_dev_scope_init();
+	if (ret)
+		pr_err("Failed to initialize device scope\n");
+
+	up_write(&dmar_global_lock);
+
+	hw_iommu_type = INTEL;
+}
+
+static void __init hv_initialize_resv_regions(void)
+{
+	hv_initalize_resv_regions_intel();
+}
+
+int __init hv_iommu_init(void)
+{
+	int ret = 0;
+	struct hv_iommu_dev *hv_iommu = NULL;
+
+	if (!hv_is_hyperv_initialized())
+		return -ENODEV;
+
+	hv_initialize_resv_regions();
+
+	hv_iommu = kzalloc(sizeof(*hv_iommu), GFP_KERNEL);
+	if (!hv_iommu)
+		return -ENOMEM;
+
+	ida_init(&hv_iommu->domain_ids);
+	hv_iommu->first_domain = HV_DEVICE_DOMAIN_ID_S2_DEFAULT + 1;
+	hv_iommu->last_domain = HV_DEVICE_DOMAIN_ID_S2_NULL - 1;
+
+	hv_iommu->geometry = (struct iommu_domain_geometry) {
+		.aperture_start = 0,
+		.aperture_end = -1UL,
+		.force_aperture = true,
+	};
+
+	hv_iommu->map_flags = IOMMU_READ | IOMMU_WRITE;
+	hv_iommu->pgsize_bitmap = HV_IOMMU_PGSIZES;
+
+	ret = iommu_device_sysfs_add(&hv_iommu->iommu, NULL, NULL, "%s", "hv-iommu");
+	if (ret) {
+		pr_err("iommu_device_sysfs_add failed: %d\n", ret);
+		goto err_free;
+	}
+
+	ret = iommu_device_register(&hv_iommu->iommu, &hv_iommu_ops, NULL);
+	if (ret) {
+		pr_err("iommu_device_register failed: %d\n", ret);
+		goto err_sysfs_remove;
+	}
+
+	/* This must come before bus_set_iommu because it calls into the hooks. */
+	hv_iommu_device = hv_iommu;
+	hv_initialize_special_domains();
+
+#ifdef CONFIG_PCI
+	ret = bus_set_iommu(&pci_bus_type, &hv_iommu_ops);
+	if (ret) {
+		pr_err("bus_set_iommu failed: %d\n", ret);
+		goto err_unregister;
+	}
+#endif
+	pr_info("Microsoft Hypervisor IOMMU initialized\n");
+
+	return 0;
+
+#ifdef CONFIG_PCI
+err_unregister:
+	iommu_device_unregister(&hv_iommu->iommu);
+#endif
+err_sysfs_remove:
+	iommu_device_sysfs_remove(&hv_iommu->iommu);
+err_free:
+	kfree(hv_iommu);
+	return ret;
+}
+
+int __init hv_iommu_detect(void)
+{
+	if (!(ms_hyperv.misc_features & HV_DEVICE_DOMAIN_AVAILABLE))
+		return -ENODEV;
+
+	iommu_detected = 1;
+	x86_init.iommu.iommu_init = hv_iommu_init;
+
+	return 1;
+}
+IOMMU_INIT_POST(hv_iommu_detect);
+
+#endif /* CONFIG_HYPERV_ROOT_PVIOMMU */
-- 
2.30.2

