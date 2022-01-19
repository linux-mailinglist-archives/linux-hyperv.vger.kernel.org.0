Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20E7349415D
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Jan 2022 20:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244141AbiAST7O (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 19 Jan 2022 14:59:14 -0500
Received: from linux.microsoft.com ([13.77.154.182]:36944 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233089AbiAST7O (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 19 Jan 2022 14:59:14 -0500
Received: by linux.microsoft.com (Postfix, from userid 1004)
        id 17C9120B928C; Wed, 19 Jan 2022 11:59:14 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 17C9120B928C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
        s=default; t=1642622354;
        bh=TD73FcumVjwPMYsmdCD93SR7TD3EAZF9X2RVmwm/lbs=;
        h=From:To:Cc:Subject:Date:From;
        b=eBvUCcyv6tq41PGYBlI74LOyTjvHHTYpcxewTdJK7b/PCtWXhy9pmiMzl8ZMksVL6
         FjxzZ+Y96/psPocglPaicK6+Fuh5qfkiyliSiGTQLgbFzbsZHuwY+LadvtPy4WLx92
         1r/PCsusCwUZkRTUYcuR83CpwzFVIwQ2kPVMOovQ=
From:   longli@linuxonhyperv.com
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, paekkaladevi@microsoft.com
Cc:     Long Li <longli@microsoft.com>
Subject: [Patch v3] PCI: hv: Fix NUMA node assignment when kernel boots with custom NUMA topology
Date:   Wed, 19 Jan 2022 11:59:06 -0800
Message-Id: <1642622346-22861-1-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Long Li <longli@microsoft.com>

When kernel boots with a NUMA topology with some NUMA nodes offline, the PCI
driver should only set an online NUMA node on the device. This can happen
during KDUMP where some NUMA nodes are not made online by the KDUMP kernel.

This patch also fixes the case where kernel is booting with "numa=off".

Fixes: 999dd956d838 ("PCI: hv: Add support for protocol 1.3 and support PCI_BUS_RELATIONS2")

Signed-off-by: Long Li <longli@microsoft.com>

Change log:
v2: use numa_map_to_online_node() to assign a node to device (suggested by
Michael Kelly <mikelley@microsoft.com>)

v3: add "Fixes" and check for num_possible_nodes()
---
 drivers/pci/controller/pci-hyperv.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 6c9efeefae1b..b5276e81bb44 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -2129,8 +2129,17 @@ static void hv_pci_assign_numa_node(struct hv_pcibus_device *hbus)
 		if (!hv_dev)
 			continue;
 
-		if (hv_dev->desc.flags & HV_PCI_DEVICE_FLAG_NUMA_AFFINITY)
-			set_dev_node(&dev->dev, hv_dev->desc.virtual_numa_node);
+		if (hv_dev->desc.flags & HV_PCI_DEVICE_FLAG_NUMA_AFFINITY &&
+		    hv_dev->desc.virtual_numa_node < num_possible_nodes())
+			/*
+			 * The kernel may boot with some NUMA nodes offline
+			 * (e.g. in a KDUMP kernel) or with NUMA disabled via
+			 * "numa=off". In those cases, adjust the host provided
+			 * NUMA node to a valid NUMA node used by the kernel.
+			 */
+			set_dev_node(&dev->dev,
+				     numa_map_to_online_node(
+					     hv_dev->desc.virtual_numa_node));
 
 		put_pcichild(hv_dev);
 	}
-- 
2.25.1

