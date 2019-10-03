Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 438ADCA165
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Oct 2019 17:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729551AbfJCPw0 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 3 Oct 2019 11:52:26 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33633 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbfJCPw0 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 3 Oct 2019 11:52:26 -0400
Received: by mail-wm1-f67.google.com with SMTP id r17so7509132wme.0;
        Thu, 03 Oct 2019 08:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YVWb+kbMfD8Yiy89fV/THmbt5OZLavh87ZiY4MpuFrw=;
        b=NlrV3ZAny5M8ArYC7Mz1CvonLEnF15hts/4/Bw4P3bhm2vdhx6/cwGdXoAMCga0+R6
         zSYkGmBAYXGePM2OhMuA4QvoriggiHRBnwBKtucPK9LTJ+co8cB1sEX9di0u3OG6ssh4
         2LrZTtrrkRvq8BuXXYVAjcdi6SVKztWjPE+2ssMWj0KcVPnMioCZqpuvNOPhU4BiXjF/
         a4gceea0yN+bkqxj08w0POAE8OiKbgIGJ0enWJbU2ZTbfvawK7AqfCeD3zeZQ3y6XC12
         cEQoJjBnhQV69WCopgMJT2r/g++fXUXjolWUQg8do6tHEeN7a1MGd8wEP2rCyuc3RscT
         p4KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YVWb+kbMfD8Yiy89fV/THmbt5OZLavh87ZiY4MpuFrw=;
        b=CbrUMVtV5I2GJbthcTJtqDwXrgm71lNTHp2EkOBYH3dpkVxaL5BlF3E6VlCPaCG8v+
         v5e5yZO/1k91LdSNGpMktgPb3/GthQ33U3mbEqawSbzq84JJKQu4XAXL1s0iHEaTxJ3V
         okPmSn6jkOcF1JnziRPFwIN69d7P3l+weKCS4RY7vbBE0Jab/JrJdrxVZd0Fm8LycFPZ
         QJbWwg1Iz81C8OKIn9ZsjTyST+TwFurJd0AgdqA5FlBN/52zQMD8LdO0gvgdyc5Pg1Xf
         q/R4F2ax/2BrUDuJaXmLMu6C2jLgcQtlwNSd+3FPiJbA7xISoU5DZAn3ZAuP4CEjCjjj
         7wug==
X-Gm-Message-State: APjAAAVcU2GldvEnjCrRKW/8rNMmPrcpFROFeBtWyJUNIWRrHoRy2F46
        sYmxUjQ9Zgm0hzvdCfQEuUX2+T+OYh8SRGzW
X-Google-Smtp-Source: APXvYqzUdkZqk1pXU+UwWS9xCHk4oKkcFVeMQ3zX/pD9lwt3siI+sz2XxHMnpmmLIxhQSt0xZGUSzw==
X-Received: by 2002:a1c:a90b:: with SMTP id s11mr7888533wme.92.1570117942015;
        Thu, 03 Oct 2019 08:52:22 -0700 (PDT)
Received: from andrea.corp.microsoft.com ([2a01:110:8012:1010:414b:bdc7:a2f9:15b6])
        by smtp.gmail.com with ESMTPSA id c4sm4477597wru.31.2019.10.03.08.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 08:52:21 -0700 (PDT)
From:   Andrea Parri <parri.andrea@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        x86@kernel.org
Cc:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Andrea Parri <parri.andrea@gmail.com>
Subject: [PATCH 1/2] x86/hyperv: Allow guests to enable InvariantTSC
Date:   Thu,  3 Oct 2019 17:52:00 +0200
Message-Id: <20191003155200.22022-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

If the hardware supports TSC scaling, Hyper-V will set bit 15 of the
HV_PARTITION_PRIVILEGE_MASK in guest VMs with a compatible Hyper-V
configuration version.  Bit 15 corresponds to the
AccessTscInvariantControls privilege.  If this privilege bit is set,
guests can access the HvSyntheticInvariantTscControl MSR: guests can
set bit 0 of this synthetic MSR to enable the InvariantTSC feature.
After setting the synthetic MSR, CPUID will enumerate support for
InvariantTSC.

Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
 arch/x86/include/asm/hyperv-tlfs.h | 5 +++++
 arch/x86/kernel/cpu/mshyperv.c     | 7 ++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index 7741e211f7f51..5f10f7f2098db 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -86,6 +86,8 @@
 #define HV_X64_ACCESS_FREQUENCY_MSRS		BIT(11)
 /* AccessReenlightenmentControls privilege */
 #define HV_X64_ACCESS_REENLIGHTENMENT		BIT(13)
+/* AccessTscInvariantControls privilege */
+#define HV_X64_ACCESS_TSC_INVARIANT		BIT(15)
 
 /*
  * Feature identification: indicates which flags were specified at partition
@@ -278,6 +280,9 @@
 #define HV_X64_MSR_TSC_EMULATION_CONTROL	0x40000107
 #define HV_X64_MSR_TSC_EMULATION_STATUS		0x40000108
 
+/* TSC invariant control */
+#define HV_X64_MSR_TSC_INVARIANT_CONTROL	0x40000118
+
 /*
  * Declare the MSR used to setup pages used to communicate with the hypervisor.
  */
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 267daad8c0360..105844d542e5c 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -286,7 +286,12 @@ static void __init ms_hyperv_init_platform(void)
 	machine_ops.shutdown = hv_machine_shutdown;
 	machine_ops.crash_shutdown = hv_machine_crash_shutdown;
 #endif
-	mark_tsc_unstable("running on Hyper-V");
+	if (ms_hyperv.features & HV_X64_ACCESS_TSC_INVARIANT) {
+		wrmsrl(HV_X64_MSR_TSC_INVARIANT_CONTROL, 0x1);
+		setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
+	} else {
+		mark_tsc_unstable("running on Hyper-V");
+	}
 
 	/*
 	 * Generation 2 instances don't support reading the NMI status from
-- 
2.23.0

