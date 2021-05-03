Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 572933716F5
	for <lists+linux-hyperv@lfdr.de>; Mon,  3 May 2021 16:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbhECOsk (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 3 May 2021 10:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbhECOsj (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 3 May 2021 10:48:39 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B632BC06174A;
        Mon,  3 May 2021 07:47:45 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id q5so2667403qvv.6;
        Mon, 03 May 2021 07:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K7WNcv9gpl7Pc9Bs4CClcYzbGI8iLKijx7i4GjrAumE=;
        b=hDTXkLgdcBg/8iActEuVZQsBNINluBlGBSf7I7odEakWa+wbqfIS8ru5mGYOIN3W9a
         Z8u+zqGdzHrqgNzvNLnG2YTpfUBkO9Pm69m3IWELrOgpm07CycymYoSV0E7Tlh5a12GP
         N8CSKMpNXgp2AGXk4Id6oTZoCkc0gd1FWZJyKTEf42SJBXZo7FdHE+6ELCXM9YKMX2ua
         HLOgS1hcP12qpAIdthqyAUltnITk3NcCCVGNaMnj9wjeIq9+MPZNM9ApVf8SFVAMs/7m
         0kdHTcxfFvXHezgVH14WCzSV8H+wu03fGHprIRg5AChgBT9MZqNHQyp+zB9vhKkQtV+X
         xY0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K7WNcv9gpl7Pc9Bs4CClcYzbGI8iLKijx7i4GjrAumE=;
        b=YDjD0rJjrNQ1idBEUDF3w4sl//Ib2cwX/gcYa6YLKsEuTUU86jt3fo7h9WsOwg0ISD
         0Q+f+LbNDrVsZogHNhekhS/nCOPqeHcB9ixmk+Y6Yn9N4v8DRT1mjmqEpe7uSpAVErT5
         IiplDhw7drOQpHnkOEfcYSbVSNjXNhbdtpq8tV+tt4GHQpDHT3kXsY9L93gho+/vkI7N
         EZ3r7Z65Lt7xu+VToxZBuSQ3QHRPBv63oqFZlccJ4Di5HB+jngIvNXTc7ZbfkYvHqo5g
         r/R8gqTTblS5C85zReZIOZ2QOwHiyfJ131uLh/spUDIyj6h6wjmi/tTVnTdAas25KeH7
         HBIA==
X-Gm-Message-State: AOAM530XM8l9QQsXH8FZkxHHvs05XSRBfvht+FYRv0w/AERh7562oAJJ
        WhpusL0YDPw5Cn3xQwKGYgk=
X-Google-Smtp-Source: ABdhPJwhFORps0pBFTvoj1SZER6t9pF8hcj2oPdiHng2UNuDKEAEABMrq6X2quoa/uEV0cg+fxBuVA==
X-Received: by 2002:ad4:4f11:: with SMTP id fb17mr20178028qvb.18.1620053264946;
        Mon, 03 May 2021 07:47:44 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id n15sm8qti.51.2021.05.03.07.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 07:47:44 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailauth.nyi.internal (Postfix) with ESMTP id 8439927C005A;
        Mon,  3 May 2021 10:47:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 03 May 2021 10:47:43 -0400
X-ME-Sender: <xms:Dg2QYO_w5aQTDdjycxDPoXzY2UrybrHhakTn3yj_a0oHZFQImyQg3g>
    <xme:Dg2QYOtrqHJQeyjCFJIaDuwCDX6RfsTJYauVilJYBTWSivUJOPlV8ssNiyb7pgXe-
    sLD6aVPWLV84i2vcA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdefgedgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephedvveetfefgiedutedtfeevvddvleekjeeuffffleeguefhhfejteekieeu
    ueelnecukfhppedufedurddutdejrddurddvheegnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgv
    rhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfh
    gvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:Dg2QYEBtr2BGPhUb77DJjaC15elTplZ9Rp9zOPDMabib8DDCbpDrTg>
    <xmx:Dg2QYGdwvEJXkHCxGayVopmsvtYj1x8nSZgSf0mFD25zu2nFBkmSaA>
    <xmx:Dg2QYDMqcOTIbsEkZfaQSylWtzq8J4xWKv9iyfKaa3YrpEUmb6d1tw>
    <xmx:Dw2QYNU1d91duQjTAndaCP6-jHMCW3ZZf0wOLaUeJKLryUcDO2eW1MBqkCMNTaKH>
Received: from localhost (unknown [131.107.1.254])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Mon,  3 May 2021 10:47:42 -0400 (EDT)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Marc Zyngier <maz@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jon Derrick <jonathan.derrick@intel.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-hyperv@vger.kernel.org
Subject: [RFC v2 3/7] PCI: hv: Generify PCI probing
Date:   Mon,  3 May 2021 22:46:31 +0800
Message-Id: <20210503144635.2297386-4-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210503144635.2297386-1-boqun.feng@gmail.com>
References: <20210503144635.2297386-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

In order to support ARM64 Hyper-V PCI, we need to set up the bridge at
probing time because ARM64 is a PCI_DOMAIN_GENERIC arch and we don't
have pci_config_window (ARM64 sysdata) for a PCI root bus on Hyper-V, so
it's impossible to retrieve the information (e.g. PCI domains, irq
domains) from bus sysdata on ARM64 after creation.

Originally in create_root_hv_pci_bus(), pci_create_root_bus() is used to
create the root bus and the corresponding bridge based on x86 sysdata.
Now we create a bridge first and then call pci_scan_root_bus_bridge(),
which allows us to do the necessary set-ups for the bridge.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 drivers/pci/controller/pci-hyperv.c | 61 +++++++++++++++--------------
 1 file changed, 31 insertions(+), 30 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 27a17a1e4a7c..27b922b4bb7b 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -450,6 +450,7 @@ enum hv_pcibus_state {
 
 struct hv_pcibus_device {
 	struct pci_sysdata sysdata;
+	struct pci_host_bridge *bridge;
 	/* Protocol version negotiated with the host */
 	enum pci_protocol_version_t protocol_version;
 	enum hv_pcibus_state state;
@@ -462,13 +463,10 @@ struct hv_pcibus_device {
 	struct resource *high_mmio_res;
 	struct completion *survey_event;
 	struct completion remove_event;
-	struct pci_bus *pci_bus;
 	spinlock_t config_lock;	/* Avoid two threads writing index page */
 	spinlock_t device_list_lock;	/* Protect lists below */
 	void __iomem *cfg_addr;
 
-	struct list_head resources_for_children;
-
 	struct list_head children;
 	struct list_head dr_list;
 
@@ -1804,7 +1802,7 @@ static void hv_pci_assign_slots(struct hv_pcibus_device *hbus)
 
 		slot_nr = PCI_SLOT(wslot_to_devfn(hpdev->desc.win_slot.slot));
 		snprintf(name, SLOT_NAME_SIZE, "%u", hpdev->desc.ser);
-		hpdev->pci_slot = pci_create_slot(hbus->pci_bus, slot_nr,
+		hpdev->pci_slot = pci_create_slot(hbus->bridge->bus, slot_nr,
 					  name, NULL);
 		if (IS_ERR(hpdev->pci_slot)) {
 			pr_warn("pci_create slot %s failed\n", name);
@@ -1834,7 +1832,7 @@ static void hv_pci_remove_slots(struct hv_pcibus_device *hbus)
 static void hv_pci_assign_numa_node(struct hv_pcibus_device *hbus)
 {
 	struct pci_dev *dev;
-	struct pci_bus *bus = hbus->pci_bus;
+	struct pci_bus *bus = hbus->bridge->bus;
 	struct hv_pci_dev *hv_dev;
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
@@ -1857,24 +1855,24 @@ static void hv_pci_assign_numa_node(struct hv_pcibus_device *hbus)
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
+	bridge->msi = &hbus->msi_chip;
+	bridge->msi->dev = &hbus->hdev->device;
 
-	hbus->pci_bus->msi = &hbus->msi_chip;
-	hbus->pci_bus->msi->dev = &hbus->hdev->device;
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
@@ -2139,7 +2137,7 @@ static void pci_devices_present_work(struct work_struct *work)
 		 * because there may have been changes.
 		 */
 		pci_lock_rescan_remove();
-		pci_scan_child_bus(hbus->pci_bus);
+		pci_scan_child_bus(hbus->bridge->bus);
 		hv_pci_assign_numa_node(hbus);
 		hv_pci_assign_slots(hbus);
 		pci_unlock_rescan_remove();
@@ -2310,8 +2308,8 @@ static void hv_eject_device_work(struct work_struct *work)
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
@@ -2680,8 +2678,7 @@ static int hv_pci_allocate_bridge_windows(struct hv_pcibus_device *hbus)
 		/* Modify this resource to become a bridge window. */
 		hbus->low_mmio_res->flags |= IORESOURCE_WINDOW;
 		hbus->low_mmio_res->flags &= ~IORESOURCE_BUSY;
-		pci_add_resource(&hbus->resources_for_children,
-				 hbus->low_mmio_res);
+		pci_add_resource(&hbus->bridge->windows, hbus->low_mmio_res);
 	}
 
 	if (hbus->high_mmio_space) {
@@ -2700,8 +2697,7 @@ static int hv_pci_allocate_bridge_windows(struct hv_pcibus_device *hbus)
 		/* Modify this resource to become a bridge window. */
 		hbus->high_mmio_res->flags |= IORESOURCE_WINDOW;
 		hbus->high_mmio_res->flags &= ~IORESOURCE_BUSY;
-		pci_add_resource(&hbus->resources_for_children,
-				 hbus->high_mmio_res);
+		pci_add_resource(&hbus->bridge->windows, hbus->high_mmio_res);
 	}
 
 	return 0;
@@ -3031,6 +3027,7 @@ static void hv_put_dom_num(u16 dom)
 static int hv_pci_probe(struct hv_device *hdev,
 			const struct hv_vmbus_device_id *dev_id)
 {
+	struct pci_host_bridge *bridge;
 	struct hv_pcibus_device *hbus;
 	u16 dom_req, dom;
 	char *name;
@@ -3043,6 +3040,10 @@ static int hv_pci_probe(struct hv_device *hdev,
 	 */
 	BUILD_BUG_ON(sizeof(*hbus) > HV_HYP_PAGE_SIZE);
 
+	bridge = devm_pci_alloc_host_bridge(&hdev->device, 0);
+	if (!bridge)
+		return -ENOMEM;
+
 	/*
 	 * With the recent 59bb47985c1d ("mm, sl[aou]b: guarantee natural
 	 * alignment for kmalloc(power-of-two)"), kzalloc() is able to allocate
@@ -3064,6 +3065,8 @@ static int hv_pci_probe(struct hv_device *hdev,
 	hbus = kzalloc(HV_HYP_PAGE_SIZE, GFP_KERNEL);
 	if (!hbus)
 		return -ENOMEM;
+
+	hbus->bridge = bridge;
 	hbus->state = hv_pcibus_init;
 	hbus->wslot_res_allocated = -1;
 
@@ -3101,7 +3104,6 @@ static int hv_pci_probe(struct hv_device *hdev,
 	refcount_set(&hbus->remove_lock, 1);
 	INIT_LIST_HEAD(&hbus->children);
 	INIT_LIST_HEAD(&hbus->dr_list);
-	INIT_LIST_HEAD(&hbus->resources_for_children);
 	spin_lock_init(&hbus->config_lock);
 	spin_lock_init(&hbus->device_list_lock);
 	spin_lock_init(&hbus->retarget_msi_interrupt_lock);
@@ -3307,9 +3309,9 @@ static int hv_pci_remove(struct hv_device *hdev)
 	if (hbus->state == hv_pcibus_installed) {
 		/* Remove the bus from PCI's point of view. */
 		pci_lock_rescan_remove();
-		pci_stop_root_bus(hbus->pci_bus);
+		pci_stop_root_bus(hbus->bridge->bus);
 		hv_pci_remove_slots(hbus);
-		pci_remove_root_bus(hbus->pci_bus);
+		pci_remove_root_bus(hbus->bridge->bus);
 		pci_unlock_rescan_remove();
 		hbus->state = hv_pcibus_removed;
 	}
@@ -3320,7 +3322,6 @@ static int hv_pci_remove(struct hv_device *hdev)
 
 	iounmap(hbus->cfg_addr);
 	hv_free_config_window(hbus);
-	pci_free_resource_list(&hbus->resources_for_children);
 	hv_pci_free_bridge_windows(hbus);
 	irq_domain_remove(hbus->irq_domain);
 	irq_domain_free_fwnode(hbus->sysdata.fwnode);
@@ -3406,7 +3407,7 @@ static int hv_pci_restore_msi_msg(struct pci_dev *pdev, void *arg)
  */
 static void hv_pci_restore_msi_state(struct hv_pcibus_device *hbus)
 {
-	pci_walk_bus(hbus->pci_bus, hv_pci_restore_msi_msg, NULL);
+	pci_walk_bus(hbus->bridge->bus, hv_pci_restore_msi_msg, NULL);
 }
 
 static int hv_pci_resume(struct hv_device *hdev)
-- 
2.30.2

