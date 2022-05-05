Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF4051C058
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 May 2022 15:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377041AbiEENTN (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 5 May 2022 09:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378934AbiEENS6 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 5 May 2022 09:18:58 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ACBD11A3C;
        Thu,  5 May 2022 06:15:19 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id i17so4343897pla.10;
        Thu, 05 May 2022 06:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y5qHL54m6D9fE++caCE9K5xKuvT/9ExUGmvS2M/SVMQ=;
        b=OIp3OXfi5KU+YOePA4S28OTtk0RXmD7fHyjtIsUBY9FuP0oCyDYSC87ijoSOtkygbL
         NW9nDnxZpobRCNR2pkYZn8irTUqNUDfYr1B2CbQVcqkCYaFSJfZzKVm0S08i/v1r9+zO
         7rEzz2DJV7cUnoQepNbB1ZlaqBmtCADJsryZjF76Yk0TVZPj0S3nKL7Getdfa7d1sCpg
         U5s5G97In4+v52ZT6/xYc1IWrG+eUOdQ6o1AHEkogeqWp0hrc0nYdgQD8uyhq9aNq2ii
         mOKPNzTNUFqvnIwBY56ayeWxzP8nr0A5pjnE2BY+nthH2PIPlmpNkh2HGXuIXH0OpEQQ
         utoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y5qHL54m6D9fE++caCE9K5xKuvT/9ExUGmvS2M/SVMQ=;
        b=4TLCPYG3tQEc48ngFnHj859mPcwKVzy7J9ou/4OGOiHT2702WunX5tw9XhRm8akiom
         5H1apJMib/CAtMtpNePMRQ8F2GIsuY3P4IJwy64p2V166Ohjr+9nySEU6xZtd6B/13BX
         NMXkliZhCYoO/Ne2wCAzPrWbTxVNoflxvbxOxiR2vfZ9qYTT89y2zglCOJ/7UHrXOKx/
         pfP27iPCNbf80+Tz+TlRK0aUM0LivKHQbVkbub3RIzEB8KTGmcgZMS70Jyxwq77/sjy+
         ITeQY5gwQiYhEnILN1lYu0kU/znH7mZ59BwY/BBEbwrmO6aPV5h0hZAw5w8TVQILAbkP
         YQMA==
X-Gm-Message-State: AOAM533hyvRXXJBsjfZGH3LhTB40HKvWRrtcbgYxlUqJSviQ/4QLDmfV
        6JGjqcwCbeqjvPbLLNLUzI4=
X-Google-Smtp-Source: ABdhPJxzK7gmlPfAA1wCyoNDgEUdtqPdnPGzx7Qd+9QuRj1y4702x3RdBAO72OtkQri1p6R0hxOJYA==
X-Received: by 2002:a17:90b:4ac9:b0:1dc:ca21:30e4 with SMTP id mh9-20020a17090b4ac900b001dcca2130e4mr1003179pjb.170.1651756518965;
        Thu, 05 May 2022 06:15:18 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:38:a7e8:659:5c6e:9219])
        by smtp.gmail.com with ESMTPSA id p21-20020a170903249500b0015e8d4eb2b4sm1474282plw.254.2022.05.05.06.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 06:15:18 -0700 (PDT)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, brijesh.singh@amd.com,
        venu.busireddy@oracle.com, michael.roth@amd.com,
        Tianyu.Lan@microsoft.com, thomas.lendacky@amd.com, jroedel@suse.de,
        michael.h.kelley@microsoft.com
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com, parri.andrea@gmail.com
Subject: [PATCH] x86/Hyper-V: Add SEV negotiate protocol support in Isolation VM
Date:   Thu,  5 May 2022 09:15:02 -0400
Message-Id: <20220505131502.402259-1-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

Hyper-V Isolation VM code uses sev_es_ghcb_hv_call() to read/write MSR
via GHCB page. The SEV-ES guest should negotiate GHCB version before
reading/writing MSR via GHCB page. Expose sev_es_negotiate_protocol()
and sev_es_terminate() from AMD SEV code and negotiate GHCB version in
hyperv_init_ghcb() fro Hyper-V Isolation VM.

Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
 arch/x86/hyperv/hv_init.c    | 8 ++++++++
 arch/x86/include/asm/sev.h   | 6 ++++++
 arch/x86/kernel/sev-shared.c | 4 ++--
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 8b392b6b7b93..56e2c34e7d64 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -29,6 +29,7 @@
 #include <clocksource/hyperv_timer.h>
 #include <linux/highmem.h>
 #include <linux/swiotlb.h>
+#include <asm/sev.h>
 
 int hyperv_init_cpuhp;
 u64 hv_current_partition_id = ~0ull;
@@ -70,6 +71,13 @@ static int hyperv_init_ghcb(void)
 	ghcb_base = (void **)this_cpu_ptr(hv_ghcb_pg);
 	*ghcb_base = ghcb_va;
 
+	/* Negotiate GHCB Version. */
+	if (!sev_es_negotiate_protocol())
+		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_PROT_UNSUPPORTED);
+
+	/* Write ghcb page back after negotiating protocol. */
+	wrmsrl(MSR_AMD64_SEV_ES_GHCB, ghcb_gpa);
+	VMGEXIT();
 	return 0;
 }
 
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 19514524f0f8..ad69c1dc081b 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -161,6 +161,9 @@ extern enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb,
 					  struct es_em_ctxt *ctxt,
 					  u64 exit_code, u64 exit_info_1,
 					  u64 exit_info_2);
+extern bool sev_es_negotiate_protocol(void);
+extern void sev_es_terminate(unsigned int set, unsigned int reason);
+
 static inline int rmpadjust(unsigned long vaddr, bool rmp_psize, unsigned long attrs)
 {
 	int rc;
@@ -226,6 +229,9 @@ static inline int snp_issue_guest_request(u64 exit_code, struct snp_req_data *in
 {
 	return -ENOTTY;
 }
+
+static bool sev_es_negotiate_protocol(void) { return false; }
+static void sev_es_terminate(unsigned int set, unsigned int reason) { }
 #endif
 
 #endif
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 2b4270d5559e..bffc38f0d5ed 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -86,7 +86,7 @@ static bool __init sev_es_check_cpu_features(void)
 	return true;
 }
 
-static void __noreturn sev_es_terminate(unsigned int set, unsigned int reason)
+void __noreturn sev_es_terminate(unsigned int set, unsigned int reason)
 {
 	u64 val = GHCB_MSR_TERM_REQ;
 
@@ -137,7 +137,7 @@ static void snp_register_ghcb_early(unsigned long paddr)
 		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_REGISTER);
 }
 
-static bool sev_es_negotiate_protocol(void)
+bool sev_es_negotiate_protocol(void)
 {
 	u64 val;
 
-- 
2.25.1

