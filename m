Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAF183CFB55
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Jul 2021 15:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239220AbhGTNNS (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 20 Jul 2021 09:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239059AbhGTNGg (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 20 Jul 2021 09:06:36 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465A0C0613E6;
        Tue, 20 Jul 2021 06:46:38 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id x10so23986819ion.9;
        Tue, 20 Jul 2021 06:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YMv1DI/ZhpMb2Ve8CTEd8dpbh8Zb1cpLxKTvPpDd7wU=;
        b=Uas6KPlF3N7rbCMCpLpu4d2yNFvOQkhtFzah6cQORmIebjJv38Yn+sINDsHaEMk1Lo
         HLicZfHtfmb47uDeIKsqtizrAuZaFQDVTSv1uTZNbiSLv5aU3dma/MvQoRoSIOPO9YVj
         P422zE506zwNekNaqmDwE2Gnd+0Q5qCRMOgkk9NkTfOHmlASZuecPyTDTK16T3QUkuD+
         +u1YAQzXGt2tzVyvE3s4Oitx521H+W/Un9Sc5BVSmJLUPpGZ+DwsQDBdjRtTfDvtgHQ9
         Donwf6/nCL9CjO5Kv+yqfwQwKq8oYtYy9RI7oMRHAhsTeqIarS3bTPjVGqQT5Y8cyE+Z
         0ZPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YMv1DI/ZhpMb2Ve8CTEd8dpbh8Zb1cpLxKTvPpDd7wU=;
        b=QcIgx/Eq9R0jiL52H3m1Y5+p+NaL52zwDTx0lT0wI45eNmEHxZWH0AnhtqwwBmzovU
         1IvaBWPu4mFjTx6vuBGwDG+d+wubXDYXeY/0NzwLjdBnGxb/wfWLYlIVVKPfEF9bPngj
         iD5E8OqeDaUDU/X+B0vIqqiBrQOWZR5b80mYJMSxuYhmE1Uwl2lLB74u2VmJOiXSO2SE
         57CUHQuVNUMtPy6XuiDWsbeurV8NXRy+aZWaA2bEiIKvs+6PBdbUgHNd2Fy4sJVVUuL8
         xzgtS6vI0K+wf/69bOVIUuVAFGNlWq/cofQLyPh9jiCdWPvSpAUWh0StTQCGVgPGw8dv
         eYLw==
X-Gm-Message-State: AOAM5311AfKwhMBCTncvbv1EPGM+LOMsHtw8DlKRx4objQ+XpLITlrv3
        wpYuts9oHoqp6ZwMnFJZgQw=
X-Google-Smtp-Source: ABdhPJykztV98i11sv1y1UBdNxeRDpKRzmMvZAyKXRAmQ4/FgSpOQgmspxLksXKKxGMmTtNbPkvw/Q==
X-Received: by 2002:a05:6638:3824:: with SMTP id i36mr14697705jav.11.1626788797796;
        Tue, 20 Jul 2021 06:46:37 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id e14sm11103558ilc.47.2021.07.20.06.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 06:46:37 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailauth.nyi.internal (Postfix) with ESMTP id 54D7B27C005A;
        Tue, 20 Jul 2021 09:46:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 20 Jul 2021 09:46:36 -0400
X-ME-Sender: <xms:vNP2YFQz7ZMyOLz5WKGTVYmlZqCR5OUscPzVwlScOBNaOPbojf7tqA>
    <xme:vNP2YOxugolpHctk1v4bKTvL9F7iGgRECwDE5B0XTKanLWo1vzpZpreYFL1hwEN9x
    6JbAKhGdI60ddvrgg>
X-ME-Received: <xmr:vNP2YK2aIZ0O-9AqX4dUQ9s7q66K03ixmo0ywqqC4_4xlX7IbvXrhMdGBTs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrfedvgdeikecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeehvdevteefgfeiudettdefvedvvdelkeejueffffelgeeuhffhjeetkeeiueeu
    leenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvg
X-ME-Proxy: <xmx:vNP2YNC1pfpPX6u1iTkpqpAXLDku0pUWatIrVT0kHwwcbyGzQqqxSQ>
    <xmx:vNP2YOgN69Hcq2cD6n1JuiMhRs6UNn2bkzE5CybtZtaj_xrNLbrSiw>
    <xmx:vNP2YBr4WRKljWpQIP8EFFmj4PLiE_CRTNXiem1M8drnxVQCQgQaag>
    <xmx:vNP2YHaseBBX4c4ynPuSY9Vd_Os_VdQkdBe0DtnvvCDfTdpEP-xi-zqpRek>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Jul 2021 09:46:35 -0400 (EDT)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Marc Zyngier <maz@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Mike Rapoport <rppt@kernel.org>
Subject: [RFC v5 5/8] PCI: hv: Generify PCI probing
Date:   Tue, 20 Jul 2021 21:44:26 +0800
Message-Id: <20210720134429.511541-6-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210720134429.511541-1-boqun.feng@gmail.com>
References: <20210720134429.511541-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

In order to support ARM64 Hyper-V PCI, we need to set up the bridge at
probing time because ARM64 is a PCI_DOMAIN_GENERIC=y arch and we don't
have pci_config_window (ARM64 sysdata) for a PCI root bus on Hyper-V, so
it's impossible to retrieve the information (e.g. PCI domains, MSI
domains) from bus sysdata on ARM64 after creation.

Originally in create_root_hv_pci_bus(), pci_create_root_bus() is used to
create the root bus and the corresponding bridge based on x86 sysdata.
Now we create a bridge first and then call pci_scan_root_bus_bridge(),
which allows us to do the necessary set-ups for the bridge.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 drivers/pci/controller/pci-hyperv.c | 57 +++++++++++++++--------------
 1 file changed, 30 insertions(+), 27 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index a53bd8728d0d..8d42da5dd1d4 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -449,6 +449,7 @@ enum hv_pcibus_state {
 
 struct hv_pcibus_device {
 	struct pci_sysdata sysdata;
+	struct pci_host_bridge *bridge;
 	/* Protocol version negotiated with the host */
 	enum pci_protocol_version_t protocol_version;
 	enum hv_pcibus_state state;
@@ -464,8 +465,6 @@ struct hv_pcibus_device {
 	spinlock_t device_list_lock;	/* Protect lists below */
 	void __iomem *cfg_addr;
 
-	struct list_head resources_for_children;
-
 	struct list_head children;
 	struct list_head dr_list;
 
@@ -1797,7 +1796,7 @@ static void hv_pci_assign_slots(struct hv_pcibus_device *hbus)
 
 		slot_nr = PCI_SLOT(wslot_to_devfn(hpdev->desc.win_slot.slot));
 		snprintf(name, SLOT_NAME_SIZE, "%u", hpdev->desc.ser);
-		hpdev->pci_slot = pci_create_slot(hbus->pci_bus, slot_nr,
+		hpdev->pci_slot = pci_create_slot(hbus->bridge->bus, slot_nr,
 					  name, NULL);
 		if (IS_ERR(hpdev->pci_slot)) {
 			pr_warn("pci_create slot %s failed\n", name);
@@ -1827,7 +1826,7 @@ static void hv_pci_remove_slots(struct hv_pcibus_device *hbus)
 static void hv_pci_assign_numa_node(struct hv_pcibus_device *hbus)
 {
 	struct pci_dev *dev;
-	struct pci_bus *bus = hbus->pci_bus;
+	struct pci_bus *bus = hbus->bridge->bus;
 	struct hv_pci_dev *hv_dev;
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
@@ -1850,21 +1849,22 @@ static void hv_pci_assign_numa_node(struct hv_pcibus_device *hbus)
  */
 static int create_root_hv_pci_bus(struct hv_pcibus_device *hbus)
 {
-	/* Register the device */
-	hbus->pci_bus = pci_create_root_bus(&hbus->hdev->device,
-					    0, /* bus number is always zero */
-					    &hv_pcifront_ops,
-					    &hbus->sysdata,
-					    &hbus->resources_for_children);
-	if (!hbus->pci_bus)
-		return -ENODEV;
+	int error;
+	struct pci_host_bridge *bridge = hbus->bridge;
+
+	bridge->dev.parent = &hbus->hdev->device;
+	bridge->sysdata = &hbus->sysdata;
+	bridge->ops = &hv_pcifront_ops;
+
+	error = pci_scan_root_bus_bridge(bridge);
+	if (error)
+		return error;
 
 	pci_lock_rescan_remove();
-	pci_scan_child_bus(hbus->pci_bus);
 	hv_pci_assign_numa_node(hbus);
-	pci_bus_assign_resources(hbus->pci_bus);
+	pci_bus_assign_resources(bridge->bus);
 	hv_pci_assign_slots(hbus);
-	pci_bus_add_devices(hbus->pci_bus);
+	pci_bus_add_devices(bridge->bus);
 	pci_unlock_rescan_remove();
 	hbus->state = hv_pcibus_installed;
 	return 0;
@@ -2127,7 +2127,7 @@ static void pci_devices_present_work(struct work_struct *work)
 		 * because there may have been changes.
 		 */
 		pci_lock_rescan_remove();
-		pci_scan_child_bus(hbus->pci_bus);
+		pci_scan_child_bus(hbus->bridge->bus);
 		hv_pci_assign_numa_node(hbus);
 		hv_pci_assign_slots(hbus);
 		pci_unlock_rescan_remove();
@@ -2295,8 +2295,8 @@ static void hv_eject_device_work(struct work_struct *work)
 	/*
 	 * Ejection can come before or after the PCI bus has been set up, so
 	 * attempt to find it and tear down the bus state, if it exists.  This
-	 * must be done without constructs like pci_domain_nr(hbus->pci_bus)
-	 * because hbus->pci_bus may not exist yet.
+	 * must be done without constructs like pci_domain_nr(hbus->bridge->bus)
+	 * because hbus->bridge->bus may not exist yet.
 	 */
 	wslot = wslot_to_devfn(hpdev->desc.win_slot.slot);
 	pdev = pci_get_domain_bus_and_slot(hbus->sysdata.domain, 0, wslot);
@@ -2662,8 +2662,7 @@ static int hv_pci_allocate_bridge_windows(struct hv_pcibus_device *hbus)
 		/* Modify this resource to become a bridge window. */
 		hbus->low_mmio_res->flags |= IORESOURCE_WINDOW;
 		hbus->low_mmio_res->flags &= ~IORESOURCE_BUSY;
-		pci_add_resource(&hbus->resources_for_children,
-				 hbus->low_mmio_res);
+		pci_add_resource(&hbus->bridge->windows, hbus->low_mmio_res);
 	}
 
 	if (hbus->high_mmio_space) {
@@ -2682,8 +2681,7 @@ static int hv_pci_allocate_bridge_windows(struct hv_pcibus_device *hbus)
 		/* Modify this resource to become a bridge window. */
 		hbus->high_mmio_res->flags |= IORESOURCE_WINDOW;
 		hbus->high_mmio_res->flags &= ~IORESOURCE_BUSY;
-		pci_add_resource(&hbus->resources_for_children,
-				 hbus->high_mmio_res);
+		pci_add_resource(&hbus->bridge->windows, hbus->high_mmio_res);
 	}
 
 	return 0;
@@ -3002,6 +3000,7 @@ static void hv_put_dom_num(u16 dom)
 static int hv_pci_probe(struct hv_device *hdev,
 			const struct hv_vmbus_device_id *dev_id)
 {
+	struct pci_host_bridge *bridge;
 	struct hv_pcibus_device *hbus;
 	u16 dom_req, dom;
 	char *name;
@@ -3014,6 +3013,10 @@ static int hv_pci_probe(struct hv_device *hdev,
 	 */
 	BUILD_BUG_ON(sizeof(*hbus) > HV_HYP_PAGE_SIZE);
 
+	bridge = devm_pci_alloc_host_bridge(&hdev->device, 0);
+	if (!bridge)
+		return -ENOMEM;
+
 	/*
 	 * With the recent 59bb47985c1d ("mm, sl[aou]b: guarantee natural
 	 * alignment for kmalloc(power-of-two)"), kzalloc() is able to allocate
@@ -3035,6 +3038,8 @@ static int hv_pci_probe(struct hv_device *hdev,
 	hbus = kzalloc(HV_HYP_PAGE_SIZE, GFP_KERNEL);
 	if (!hbus)
 		return -ENOMEM;
+
+	hbus->bridge = bridge;
 	hbus->state = hv_pcibus_init;
 	hbus->wslot_res_allocated = -1;
 
@@ -3071,7 +3076,6 @@ static int hv_pci_probe(struct hv_device *hdev,
 	hbus->hdev = hdev;
 	INIT_LIST_HEAD(&hbus->children);
 	INIT_LIST_HEAD(&hbus->dr_list);
-	INIT_LIST_HEAD(&hbus->resources_for_children);
 	spin_lock_init(&hbus->config_lock);
 	spin_lock_init(&hbus->device_list_lock);
 	spin_lock_init(&hbus->retarget_msi_interrupt_lock);
@@ -3295,9 +3299,9 @@ static int hv_pci_remove(struct hv_device *hdev)
 
 		/* Remove the bus from PCI's point of view. */
 		pci_lock_rescan_remove();
-		pci_stop_root_bus(hbus->pci_bus);
+		pci_stop_root_bus(hbus->bridge->bus);
 		hv_pci_remove_slots(hbus);
-		pci_remove_root_bus(hbus->pci_bus);
+		pci_remove_root_bus(hbus->bridge->bus);
 		pci_unlock_rescan_remove();
 	}
 
@@ -3307,7 +3311,6 @@ static int hv_pci_remove(struct hv_device *hdev)
 
 	iounmap(hbus->cfg_addr);
 	hv_free_config_window(hbus);
-	pci_free_resource_list(&hbus->resources_for_children);
 	hv_pci_free_bridge_windows(hbus);
 	irq_domain_remove(hbus->irq_domain);
 	irq_domain_free_fwnode(hbus->sysdata.fwnode);
@@ -3390,7 +3393,7 @@ static int hv_pci_restore_msi_msg(struct pci_dev *pdev, void *arg)
  */
 static void hv_pci_restore_msi_state(struct hv_pcibus_device *hbus)
 {
-	pci_walk_bus(hbus->pci_bus, hv_pci_restore_msi_msg, NULL);
+	pci_walk_bus(hbus->bridge->bus, hv_pci_restore_msi_msg, NULL);
 }
 
 static int hv_pci_resume(struct hv_device *hdev)
-- 
2.30.2

