Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C37939916B
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Jun 2021 19:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbhFBRW6 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Jun 2021 13:22:58 -0400
Received: from linux.microsoft.com ([13.77.154.182]:51194 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbhFBRWz (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Jun 2021 13:22:55 -0400
Received: from viremana-dev.fwjladdvyuiujdukmejncen4mf.xx.internal.cloudapp.net (unknown [13.66.132.26])
        by linux.microsoft.com (Postfix) with ESMTPSA id C911320B801E;
        Wed,  2 Jun 2021 10:21:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C911320B801E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1622654471;
        bh=LcCVWexkc+Cg1xIMBBr5Dna6p3oVF5XZrxYL1XT149g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WyngHRpms20eDhEOoq5YC59tyZuC1miOYbbE0+RLo8jl8k7441ooWOqBiVwB/xIEw
         9p7HJdBD6Xr3rdlZC2AXCBjFNR1VWZM7iQYVTJ4/BQwkcvoBDoRYa57eQCf/H2y2u9
         rkGhn9T6ysXfPzJJQ/ouR7Jk6OkF1bEwPLfW0tc0=
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
Subject: [PATCH 11/17] mshv: HvClearVirtualInterrupt hypercall
Date:   Wed,  2 Jun 2021 17:20:56 +0000
Message-Id: <b4c2bf69332b8c7bcfb060341d5e9bcdadbe7fd1.1622654100.git.viremana@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1622654100.git.viremana@linux.microsoft.com>
References: <cover.1622654100.git.viremana@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

For HvX64InterruptTypeExtInt interrupts, before asserting a new
interrupt, previous inteerupt's acknowledgment should be cleared
by this hypercall HvClearVirtualInterrupt. (TLFS 10.3.2)

This is to be used in a later patch in this series.

Signed-off-by: Vineeth Pillai <viremana@linux.microsoft.com>
---
 drivers/hv/hv_call.c              | 20 ++++++++++++++++++++
 drivers/hv/mshv.h                 |  1 +
 include/asm-generic/hyperv-tlfs.h |  1 +
 3 files changed, 22 insertions(+)

diff --git a/drivers/hv/hv_call.c b/drivers/hv/hv_call.c
index 57db3a8ac94a..d5cdbe4e93da 100644
--- a/drivers/hv/hv_call.c
+++ b/drivers/hv/hv_call.c
@@ -743,6 +743,26 @@ int hv_call_translate_virtual_address(
 }
 
 
+int
+hv_call_clear_virtual_interrupt(u64 partition_id)
+{
+	unsigned long flags;
+	int status;
+
+	local_irq_save(flags);
+	status = hv_do_fast_hypercall8(HVCALL_CLEAR_VIRTUAL_INTERRUPT,
+				       partition_id) &
+			HV_HYPERCALL_RESULT_MASK;
+	local_irq_restore(flags);
+
+	if (status != HV_STATUS_SUCCESS) {
+		pr_err("%s: %s\n", __func__, hv_status_to_string(status));
+		return -hv_status_to_errno(status);
+	}
+
+	return 0;
+}
+
 int
 hv_call_create_port(u64 port_partition_id, union hv_port_id port_id,
 		    u64 connection_partition_id,
diff --git a/drivers/hv/mshv.h b/drivers/hv/mshv.h
index 76cd00fd4b3f..404807c98512 100644
--- a/drivers/hv/mshv.h
+++ b/drivers/hv/mshv.h
@@ -117,6 +117,7 @@ int hv_call_assert_virtual_interrupt(
 		u32 vector,
 		u64 dest_addr,
 		union hv_interrupt_control control);
+int hv_call_clear_virtual_interrupt(u64 partition_id);
 int hv_call_get_vp_state(
 		u32 vp_index,
 		u64 partition_id,
diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
index 3ed4f532ed57..693d41192e9e 100644
--- a/include/asm-generic/hyperv-tlfs.h
+++ b/include/asm-generic/hyperv-tlfs.h
@@ -159,6 +159,7 @@ struct ms_hyperv_tsc_page {
 #define HVCALL_GET_VP_REGISTERS			0x0050
 #define HVCALL_SET_VP_REGISTERS			0x0051
 #define HVCALL_TRANSLATE_VIRTUAL_ADDRESS	0x0052
+#define HVCALL_CLEAR_VIRTUAL_INTERRUPT		0x0056
 #define HVCALL_DELETE_PORT			0x0058
 #define HVCALL_DISCONNECT_PORT			0x005b
 #define HVCALL_POST_MESSAGE			0x005c
-- 
2.25.1

