Return-Path: <linux-hyperv+bounces-8100-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 61292CEAB2A
	for <lists+linux-hyperv@lfdr.de>; Tue, 30 Dec 2025 22:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C596530492B7
	for <lists+linux-hyperv@lfdr.de>; Tue, 30 Dec 2025 21:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E31931770B;
	Tue, 30 Dec 2025 21:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tQp1TfNE"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDBB3081A4
	for <linux-hyperv@vger.kernel.org>; Tue, 30 Dec 2025 21:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767129240; cv=none; b=TTwXYCSSUouccbmxRRAoRRZRghrhyDnb4JEA5USKOyBKxXwpht4AX5KKADqezgey+ok5TngqWNrX/waz6V0aDJcCTr/Nbhx1Y3d5PS2g4Q7gG1gejIK9HET52cxXRQPovxMfpa0tZea6AlcyNK5ywoMxARpi5C6mGNZUbd8TCQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767129240; c=relaxed/simple;
	bh=FtS6vDWiO9EDo/z8VoY1nvCPCfhD7nX6eEPGDJt96m0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qbKyBlqpuUhWrCV2vkt+AGIdo2/ni26ZY7raVj94XxDCRmlXAgURyR3PGXE2qi1R9K9CsBvpuOvHaMSMwXYbKH4Kua4ajYEUryS2i7exCUvi+ip8wwoUyHFCtbFfBLmvbY8YQbAm62GnUA9pUMAYAlW0/GDK50+nFcEf/0UQqsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tQp1TfNE; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-29f13989cd3so305133605ad.1
        for <linux-hyperv@vger.kernel.org>; Tue, 30 Dec 2025 13:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767129238; x=1767734038; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=wOA69MRBSxKnLZU9X2oOZa8j9xPVFywhN+aFtQXd8sE=;
        b=tQp1TfNEu2OkdrOL0mQ5V6KQ6KD9hiXFQJ3HP03B03weEn01SRLBf/S8CAgG5NFmx6
         brEE7bdF01CH9njEpwoK+k2BEUvVXGr9h7GThts8S6YMDjtqN4OYr32mwakAoKkmRQnm
         bqri2nm9OLUSqkwPUvYSmH3zkUuyi+JR+3B3lBqMoFZ6a5AP+Xp0LcH5jV0ka0bQdtFB
         POyGUvjTS1iJgOgI5lbXIOJdOeys5M/58r9vWDIzuN34g5g1PjEJQI+E8x0R5/kDY3PJ
         rVZBx0/2xFKQ0mr+iyF5OGyWsf3msa9YKvj9VvGxRtAEHdi7RMX1J8aUzH2zaE7HljN8
         9Hfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767129238; x=1767734038;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wOA69MRBSxKnLZU9X2oOZa8j9xPVFywhN+aFtQXd8sE=;
        b=rgnneIeb8yDdz2hV0MldIB+7bJ0YsS8HAW42X4Nv+HkRhxDjuFrnNu9TQadxz5tFp+
         /tWp6t/i0w9BZxt6EIXjvEcJwtp1igLjmqQqUg+5MdXpxUt2dJaFYwmXrvvr80HqaMtE
         aTNhoO36P2MffmLrKqsq2NVxA82eydyWOt3Wpaxw9rgt9ClVFP0iGnZMQbJm5kqvUDTc
         Wqd21gFwfCm7aciWFYZrpXqJnJrYkkG5tstaJ5Kz0GpoL02Z/dEwYZ+AXuAYiKtKEZYr
         OTrD2BBZDh/8lnt1tCYNIUfR8MmnbkX1WH1964cYFfjkiGVYEoT/lrbRFa0E1OUVW3kM
         ayEw==
X-Forwarded-Encrypted: i=1; AJvYcCXyxpsd9MyOvpm1Q+PMf8D9G1itTkLpvXFrAMjuxaOWJQCxTJOQKs3TYpLvj+3/PVAeOh61wvKIzL6oDxE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmCOdXAUj77PQjdRtcNkMuIc4r84dw8amYx4Dp2Cg0whZMhivx
	ivWa7RQePvUqyCk9U8jHcezyUOuIAp1gq1Vy2OWzjvfEG4sTs7/1i4qXHE36gBquv86MnzUPkNv
	nmFq0iw==
