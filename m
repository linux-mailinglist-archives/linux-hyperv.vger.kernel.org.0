Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9F25B3ECC
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Sep 2019 18:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730969AbfIPQXI (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 16 Sep 2019 12:23:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42950 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730738AbfIPQXH (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 16 Sep 2019 12:23:07 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2EBE53B714
        for <linux-hyperv@vger.kernel.org>; Mon, 16 Sep 2019 16:23:07 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id o16so117619wru.10
        for <linux-hyperv@vger.kernel.org>; Mon, 16 Sep 2019 09:23:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hTif/hdyQ2dgFmG83XOhs3M15HFTZ4c2i4bvJhs3seA=;
        b=Qill7a8DpP8pEgcyvfmlsJQD4PvJGEr1QHvsGkQjlc1V4yg8IfZIT882ZoQpghzxFe
         rY48rssdkbLXeWKBbHkTMKPcXBeTq2JVZWEnr6VF+BIK5HyX418d9PtbNC21/ZhajkhZ
         G3b0aVDtTMuEUfTuigSsaklZlfPEBMCkbevi1GSJ+VJMTYACZTX2gwxUTpRPeZFAH3yg
         BPD+fibxNNlgbdYpORjxMxauDwpVTHWPDyk0kSI2Ye4i8WTL2ur+dz2w7WyCYU6A8+Qn
         //KCFUg6QK8Qv5Rf0ku25jj2zigF3UhmCqN/tP/wIrj+0lb6iyS+m6Xadz4jC5EbW6AL
         hFgA==
X-Gm-Message-State: APjAAAXGPWaOtsLXrHvmcua9OUw/hA9VvZmmfq/zh/ySAGmw0QhUEB+v
        vb13it+LHrXRx+C0eEhbF2TY+OSnDfCzDqoN1+NLGXt5o3nBEHYmuEO+MNPV12i7ihMQqEjQboP
        XRUMZjLI6EkTZTxBZPR88DZau
X-Received: by 2002:a7b:c3c6:: with SMTP id t6mr20516wmj.5.1568650985770;
        Mon, 16 Sep 2019 09:23:05 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwJ2BsBwbNvJMLRpYPdToi80JcADK8zG0+oHLr+0eXOrKGkWIoV4bSie2tXYamBJOS5FHSDNw==
X-Received: by 2002:a7b:c3c6:: with SMTP id t6mr20494wmj.5.1568650985442;
        Mon, 16 Sep 2019 09:23:05 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id q10sm78370575wrd.39.2019.09.16.09.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 09:23:04 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jim Mattson <jmattson@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Roman Kagan <rkagan@virtuozzo.com>
Subject: [PATCH 2/3] KVM: x86: hyper-v: set NoNonArchitecturalCoreSharing CPUID bit when SMT is impossible
Date:   Mon, 16 Sep 2019 18:22:57 +0200
Message-Id: <20190916162258.6528-3-vkuznets@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190916162258.6528-1-vkuznets@redhat.com>
References: <20190916162258.6528-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hyper-V 2019 doesn't expose MD_CLEAR CPUID bit to guests when it cannot
guarantee that two virtual processors won't end up running on sibling SMT
threads without knowing about it. This is done as an optimization as in
this case there is nothing the guest can do to protect itself against MDS
and issuing additional flush requests is just pointless. On bare metal the
topology is known, however, when Hyper-V is running nested (e.g. on top of
KVM) it needs an additional piece of information: a confirmation that the
exposed topology (wrt vCPU placement on different SMT threads) is
trustworthy.

NoNonArchitecturalCoreSharing (CPUID 0x40000004 EAX bit 18) is described in
TLFS as follows: "Indicates that a virtual processor will never share a
physical core with another virtual processor, except for virtual processors
that are reported as sibling SMT threads." From KVM we can give such
guarantee in two cases:
- SMT is unsupported or forcefully disabled (just 'disabled' doesn't work
 as it can become re-enabled during the lifetime of the guest).
- vCPUs are properly pinned so the scheduler won't put them on sibling
SMT threads (when they're not reported as such).

This patch reports NoNonArchitecturalCoreSharing bit in to userspace in the
first case. The second case is outside of KVM's domain of responsibility
(as vCPU pinning is actually done by someone who manages KVM's userspace -
e.g. libvirt pinning QEMU threads).

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/include/asm/hyperv-tlfs.h | 7 +++++++
 arch/x86/kvm/hyperv.c              | 4 +++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index af78cd72b8f3..989a1efe7f5e 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -170,6 +170,13 @@
 /* Recommend using enlightened VMCS */
 #define HV_X64_ENLIGHTENED_VMCS_RECOMMENDED		BIT(14)
 
+/*
+ * Virtual processor will never share a physical core with another virtual
+ * processor, except for virtual processors that are reported as sibling SMT
+ * threads.
+ */
+#define HV_X64_NO_NONARCH_CORESHARING                  BIT(18)
+
 /* Nested features. These are HYPERV_CPUID_NESTED_FEATURES.EAX bits. */
 #define HV_X64_NESTED_GUEST_MAPPING_FLUSH		BIT(18)
 #define HV_X64_NESTED_MSR_BITMAP			BIT(19)
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index fff790a3f4ee..9c187d16a9cd 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -23,6 +23,7 @@
 #include "ioapic.h"
 #include "hyperv.h"
 
+#include <linux/cpu.h>
 #include <linux/kvm_host.h>
 #include <linux/highmem.h>
 #include <linux/sched/cputime.h>
@@ -1864,7 +1865,8 @@ int kvm_vcpu_ioctl_get_hv_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid2 *cpuid,
 			ent->eax |= HV_X64_EX_PROCESSOR_MASKS_RECOMMENDED;
 			if (evmcs_ver)
 				ent->eax |= HV_X64_ENLIGHTENED_VMCS_RECOMMENDED;
-
+			if (!cpu_smt_possible())
+				ent->eax |= HV_X64_NO_NONARCH_CORESHARING;
 			/*
 			 * Default number of spinlock retry attempts, matches
 			 * HyperV 2016.
-- 
2.20.1

