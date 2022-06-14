Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61D1F54A3C0
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Jun 2022 03:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234470AbiFNBqK (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 13 Jun 2022 21:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232466AbiFNBqK (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 13 Jun 2022 21:46:10 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1CF528733;
        Mon, 13 Jun 2022 18:46:08 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id s135so7165341pgs.10;
        Mon, 13 Jun 2022 18:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EBGL9E7OB4V1zTXBIQFEfKIFlS17lj/9UnG0R5XFTgA=;
        b=q6umwX76xn6HGaNN598lYDpD2rotyodQQoXamqAbIMDR0Nk7xjiBUc57LYUSH/4R2o
         YhkfdsdF80Vtt2X4WILafYjbplVLv2YXIACHIEw8cCqluwkWVFhM1v5wWcIWOZNpWz6V
         CFXiwwap3cY0oKcKUPzap4juEfoauBfMQu1D+aZEaWutSJ7drxDG4syF0YJofdmGdbM3
         JBp6zUOAbcWp3H5j01YKn8ajEstkKabzJktcbxwpuN+ZawSE9ZKVnDG8j5zVl6lHUIcO
         9HJlQaP435A3YcPhhTrYsZZvUxdC/R/uWtgtiSIZNkhLeaEHIsX4/hlbwXaRl3cV4jsI
         mWlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EBGL9E7OB4V1zTXBIQFEfKIFlS17lj/9UnG0R5XFTgA=;
        b=7VZUqBTxIgC2ikF9P4piM7guNyumGHnQkER242kYfEuyp6FoGnx9RcB5Odi2deX+GI
         NTInyNxmwg+5+yehfwYnFpADDMiczmAmLuFxoCl9QwbSY3K3scgvEH66inK9LXxDtd8V
         DfTANMrZ4nYgvLm0tDZoVEZm+6i/b1KU8HPR0wXQsPE+xjkjPNQkawkmaGDukGVgQqWO
         cuemBmqopdfreqgRSq9MdK0M+ZpxxKMQCjUUzD0q6npr3OSTDQ1JOfIGh+EYEQNvuxAO
         y/j76qyNS+CEuVJB1TfAGAGVt938joVB5POVTPhUOB8HZv7+TM4CCxTomJii59W4G3eh
         XrkQ==
X-Gm-Message-State: AOAM532djeT6PocJdairCK2Mh+WMiTqp7uX6O7G0mAteLjiUCmcQYSOL
        qqbSrJKJqpruhx1OVgha6iw=
X-Google-Smtp-Source: ABdhPJyFN4D018rKHi7xTrBq/m8qKfEzwuOFn6fhHV+/87C7zc8nblte4mFf2i/wMFqpqbPOL0irOQ==
X-Received: by 2002:a65:6cc8:0:b0:3fe:2b89:cc00 with SMTP id g8-20020a656cc8000000b003fe2b89cc00mr2211916pgw.599.1655171168123;
        Mon, 13 Jun 2022 18:46:08 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:37:7f38:359f:eb4a:3919])
        by smtp.gmail.com with ESMTPSA id fs23-20020a17090af29700b001df2f8f0a45sm6021473pjb.1.2022.06.13.18.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 18:46:07 -0700 (PDT)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com, parri.andrea@gmail.com,
        thomas.lendacky@amd.com
Subject: [PATCH V3] x86/Hyper-V: Add SEV negotiate protocol support in Isolation VM
Date:   Mon, 13 Jun 2022 21:45:53 -0400
Message-Id: <20220614014553.1915929-1-ltykernel@gmail.com>
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
hyperv_init() and use the version to communicate with Hyper-V
in the ghcb hv call function.

Fixes: 2ea29c5abbc2 ("x86/sev: Save the negotiated GHCB version")
Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
Change since v1:
       - Negotiate ghcb version in Hyper-V init.
       - use native_wrmsrl() instead of native_wrmsr() in the
       	 wr_ghcb_msr().
