Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0395E53B796
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Jun 2022 13:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234017AbiFBLFl (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 2 Jun 2022 07:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232354AbiFBLFk (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 2 Jun 2022 07:05:40 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B262997A1;
        Thu,  2 Jun 2022 04:05:39 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id o6-20020a17090a0a0600b001e2c6566046so9069741pjo.0;
        Thu, 02 Jun 2022 04:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ot7WIeiKTGQtC++IcJ6ZuEJK/3LcqAZnTEywxnlnHF0=;
        b=e7MuQo9sEQki55DGkvGfnRjLVZOGnr09P9w0X6mdHMZKowCsh1udYr9ng35NdPxP9A
         hKrHow+xhzjnTdwUQCeKJObDALkuQA4LOZdyIeG6K6Lr6ISW4mGrUZ1RV9gcFZlO/CiC
         rDdPfIKBpfGO+rwSHL8b8QbC35lLQk+siHWvZZG1UJb2LGgHi/2xbuf1u9YBSV6qqZ6i
         HwOr+daUpaHMStZZIV4cXl93jupYMI0nChRlQhDMwVosyNBtGOWx4ErNqGpachE01SOd
         7UTPO2vfAGKE57lccI8flB/UJTAlFSTRZq3gHIZ9T5qoZSCaatvDFxS2yjW8V4jUXfBs
         s4Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ot7WIeiKTGQtC++IcJ6ZuEJK/3LcqAZnTEywxnlnHF0=;
        b=7O2g7wcOKW3mUJPfeqA6Tp5g4M1bQLdg6AvThaEqh1yiUm9S1hmzbWD70kbwqL7xZn
         uoonS0tb4MpEhxCSVE1X/Qu5IRNFa/1OgoWxYpocJJoqJNlDkUySOztPrAezYfCL5+pU
         pBEhpYzUYbBDAgTO1ik1c+iBjV2mHC0XVYPvXuGpXSyczP8DZc9Cz3En1BXmlap873ci
         ZtxNhtAK0hkbuMsbBordfXQReaPrScjXTxjMxjG2ivgwyrCpaxuTdp76wKdAioRE3N1n
         e95QsPDQHZtVZ4cJ5V4LoXY+LMn8BEjdKyE8HTAaY6hVUriS31EdwKaSKm6BnfGgdr9A
         dICQ==
X-Gm-Message-State: AOAM532ECEQK9+VbIgt1ywpmZQKZs1IUxFYVW/3pIhp7dg9B4mf6szNy
        4HwsptffYB2jzFXLzUDBgXg=
X-Google-Smtp-Source: ABdhPJzs28+OeblhoOXsNlCb201ilbsPe7iVTa/FahKnwnmuRDm7Ju1TcDKVSBFpJpTtHjQWwDQFMw==
X-Received: by 2002:a17:902:d2c2:b0:164:1047:5438 with SMTP id n2-20020a170902d2c200b0016410475438mr4375254plc.18.1654167938705;
        Thu, 02 Jun 2022 04:05:38 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:b:75c6:1ee6:fd1b:7d08])
        by smtp.gmail.com with ESMTPSA id s4-20020a655844000000b003fc8ce7e30csm3034148pgr.68.2022.06.02.04.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 04:05:37 -0700 (PDT)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com, parri.andrea@gmail.com,
        thomas.lendacky@amd.com
Subject: [PATCH V2] x86/Hyper-V: Add SEV negotiate protocol support in Isolation VM
Date:   Thu,  2 Jun 2022 07:05:07 -0400
Message-Id: <20220602110507.243083-1-ltykernel@gmail.com>
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

Hyper-V Isolation VM current code uses sev_es_ghcb_hv_call()
to read/write MSR via GHCB page and depends on the sev code.
This may cause regression when sev code changes interface
design.

