Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44F5544063F
	for <lists+linux-hyperv@lfdr.de>; Sat, 30 Oct 2021 02:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbhJ3AKv (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 29 Oct 2021 20:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbhJ3AKt (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 29 Oct 2021 20:10:49 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C52C061766
        for <linux-hyperv@vger.kernel.org>; Fri, 29 Oct 2021 17:08:20 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id x68-20020a25ce47000000b005c198858e6bso16243466ybe.21
        for <linux-hyperv@vger.kernel.org>; Fri, 29 Oct 2021 17:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=wz/8MevGpjzdvDnhVpyJBCzungFskdSkdImKXwiMg/I=;
        b=bEKHvWxbIHcoKBI3HYXYgxoMzuvtHQ4hSF2tjPjE9oY6sYXgcf/CR7jIWnZ9yuullK
         cx2pF2IsS9Qck8zL+Vc6lJTis8cqdU2hi7yp6/AN8YyqpU0kG/cnBNsqc1wh06jN6/74
         S043k1zNIu3960zI6J+IBN1PbEHk1Xq1eC1VesmERCMxBsP6DZWvQJKI5ncbxTLdX9lR
         sgEEn+BU0NFtwgx0TQ67KXRiayHQTEGKvjufojV+Y8399lRB9avT3RGCPpHIkRj/os0E
         /2rGZM6ilNgD4YV2egIr45jpjmJSDoayQuWPCN5BTpJkoUWx08OPF9/mRErLLYYY1Qwv
         lxAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=wz/8MevGpjzdvDnhVpyJBCzungFskdSkdImKXwiMg/I=;
        b=rJT59DvZNicWQ8IN9eZHx9HOQbKmXjbwSR52f3t6vZsMAADVZU3oC7j+Vu4iMQvMLz
         SgQNEd0IDJaE6VIlN78jfejaqj0p7mo77hZ8gUj28AM7JoOQDenqDkjFNx6xZo7ARgaV
         lNGnZ2WQyePG3gc5L0eTwJgPQ6j+251ji6bkJQDN5xK/4FPri0iYvXFxuC7q7bjLnS+6
         IKxBm3VU0+c4XiFujJBqWl+cv/uGGFxAaHCTmM4RhBl2S7UdoBCK1W/P1jm8qcfuB4x/
         fNKy0ZUPQz77Mmnc76ZeUjUt5+2Rt7suaX8M7ooA3oaYTWoFmzw+0fhCCpU0sfguRrdh
         f92w==
X-Gm-Message-State: AOAM530iDKFX6nICuwaHz32ZAeGsYqesOqmsRevgy5vCTe7CwoKA1D+u
        +ZtiDFeMlhPFCzAtMAAa3KoRudwx4VE=
X-Google-Smtp-Source: ABdhPJznz7gJyFZdtvPE0xpriSkDXdUYVnYC/fWXWGFXsPjlMb/ptep74ulU5Srf6wPrCsfn39qX8VSY3Ng=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:ce6:9e5f:4ab5:a0d2])
 (user=seanjc job=sendgmr) by 2002:a25:bace:: with SMTP id a14mr15481635ybk.283.1635552499540;
 Fri, 29 Oct 2021 17:08:19 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 29 Oct 2021 17:07:56 -0700
In-Reply-To: <20211030000800.3065132-1-seanjc@google.com>
Message-Id: <20211030000800.3065132-5-seanjc@google.com>
Mime-Version: 1.0
References: <20211030000800.3065132-1-seanjc@google.com>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
Subject: [PATCH v2 4/8] KVM: x86: Add a helper to get the sparse VP_SET for
 IPIs and TLB flushes
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

Add a helper, kvm_get_sparse_vp_set(), to handle sanity checks related to
the VARHEAD field and reading the sparse banks of a VP_SET.  A future
commit to reduce the memory footprint of sparse_banks will introduce more
common code to the sparse bank retrieval.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/hyperv.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index e68931ed27f6..3d0981163eed 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -1750,10 +1750,19 @@ struct kvm_hv_hcall {
 	sse128_t xmm[HV_HYPERCALL_MAX_XMM_REGISTERS];
 };
 
+static u64 kvm_get_sparse_vp_set(struct kvm *kvm, struct kvm_hv_hcall *hc,
+				 u64 *sparse_banks, gpa_t offset)
+{
+	if (hc->var_cnt > 64)
+		return -EINVAL;
+
+	return kvm_read_guest(kvm, hc->ingpa + offset, sparse_banks,
+			      hc->var_cnt * sizeof(*sparse_banks));
+}
+
 static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc, bool ex)
 {
 	int i;
-	gpa_t gpa;
 	struct kvm *kvm = vcpu->kvm;
 	struct hv_tlb_flush_ex flush_ex;
 	struct hv_tlb_flush flush;
@@ -1830,13 +1839,9 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc, bool
 			goto do_flush;
 		}
 
-		if (hc->var_cnt > 64)
-			return HV_STATUS_INVALID_HYPERCALL_INPUT;
-
-		gpa = hc->ingpa + offsetof(struct hv_tlb_flush_ex,
-					   hv_vp_set.bank_contents);
-		if (unlikely(kvm_read_guest(kvm, gpa, sparse_banks,
-					    hc->var_cnt * sizeof(sparse_banks[0]))))
+		if (kvm_get_sparse_vp_set(kvm, hc, sparse_banks,
+					  offsetof(struct hv_tlb_flush_ex,
+						   hv_vp_set.bank_contents)))
 			return HV_STATUS_INVALID_HYPERCALL_INPUT;
 	}
 
@@ -1933,14 +1938,9 @@ static u64 kvm_hv_send_ipi(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc, bool
 		if (!hc->var_cnt)
 			goto ret_success;
 
-		if (hc->var_cnt > 64)
-			return HV_STATUS_INVALID_HYPERCALL_INPUT;
-
-		if (kvm_read_guest(kvm,
-				   hc->ingpa + offsetof(struct hv_send_ipi_ex,
-							vp_set.bank_contents),
-				   sparse_banks,
-				   hc->var_cnt * sizeof(sparse_banks[0])))
+		if (kvm_get_sparse_vp_set(kvm, hc, sparse_banks,
+					  offsetof(struct hv_send_ipi_ex,
+						   vp_set.bank_contents)))
 			return HV_STATUS_INVALID_HYPERCALL_INPUT;
 	}
 
-- 
2.33.1.1089.g2158813163f-goog

