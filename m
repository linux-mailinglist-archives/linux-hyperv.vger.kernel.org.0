Return-Path: <linux-hyperv+bounces-10549-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBVHFUrz9Gl+FwIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10549-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 01 May 2026 20:39:06 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9EA64AEE52
	for <lists+linux-hyperv@lfdr.de>; Fri, 01 May 2026 20:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0DD303007E07
	for <lists+linux-hyperv@lfdr.de>; Fri,  1 May 2026 18:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300A6359A7E;
	Fri,  1 May 2026 18:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Yr2yEuJp"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91216346AE5;
	Fri,  1 May 2026 18:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777660734; cv=none; b=Vu888MYsz2gdTtNG31HU1H6uiggMKBd4fA4emr4b5sq3VoD2R1/sgSpd0HAg6DV69bg8bI3nDdpe7Z3G5q7BUR85O4xv8O2vZnY7QdzNP4c5k6suVa3Myxyu4/YK4ThAStAjmx2Fel+RikL6DIlFSNlHwPWb5khWAVUszb5KQiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777660734; c=relaxed/simple;
	bh=Cs/3xyomAhG80Ub25L3D0EyGfkubymoWuhLCR3M++6k=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CJYCgBDPgOUF6vNwNqxXDJhmo7tG/ReEPH2PN+dYJBxLGiuSII69pGOvnyqpQJXcSWaapJd/Nxnzz0ZFOwqAesNoXdfF+i6zFVrm/9z5JJOKPEgM7wZWXQpul4Ef5LJJv8Io/Cixk3SS+JPF4Ksb6Ib8M0MNk1dvneEm9autarw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Yr2yEuJp; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.17.144.128] (unknown [131.107.1.128])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1753E20B7167;
	Fri,  1 May 2026 11:38:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1753E20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777660726;
	bh=VWHUtdKcIqKUgAKujME9mYENyngCK25nDrOwnvGtKZ4=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=Yr2yEuJpMuZAb5c5L1ZVIGd0WTZdXvOQUbBFLDZxcjSqzT3t7eNSzNOawn0riz86Q
	 PzKG/qeVpwgR8AZks1mgXdNM0zypBT2mCoGxKdetYOza06aF3g9fJTwhucp8bqYjB5
	 ug7tBUkWFaCjbSwK5Bva8svCaU3VxBfj+1VLDrqc=
Message-ID: <af9fa6f0-1dce-4a15-98c5-b4f8cc8b7f70@linux.microsoft.com>
Date: Fri, 1 May 2026 11:38:44 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: hpa@zytor.com, robin.murphy@arm.com, robh@kernel.org, wei.liu@kernel.org,
 mhklinux@outlook.com, muislam@microsoft.com, namjain@linux.microsoft.com,
 magnuskulke@linux.microsoft.com, anbelski@linux.microsoft.com,
 linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
 iommu@lists.linux.dev, linux-pci@vger.kernel.org,
 linux-arch@vger.kernel.org, easwar.hariharan@linux.microsoft.com,
 kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
 longli@microsoft.com, tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, joro@8bytes.org,
 will@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
 bhelgaas@google.com, arnd@arndb.de
Subject: Re: [PATCH V2 08/11] PCI: hv: Build device id for a VMBus device,
 export PCI devid function
To: Mukesh R <mrathor@linux.microsoft.com>
References: <20260501004157.3108202-1-mrathor@linux.microsoft.com>
 <20260501004157.3108202-9-mrathor@linux.microsoft.com>
