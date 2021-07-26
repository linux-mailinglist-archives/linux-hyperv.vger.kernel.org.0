Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 636D93D666B
	for <lists+linux-hyperv@lfdr.de>; Mon, 26 Jul 2021 20:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232940AbhGZR1E (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 26 Jul 2021 13:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232788AbhGZR1A (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 26 Jul 2021 13:27:00 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C07C061757;
        Mon, 26 Jul 2021 11:07:29 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id r18so13034243iot.4;
        Mon, 26 Jul 2021 11:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=72T2tgkNXoiemTTwhzHsPU9qvyDpQPAl/IgD/AO0ZcQ=;
        b=RzQqnggOpmkCiUVlYIQL4zhzcVCaR7CUIUJcbZje3n0c/vOsBYDDf0AEDCFqJqjVw2
         Dp3W7AI3KH20+h1hvIHH4cf3iGaWzpElf8XSPXzdgwAYbCaEPNNYOJcF2HpwriEi7+78
         dgS/pHTweJDoYd5WvoBpqBJD6xl0HCrE89f5Gts34f+ljLR3B4IvNt2oIyCKohpNvXWd
         zfVlv251JzVB+cRo2Ou48m3NcJM7VCSTvi6s7mnFJuBRPQM+t/kC1dg10X0I4T7zMeo+
         vlIFqtBgWTJFGjRG8n4LW+OG2gIfuGxyf9WDT3yP4RaB+jzFGdQWrw36G3pcOSCBLtiE
         e0SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=72T2tgkNXoiemTTwhzHsPU9qvyDpQPAl/IgD/AO0ZcQ=;
        b=LPTwJo/6LdUplznaedgqtTXGfYrXnZI2g6To8BhVzYFJpYPDRLKuv9iC8q8xoS3CJv
         F3Wdc/zs0w8+oVxe5CwooIquBy8LDrJXL771X959JV3KIrgeE/OSiY8ItjGF4jhghtjZ
         NRS/9j3sr/f14AKmUgajxtjQ3/2OCaforYdvgTBjS/Y4R4j735TW1hSCxat4htPujhMu
         wOWiBFemW3IaZlaEzrDjyHx+Gj6t2i7DZcFbafn4hKPDNivEtwzmO+GGuyudkdF5Ed1B
         fkMl6YOooAQoosnj383/Avy/bafN8nGcKfGuCl6nFajm0Piz7yeafwScdmWxzJIfsRHJ
         EPpQ==
X-Gm-Message-State: AOAM5304rWrHBOXrZ/NFcalg9QenNwDwM3Jh/9cYsIDu4h96KHUrPZbl
        tqr/LYnAi74Bmcm+mweZ6D4=
X-Google-Smtp-Source: ABdhPJxXwf7MgIN6X14/XkQVo1ARysCrKgFFByO+plxAreQkzmAdOWciCJ3nqw9S/KdBeRn1GukBfA==
X-Received: by 2002:a5e:9513:: with SMTP id r19mr15735512ioj.156.1627322848502;
        Mon, 26 Jul 2021 11:07:28 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id u12sm357949iog.54.2021.07.26.11.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 11:07:28 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailauth.nyi.internal (Postfix) with ESMTP id 3395527C0066;
        Mon, 26 Jul 2021 14:07:27 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 26 Jul 2021 14:07:27 -0400
X-ME-Sender: <xms:3_n-YBEVZN48WOvJS51flzlcFErYH-FPQ97mdnVqPMOCbuGLcjMS-w>
    <xme:3_n-YGVaLA16mOaQvKU5e4ldAjbRNkkaNl5sXFtbNN_XY4Iyweqx_IzzjVW3RNaD6
    f93eMF4Q42BnJ1G4g>
X-ME-Received: <xmr:3_n-YDKTlVd1MIsy0moBcoHMVGzZ7j-KnmPwwxQcZMgfxCdSsM0M25m-vFY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrgeehgdduudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephedvveetfefgiedutedtfeevvddvleekjeeuffffleeguefhhfejteekieeu
    ueelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgv
X-ME-Proxy: <xmx:3_n-YHEE6v8WaGMR--pRe_8YoFqbDn-sYU32icBiVud7a-C16k2FTA>
    <xmx:3_n-YHUuEYlCJ2k2-Nv9P1Vvt0bTtzINYvCIfK1LpqKkpipBTNmRew>
    <xmx:3_n-YCOC0JZPAzQVeN8tGG3XJHerCSGmst2j_JIi9QJbke-hZIL6fw>
    <xmx:3_n-YOMWm0DBMERZriCni2vE3b3hd8XfqS_OqPtZPlV3DekqPfKvhE728nI>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Jul 2021 14:07:26 -0400 (EDT)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Mike Rapoport <rppt@kernel.org>
Subject: [PATCH v6 5/8] PCI: hv: Generify PCI probing
Date:   Tue, 27 Jul 2021 02:06:54 +0800
Message-Id: <20210726180657.142727-6-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210726180657.142727-1-boqun.feng@gmail.com>
References: <20210726180657.142727-1-boqun.feng@gmail.com>
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
2.32.0