X-Google-Smtp-Source: AGHT+IGftgrWDxU9JRSkm0FiwGGoGvhG2Dx0NpSdcsxezbCl/FD/ZIEilFGQEh5s6/zxrFLBFLg9TgQMQQo=
X-Received: from pjuu16.prod.google.com ([2002:a17:90b:5870:b0:34c:2f52:23aa])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:290:b0:2a1:e19:ff5
 with SMTP id d9443c01a7336-2a2f273818fmr384080235ad.38.1767129237699; Tue, 30
 Dec 2025 13:13:57 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 30 Dec 2025 13:13:43 -0800
In-Reply-To: <20251230211347.4099600-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251230211347.4099600-1-seanjc@google.com>
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
Message-ID: <20251230211347.4099600-5-seanjc@google.com>
Subject: [PATCH v2 4/8] KVM: SVM: Filter out 64-bit exit codes when invoking
 exit handlers on bare metal
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>
Cc: kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>
Content-Type: text/plain; charset="UTF-8"

Explicitly filter out 64-bit exit codes when invoking exit handlers, as
svm_exit_handlers[] will never be sized with entries that use bits 63:32.

Processing the non-failing exit code as a 32-bit value will allow tracking
exit_code as a single 64-bit value (which it is, architecturally).  This
will also allow hardening KVM against Spectre-like attacks without needing
to do silly things to avoid build failures on 32-bit kernels
(array_index_nospec() rightly asserts that the index fits in an "unsigned
long").

Omit the check when running as a VM, as KVM has historically failed to set
bits 63:32 appropriately when synthesizing VM-Exits, i.e. KVM could get
false positives when running as a VM on an older, broken KVM/kernel.  From
a functional perspective, omitting the check is "fine", as any unwanted
collision between e.g. VMEXIT_INVALID and a 32-bit exit code will be
fatal to KVM-on-KVM regardless of what KVM-as-L1 does.

Reviewed-by: Yosry Ahmed <yosry.ahmed@linux.dev>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index e24bedf1fc81..1ffe922e95fd 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3443,8 +3443,22 @@ static void dump_vmcb(struct kvm_vcpu *vcpu)
 		sev_free_decrypted_vmsa(vcpu, save);
 }
 
-int svm_invoke_exit_handler(struct kvm_vcpu *vcpu, u64 exit_code)
+int svm_invoke_exit_handler(struct kvm_vcpu *vcpu, u64 __exit_code)
 {
+	u32 exit_code = __exit_code;
+
+	/*
+	 * SVM uses negative values, i.e. 64-bit values, to indicate that VMRUN
+	 * failed.  Report all such errors to userspace (note, VMEXIT_INVALID,
+	 * a.k.a. SVM_EXIT_ERR, is special cased by svm_handle_exit()).  Skip
+	 * the check when running as a VM, as KVM has historically left garbage
+	 * in bits 63:32, i.e. running KVM-on-KVM would hit false positives if
+	 * the underlying kernel is buggy.
+	 */
+	if (!cpu_feature_enabled(X86_FEATURE_HYPERVISOR) &&
+	    (u64)exit_code != __exit_code)
+		goto unexpected_vmexit;
+
 #ifdef CONFIG_MITIGATION_RETPOLINE
 	if (exit_code == SVM_EXIT_MSR)
 		return msr_interception(vcpu);
@@ -3471,7 +3485,7 @@ int svm_invoke_exit_handler(struct kvm_vcpu *vcpu, u64 exit_code)
 
 unexpected_vmexit:
 	dump_vmcb(vcpu);
-	kvm_prepare_unexpected_reason_exit(vcpu, exit_code);
+	kvm_prepare_unexpected_reason_exit(vcpu, __exit_code);
 	return 0;
 }
 
-- 
2.52.0.351.gbe84eed79e-goog


