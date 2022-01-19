Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C179493318
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Jan 2022 03:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344789AbiASCpo (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 18 Jan 2022 21:45:44 -0500
Received: from linux.microsoft.com ([13.77.154.182]:57306 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344162AbiASCpm (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 18 Jan 2022 21:45:42 -0500
Received: by linux.microsoft.com (Postfix, from userid 1004)
        id 0974220B9270; Tue, 18 Jan 2022 18:45:42 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0974220B9270
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
        s=default; t=1642560342;
        bh=wjkIeI5Gu3gvLdHM1LQSKa2r2Zn13qiiFCxWtUIlO6g=;
        h=From:To:Cc:Subject:Date:From;
        b=Zx4DOsdq+SgaWZp1+46YZiMi5Xk67C+0pfjN0RYoxl5g1wu7rEnxvRqH0NuwXFWwp
         igW/bDWZAGKodrUHBUMvV+7Fg56H7AWiDBbm9tTzQoRJmIvHV6TXx0WrlSPFHEuY5b
         nqOw76QUGMogzolUXmzaNZunj5hVBfL+EZMsT3zc=
From:   longli@linuxonhyperv.com
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, paekkaladevi@microsoft.com
Cc:     Long Li <longli@microsoft.com>
Subject: [Patch v2] PCI: hv: Fix NUMA node assignment when kernel boots with custom NUMA topology
Date:   Tue, 18 Jan 2022 18:45:29 -0800
Message-Id: <1642560329-5012-1-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Long Li <longli@microsoft.com>

When kernel boots with a NUMA topology with some NUMA nodes offline, the PCI
driver should only set an online NUMA node on the device. This can happen
during KDUMP where some NUMA nodes are not made online by the KDUMP kernel.

This patch also fixes the case where kernel is booting with "numa=off".

Signed-off-by: Long Li <longli@microsoft.com>

Change from v1:
Use numa_map_to_online_node() to assign a node to device (suggested by
Michael Kelly <mikelley@microsoft.com>)

---
 drivers/pci/controller/pci-hyperv.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 6c9efeefae1b..c7519add6f13 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -2130,7 +2130,15 @@ static void hv_pci_assign_numa_node(struct hv_pcibus_device *hbus)
 			continue;
 
 		if (hv_dev->desc.flags & HV_PCI_DEVICE_FLAG_NUMA_AFFINITY)
-			set_dev_node(&dev->dev, hv_dev->desc.virtual_numa_node);
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