The latest SEV-ES code requires to negotiate GHCB version before
reading/writing MSR via GHCB page and sev_es_ghcb_hv_call() doesn't
work for Hyper-V Isolation VM. Add Hyper-V ghcb related implementation
to decouple SEV and Hyper-V code. Negotiate GHCB version in the
hyperv_init_ghcb() and use the version to communicate with Hyper-V
in the ghcb hv call function.

Fixes: 2ea29c5abbc2 ("x86/sev: Save the negotiated GHCB version")
Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
 arch/x86/hyperv/hv_init.c       |  6 +++
 arch/x86/hyperv/ivm.c           | 88 ++++++++++++++++++++++++++++++---
 arch/x86/include/asm/mshyperv.h |  4 ++
 3 files changed, 92 insertions(+), 6 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 8b392b6b7b93..40b6874accdb 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -29,6 +29,7 @@
 #include <clocksource/hyperv_timer.h>
 #include <linux/highmem.h>
 #include <linux/swiotlb.h>
+#include <asm/sev.h>
 
 int hyperv_init_cpuhp;
 u64 hv_current_partition_id = ~0ull;
@@ -70,6 +71,11 @@ static int hyperv_init_ghcb(void)
 	ghcb_base = (void **)this_cpu_ptr(hv_ghcb_pg);
 	*ghcb_base = ghcb_va;
 
+	/* Negotiate GHCB Version. */
+	if (!hv_ghcb_negotiate_protocol())
+		hv_ghcb_terminate(SEV_TERM_SET_GEN,
+				  GHCB_SEV_ES_PROT_UNSUPPORTED);
+
 	return 0;
 }
 
diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index 2b994117581e..4b67c4d7c4f5 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -53,6 +53,8 @@ union hv_ghcb {
 	} hypercall;
 } __packed __aligned(HV_HYP_PAGE_SIZE);
 
+static u16 ghcb_version __ro_after_init;
+
 u64 hv_ghcb_hypercall(u64 control, void *input, void *output, u32 input_size)
 {
 	union hv_ghcb *hv_ghcb;
@@ -96,12 +98,89 @@ u64 hv_ghcb_hypercall(u64 control, void *input, void *output, u32 input_size)
 	return status;
 }
 
