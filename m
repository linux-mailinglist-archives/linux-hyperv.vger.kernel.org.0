Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC7E362C78
	for <lists+linux-hyperv@lfdr.de>; Sat, 17 Apr 2021 02:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235037AbhDQAnh (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 16 Apr 2021 20:43:37 -0400
Received: from linux.microsoft.com ([13.77.154.182]:55694 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbhDQAng (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 16 Apr 2021 20:43:36 -0400
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id D4D7120B8001;
        Fri, 16 Apr 2021 17:43:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D4D7120B8001
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1618620190;
        bh=lDwr9oolzxrISbVZdtLhlzKS8cfB+ST2jdq14dk3uqQ=;
        h=From:To:Cc:Subject:Date:Reply-To:From;
        b=VooojyDfneJQ6sQr2+vSaN7EWg27hEY4WqKW1jlNPFa/orSDBYiGd/ONw4ZkeW98m
         qNBMnoUv07NNq/6uiDZYX+74AhPrZ/yikvf/O95ufUF8V79k/cf6OyNU+c3/7eLiZZ
         crHwj4kxTJA3ksdelE5Lf1bGnFveBIO7RFn4cDyg=
From:   Joseph Salisbury <joseph.salisbury@linux.microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, mikelley@microsoft.com
Cc:     x86@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, joseph.salisbury@microsoft.com
Subject: [PATCH 1/2] x86/hyperv: Move hv_do_rep_hypercall to asm-generic
Date:   Fri, 16 Apr 2021 17:43:02 -0700
Message-Id: <1618620183-9967-1-git-send-email-joseph.salisbury@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Reply-To: joseph.salisbury@microsoft.com
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Joseph Salisbury <joseph.salisbury@microsoft.com>

This patch makes no functional changes.  It simply moves hv_do_rep_hypercall()
out of arch/x86/include/asm/mshyperv.h and into asm-generic/mshyperv.h

hv_do_rep_hypercall() is architecture independent, so it makes sense that it
should be in the architecture independent mshyperv.h, not in the x86-specific
mshyperv.h.

This is done in preperation for a follow up patch which creates a consistent
pattern for checking Hyper-V hypercall status.

Signed-off-by: Joseph Salisbury <joseph.salisbury@microsoft.com>
---
 arch/x86/include/asm/mshyperv.h | 32 --------------------------------
 include/asm-generic/mshyperv.h  | 31 +++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 32 deletions(-)

diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index ccf60a809a17..bfc98b490f07 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -189,38 +189,6 @@ static inline u64 hv_do_fast_hypercall16(u16 code, u64 input1, u64 input2)
 	return hv_status;
 }
 
-/*
- * Rep hypercalls. Callers of this functions are supposed to ensure that
- * rep_count and varhead_size comply with Hyper-V hypercall definition.
- */
-static inline u64 hv_do_rep_hypercall(u16 code, u16 rep_count, u16 varhead_size,
-				      void *input, void *output)
-{
-	u64 control = code;
-	u64 status;
-	u16 rep_comp;
-
-	control |= (u64)varhead_size << HV_HYPERCALL_VARHEAD_OFFSET;
-	control |= (u64)rep_count << HV_HYPERCALL_REP_COMP_OFFSET;
-
-	do {
-		status = hv_do_hypercall(control, input, output);
-		if ((status & HV_HYPERCALL_RESULT_MASK) != HV_STATUS_SUCCESS)
-			return status;
-
-		/* Bits 32-43 of status have 'Reps completed' data. */
-		rep_comp = (status & HV_HYPERCALL_REP_COMP_MASK) >>
-			HV_HYPERCALL_REP_COMP_OFFSET;
-
-		control &= ~HV_HYPERCALL_REP_START_MASK;
-		control |= (u64)rep_comp << HV_HYPERCALL_REP_START_OFFSET;
-
-		touch_nmi_watchdog();
-	} while (rep_comp < rep_count);
-
-	return status;
-}
-
 extern struct hv_vp_assist_page **hv_vp_assist_page;
 
 static inline struct hv_vp_assist_page *hv_get_vp_assist_page(unsigned int cpu)
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index dff58a3db5d5..a5246a6ea02d 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -41,6 +41,37 @@ extern struct ms_hyperv_info ms_hyperv;
 extern u64 hv_do_hypercall(u64 control, void *inputaddr, void *outputaddr);
 extern u64 hv_do_fast_hypercall8(u16 control, u64 input8);
 
+/*
+ * Rep hypercalls. Callers of this functions are supposed to ensure that
+ * rep_count and varhead_size comply with Hyper-V hypercall definition.
+ */
+static inline u64 hv_do_rep_hypercall(u16 code, u16 rep_count, u16 varhead_size,
+				      void *input, void *output)
+{
+	u64 control = code;
+	u64 status;
+	u16 rep_comp;
+
+	control |= (u64)varhead_size << HV_HYPERCALL_VARHEAD_OFFSET;
+	control |= (u64)rep_count << HV_HYPERCALL_REP_COMP_OFFSET;
+
+	do {
+		status = hv_do_hypercall(control, input, output);
+		if ((status & HV_HYPERCALL_RESULT_MASK) != HV_STATUS_SUCCESS)
+			return status;
+
+		/* Bits 32-43 of status have 'Reps completed' data. */
+		rep_comp = (status & HV_HYPERCALL_REP_COMP_MASK) >>
+			HV_HYPERCALL_REP_COMP_OFFSET;
+
+		control &= ~HV_HYPERCALL_REP_START_MASK;
+		control |= (u64)rep_comp << HV_HYPERCALL_REP_START_OFFSET;
+
+		touch_nmi_watchdog();
+	} while (rep_comp < rep_count);
+
+	return status;
+}
 
 /* Generate the guest OS identifier as described in the Hyper-V TLFS */
 static inline  __u64 generate_guest_id(__u64 d_info1, __u64 kernel_version,
-- 
2.17.1

