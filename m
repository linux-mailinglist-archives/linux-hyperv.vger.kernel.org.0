Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7BE14AC57A
	for <lists+linux-hyperv@lfdr.de>; Mon,  7 Feb 2022 17:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238251AbiBGQV3 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 7 Feb 2022 11:21:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343750AbiBGQJy (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 7 Feb 2022 11:09:54 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E24C0401DF;
        Mon,  7 Feb 2022 08:09:44 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id v15-20020a17090a4ecf00b001b82db48754so14044290pjl.2;
        Mon, 07 Feb 2022 08:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bc9AHRZR1pshNQdSUMPi4giKprTpkGNBEnF9JWPwt2E=;
        b=JAfoiZ9t8GzKsMy000nAJS6NlGY4h0Fahz0vPp4DgANVACMUHAediTakMcUf2VUbQn
         L4U46ZbxdSfCdqgTca9qs8DK/e59ANl6k6XGndSJTQGZkQfGzKYFxaH0Aa+NKx8y9kDc
         ROnb3EJqAhPYk8fTVtkSq4fMazHidRwyIWpzzxmKpXQBeOt+8F6Njax/Ef7P/xBIhMX6
         UM3+Xe+w5ebHtNlZmh7kDlteUh0+9x/xEAY1QSa0Flgr5eWMFx0X0qilvVSPHp6+G9LK
         lfr4bUoVst/4kF43XMtL0sWdJo6uU/snm/oCBT4NNwwb4SaPO5bR4n3dVy4a2NBkB56x
         0tNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bc9AHRZR1pshNQdSUMPi4giKprTpkGNBEnF9JWPwt2E=;
        b=H5FQYXf6TfE5Wxhpo/QOgBbqPos4zU1aNrf6dff/4ZTTNo2qgS75gHEFlZA+uxRKO8
         me2wg249LYVmMrQearoKgUp0DX4TLG1wC2sPzj11WjnMhhZm26ewH/bCngfSDMhdnAcI
         OedrdPlD/Mk9CqL91ci9XUAt5Rcbv8dtr7xfA/aK9nL4o9EpGb6qoHGJeDKk8vdxrUUe
         ntlgJEz0q/NY5VFV2A2AlrOJMdTA8Naz0mLg4LAj1zpDu6QA4EGU2PnwsrBqt45qa8SC
         MzjzVByx9Ad7/jG9ljKflKCsEdjARSJ8IJt/9rjlYio3yd0qEnMQ0Lg91eyjZBJHGmvu
         E+Vg==
X-Gm-Message-State: AOAM530Ptb5r7F13yiC4Bkunh/r1w7KwwBFJTMzODD59m/w9qVUQ0Y5G
        7DcHIuhLMxDWfSiXlUDi5tg=
X-Google-Smtp-Source: ABdhPJxvraa0Ez4eY9PIHd2rqE7xpEpvngaRaU3dzq0slx+I8MQ6gqMKshVGQWXwXnCvEpiNZqZuDw==
X-Received: by 2002:a17:902:a413:: with SMTP id p19mr305861plq.35.1644250184070;
        Mon, 07 Feb 2022 08:09:44 -0800 (PST)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:7:49ed:b358:ae30:a484])
        by smtp.gmail.com with ESMTPSA id z14sm5958859pfh.173.2022.02.07.08.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 08:09:43 -0800 (PST)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, brijesh.singh@amd.com,
        michael.roth@amd.com, jroedel@suse.de, Tianyu.Lan@microsoft.com,
        thomas.lendacky@amd.com, michael.h.kelley@microsoft.com
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC FATCH] x86/Hyper-V: Add SEV negotiate protocol support in Isolation VM.
Date:   Mon,  7 Feb 2022 11:09:28 -0500
Message-Id: <20220207160928.111718-1-ltykernel@gmail.com>
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
via ghcb page. The SEV-ES guest should call the sev_es_negotiate_protocol()
to negotiate the GHCB protocol version before establishing the GHCB. Call
sev_es_negotiate_protocol() in the hyperv_init_ghcb().

Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
This patch based on the "Add AMD Secure Nested Paging (SEV-SNP) Guest Support"
patchset. https://lore.kernel.org/lkml/20220128171804.569796-1-brijesh.singh@amd.com/

 arch/x86/hyperv/hv_init.c    | 6 ++++++
 arch/x86/include/asm/sev.h   | 2 ++
 arch/x86/kernel/sev-shared.c | 2 +-
 arch/x86/kernel/sev.c        | 4 ++--
 4 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 24f4a06ac46a..a22303fccf02 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -28,6 +28,7 @@
 #include <linux/syscore_ops.h>
 #include <clocksource/hyperv_timer.h>
 #include <linux/highmem.h>
+#include <asm/sev.h>
 
 int hyperv_init_cpuhp;
 u64 hv_current_partition_id = ~0ull;
@@ -69,6 +70,11 @@ static int hyperv_init_ghcb(void)
 	ghcb_base = (void **)this_cpu_ptr(hv_ghcb_pg);
 	*ghcb_base = ghcb_va;
 
+	sev_es_negotiate_protocol();
+
+	/* Write ghcb page back after negotiating protocol. */
+	wrmsrl(MSR_AMD64_SEV_ES_GHCB, ghcb_gpa);
+	VMGEXIT();
 	return 0;
 }
 
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 7a5934af9d47..fc6b0c526492 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -120,6 +120,8 @@ extern enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb,
 					  struct es_em_ctxt *ctxt,
 					  u64 exit_code, u64 exit_info_1,
 					  u64 exit_info_2);
+extern bool sev_es_negotiate_protocol(void);
+
 static inline int rmpadjust(unsigned long vaddr, bool rmp_psize, unsigned long attrs)
 {
 	int rc;
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index ce06cb7c8ed0..8b8af5a8d402 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -145,7 +145,7 @@ static void snp_register_ghcb_early(unsigned long paddr)
 		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_REGISTER);
 }
 
-static bool sev_es_negotiate_protocol(void)
+bool sev_es_negotiate_protocol(void)
 {
 	u64 val;
 
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 3568b3303314..46c53c4885ee 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -167,12 +167,12 @@ void noinstr __sev_es_ist_exit(void)
 	this_cpu_write(cpu_tss_rw.x86_tss.ist[IST_INDEX_VC], *(unsigned long *)ist);
 }
 
-static inline u64 sev_es_rd_ghcb_msr(void)
+inline u64 sev_es_rd_ghcb_msr(void)
 {
 	return __rdmsr(MSR_AMD64_SEV_ES_GHCB);
 }
 
-static __always_inline void sev_es_wr_ghcb_msr(u64 val)
+__always_inline void sev_es_wr_ghcb_msr(u64 val)
 {
 	u32 low, high;
 
-- 
2.25.1