---
 arch/x86/hyperv/hv_init.c       |  6 +++
 arch/x86/hyperv/ivm.c           | 84 ++++++++++++++++++++++++++++++---
 arch/x86/include/asm/mshyperv.h |  4 ++
 3 files changed, 88 insertions(+), 6 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 8b392b6b7b93..3de6d8b53367 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -13,6 +13,7 @@
 #include <linux/io.h>
 #include <asm/apic.h>
 #include <asm/desc.h>
+#include <asm/sev.h>
 #include <asm/hypervisor.h>
 #include <asm/hyperv-tlfs.h>
 #include <asm/mshyperv.h>
@@ -405,6 +406,11 @@ void __init hyperv_init(void)
 	}
 
 	if (hv_isolation_type_snp()) {
+		/* Negotiate GHCB Version. */
+		if (!hv_ghcb_negotiate_protocol())
+			hv_ghcb_terminate(SEV_TERM_SET_GEN,
+					  GHCB_SEV_ES_PROT_UNSUPPORTED);
+
 		hv_ghcb_pg = alloc_percpu(union hv_ghcb *);
 		if (!hv_ghcb_pg)
 			goto free_vp_assist_page;
diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index 2b994117581e..1dbcbd9da74d 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -53,6 +53,8 @@ union hv_ghcb {
 	} hypercall;
 } __packed __aligned(HV_HYP_PAGE_SIZE);
 
+static u16 hv_ghcb_version __ro_after_init;
+
 u64 hv_ghcb_hypercall(u64 control, void *input, void *output, u32 input_size)
 {
 	union hv_ghcb *hv_ghcb;
@@ -96,12 +98,85 @@ u64 hv_ghcb_hypercall(u64 control, void *input, void *output, u32 input_size)
 	return status;
 }
 
+static inline u64 rd_ghcb_msr(void)
+{
+	return __rdmsr(MSR_AMD64_SEV_ES_GHCB);
+}
+
+static inline void wr_ghcb_msr(u64 val)
+{
+	native_wrmsrl(MSR_AMD64_SEV_ES_GHCB, val);
+}
+
+static enum es_result hv_ghcb_hv_call(struct ghcb *ghcb, u64 exit_code,
+				   u64 exit_info_1, u64 exit_info_2)
+{
+	/* Fill in protocol and format specifiers */
+	ghcb->protocol_version = hv_ghcb_version;
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
+	hv_ghcb_version = min_t(size_t, GHCB_MSR_PROTO_MAX(val),
+			     GHCB_PROTOCOL_MAX);
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
@@ -120,8 +195,7 @@ void hv_ghcb_msr_write(u64 msr, u64 value)
 	ghcb_set_rax(&hv_ghcb->ghcb, lower_32_bits(value));
 	ghcb_set_rdx(&hv_ghcb->ghcb, upper_32_bits(value));
 
-	if (sev_es_ghcb_hv_call(&hv_ghcb->ghcb, false, &ctxt,
-				SVM_EXIT_MSR, 1, 0))
+	if (hv_ghcb_hv_call(&hv_ghcb->ghcb, SVM_EXIT_MSR, 1, 0))
 		pr_warn("Fail to write msr via ghcb %llx.\n", msr);
 
 	local_irq_restore(flags);
@@ -133,7 +207,6 @@ void hv_ghcb_msr_read(u64 msr, u64 *value)
 	union hv_ghcb *hv_ghcb;
 	void **ghcb_base;
 	unsigned long flags;
-	struct es_em_ctxt ctxt;
 
 	/* Check size of union hv_ghcb here. */
 	BUILD_BUG_ON(sizeof(union hv_ghcb) != HV_HYP_PAGE_SIZE);
@@ -152,8 +225,7 @@ void hv_ghcb_msr_read(u64 msr, u64 *value)
 	}
 
 	ghcb_set_rcx(&hv_ghcb->ghcb, msr);
-	if (sev_es_ghcb_hv_call(&hv_ghcb->ghcb, false, &ctxt,
-				SVM_EXIT_MSR, 0, 0))
+	if (hv_ghcb_hv_call(&hv_ghcb->ghcb, SVM_EXIT_MSR, 0, 0))
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

