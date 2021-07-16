Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4FB3CB7DF
	for <lists+linux-hyperv@lfdr.de>; Fri, 16 Jul 2021 15:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239750AbhGPNf4 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 16 Jul 2021 09:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239391AbhGPNfz (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 16 Jul 2021 09:35:55 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7423FC06175F
        for <linux-hyperv@vger.kernel.org>; Fri, 16 Jul 2021 06:32:59 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id cu14so6482779pjb.0
        for <linux-hyperv@vger.kernel.org>; Fri, 16 Jul 2021 06:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=selXb4Bpi1MsQNNsOTSazIAMo3P6W3ZQxlBy+7d1uoA=;
        b=TKilLRGbQctMearfWgitH6Ew9iqkFRPPoNfm4Ep2oUcmmMFvI3jhFgAIZWHZQE3pqd
         KmraLPyMfR52nqwn100K7VEKcTyCCOHda4CUEN/aP+wRnBtCvUjcD5DU3Qdz4kB6gsBt
         5vqp3L3eid5W6E5VukZ9QRN7WrcgIZsSQv8cFLxot0b4dSyoqAetBaJXnica98nfDvKf
         XLVHVhXZ6oPFQufyxls0PnLHGhGMlas9vd9SCepwmmBJu/wIE5I3UHL7fgAM8rFT+AAm
         LVnqYBjsEkM5LRcX1q5EeqRg+Wj3YKZH9XUFZRG7Feheupz8oblp5Xoh718Hy6Vx4Iec
         giyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=selXb4Bpi1MsQNNsOTSazIAMo3P6W3ZQxlBy+7d1uoA=;
        b=HGe3l/7lB3hy5pFErAJ6NMGK1zuccIM88YCXR4Y/apSkFZsZ5PLYFGqZcfOmI7u89X
         K7UutINNmSf7UrRIt1ZeoWK7N4U11N9fE+ED52Hte9I40cIZER+rfkMHNCj+qV9aoIeJ
         sscuqV1H4iULjAYisnH5ds7AIUviceYkxjjsdmyM9+yzilQ0cvY6zlOL6jjMQnIuSKwm
         4/MrC8Ub8RASvudhBIgLA55bWCFlkG+mawGwvh4KytsVcST9CBqJfOJc/POWRgpRxjJ8
         hERRp7SX/UoIuFDL0I3jVJRVTYzTy8u3VvnE2GJAm+ce5huMkftJT/z1CCTUkry9GG/P
         xa/A==
X-Gm-Message-State: AOAM530wkxBt72hpd2pk8119F4TgdNYoOPhm13eBBq0K/AT0yssz8A3m
        Xd7eQ20h3ZQ8tCeJ4f8i+GVtTg==
X-Google-Smtp-Source: ABdhPJygtVXL3lsL1CB5q8xnQgTzQFCwFB8iHKf0NCmk7gV17UIErzJ4qWzHrSYgd2EeFyQLuDCs3w==
X-Received: by 2002:a17:902:760c:b029:129:2dde:f8c9 with SMTP id k12-20020a170902760cb02901292ddef8c9mr8036733pll.41.1626442378595;
        Fri, 16 Jul 2021 06:32:58 -0700 (PDT)
Received: from anisinha-lenovo.ba.nuagenetworks.net ([115.96.126.211])
        by smtp.googlemail.com with ESMTPSA id v14sm11434730pgo.89.2021.07.16.06.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 06:32:58 -0700 (PDT)
From:   Ani Sinha <ani@anisinha.ca>
To:     linux-kernel@vger.kernel.org
Cc:     anirban.sinha@nokia.com, mikelley@microsoft.com,
        Ani Sinha <ani@anisinha.ca>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-hyperv@vger.kernel.org
Subject: [PATCH v2] x86/hyperv: add comment describing TSC_INVARIANT_CONTROL MSR setting bit 0
Date:   Fri, 16 Jul 2021 19:02:45 +0530
Message-Id: <20210716133245.3272672-1-ani@anisinha.ca>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Commit dce7cd62754b5 ("x86/hyperv: Allow guests to enable InvariantTSC")
added the support for HV_X64_MSR_TSC_INVARIANT_CONTROL. Setting bit 0
of this synthetic MSR will allow hyper-v guests to report invariant TSC
CPU feature through CPUID. This comment adds this explanation to the code
and mentions where the Intel's generic platform init code reads this
feature bit from CPUID. The comment will help developers understand how
the two parts of the initialization (hyperV specific and non-hyperV
specific generic hw init) are related.

Signed-off-by: Ani Sinha <ani@anisinha.ca>
---
 arch/x86/kernel/cpu/mshyperv.c | 9 +++++++++
 1 file changed, 9 insertions(+)

changelog:
v1: initial patch
v2: slight comment update based on received feedback.

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 715458b7729a..3b05dab3086e 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -368,6 +368,15 @@ static void __init ms_hyperv_init_platform(void)
 	machine_ops.crash_shutdown = hv_machine_crash_shutdown;
 #endif
 	if (ms_hyperv.features & HV_ACCESS_TSC_INVARIANT) {
+		/*
+		 * Writing to synthetic MSR 0x40000118 updates/changes the
+		 * guest visible CPUIDs. Setting bit 0 of this MSR  enables
+		 * guests to report invariant TSC feature through CPUID
+		 * instruction, CPUID 0x800000007/EDX, bit 8. See code in
+		 * early_init_intel() where this bit is examined. The
+		 * setting of this MSR bit should happen before init_intel()
+		 * is called.
+		 */
 		wrmsrl(HV_X64_MSR_TSC_INVARIANT_CONTROL, 0x1);
 		setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
 	}
-- 
2.25.1

