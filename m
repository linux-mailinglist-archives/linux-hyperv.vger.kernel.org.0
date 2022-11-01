Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 478876150B5
	for <lists+linux-hyperv@lfdr.de>; Tue,  1 Nov 2022 18:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbiKARbW (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 1 Nov 2022 13:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbiKARbQ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 1 Nov 2022 13:31:16 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7A0821C134;
        Tue,  1 Nov 2022 10:31:15 -0700 (PDT)
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [20.120.152.163])
        by linux.microsoft.com (Postfix) with ESMTPSA id 4008D20B9F80;
        Tue,  1 Nov 2022 10:31:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4008D20B9F80
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1667323875;
        bh=gzbi2cZL78wkI/YYwutmnQjWwUdGs2YRrCc1CbsM23M=;
        h=Subject:From:Cc:Date:In-Reply-To:References:From;
        b=Dp8fRevRUiByRldOLyNZVh3jh0kTfvjocg7HEKUIBtW5U6i32+7W9R6yp9Hp8K4Aa
         IEz5Ysl9V4PNsmYUWX9CrT+2gUJCmhqJ8k2/fLRLUT6jAFztmV0FuRAY3D5JiIegpV
         wS5aGv8KQovg4fkkfW6BNdMHQxpF7Sx7g5rH9LYM=
Subject: [PATCH 3/4] drivers/clocksource/hyper-v: Use TSC PFN getter to map
 vvar page
From:   Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc:     Stanislav Kinsburskiy <stanislav.kinsburskiy@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Date:   Tue, 01 Nov 2022 17:31:15 +0000
Message-ID: <166732387510.9827.8987757583900408743.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: <166732356767.9827.4925884794177179249.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: <166732356767.9827.4925884794177179249.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-18.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,MISSING_HEADERS,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Stanislav Kinsburskiy <stanislav.kinsburskiy@gmail.com>

Instead of converting the virtual address to physical directly.
This is a precursor patch for the upcoming support for TSC page mapping into
hyper-v root partition, which address will be defined by the hypervisor and
mapped into the kernel.

Signed-off-by: Stanislav Kinsburskiy <stanislav.kinsburskiy@gmail.com>
CC: Andy Lutomirski <luto@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Ingo Molnar <mingo@redhat.com>
CC: Borislav Petkov <bp@alien8.de>
CC: Dave Hansen <dave.hansen@linux.intel.com>
CC: x86@kernel.org
CC: "H. Peter Anvin" <hpa@zytor.com>
CC: "K. Y. Srinivasan" <kys@microsoft.com>
CC: Haiyang Zhang <haiyangz@microsoft.com>
CC: Wei Liu <wei.liu@kernel.org>
CC: Dexuan Cui <decui@microsoft.com>
CC: Daniel Lezcano <daniel.lezcano@linaro.org>
CC: linux-kernel@vger.kernel.org
CC: linux-hyperv@vger.kernel.org
---
 arch/x86/entry/vdso/vma.c          |    7 +++----
 drivers/clocksource/hyperv_timer.c |    3 ++-
 include/clocksource/hyperv_timer.h |    6 ++++++
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 311eae30e089..6976416b2c9f 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -210,11 +210,10 @@ static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
 					pgprot_decrypted(vma->vm_page_prot));
 		}
 	} else if (sym_offset == image->sym_hvclock_page) {
-		struct ms_hyperv_tsc_page *tsc_pg = hv_get_tsc_page();
+		pfn = hv_get_tsc_pfn();
 
-		if (tsc_pg && vclock_was_used(VDSO_CLOCKMODE_HVCLOCK))
-			return vmf_insert_pfn(vma, vmf->address,
-					virt_to_phys(tsc_pg) >> PAGE_SHIFT);
+		if (pfn && vclock_was_used(VDSO_CLOCKMODE_HVCLOCK))
+			return vmf_insert_pfn(vma, vmf->address, pfn);
 	} else if (sym_offset == image->sym_timens_page) {
 		struct page *timens_page = find_timens_vvar_page(vma);
 
diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index d447bc99a399..635c14c1e3bf 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -369,10 +369,11 @@ static union {
 static struct ms_hyperv_tsc_page *tsc_page = &tsc_pg.page;
 static unsigned long tsc_pfn;
 
-static unsigned long hv_get_tsc_pfn(void)
+unsigned long hv_get_tsc_pfn(void)
 {
 	return tsc_pfn;
 }
+EXPORT_SYMBOL_GPL(hv_get_tsc_pfn);
 
 struct ms_hyperv_tsc_page *hv_get_tsc_page(void)
 {
diff --git a/include/clocksource/hyperv_timer.h b/include/clocksource/hyperv_timer.h
index b3f5d73ae1d6..3078d23faaea 100644
--- a/include/clocksource/hyperv_timer.h
+++ b/include/clocksource/hyperv_timer.h
@@ -32,6 +32,7 @@ extern void hv_stimer0_isr(void);
 
 extern void hv_init_clocksource(void);
 
+extern unsigned long hv_get_tsc_pfn(void);
 extern struct ms_hyperv_tsc_page *hv_get_tsc_page(void);
 
 static inline notrace u64
@@ -90,6 +91,11 @@ hv_read_tsc_page(const struct ms_hyperv_tsc_page *tsc_pg)
 }
 
 #else /* CONFIG_HYPERV_TIMER */
+static inline unsigned long hv_get_tsc_pfn(void)
+{
+	return 0;
+}
+
 static inline struct ms_hyperv_tsc_page *hv_get_tsc_page(void)
 {
 	return NULL;


