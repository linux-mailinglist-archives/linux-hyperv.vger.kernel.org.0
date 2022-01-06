Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAC65486DA7
	for <lists+linux-hyperv@lfdr.de>; Fri,  7 Jan 2022 00:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245428AbiAFXVF (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 6 Jan 2022 18:21:05 -0500
Received: from linux.microsoft.com ([13.77.154.182]:37148 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234795AbiAFXVF (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 6 Jan 2022 18:21:05 -0500
Received: by linux.microsoft.com (Postfix, from userid 1004)
        id DEE8A20B7179; Thu,  6 Jan 2022 15:21:04 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DEE8A20B7179
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
        s=default; t=1641511264;
        bh=QLQ7OeBa1sO3epoyChchUmo5nTa02ccxvrxcJ1gXpmo=;
        h=From:To:Cc:Subject:Date:From;
        b=hpK8tNrBj56qotepxk+nYmrsB9u9r0S0KVSX/G+4ZWtIYGHpcIlPA4ugbpDRjWAJ/
         XsO9Z6eZKXmX7KfLH/KiS4V2JjE0Nw2bifihsB64W5S8LS6GV1pwQw0wPKuw6yejGD
         Av31xnXih0zODLgEEIcI8Im9+mVZIkejsSHCg+kM=
From:   longli@linuxonhyperv.com
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, paekkaladevi@microsoft.com
Cc:     Long Li <longli@microsoft.com>
Subject: [PATCH] PCI: hv: Fix NUMA node assignment when kernel boots with parameters affecting NUMA topology
Date:   Thu,  6 Jan 2022 15:20:28 -0800
Message-Id: <1641511228-12415-1-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Long Li <longli@microsoft.com>

When the kernel boots with parameters restricting the number of cpus or NUMA
nodes, e.g. maxcpus=X or numa=off, the vPCI driver should only set to the NUMA
node to a value that is valid in the current running kernel.

Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/pci/controller/pci-hyperv.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index fc1a29acadbb..8686343eff4c 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -1835,8 +1835,21 @@ static void hv_pci_assign_numa_node(struct hv_pcibus_device *hbus)
 		if (!hv_dev)
 			continue;
 
-		if (hv_dev->desc.flags & HV_PCI_DEVICE_FLAG_NUMA_AFFINITY)
-			set_dev_node(&dev->dev, hv_dev->desc.virtual_numa_node);
+		if (hv_dev->desc.flags & HV_PCI_DEVICE_FLAG_NUMA_AFFINITY) {
+			int cpu;
+			bool found_node = false;
+
+			for_each_possible_cpu(cpu)
+				if (cpu_to_node(cpu) ==
+				    hv_dev->desc.virtual_numa_node) {
+					found_node = true;
+					break;
+				}
+
+			if (found_node)
+				set_dev_node(&dev->dev,
+					     hv_dev->desc.virtual_numa_node);
+		}
 
 		put_pcichild(hv_dev);
 	}
-- 
2.25.1