+static inline u64 rd_ghcb_msr(void)
+{
+	return __rdmsr(MSR_AMD64_SEV_ES_GHCB);
+}
+
+static inline void wr_ghcb_msr(u64 val)
+{
+	u32 low, high;
+
+	low  = (u32)(val);
+	high = (u32)(val >> 32);
+
+	native_wrmsr(MSR_AMD64_SEV_ES_GHCB, low, high);
+}
+
+static enum es_result ghcb_hv_call(struct ghcb *ghcb, u64 exit_code,
+				   u64 exit_info_1, u64 exit_info_2)
+{
+	/* Fill in protocol and format specifiers */
+	ghcb->protocol_version = ghcb_version;
+	ghcb->ghcb_usage       = GHCB_DEFAULT_USAGE;
+
+	ghcb_set_sw_exit_code(ghcb, exit_code);
+	ghcb_set_sw_exit_info_1(ghcb, exit_info_1);
+	ghcb_set_sw_exit_info_2(ghcb, exit_info_2);
+
+	VMGEXIT();
+
+	if (ghcb->save.sw_exit_info_1 & GENMASK_ULL(31, 0))
+		return ES_VMM_ERROR;
+	else
+		return ES_OK;
+}
+
+void hv_ghcb_terminate(unsigned int set, unsigned int reason)
+{
+	u64 val = GHCB_MSR_TERM_REQ;
+
+	/* Tell the hypervisor what went wrong. */
+	val |= GHCB_SEV_TERM_REASON(set, reason);
+
+	/* Request Guest Termination from Hypvervisor */
+	wr_ghcb_msr(val);
+	VMGEXIT();
+
+	while (true)
+		asm volatile("hlt\n" : : : "memory");
+}
+
+bool hv_ghcb_negotiate_protocol(void)
+{
+	u64 ghcb_gpa;
+	u64 val;
+
+	/* Save ghcb page gpa. */
+	ghcb_gpa = rd_ghcb_msr();
+
+	/* Do the GHCB protocol version negotiation */
+	wr_ghcb_msr(GHCB_MSR_SEV_INFO_REQ);
+	VMGEXIT();
+	val = rd_ghcb_msr();
+
+	if (GHCB_MSR_INFO(val) != GHCB_MSR_SEV_INFO_RESP)
+		return false;
+
+	if (GHCB_MSR_PROTO_MAX(val) < GHCB_PROTOCOL_MIN ||
+	    GHCB_MSR_PROTO_MIN(val) > GHCB_PROTOCOL_MAX)
+		return false;
+
+	ghcb_version = min_t(size_t, GHCB_MSR_PROTO_MAX(val), GHCB_PROTOCOL_MAX);
+
+	/* Write ghcb page back after negotiating protocol. */
+	wr_ghcb_msr(ghcb_gpa);
+	VMGEXIT();
+
+	return true;
+}
+
 void hv_ghcb_msr_write(u64 msr, u64 value)
 {
 	union hv_ghcb *hv_ghcb;
 	void **ghcb_base;
 	unsigned long flags;
-	struct es_em_ctxt ctxt;
 
 	if (!hv_ghcb_pg)
 		return;
@@ -120,8 +199,7 @@ void hv_ghcb_msr_write(u64 msr, u64 value)
 	ghcb_set_rax(&hv_ghcb->ghcb, lower_32_bits(value));
 	ghcb_set_rdx(&hv_ghcb->ghcb, upper_32_bits(value));
 
-	if (sev_es_ghcb_hv_call(&hv_ghcb->ghcb, false, &ctxt,
-				SVM_EXIT_MSR, 1, 0))
+	if (ghcb_hv_call(&hv_ghcb->ghcb, SVM_EXIT_MSR, 1, 0))
 		pr_warn("Fail to write msr via ghcb %llx.\n", msr);
 
 	local_irq_restore(flags);
@@ -133,7 +211,6 @@ void hv_ghcb_msr_read(u64 msr, u64 *value)
 	union hv_ghcb *hv_ghcb;
 	void **ghcb_base;
 	unsigned long flags;
-	struct es_em_ctxt ctxt;
 
 	/* Check size of union hv_ghcb here. */
 	BUILD_BUG_ON(sizeof(union hv_ghcb) != HV_HYP_PAGE_SIZE);
@@ -152,8 +229,7 @@ void hv_ghcb_msr_read(u64 msr, u64 *value)
 	}
 
 	ghcb_set_rcx(&hv_ghcb->ghcb, msr);
-	if (sev_es_ghcb_hv_call(&hv_ghcb->ghcb, false, &ctxt,
-				SVM_EXIT_MSR, 0, 0))
+	if (ghcb_hv_call(&hv_ghcb->ghcb, SVM_EXIT_MSR, 0, 0))
 		pr_warn("Fail to read msr via ghcb %llx.\n", msr);
 	else
 		*value = (u64)lower_32_bits(hv_ghcb->ghcb.save.rax)
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index a82f603d4312..61f0c206bff0 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -179,9 +179,13 @@ int hv_set_mem_host_visibility(unsigned long addr, int numpages, bool visible);
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 void hv_ghcb_msr_write(u64 msr, u64 value);
 void hv_ghcb_msr_read(u64 msr, u64 *value);
+bool hv_ghcb_negotiate_protocol(void);
+void hv_ghcb_terminate(unsigned int set, unsigned int reason);
 #else
 static inline void hv_ghcb_msr_write(u64 msr, u64 value) {}
 static inline void hv_ghcb_msr_read(u64 msr, u64 *value) {}
+static inline bool hv_ghcb_negotiate_protocol(void) { return false; }
+static inline void hv_ghcb_terminate(unsigned int set, unsigned int reason) {}
 #endif
 
 extern bool hv_isolation_type_snp(void);
-- 
2.25.1

