Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD0CE4459A1
	for <lists+linux-hyperv@lfdr.de>; Thu,  4 Nov 2021 19:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234137AbhKDSZ1 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 4 Nov 2021 14:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234172AbhKDSZZ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 4 Nov 2021 14:25:25 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97534C061205
        for <linux-hyperv@vger.kernel.org>; Thu,  4 Nov 2021 11:22:47 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id z187-20020a6233c4000000b0047c2090f1abso4391481pfz.23
        for <linux-hyperv@vger.kernel.org>; Thu, 04 Nov 2021 11:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=jpAcC9sKt5b/T+a4qZnHVk8srWMFmGVXhrzjULcw9gM=;
        b=XU3u9vuox99tFvdn2blqlYHVvzPWHcPxHBksOxD75cbfDSXbPe9AdiYsKvU24bWp2a
         UByzBBkp3i4b65+SGbvChxsrKDHANb1/52Q6h8MgvFKobE3Qkm0uxiewekYvm74qBRQJ
         zZ6FrpbUi0BaDLOpJJD416GpbxNsi0bVcbs+gGSUcZ+Zg3sRvT2CTf6XTQ+xrSxTQjAj
         oVOlLNdpS5yz6LooPyyT8TI2Q2+82ll+XvaNojQmQJOdGLuuWSlYGJL3gAhttpIA8q7R
         mukxt0JJPqim3Dv9Q+V81LsgGoLV1EwXdLFqqeAAiDYaoVwQlSQeyOatBD3+rJy6Yx2/
         86Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=jpAcC9sKt5b/T+a4qZnHVk8srWMFmGVXhrzjULcw9gM=;
        b=324b7/QclUasRtde1/HhS16jApMNb17dnUgp1NYeCLzQsg3yOQiF/Pc3ifIdJlXC+L
         PNldJs1MXbczqPyAOwdoRgKpWG9PsrnyklY5uLIvvaxP1t1UG9ngqP4U4fWyEzKMBICX
         uU4uRXf8Hswwh/bf7PLDt50IwCAbcKDps9S9V5XoqNfu1uVw5LOHf88UinxtpURb/TpT
         JP1Mot8ZxcinaPbTxoVvB7T2wpK0PynerD9u4X+OTWkIASuiiymXKrn4mlR21QC9Ta+M
         ZbMUN7jDzc5MTQ316pdq6+b1Nlt5CNeyZlxe/WX7xuk3bbHsmtqllJF2gM9B4FS9/tMa
         vSHA==
X-Gm-Message-State: AOAM5329zP8Z8bPN75Xck0sUhWxxYTT9bq+GCrgyaWpUxvfoTeTc9Cs0
        K/CY4VmybdXQDJICcqBxedFrOUPOkGA=
X-Google-Smtp-Source: ABdhPJy86zvK8IJJ4Z5x9l95/Gc4m+3iWcNRdRFBnmMcxqJ9yjg7fLi2Mlj4km5rKu8VJG04D6OuRXCo3Ks=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90a:5285:: with SMTP id
 w5mr166505pjh.1.1636050166841; Thu, 04 Nov 2021 11:22:46 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu,  4 Nov 2021 18:22:39 +0000
In-Reply-To: <20211104182239.1302956-1-seanjc@google.com>
Message-Id: <20211104182239.1302956-3-seanjc@google.com>
Mime-Version: 1.0
References: <20211104182239.1302956-1-seanjc@google.com>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH v2 2/2] x86/hyperv: Move required MSRs check to initial
 platform probing
From:   Sean Christopherson <seanjc@google.com>
To:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Explicitly check for MSR_HYPERCALL and MSR_VP_INDEX support when probing
for running as a Hyper-V guest instead of waiting until hyperv_init() to
detect the bogus configuration.  Add messages to give the admin a heads
up that they are likely running on a broken virtual machine setup.

At best, silently disabling Hyper-V is confusing and difficult to debug,
e.g. the kernel _says_ it's using all these fancy Hyper-V features, but
always falls back to the native versions.  At worst, the half baked setup
will crash/hang the kernel.

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/hyperv/hv_init.c      |  9 +--------
 arch/x86/kernel/cpu/mshyperv.c | 20 +++++++++++++++-----
 2 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 7d252a58fbe4..96eb7db31c8e 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -386,20 +386,13 @@ static void __init hv_get_partition_id(void)
  */
 void __init hyperv_init(void)
 {
-	u64 guest_id, required_msrs;
+	u64 guest_id;
 	union hv_x64_msr_hypercall_contents hypercall_msr;
 	int cpuhp;
 
 	if (x86_hyper_type != X86_HYPER_MS_HYPERV)
 		return;
 
-	/* Absolutely required MSRs */
-	required_msrs = HV_MSR_HYPERCALL_AVAILABLE |
-		HV_MSR_VP_INDEX_AVAILABLE;
-
-	if ((ms_hyperv.features & required_msrs) != required_msrs)
-		return;
-
 	if (hv_common_init())
 		return;
 
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 4794b716ec79..ff55df60228f 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -163,12 +163,22 @@ static uint32_t  __init ms_hyperv_platform(void)
 	cpuid(HYPERV_CPUID_VENDOR_AND_MAX_FUNCTIONS,
 	      &eax, &hyp_signature[0], &hyp_signature[1], &hyp_signature[2]);
 
-	if (eax >= HYPERV_CPUID_MIN &&
-	    eax <= HYPERV_CPUID_MAX &&
-	    !memcmp("Microsoft Hv", hyp_signature, 12))
-		return HYPERV_CPUID_VENDOR_AND_MAX_FUNCTIONS;
+	if (eax < HYPERV_CPUID_MIN || eax > HYPERV_CPUID_MAX ||
+	    memcmp("Microsoft Hv", hyp_signature, 12))
+		return 0;
 
-	return 0;
+	/* HYPERCALL and VP_INDEX MSRs are mandatory for all features. */
+	eax = cpuid_eax(HYPERV_CPUID_FEATURES);
+	if (!(eax & HV_MSR_HYPERCALL_AVAILABLE)) {
+		pr_warn("x86/hyperv: HYPERCALL MSR not available.\n");
+		return 0;
+	}
+	if (!(eax & HV_MSR_VP_INDEX_AVAILABLE)) {
+		pr_warn("x86/hyperv: VP_INDEX MSR not available.\n");
+		return 0;
+	}
+
+	return HYPERV_CPUID_VENDOR_AND_MAX_FUNCTIONS;
 }
 
 static unsigned char hv_get_nmi_reason(void)
-- 
2.34.0.rc0.344.g81b53c2807-goog

