Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9C82399164
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Jun 2021 19:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbhFBRW4 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Jun 2021 13:22:56 -0400
Received: from linux.microsoft.com ([13.77.154.182]:51132 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbhFBRWy (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Jun 2021 13:22:54 -0400
Received: from viremana-dev.fwjladdvyuiujdukmejncen4mf.xx.internal.cloudapp.net (unknown [13.66.132.26])
        by linux.microsoft.com (Postfix) with ESMTPSA id 2588F20B800A;
        Wed,  2 Jun 2021 10:21:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2588F20B800A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1622654471;
        bh=/qyyPfDhCSOvSSJ4ytAjJIJ/ZobYwNoLWEJybKLalzw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jPaRonM9ubP64S0+h09D7nQRSwwnsWRVmHeFHfY/cjxNmTNcxSUax0XofmwIlDla3
         phnOL45EIEc7nIbSUDy46rGUbQUV0pBUdYMvT1YvpK/rxQhAm7Rzt/jUmMHl0EtlaQ
         8cUFmrJ+Zqrm6mjVghtN+crfDmYQ8CI9FyvwlqfM=
From:   Vineeth Pillai <viremana@linux.microsoft.com>
To:     Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Vineeth Pillai <viremana@linux.microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: [PATCH 04/17] hyperv: Wrapper for setting proximity_domain_info
Date:   Wed,  2 Jun 2021 17:20:49 +0000
Message-Id: <59b4e5f5d9568960ef4f3e07b98d3cc0d4f855f9.1622654100.git.viremana@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1622654100.git.viremana@linux.microsoft.com>
References: <cover.1622654100.git.viremana@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Refactor the code to populate proximity_domain_info from numa node
as a wrapper function. This wrapper is needed in future patches in
this series. No intended change in functionality.

Signed-off-by: Vineeth Pillai <viremana@linux.microsoft.com>
---
 arch/x86/hyperv/hv_proc.c      | 15 ++++-----------
 include/asm-generic/mshyperv.h | 14 ++++++++++++++
 2 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/arch/x86/hyperv/hv_proc.c b/arch/x86/hyperv/hv_proc.c
index ec9b0c69603e..30c88f1ec558 100644
--- a/arch/x86/hyperv/hv_proc.c
+++ b/arch/x86/hyperv/hv_proc.c
@@ -3,7 +3,6 @@
 #include <linux/vmalloc.h>
 #include <linux/mm.h>
 #include <linux/clockchips.h>
-#include <linux/acpi.h>
 #include <linux/hyperv.h>
 #include <linux/slab.h>
 #include <linux/cpuhotplug.h>
@@ -146,7 +145,6 @@ int hv_call_add_logical_proc(int node, u32 lp_index, u32 apic_id)
 	u64 status;
 	unsigned long flags;
 	int ret = HV_STATUS_SUCCESS;
-	int pxm = node_to_pxm(node);
 
 	/*
 	 * When adding a logical processor, the hypervisor may return
@@ -163,10 +161,8 @@ int hv_call_add_logical_proc(int node, u32 lp_index, u32 apic_id)
 		input->lp_index = lp_index;
 		input->apic_id = apic_id;
 		input->flags = 0;
-		input->proximity_domain_info.domain_id = pxm;
-		input->proximity_domain_info.flags.reserved = 0;
-		input->proximity_domain_info.flags.proximity_info_valid = 1;
-		input->proximity_domain_info.flags.proximity_preferred = 1;
+		input->proximity_domain_info =
+			numa_node_to_proximity_domain_info(node);
 		status = hv_do_hypercall(HVCALL_ADD_LOGICAL_PROCESSOR,
 					 input, output);
 		local_irq_restore(flags);
@@ -191,7 +187,6 @@ int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags)
 	u64 status;
 	unsigned long irq_flags;
 	int ret = HV_STATUS_SUCCESS;
-	int pxm = node_to_pxm(node);
 
 	/* Root VPs don't seem to need pages deposited */
 	if (partition_id != hv_current_partition_id) {
@@ -211,10 +206,8 @@ int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags)
 		input->flags = flags;
 		input->subnode_type = HvSubnodeAny;
 		if (node != NUMA_NO_NODE) {
-			input->proximity_domain_info.domain_id = pxm;
-			input->proximity_domain_info.flags.reserved = 0;
-			input->proximity_domain_info.flags.proximity_info_valid = 1;
-			input->proximity_domain_info.flags.proximity_preferred = 1;
+			input->proximity_domain_info =
+				numa_node_to_proximity_domain_info(node);
 		} else {
 			input->proximity_domain_info.as_uint64 = 0;
 		}
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index ec9afca749f0..d9b91b8f63c8 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -21,10 +21,24 @@
 #include <linux/types.h>
 #include <linux/atomic.h>
 #include <linux/bitops.h>
+#include <acpi/acpi_numa.h>
 #include <linux/cpumask.h>
 #include <asm/ptrace.h>
 #include <asm/hyperv-tlfs.h>
 
+static inline union hv_proximity_domain_info
+numa_node_to_proximity_domain_info(int node)
+{
+	union hv_proximity_domain_info proximity_domain_info;
+
+	proximity_domain_info.domain_id = node_to_pxm(node);
+	proximity_domain_info.flags.reserved = 0;
+	proximity_domain_info.flags.proximity_info_valid = 1;
+	proximity_domain_info.flags.proximity_preferred = 1;
+
+	return proximity_domain_info;
+}
+
 struct ms_hyperv_info {
 	u32 features;
 	u32 priv_high;
-- 
2.25.1

