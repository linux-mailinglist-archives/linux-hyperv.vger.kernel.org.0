Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5690A3A1AFB
	for <lists+linux-hyperv@lfdr.de>; Wed,  9 Jun 2021 18:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234353AbhFIQed (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 9 Jun 2021 12:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234131AbhFIQec (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 9 Jun 2021 12:34:32 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76839C06175F;
        Wed,  9 Jun 2021 09:32:23 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id q7so23440554iob.4;
        Wed, 09 Jun 2021 09:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vqBveVW+QXtLYaHB7yqWFO//rHtu2kTppz7aYTPDGpI=;
        b=IVlt30w8gXUQQVpoIG8k7AhJU4bKQn4HR7uLbTBl/+JgID4AnYciYfQujYnqikZTl0
         blVMEyOmhj1ICGRi/q9eNomk6Mg3T0rn0KlTDQmmRJZfrpk/U/f72QO27WaOBYVtbOFk
         CrUvyGBbBBKIJmcLfUr4Gp2NfxZxlmuAksfQTnp1EN3lZ7p3MHv3DiUOBuvYo8zRoArK
         k6SKJ4V6YLrbYFccW5kFhhwP87v//gL/xRVFY03m1MADyq1VrV//EXOhjtBSlipuT6pu
         ydyhkAYGHD5PcbFajgSrs8giXNftnxNkDsRE3gwN3lj3lLEqim60Lv+8VBF6fjLAlGLM
         eOBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vqBveVW+QXtLYaHB7yqWFO//rHtu2kTppz7aYTPDGpI=;
        b=uaRSOi3M4AnOLaKAqpsW77Yw7/7P+KLaD1mQ/TXpie3gMstSTv4mJLF1gGkNW9mNTk
         omofn0yN5sGcT9Oa44xtTtey7HysRBdJqPtHNurjrVxAQ85Qz+xwVt8Y7GM7cpCiQAF+
         ildRM0jus2FPj4WnoG1fk60ntCw8jSIqPUaT+ZahQQ66hClX1IT4TKA+ec0Sf/XPWK4l
         Fd/VO0VHrvJ6uSK9sn7xFcQ8MiJgXVzY1dFEgqZr3c4zrfwnJvssga7F47bLTAZrLPmm
         wWZ5OMj0fgdI/VqsmpxROfsW/1PZrylLggNBcF0ELPZOs3BNF/flXkC2CpzbKba1PwsU
         dkEg==
X-Gm-Message-State: AOAM532v2UiDE7g4q/ArXkef01KTmpo+IcQIoxUhvwsVlS9IEWO2PHIl
        yH+IiDzeyc51wigCdemPths=
X-Google-Smtp-Source: ABdhPJz1gIAsh3FzP6RRQPelu9Vh+/ATzj3yw+zK9wSyf2wONV6zQZAPcTZQ8AUUthktTSAXzbgXFQ==
X-Received: by 2002:a02:2a8c:: with SMTP id w134mr469641jaw.138.1623256342893;
        Wed, 09 Jun 2021 09:32:22 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id j18sm230844ioo.3.2021.06.09.09.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 09:32:22 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 9286727C005B;
        Wed,  9 Jun 2021 12:32:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 09 Jun 2021 12:32:21 -0400
X-ME-Sender: <xms:Fe3AYFUN2EkzCkpw_bsnlJ5c_6bn13mXZJXLiNXor3CvaVrI9rjjdg>
    <xme:Fe3AYFknStWwMr96iAPgkeuEQkf3fHuhpRSsoCj3eGjxeNvzuBqcn70VuXi8TGASk
    VoKPrJtpVSgH18UCw>
X-ME-Received: <xmr:Fe3AYBYPWduLRSV6SwXRpuUPEfFC8285S2Usao-N_5Hv2nPuSt02zPH5S0k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeduuddguddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehvdevteefgfeiudettdefvedvvdelkeejueffffelgeeuhffhjeetkeei
    ueeuleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:Fe3AYIWcpKlYWmH2ZQ46bz-hdXMVOeJKRgWv2eJORMPA0yMnMGayFA>
    <xmx:Fe3AYPnmlfw1zIWDO64HUyQ6gOSV2NwK9gulKXdP-GA_hhPFwD6W-Q>
    <xmx:Fe3AYFeqyZV5_gZ6yutGNmZ9bvIUrw-rohEOUti6pdP8WM9xM5HjHg>
    <xmx:Fe3AYB0ZZWIiVWCxas7DX0NwzZuX78haQPA3Qq-jdEyc4e6aQWu2go4FtPg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Jun 2021 12:32:20 -0400 (EDT)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, Clint Sbisa <csbisa@amazon.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [RFC v3 3/7] PCI: hv: Generify PCI probing
Date:   Thu, 10 Jun 2021 00:32:07 +0800
Message-Id: <20210609163211.3467449-4-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210609163211.3467449-1-boqun.feng@gmail.com>
References: <20210609163211.3467449-1-boqun.feng@gmail.com>
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
 drivers/pci/controller/pci-hyperv.c | 58 +++++++++++++++--------------
 1 file changed, 30 insertions(+), 28 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 6511648271b2..ee9f8e27e2e8 100644
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
 
@@ -1803,7 +1801,7 @@ static void hv_pci_assign_slots(struct hv_pcibus_device *hbus)
 
 		slot_nr = PCI_SLOT(wslot_to_devfn(hpdev->desc.win_slot.slot));
 		snprintf(name, SLOT_NAME_SIZE, "%u", hpdev->desc.ser);
-		hpdev->pci_slot = pci_create_slot(hbus->pci_bus, slot_nr,
+		hpdev->pci_slot = pci_create_slot(hbus->bridge->bus, slot_nr,
 					  name, NULL);
 		if (IS_ERR(hpdev->pci_slot)) {
 			pr_warn("pci_create slot %s failed\n", name);
@@ -1833,7 +1831,7 @@ static void hv_pci_remove_slots(struct hv_pcibus_device *hbus)
 static void hv_pci_assign_numa_node(struct hv_pcibus_device *hbus)
 {
 	struct pci_dev *dev;
-	struct pci_bus *bus = hbus->pci_bus;
+	struct pci_bus *bus = hbus->bridge->bus;
 	struct hv_pci_dev *hv_dev;
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
@@ -1856,21 +1854,22 @@ static void hv_pci_assign_numa_node(struct hv_pcibus_device *hbus)
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
@@ -2135,7 +2134,7 @@ static void pci_devices_present_work(struct work_struct *work)
 		 * because there may have been changes.
 		 */
 		pci_lock_rescan_remove();
-		pci_scan_child_bus(hbus->pci_bus);
+		pci_scan_child_bus(hbus->bridge->bus);
 		hv_pci_assign_numa_node(hbus);
 		hv_pci_assign_slots(hbus);
 		pci_unlock_rescan_remove();
@@ -2306,8 +2305,8 @@ static void hv_eject_device_work(struct work_struct *work)
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
@@ -2676,8 +2675,7 @@ static int hv_pci_allocate_bridge_windows(struct hv_pcibus_device *hbus)
 		/* Modify this resource to become a bridge window. */
 		hbus->low_mmio_res->flags |= IORESOURCE_WINDOW;
 		hbus->low_mmio_res->flags &= ~IORESOURCE_BUSY;
-		pci_add_resource(&hbus->resources_for_children,
-				 hbus->low_mmio_res);
+		pci_add_resource(&hbus->bridge->windows, hbus->low_mmio_res);
 	}
 
 	if (hbus->high_mmio_space) {
@@ -2696,8 +2694,7 @@ static int hv_pci_allocate_bridge_windows(struct hv_pcibus_device *hbus)
 		/* Modify this resource to become a bridge window. */
 		hbus->high_mmio_res->flags |= IORESOURCE_WINDOW;
 		hbus->high_mmio_res->flags &= ~IORESOURCE_BUSY;
-		pci_add_resource(&hbus->resources_for_children,
-				 hbus->high_mmio_res);
+		pci_add_resource(&hbus->bridge->windows, hbus->high_mmio_res);
 	}
 
 	return 0;
@@ -3027,6 +3024,7 @@ static void hv_put_dom_num(u16 dom)
 static int hv_pci_probe(struct hv_device *hdev,
 			const struct hv_vmbus_device_id *dev_id)
 {
+	struct pci_host_bridge *bridge;
 	struct hv_pcibus_device *hbus;
 	u16 dom_req, dom;
 	char *name;
@@ -3039,6 +3037,10 @@ static int hv_pci_probe(struct hv_device *hdev,
 	 */
 	BUILD_BUG_ON(sizeof(*hbus) > HV_HYP_PAGE_SIZE);
 
+	bridge = devm_pci_alloc_host_bridge(&hdev->device, 0);
+	if (!bridge)
+		return -ENOMEM;
+
 	/*
 	 * With the recent 59bb47985c1d ("mm, sl[aou]b: guarantee natural
 	 * alignment for kmalloc(power-of-two)"), kzalloc() is able to allocate
@@ -3060,6 +3062,8 @@ static int hv_pci_probe(struct hv_device *hdev,
 	hbus = kzalloc(HV_HYP_PAGE_SIZE, GFP_KERNEL);
 	if (!hbus)
 		return -ENOMEM;
+
+	hbus->bridge = bridge;
 	hbus->state = hv_pcibus_init;
 	hbus->wslot_res_allocated = -1;
 
@@ -3097,7 +3101,6 @@ static int hv_pci_probe(struct hv_device *hdev,
 	refcount_set(&hbus->remove_lock, 1);
 	INIT_LIST_HEAD(&hbus->children);
 	INIT_LIST_HEAD(&hbus->dr_list);
-	INIT_LIST_HEAD(&hbus->resources_for_children);
 	spin_lock_init(&hbus->config_lock);
 	spin_lock_init(&hbus->device_list_lock);
 	spin_lock_init(&hbus->retarget_msi_interrupt_lock);
@@ -3303,9 +3306,9 @@ static int hv_pci_remove(struct hv_device *hdev)
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
@@ -3316,7 +3319,6 @@ static int hv_pci_remove(struct hv_device *hdev)
 
 	iounmap(hbus->cfg_addr);
 	hv_free_config_window(hbus);
-	pci_free_resource_list(&hbus->resources_for_children);
 	hv_pci_free_bridge_windows(hbus);
 	irq_domain_remove(hbus->irq_domain);
 	irq_domain_free_fwnode(hbus->sysdata.fwnode);
@@ -3402,7 +3404,7 @@ static int hv_pci_restore_msi_msg(struct pci_dev *pdev, void *arg)
  */
 static void hv_pci_restore_msi_state(struct hv_pcibus_device *hbus)
 {
-	pci_walk_bus(hbus->pci_bus, hv_pci_restore_msi_msg, NULL);
+	pci_walk_bus(hbus->bridge->bus, hv_pci_restore_msi_msg, NULL);
 }
 
 static int hv_pci_resume(struct hv_device *hdev)
-- 
2.30.2

