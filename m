Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B95C280F48
	for <lists+linux-hyperv@lfdr.de>; Fri,  2 Oct 2020 10:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbgJBIwg (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 2 Oct 2020 04:52:36 -0400
Received: from mail-co1nam11on2123.outbound.protection.outlook.com ([40.107.220.123]:20961
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725993AbgJBIwg (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 2 Oct 2020 04:52:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ww54InFsvQfHBUSmokl6WRowrbtPmgZvdB53BVAygR77lAOmZMaq6hVe4j/WX7JpX5RjEC1EATlsQwAKvf6J+OcY2jDqNOo+x209v8k6rjmxEfMUZk/w3RHIlIeOtf5tt+clOgw9Q/Ah8FH44KZKDYyWtK3n/M0dmPAr+waR8+Mhz7y1WGZi7wAMyD4yXJi3JO2gXSAhmx5AXYvpkdF7LquwsmBeshjYypPU9k2WA6FXsXzL+F6FXslXR6oCJk6TbD/FhZbHIe68jd0WoZN0q+XZrg1/BqOOXDb2FJh4POzCDR7CYI25Riq/6tGaGObgnf9xOXFIzWraMYa3aiFtww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MUDVMjMJB+tyjHwy000qc7sCSzh1hsxorwEshSA2OCQ=;
 b=HU/TOqafwpItHk/70ZRXikcBgECb9fIE+RZRAcY5sx/esQKoc8Fvsrh+WbZnfO78OI090q8c9QpBj7j/+ZjdZi8ac31Q58OEspJADQOvB+0Hn00hBj+3kqVM3lr6EZRF7Z4iJeAVYL7mMITdCMYBUVG2K6YV68Shvz0/j/ueXun1zWEswd3TPpj0Hh6CQfpFzpQ5+sRsC8qgThhzDaCpTn6deX6XXEYzWACySs6Pk9j2C9ens12T2V+jMEenABHwbKXIArcRAhckjOGSebknP+6wCljRQpQjH09E79X3U2wurNeIcTfwceMR56wqxFs92qYgim43DsSDbB+kabJ+Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MUDVMjMJB+tyjHwy000qc7sCSzh1hsxorwEshSA2OCQ=;
 b=i3n6i+o9dG7iopP/HAALPD+x2mnncodHaThVw0EWhITAv4sJ0RAKG2RedRZPIRY274CYkMTXNcXBrlqUaDVRu6vUTqeqTXT/FL29A2bAGqHbSAtU15ww+ywlXKCxkdupxyB3xICVz4Hc/0CGguEPGG16doNoGOmbf3bS+Lnia70=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=microsoft.com;
Received: from BN6PR21MB0162.namprd21.prod.outlook.com (2603:10b6:404:94::8)
 by BN6PR21MB0129.namprd21.prod.outlook.com (2603:10b6:404:93::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.14; Fri, 2 Oct
 2020 08:52:32 +0000
Received: from BN6PR21MB0162.namprd21.prod.outlook.com
 ([fe80::641a:3e30:395a:38d6]) by BN6PR21MB0162.namprd21.prod.outlook.com
 ([fe80::641a:3e30:395a:38d6%13]) with mapi id 15.20.3455.015; Fri, 2 Oct 2020
 08:52:32 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     lorenzo.pieralisi@arm.com, maz@kernel.org, bhelgaas@google.com,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        wei.liu@kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com
Cc:     jakeo@microsoft.com, Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v3] PCI: hv: Fix hibernation in case interrupts are not re-created
Date:   Fri,  2 Oct 2020 01:51:58 -0700
Message-Id: <20201002085158.9168-1-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
Reply-To: decui@microsoft.com
Content-Type: text/plain
X-Originating-IP: [2001:4898:80e8:a:784f:8b8b:1755:1e09]
X-ClientProxiedBy: MWHPR22CA0057.namprd22.prod.outlook.com
 (2603:10b6:300:12a::19) To BN6PR21MB0162.namprd21.prod.outlook.com
 (2603:10b6:404:94::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from decui-u1804.corp.microsoft.com (2001:4898:80e8:a:784f:8b8b:1755:1e09) by MWHPR22CA0057.namprd22.prod.outlook.com (2603:10b6:300:12a::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend Transport; Fri, 2 Oct 2020 08:52:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ce65d66f-75bc-437e-a9b8-08d866b07ffd
X-MS-TrafficTypeDiagnostic: BN6PR21MB0129:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR21MB0129089E3F226C451B728F15BF310@BN6PR21MB0129.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: keK5/s3mx+/jZZAraPeG12gIMNOyGFTWaJewOXu3mcuSWnM2AXQK5+SZOOd3RASArfreGA5P/v3sf9pDGcp6eSPlx9MSmJtp9CJINMd/ZtK2MCq5HdQtvzfVt5eafnUfoc0h6fwUxNBn0H1efTHS1QwKaj8A5+7SKnkGYXQp7ahs4zW6rxOF7T1DeY6s0YFTZ+h+kYpS8g7cIGV5s3l5ebB3s8dNBL92nV0HuC80t3GaA5yywS9T//PqIQeazPjjd3Q1c4Sc9IGNkSPibPoTvgv+WP3/8NW7UEd7jpYQXWtDztAYDnBUH+GHjQl4OMET1weidaeCbUS0vHXpjXKux5c53DWjw/66fVl1YjlxZJCI3r1qGDh0nPLCeip+i2u9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR21MB0162.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(346002)(396003)(366004)(136003)(7696005)(2616005)(8936002)(66556008)(82950400001)(6486002)(66476007)(107886003)(36756003)(2906002)(1076003)(186003)(86362001)(82960400001)(5660300002)(10290500003)(16526019)(8676002)(478600001)(3450700001)(83380400001)(4326008)(316002)(66946007)(6636002)(6666004)(52116002)(921003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 93wR+IaARiS979uI+DqJzaho3wBh5xnfKqpHrAi68mzqlNKydYTTAy+m3kL0nWmMxCrBGGs+tYOiXm+F3iOjy3OGBpBqM+/b9WOmMmweUs9qxuYg9d6vOOTmG+l3LDxfwHxrvhPsQubF5hSLtk+UQVdHoKiJkf/fqpqdq8Zze0o5YBZqzDFnfECCFwNFNMlaF7RxltZDDmmXuC4pb3h01mzizdLfM5iMKgchStI0cI9tNYfUNADeuKOPMj9twI9rVyVZABa5Zxsz091TtsVa+eARtt350sR1Z9Vh6vkGw7ef+dbEhbsNINvMAVzxgc6r2b0DzyFBMO9caub0mxmaSNIBEZnNil4TD9OP6TJd2FD5TiYYSCc+zajMduMemrPZ0StY51gNvBen3jKpBfdJxOFDW4LXLvvCip+OhX7QYSPXwwaGGd7gs7h786quAiaIxxLkYw224sW7gQxBuQF371BrGmokq34M06YR6hdLvgDgthlNyGUtUfJtGzw5ymp3vjcLYgIn7K9s1VgJJ2Qaw1iVt1deC6KYWGbgGxr3Kf2AySz/WwsSDranOgxzlza4vXIhCKXj+gM8JGhyCk8SI647Tt6oVsgzFW//EaHUv3StpwPkSaL02AX1vH07Gonrj0+eoqV8ZzWicf1QddOLZS0aQOjXe1vFYSm8Fbr/B4K+BwivV7mkdil/Ox3R3ocpNeV38vChIifKC5wWzRZb5A==
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce65d66f-75bc-437e-a9b8-08d866b07ffd
X-MS-Exchange-CrossTenant-AuthSource: BN6PR21MB0162.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2020 08:52:32.4401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ul1RylfZ+Z33nKKprt65KwwXSCSCAhngImeVq+v/yzwTWcjPZb8GY9eEldChp/wIyd4y/Cvf0iUcVyPoJarRhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR21MB0129
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

pci_restore_msi_state() directly writes the MSI/MSI-X related registers
via MMIO. On a physical machine, this works perfectly; for a Linux VM
running on a hypervisor, which typically enables IOMMU interrupt remapping,
the hypervisor usually should trap and emulate the MMIO accesses in order
to re-create the necessary interrupt remapping table entries in the IOMMU,
otherwise the interrupts can not work in the VM after hibernation.

Hyper-V is different from other hypervisors in that it does not trap and
emulate the MMIO accesses, and instead it uses a para-virtualized method,
which requires the VM to call hv_compose_msi_msg() to notify the hypervisor
of the info that would be passed to the hypervisor in the case of the
trap-and-emulate method. This is not an issue to a lot of PCI device
drivers, which destroy and re-create the interrupts across hibernation, so
hv_compose_msi_msg() is called automatically. However, some PCI device
drivers (e.g. the in-tree GPU driver nouveau and the out-of-tree Nvidia
proprietary GPU driver) do not destroy and re-create MSI/MSI-X interrupts
across hibernation, so hv_pci_resume() has to call hv_compose_msi_msg(),
otherwise the PCI device drivers can no longer receive interrupts after
the VM resumes from hibernation.

Hyper-V is also different in that chip->irq_unmask() may fail in a
Linux VM running on Hyper-V (on a physical machine, chip->irq_unmask()
can not fail because unmasking an MSI/MSI-X register just means an MMIO
write): during hibernation, when a CPU is offlined, the kernel tries
to move the interrupt to the remaining CPUs that haven't been offlined
yet. In this case, hv_irq_unmask() -> hv_do_hypercall() always fails
because the vmbus channel has been closed: here the early "return" in
hv_irq_unmask() means the pci_msi_unmask_irq() is not called, i.e. the
desc->masked remains "true", so later after hibernation, the MSI interrupt
always remains masked, which is incorrect. Refer to cpu_disable_common()
-> fixup_irqs() -> irq_migrate_all_off_this_cpu() -> migrate_one_irq():

static bool migrate_one_irq(struct irq_desc *desc)
{
...
        if (maskchip && chip->irq_mask)
                chip->irq_mask(d);
...
        err = irq_do_set_affinity(d, affinity, false);
...
        if (maskchip && chip->irq_unmask)
                chip->irq_unmask(d);

Fix the issue by calling pci_msi_unmask_irq() unconditionally in
hv_irq_unmask(). Also suppress the error message for hibernation because
the hypercall failure during hibernation does not matter (at this time
all the devices have been frozen). Note: the correct affinity info is
still updated into the irqdata data structure in migrate_one_irq() ->
irq_do_set_affinity() -> hv_set_affinity(), so later when the VM
resumes, hv_pci_restore_msi_state() is able to correctly restore
the interrupt with the correct affinity.

Fixes: ac82fc832708 ("PCI: hv: Add hibernation support")
Reviewed-by: Jake Oshins <jakeo@microsoft.com>
Signed-off-by: Dexuan Cui <decui@microsoft.com>
---

Changes in v2:
    Fixed a typo in the comment in hv_irq_unmask. Thanks to Michael!
    Added Jake's Reviewed-by.

Changes in v3:
    Improved the commit log.
    Improved the comments.
    Improved the change in hv_irq_unmask(): removed the early "return"
        and call pci_msi_unmask_irq() unconditionally.

 drivers/pci/controller/pci-hyperv.c | 50 +++++++++++++++++++++++++++--
 1 file changed, 47 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index fc4c3a15e570..a9df492fbffa 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -1276,11 +1276,25 @@ static void hv_irq_unmask(struct irq_data *data)
 exit_unlock:
 	spin_unlock_irqrestore(&hbus->retarget_msi_interrupt_lock, flags);
 
-	if (res) {
+	/*
+	 * During hibernation, when a CPU is offlined, the kernel tries
+	 * to move the interrupt to the remaining CPUs that haven't
+	 * been offlined yet. In this case, the below hv_do_hypercall()
+	 * always fails since the vmbus channel has been closed:
+	 * refer to cpu_disable_common() -> fixup_irqs() ->
+	 * irq_migrate_all_off_this_cpu() -> migrate_one_irq().
+	 *
+	 * Suppress the error message for hibernation because the failure
+	 * during hibernation does not matter (at this time all the devices
+	 * have been frozen). Note: the correct affinity info is still updated
+	 * into the irqdata data structure in migrate_one_irq() ->
+	 * irq_do_set_affinity() -> hv_set_affinity(), so later when the VM
+	 * resumes, hv_pci_restore_msi_state() is able to correctly restore
+	 * the interrupt with the correct affinity.
+	 */
+	if (res && hbus->state != hv_pcibus_removing)
 		dev_err(&hbus->hdev->device,
 			"%s() failed: %#llx", __func__, res);
-		return;
-	}
 
 	pci_msi_unmask_irq(data);
 }
@@ -3372,6 +3386,34 @@ static int hv_pci_suspend(struct hv_device *hdev)
 	return 0;
 }
 
+static int hv_pci_restore_msi_msg(struct pci_dev *pdev, void *arg)
+{
+	struct msi_desc *entry;
+	struct irq_data *irq_data;
+
+	for_each_pci_msi_entry(entry, pdev) {
+		irq_data = irq_get_irq_data(entry->irq);
+		if (WARN_ON_ONCE(!irq_data))
+			return -EINVAL;
+
+		hv_compose_msi_msg(irq_data, &entry->msg);
+	}
+
+	return 0;
+}
+
+/*
+ * Upon resume, pci_restore_msi_state() -> ... ->  __pci_write_msi_msg()
+ * directly writes the MSI/MSI-X registers via MMIO, but since Hyper-V
+ * doesn't trap and emulate the MMIO accesses, here hv_compose_msi_msg()
+ * must be used to ask Hyper-V to re-create the IOMMU Interrupt Remapping
+ * Table entries.
+ */
+static void hv_pci_restore_msi_state(struct hv_pcibus_device *hbus)
+{
+	pci_walk_bus(hbus->pci_bus, hv_pci_restore_msi_msg, NULL);
+}
+
 static int hv_pci_resume(struct hv_device *hdev)
 {
 	struct hv_pcibus_device *hbus = hv_get_drvdata(hdev);
@@ -3405,6 +3447,8 @@ static int hv_pci_resume(struct hv_device *hdev)
 
 	prepopulate_bars(hbus);
 
+	hv_pci_restore_msi_state(hbus);
+
 	hbus->state = hv_pcibus_installed;
 	return 0;
 out:
-- 
2.19.1

