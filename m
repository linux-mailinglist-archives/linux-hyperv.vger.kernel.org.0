Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D067C3F58D2
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Aug 2021 09:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbhHXHVI (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 24 Aug 2021 03:21:08 -0400
Received: from linux.microsoft.com ([13.77.154.182]:54612 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232173AbhHXHVH (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 24 Aug 2021 03:21:07 -0400
Received: by linux.microsoft.com (Postfix, from userid 1004)
        id 1BE3320B7192; Tue, 24 Aug 2021 00:20:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1BE3320B7192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
        s=default; t=1629789624;
        bh=pT9MfMBwFEzM8B1XTfJ8fkYHPKmhI6ubzUcWHq4gd20=;
        h=From:To:Cc:Subject:Date:From;
        b=lLWFly0aKAauojK7Rlr2GcDxHv76/4KGNj99MTYveFGZBo5d+JCmMGofQaXqrnjVA
         7qxnwLDf6wZr3065KuPO1VKK4EJ/dLRzB8QpdqqDeOz5sVeDFnDiBuMmh1iEYPvaTV
         zWHAFTJs0q0UJr/aNG4sFBqksr+26PNektX9c1gY=
From:   longli@linuxonhyperv.com
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org
Cc:     Long Li <longli@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] PCI: hv: Fix a bug on removing child devices on the bus
Date:   Tue, 24 Aug 2021 00:20:20 -0700
Message-Id: <1629789620-11049-1-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Long Li <longli@microsoft.com>

In hv_pci_bus_exit, the code is holding a spinlock while calling
pci_destroy_slot(), which takes a mutex.

This is not safe for spinlock. Fix this by moving the children to be
deleted to a list on the stack, and removing them after spinlock is
released.

Fixes: 94d22763207a ("PCI: hv: Fix a race condition when removing the device")

Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>
Cc: Dexuan Cui <decui@microsoft.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Rob Herring <robh@kernel.org>
Cc: "Krzysztof Wilczyński" <kw@linux.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Michael Kelley <mikelley@microsoft.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/pci/controller/pci-hyperv.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index a53bd8728d0d..d4f3cce18957 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -3220,6 +3220,7 @@ static int hv_pci_bus_exit(struct hv_device *hdev, bool keep_devs)
 	struct hv_pci_dev *hpdev, *tmp;
 	unsigned long flags;
 	int ret;
+	struct list_head removed;
 
 	/*
 	 * After the host sends the RESCIND_CHANNEL message, it doesn't
@@ -3229,9 +3230,18 @@ static int hv_pci_bus_exit(struct hv_device *hdev, bool keep_devs)
 		return 0;
 
 	if (!keep_devs) {
-		/* Delete any children which might still exist. */
+		INIT_LIST_HEAD(&removed);
+
+		/* Move all present children to the list on stack */
 		spin_lock_irqsave(&hbus->device_list_lock, flags);
-		list_for_each_entry_safe(hpdev, tmp, &hbus->children, list_entry) {
+		list_for_each_entry_safe(hpdev, tmp, &hbus->children, list_entry)
+			list_move_tail(&hpdev->list_entry, &removed);
+		spin_unlock_irqrestore(&hbus->device_list_lock, flags);
+
+		/* Remove all children in the list */
+		while (!list_empty(&removed)) {
+			hpdev = list_first_entry(&removed, struct hv_pci_dev,
+						 list_entry);
 			list_del(&hpdev->list_entry);
 			if (hpdev->pci_slot)
 				pci_destroy_slot(hpdev->pci_slot);
@@ -3239,7 +3249,6 @@ static int hv_pci_bus_exit(struct hv_device *hdev, bool keep_devs)
 			put_pcichild(hpdev);
 			put_pcichild(hpdev);
 		}
-		spin_unlock_irqrestore(&hbus->device_list_lock, flags);
 	}
 
 	ret = hv_send_resources_released(hdev);
-- 
2.25.1

