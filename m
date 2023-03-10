Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2506B4295
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Mar 2023 15:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbjCJOEr (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 10 Mar 2023 09:04:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbjCJOEb (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 10 Mar 2023 09:04:31 -0500
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237521588C;
        Fri, 10 Mar 2023 06:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=2PyfUlnwgN5RjZe7ar8tVggCq1gu3L2eKgJ5SOORC40=; b=kvPMzlQP3K6BQ04TJU1vzMI43o
        MfFe631uEbjqIdKC49kceDEQ9BZAq1RvdbRUB+aY5cukUU4prKFihUklp8rF14d84rB9dge8pu+Ki
        lfAou2K0vj4pzmU1f+Pwh8iKmz82RPhAk/VCNM/6KukQi0GeI7lslhMJr+ekPRMFDQgRt1KMQsBnC
        PO8AhgQyxiQ/RZcfEL91OF0E86uEehSgTuykWt3DjrUhm7p0aIUbq1Wp1rN9YhPGg7t9fzVthtdhv
        rpAD8qzTHx5Ps5BmoR9ZRNp1VMUlR4D+NaL4qW3cSXBlXmpHXCPdX6lHscMJoxZC6dbzurnGCph6q
        QYf5CgVA==;
Received: from 201-68-164-191.dsl.telesp.net.br ([201.68.164.191] helo=localhost)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1padM1-002qb0-GZ; Fri, 10 Mar 2023 15:04:17 +0100
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To:     linux-hyperv@vger.kernel.org, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, decui@microsoft.com,
        haiyangz@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        thomas.lendacky@amd.com, jpoimboe@kernel.org, peterz@infradead.org,
        kernel-dev@igalia.com, kernel@gpiccoli.net,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] x86/hyperv: Mark hv_ghcb_terminate() as noreturn
Date:   Fri, 10 Mar 2023 11:02:52 -0300
Message-Id: <20230310140251.1159036-1-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.39.2
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

Annotate the function prototype as noreturn to prevent objtool
warnings like:

vmlinux.o: warning: objtool: hyperv_init+0x55c: unreachable instruction

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
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---


Hey folks, after getting the warning myself a quick search led me to Arnd's
thorough report - investigating a bit, this seems to be the proper solution.

Notice I didn't add the function to objtool's static list, seems this is
unnecessary in this case - lemme know otherwise!
Thanks in advance for reviews,


Guilherme


 arch/x86/include/asm/mshyperv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
-- 
2.39.2

