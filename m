Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6B03FBF50
	for <lists+linux-hyperv@lfdr.de>; Tue, 31 Aug 2021 01:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239004AbhH3XO3 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 30 Aug 2021 19:14:29 -0400
Received: from linux.microsoft.com ([13.77.154.182]:48426 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238898AbhH3XO3 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 30 Aug 2021 19:14:29 -0400
Received: by linux.microsoft.com (Postfix, from userid 1004)
        id 24BE820B90FF; Mon, 30 Aug 2021 16:13:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 24BE820B90FF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
        s=default; t=1630365215;
        bh=y8kbnU6wSCpgwXOq1MQQIkVnRwqj3xH6aJeaz2aubBY=;
        h=From:To:Cc:Subject:Date:From;
        b=sSkVi6OXSgiAj4hA98ukq34ASL/5U3pAIYzzvNkQswfVkKvxpySXEA+VX3YMrLCoP
         T/JnEMwesI348tJ9hy53ZX/p4571zO7va6B2YqKgEIHRf7kGDWNscy0J0whfdNoVG4
         yFIDkJzZ8RdZQMYlsUFSPb/JCmOYvXoh0TFGg6ME=
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
        Michael Kelley <mikelley@microsoft.com>
Subject: [Patch v2] PCI: hv: Fix sleep while in non-sleep context when removing child devices from the bus
Date:   Mon, 30 Aug 2021 16:13:27 -0700
Message-Id: <1630365207-20616-1-git-send-email-longli@linuxonhyperv.com>
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
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Link: https://lore.kernel.org/linux-hyperv/20210823152130.GA21501@kili/
Signed-off-by: Long Li <longli@microsoft.com>
---
Changes in v2:
Made patch title more specific on what the patch does.
Added link to the original bug report.
Changed to list_for_each_entry_safe for iterating the removed list.

 drivers/pci/controller/pci-hyperv.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index a53bd8728d0d..fc1a29acadbb 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -3229,9 +3229,17 @@ static int hv_pci_bus_exit(struct hv_device *hdev, bool keep_devs)
 		return 0;
 
 	if (!keep_devs) {
-		/* Delete any children which might still exist. */
+		struct list_head removed;
+
+		/* Move all present children to the list on stack */
+		INIT_LIST_HEAD(&removed);
 		spin_lock_irqsave(&hbus->device_list_lock, flags);
-		list_for_each_entry_safe(hpdev, tmp, &hbus->children, list_entry) {
+		list_for_each_entry_safe(hpdev, tmp, &hbus->children, list_entry)
+			list_move_tail(&hpdev->list_entry, &removed);
+		spin_unlock_irqrestore(&hbus->device_list_lock, flags);
+
+		/* Remove all children in the list */
+		list_for_each_entry_safe(hpdev, tmp, &removed, list_entry) {
 			list_del(&hpdev->list_entry);
 			if (hpdev->pci_slot)
 				pci_destroy_slot(hpdev->pci_slot);
@@ -3239,7 +3247,6 @@ static int hv_pci_bus_exit(struct hv_device *hdev, bool keep_devs)
 			put_pcichild(hpdev);
 			put_pcichild(hpdev);
 		}
-		spin_unlock_irqrestore(&hbus->device_list_lock, flags);
 	}
 
 	ret = hv_send_resources_released(hdev);
-- 
2.25.1

