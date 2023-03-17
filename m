Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA2566BEDB3
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Mar 2023 17:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbjCQQGy (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 17 Mar 2023 12:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbjCQQGu (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 17 Mar 2023 12:06:50 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10DF45FEAD;
        Fri, 17 Mar 2023 09:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=bFCq2RSEAg+Y5fRTPik+kLtPCBISXTx/n8QU8KXWe6s=; b=dwAVOmc0zjj3yMuhkUmfQBj4pv
        ihKPwMBJ5zZGdtfkbalG+mlkZWO1mgulTp+x7fHf5eM9Fk5w7K0jD5iVAQEOhn+0J9Eq3I3vEmNQ7
        pAXRc1H9v7iCwRePWoK5tkJ01gUUjVxncoxcDf0bw63B/aMLoO+yKNyrD035dxBzQnKwTnytv/2Sj
        kkjk5xmmRuTOsazWVVkbLOBtf5eRS9Msf85WvIlQSdAzE/r6sGuTW7pH9oWKxtUShNwyV2dtGSd6K
        UBSVJph6dwo/aR+51exbocMN0VYNoc1xR7MmugWdeAcfSEVftpgeDatUopFTRvxRYYMdMxA7TBNEo
        FNNjbu1w==;
Received: from [152.254.169.34] (helo=localhost)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1pdCaZ-00G3jr-Fb; Fri, 17 Mar 2023 17:05:56 +0100
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To:     linux-hyperv@vger.kernel.org, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, decui@microsoft.com,
        haiyangz@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        thomas.lendacky@amd.com, peterz@infradead.org,
        kernel-dev@igalia.com, kernel@gpiccoli.net,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Subject: [PATCH v3] x86/hyperv: Mark hv_ghcb_terminate() as noreturn
Date:   Fri, 17 Mar 2023 13:05:46 -0300
Message-Id: <20230317160546.1497477-1-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230310154452.1169204-1-gpiccoli@igalia.com>
References: <20230310154452.1169204-1-gpiccoli@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Annotate the function prototype and definition as noreturn to prevent
objtool warnings like:

vmlinux.o: warning: objtool: hyperv_init+0x55c: unreachable instruction

Also, as per Josh's suggestion, add it to the global_noreturns list.
As a comparison, an objdump output without the annotation:

[...]
1b63:  mov    $0x1,%esi
1b68:  xor    %edi,%edi
1b6a:  callq  ffffffff8102f680 <hv_ghcb_terminate>
1b6f:  jmpq   ffffffff82f217ec <hyperv_init+0x9c> # unreachable
1b74:  cmpq   $0xffffffffffffffff,-0x702a24(%rip)
[...]

Now, after adding the __noreturn to the function prototype:

[...]
17df:  callq  ffffffff8102f6d0 <hv_ghcb_negotiate_protocol>
17e4:  test   %al,%al
17e6:  je     ffffffff82f21bb9 <hyperv_init+0x469>
[...]  <many insns>
1bb9:  mov    $0x1,%esi
1bbe:  xor    %edi,%edi
1bc0:  callq  ffffffff8102f680 <hv_ghcb_terminate>
1bc5:  nopw   %cs:0x0(%rax,%rax,1) # end of function

Reported-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/r/9698eff1-9680-4f0a-94de-590eaa923e94@app.fastmail.com/
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---


V3:
- As per Michael / Josh advice (thanks!), added __noreturn to the
function definition as well.

V2:
- Per Josh's suggestion (thanks!), added the function name to the
objtool global table.

Thanks in advance for reviews/comments!
Cheers,

Guilherme


 arch/x86/hyperv/ivm.c           | 2 +-
 arch/x86/include/asm/mshyperv.h | 2 +-
 tools/objtool/check.c           | 1 +
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index 1dbcbd9da74d..4f79dc76042d 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -127,7 +127,7 @@ static enum es_result hv_ghcb_hv_call(struct ghcb *ghcb, u64 exit_code,
 		return ES_OK;
 }
 
-void hv_ghcb_terminate(unsigned int set, unsigned int reason)
+void __noreturn hv_ghcb_terminate(unsigned int set, unsigned int reason)
 {
 	u64 val = GHCB_MSR_TERM_REQ;
 
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 4c4c0ec3b62e..09c26e658bcc 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -212,7 +212,7 @@ int hv_set_mem_host_visibility(unsigned long addr, int numpages, bool visible);
 void hv_ghcb_msr_write(u64 msr, u64 value);
 void hv_ghcb_msr_read(u64 msr, u64 *value);
 bool hv_ghcb_negotiate_protocol(void);
-void hv_ghcb_terminate(unsigned int set, unsigned int reason);
+void __noreturn hv_ghcb_terminate(unsigned int set, unsigned int reason);
 #else
 static inline void hv_ghcb_msr_write(u64 msr, u64 value) {}
 static inline void hv_ghcb_msr_read(u64 msr, u64 *value) {}
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index f937be1afe65..4b5e03f61f1f 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -209,6 +209,7 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
 		"do_task_dead",
 		"ex_handler_msr_mce",
 		"fortify_panic",
+		"hv_ghcb_terminate",
 		"kthread_complete_and_exit",
 		"kthread_exit",
 		"kunit_try_catch_throw",
-- 
2.39.2

