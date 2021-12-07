Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6979246C732
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 Dec 2021 23:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242223AbhLGWNX (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 7 Dec 2021 17:13:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242197AbhLGWNV (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 7 Dec 2021 17:13:21 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8762CC0617A1
        for <linux-hyperv@vger.kernel.org>; Tue,  7 Dec 2021 14:09:50 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id p24-20020a170902a41800b001438d6c7d71so99636plq.7
        for <linux-hyperv@vger.kernel.org>; Tue, 07 Dec 2021 14:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=JNBI+S2Jw5Vs4x4pkp+oETPJ8WHMJe4kYnIfeY40RAo=;
        b=H0Ol+y/a13fDttBnOc0z9kTIyBRa7LB9zOK5FeI6QQMlBRx6rp+ElP7mpguG1NFW6Q
         3TrlFcPjXek6+IluQsPwdB/sH+raBYdQvJkp8XfHLIohUErExFS5iMOsjdNxUAUyMjii
         ZIED1vVYFbjCovBwJhmBTSVw4Vc3KldLKGLDNJbwhwxwbH4zZk2jEpQabC+nlDTIXfz4
         lUnW46E8xqCkKwNd2SRQGrzNcdREWA1Bf8c2fX6bGf3rLxk/BXR65nLxbpAUFaxIj65Q
         jWISYOmjde1Cb0/nRiB9BS4KijuJ5KTG5oYZHghGblqQbtSfMkypGOln6kCYugCOAJbM
         sbCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=JNBI+S2Jw5Vs4x4pkp+oETPJ8WHMJe4kYnIfeY40RAo=;
        b=mC0URS36rjyUY8yDeoQm5K6+gUrPgEJUlqorRrEmTlmeszoaZ1u6ZXPU7eiqbejWCN
         yKGiWk8kNrzCwL40/10pRPP8Nsg+MHHPxdnkZciyFkIE4o0fmGWg5qepx/GPQBdLicgU
         wkFdCRX5om3G1iwrvhoXVPS7wDkZWKf5eoWl0ZH87TZDRa6QUvW5u9eePXbzagl0rm99
         upqO4oKF35ysEaCqHcR5u4gpjH0NYkRmrK+21VHochdnS7OVYlND8uviGs0Xu4uNf7MU
         4CeL6E5UvstAx5ZPFG1Ou69+V1UDDYGZbI3ZukQhpIGw82DRGFFtn5/k6XcRSiBRUJnD
         qfHw==
X-Gm-Message-State: AOAM532fb2d+LIJEtpIgytZnT6XdVi81nq956EndNbFQL4BztciVxbLB
        oC+bdGBQDXID1KSrddCgON4D2a1Fh+o=
X-Google-Smtp-Source: ABdhPJzYI9Ielu744KQZUdFhLMEjd4KuXafE47GaJMqZ01zbaWxslijUvytjk8sHKu8mR2UEuWlq6yHLnvk=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:902:b7cb:b0:141:b33a:9589 with SMTP id
 v11-20020a170902b7cb00b00141b33a9589mr54924224plz.9.1638914990041; Tue, 07
 Dec 2021 14:09:50 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue,  7 Dec 2021 22:09:26 +0000
In-Reply-To: <20211207220926.718794-1-seanjc@google.com>
Message-Id: <20211207220926.718794-9-seanjc@google.com>
Mime-Version: 1.0
References: <20211207220926.718794-1-seanjc@google.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH v3 8/8] KVM: x86: Add checks for reserved-to-zero Hyper-V
 hypercall fields
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ajay Garg <ajaygargnsit@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Add checks for the three fields in Hyper-V's hypercall params that must
be zero.  Per the TLFS, HV_STATUS_INVALID_HYPERCALL_INPUT is returned if
"A reserved bit in the specified hypercall input value is non-zero."

Note, some versions of the TLFS have an off-by-one bug for the last
reserved field, and define it as being bits 64:60.  See
https://github.com/MicrosoftDocs/Virtualization-Documentation/pull/1682.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/hyperv.c             | 5 +++++
 include/asm-generic/hyperv-tlfs.h | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 522ccd2f0db4..3be59f13b467 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -2237,6 +2237,11 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
 		goto hypercall_complete;
 	}
 
+	if (unlikely(hc.param & HV_HYPERCALL_RSVD_MASK)) {
+		ret = HV_STATUS_INVALID_HYPERCALL_INPUT;
+		goto hypercall_complete;
+	}
+
 	if (hc.fast && is_xmm_fast_hypercall(&hc)) {
 		if (unlikely(hv_vcpu->enforce_cpuid &&
 			     !(hv_vcpu->cpuid_cache.features_edx &
diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
index 8a04c8fba598..2354378eef4c 100644
--- a/include/asm-generic/hyperv-tlfs.h
+++ b/include/asm-generic/hyperv-tlfs.h
@@ -184,11 +184,17 @@ enum HV_GENERIC_SET_FORMAT {
 #define HV_HYPERCALL_FAST_BIT		BIT(16)
 #define HV_HYPERCALL_VARHEAD_OFFSET	17
 #define HV_HYPERCALL_VARHEAD_MASK	GENMASK_ULL(26, 17)
+#define HV_HYPERCALL_RSVD0_MASK		GENMASK_ULL(31, 27)
 #define HV_HYPERCALL_REP_COMP_OFFSET	32
 #define HV_HYPERCALL_REP_COMP_1		BIT_ULL(32)
 #define HV_HYPERCALL_REP_COMP_MASK	GENMASK_ULL(43, 32)
+#define HV_HYPERCALL_RSVD1_MASK		GENMASK_ULL(47, 44)
 #define HV_HYPERCALL_REP_START_OFFSET	48
 #define HV_HYPERCALL_REP_START_MASK	GENMASK_ULL(59, 48)
+#define HV_HYPERCALL_RSVD2_MASK		GENMASK_ULL(63, 60)
+#define HV_HYPERCALL_RSVD_MASK		(HV_HYPERCALL_RSVD0_MASK | \
+					 HV_HYPERCALL_RSVD1_MASK | \
+					 HV_HYPERCALL_RSVD2_MASK)
 
 /* hypercall status code */
 #define HV_STATUS_SUCCESS			0
-- 
2.34.1.400.ga245620fadb-goog