From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <20260501004157.3108202-9-mrathor@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: E9EA64AEE52
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-10549-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[zytor.com,arm.com,kernel.org,outlook.com,microsoft.com,linux.microsoft.com,vger.kernel.org,lists.linux.dev,redhat.com,alien8.de,linux.intel.com,8bytes.org,google.com,arndb.de];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[easwar.hariharan@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,linux.microsoft.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On 4/30/2026 5:41 PM, Mukesh R wrote:
> On Hyper-V, most hypercalls related to PCI passthru to map/unmap regions,
> interrupts, etc need a device ID as a parameter. This device ID refers
> to that specific device during the lifetime of passthru.
> 
> An L1VH VM only contains VMBus based devices. A device ID for a VMBus
> device is slightly different in that it uses the hv_pcibus_device info
> for building it to make sure it matches exactly what the hypervisor
> expects. This VMBus based device ID is needed when attaching devices in
> an L1VH based guest VM. Before building it, a check is done to make sure
> the device is a valid VMBus device.
> 
> In remaining cases, PCI device ID is used. So, also make PCI device ID
> build function hv_build_devid_type_pci() public.
> 
> Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
> ---
>  arch/x86/hyperv/irqdomain.c         |  9 +++++----
>  arch/x86/include/asm/mshyperv.h     |  6 ++++++
>  drivers/pci/controller/pci-hyperv.c | 24 ++++++++++++++++++++++++
>  include/asm-generic/mshyperv.h      |  8 ++++++++
>  4 files changed, 43 insertions(+), 4 deletions(-)
> 
Please see the discussion on a similar patch for the guest IOMMU driver here:
https://lore.kernel.org/all/2dabc1b8-0cf0-4fc8-9cd4-cce60adfc05e@linux.microsoft.com/

My implementation of that approach is below:

--------------------x8-------------------------------------------------
commit 233e90466cb79b3a952806206d89164ca2a1428a
Author: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Date:   Thu Apr 30 20:46:05 2026 +0000

    PCI: hv: Inform IOMMU when new devices are offered

    Hyper-V uses a logical device ID to identify a PCI endpoint device for
    child partitions. This ID is built from parts of the virtual PCI bus
    GUID and the function number of the PCI BDF. This ID is required to
    identify devices to the hypervisor for IOMMU management hypercalls used
    by the Hyper-V IOMMU driver.

    Inform the IOMMU driver of the Hyper-V vPCI bus GUID so it can build the
    logical device ID for vPCI devices, and factor the logic for building
    this ID into a standalone helper function for clarity and easier
    maintenance in tandem with the IOMMU driver's version.

    Signed-off-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>

diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 20d947c2c758..d1070a4a24eb 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -315,6 +315,9 @@ static inline void __mshv_vtl_return_call(struct mshv_vtl_cpu_context *vtl0) {}
 
 #ifdef CONFIG_HYPERV_PVIOMMU
 int __init hv_iommu_init(void);
+int hv_iommu_inform(int dom, guid_t bus_instance_guid);
+#else
+int hv_iommu_inform(int dom, guid_t bus_instance_guid) {}
 #endif
 
 #include <asm-generic/mshyperv.h>
diff --git a/drivers/iommu/hyperv/iommu.c b/drivers/iommu/hyperv/iommu.c
index ad7000f4566e..34a39c3b89b4 100644
--- a/drivers/iommu/hyperv/iommu.c
+++ b/drivers/iommu/hyperv/iommu.c
@@ -8,6 +8,7 @@
 
 #include <linux/iommu.h>
 #include <linux/pci.h>
+#include <linux/uuid.h>
 #include <linux/dma-map-ops.h>
 #include <linux/generic_pt/iommu.h>
 #include <linux/syscore_ops.h>
@@ -26,12 +27,86 @@ static struct hv_iommu_domain hv_blocking_domain;
 static const struct iommu_domain_ops hv_iommu_identity_domain_ops;
 static const struct iommu_domain_ops hv_iommu_blocking_domain_ops;
 static struct iommu_ops hv_iommu_ops;
+static struct list_head hv_pci_bus_list;
 
 #define hv_iommu_present(iommu_cap) (iommu_cap & HV_IOMMU_CAP_PRESENT)
 #define hv_iommu_s1_domain_supported(iommu_cap) (iommu_cap & HV_IOMMU_CAP_S1)
 #define hv_iommu_5lvl_supported(iommu_cap) (iommu_cap & HV_IOMMU_CAP_S1_5LVL)
 #define hv_iommu_ats_supported(iommu_cap) (iommu_cap & HV_IOMMU_CAP_ATS)
 
+/*
+ * Build a "Device Logical ID" out of this PCI bus's instance GUID and the
+ * function number of the device.
+ * This is identical and should be maintained in sync with
+ * hv_pci_build_logical_dev_id() in pci-hyperv.c. Only repeated here to avoid
+ * dependency of a built-in driver (iommu) on a module (pci-hyperv) and to
+ * maintain the correct direction of dependency of the PCI driver on the IOMMU
+ * instead of vice versa
+ */
+static u64 hv_iommu_build_logical_dev_id(struct pci_dev *pdev,
+					 guid_t bus_instance_guid)
+{
+	return (u64)((bus_instance_guid.b[5] << 24) |
+		     (bus_instance_guid.b[4] << 16) |
+		     (bus_instance_guid.b[7] << 8)  |
+		     (bus_instance_guid.b[6] & 0xf8) |
+		     PCI_FUNC(pdev->devfn));
+}
+
+static struct hv_pci_busdata *find_hv_pci_bus(int dom)
+{
+	struct hv_pci_busdata *curr = NULL;
+
+	list_for_each_entry(curr, &hv_pci_bus_list, list) {
+		if (curr->dom == dom) {
+			return curr;
+		}
+	}
+	return NULL;
+}
+
+#define INVALID_LOGICAL_DEV_ID	0
+static u64 hv_iommu_get_logical_dev_id(struct pci_dev *pdev)
+{
+	struct hv_pci_busdata *bus = find_hv_pci_bus(pci_domain_nr(pdev->bus));
+
+	if (!bus) {
+		dev_WARN(&pdev->dev,
+			"received device ID request for missing hv_pci bus\n");
+		return INVALID_LOGICAL_DEV_ID;
+	}
+
+	return hv_iommu_build_logical_dev_id(pdev, bus->bus_instance_guid);
+}
+
+int hv_iommu_inform(int dom, guid_t bus_instance_guid)
+{
+	struct hv_pci_busdata *found, *new;
+
+	/* Don't spend memory if there is no consumer */
+	if (no_iommu || !iommu_detected)
+		return 0;
+
+	found = find_hv_pci_bus(dom);
+	if (found && !guid_equal(&found->bus_instance_guid, &bus_instance_guid)) {
+		found->bus_instance_guid = bus_instance_guid;
+		return 0;
+	}
+
+	new = kzalloc_obj(*new);
+	if (!new) {
+		pr_info("No memory to allocate hv_pci bus data\n");
+		return -ENOMEM;
+	}
+
+	new->dom = dom;
+	new->bus_instance_guid = bus_instance_guid;
+	list_add(&new->list, &hv_pci_bus_list);
+
+	return 0;
+}
+EXPORT_SYMBOL_FOR_MODULES(hv_iommu_inform, "pci-hyperv");
+
 static int hv_create_device_domain(struct hv_iommu_domain *hv_domain, u32 domain_stage)
 {
 	int ret;
@@ -143,7 +218,7 @@ static void hv_iommu_detach_dev(struct iommu_domain *domain, struct device *dev)
 	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
 	memset(input, 0, sizeof(*input));
 	input->partition_id = HV_PARTITION_ID_SELF;
-	input->device_id.as_uint64 = hv_build_logical_dev_id(pdev);
+	input->device_id.as_uint64 = hv_iommu_get_logical_dev_id(pdev);
 	status = hv_do_hypercall(HVCALL_DETACH_DEVICE_DOMAIN, input, NULL);
 
 	local_irq_restore(flags);
@@ -185,7 +260,7 @@ static int hv_iommu_attach_dev(struct iommu_domain *domain, struct device *dev,
 	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
 	memset(input, 0, sizeof(*input));
 	input->device_domain = hv_domain->device_domain;
-	input->device_id.as_uint64 = hv_build_logical_dev_id(pdev);
+	input->device_id.as_uint64 = hv_iommu_get_logical_dev_id(pdev);
 	status = hv_do_hypercall(HVCALL_ATTACH_DEVICE_DOMAIN, input, NULL);
 
 	local_irq_restore(flags);
@@ -213,7 +288,7 @@ static int hv_iommu_get_logical_device_property(struct device *dev,
 	output = *this_cpu_ptr(hyperv_pcpu_input_arg) + sizeof(*input);
 	memset(input, 0, sizeof(*input));
 	input->partition_id = HV_PARTITION_ID_SELF;
-	input->logical_device_id = hv_build_logical_dev_id(to_pci_dev(dev));
+	input->logical_device_id = hv_iommu_get_logical_dev_id(to_pci_dev(dev));
 	input->code = code;
 	status = hv_do_hypercall(HVCALL_GET_LOGICAL_DEVICE_PROPERTY, input, output);
 	*property = *output;
@@ -665,6 +740,7 @@ int __init hv_iommu_init(void)
 
 	iommu_detected = 1;
 	pci_request_acs();
+	INIT_LIST_HEAD(&hv_pci_bus_list);
 
 	hv_iommu = kzalloc(sizeof(*hv_iommu), GFP_KERNEL);
 	if (!hv_iommu)
diff --git a/drivers/iommu/hyperv/iommu.h b/drivers/iommu/hyperv/iommu.h
index 8829176ddb51..5b2d1c41c101 100644
--- a/drivers/iommu/hyperv/iommu.h
+++ b/drivers/iommu/hyperv/iommu.h
@@ -36,6 +36,12 @@ struct hv_iommu_domain {
 	u64		pgsize_bitmap;
 };
 
+struct hv_pci_busdata {
+	int dom;
+	guid_t bus_instance_guid;
+	struct list_head list;
+};
+
 struct hv_iommu_endpoint {
 	struct device *dev;
 	struct hv_iommu_dev *hv_iommu;
diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 3b7adf28ee09..5d4fb2c2f60a 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -597,23 +597,19 @@ static unsigned int hv_msi_get_int_vector(struct irq_data *data)
 
 #define hv_msi_prepare		pci_msi_prepare
 
-/**
+#define INVALID_LOGICAL_DEV_ID	0
+/*
  * Build a "Device Logical ID" out of this PCI bus's instance GUID and the
  * function number of the device.
  */
-u64 hv_build_logical_dev_id(struct pci_dev *pdev)
+static u64 hv_pci_build_logical_dev_id(struct pci_dev *pdev, guid_t bus_instance_guid)
 {
-	struct pci_bus *pbus = pdev->bus;
-	struct hv_pcibus_device *hbus = container_of(pbus->sysdata,
-						struct hv_pcibus_device, sysdata);
-
-	return (u64)((hbus->hdev->dev_instance.b[5] << 24) |
-		     (hbus->hdev->dev_instance.b[4] << 16) |
-		     (hbus->hdev->dev_instance.b[7] << 8)  |
-		     (hbus->hdev->dev_instance.b[6] & 0xf8) |
+	return (u64)((bus_instance_guid.b[5] << 24) |
+		     (bus_instance_guid.b[4] << 16) |
+		     (bus_instance_guid.b[7] << 8)  |
+		     (bus_instance_guid.b[6] & 0xf8) |
 		     PCI_FUNC(pdev->devfn));
 }
-EXPORT_SYMBOL_GPL(hv_build_logical_dev_id);
 
 /**
  * hv_irq_retarget_interrupt() - "Unmask" the IRQ by setting its current
@@ -657,7 +653,7 @@ static void hv_irq_retarget_interrupt(struct irq_data *data)
 	params->int_entry.source = HV_INTERRUPT_SOURCE_MSI;
 	params->int_entry.msi_entry.address.as_uint32 = int_desc->address & 0xffffffff;
 	params->int_entry.msi_entry.data.as_uint32 = int_desc->data;
-	params->device_id = hv_build_logical_dev_id(pdev);
+	params->device_id = hv_pci_build_logical_dev_id(pdev, hbus->hdev->dev_instance);
 	params->int_target.vector = hv_msi_get_int_vector(data);
 
 	if (hbus->protocol_version >= PCI_PROTOCOL_VERSION_1_2) {
@@ -3869,6 +3865,9 @@ static int hv_pci_probe(struct hv_device *hdev,
 
 	hbus->state = hv_pcibus_probed;
 
+	/* Inform the IOMMU of the bus GUID of devices headed their way */
+	hv_iommu_inform(dom, hdev->dev_instance);
+
 	ret = create_root_hv_pci_bus(hbus);
 	if (ret)
 		goto free_windows;

--------------------8x-------------------------------------------------

Thanks,
Easwar (he/him)

