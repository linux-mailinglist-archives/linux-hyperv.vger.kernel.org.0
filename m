Return-Path: <linux-hyperv+bounces-7561-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F74C5A696
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Nov 2025 23:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3A2404E7D0B
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Nov 2025 22:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B97D327210;
	Thu, 13 Nov 2025 22:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sPElYpZ5"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13D8326945
	for <linux-hyperv@vger.kernel.org>; Thu, 13 Nov 2025 22:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763074593; cv=none; b=lurZ2xKHSN6lQiuukYmTtORkepJ2SqTpQObq78Be5vk88Rm9B+aMDUx1jNCm1CcNj1/rQcJDZG05l6sJ3R84ONAMY2BxPzfRM08RcpHBwbV3n88NrLpW50a6gVDGUwXCTRHUoDiFOAqkTpcOaYUaUyP7+d44sDoxc1T86kpXmgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763074593; c=relaxed/simple;
	bh=DZnTVcVd7ilWEk7QprLP8HYWZGe/PyhrQBrHuLnfjVw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mlcEFDFK/ShWyUmlA7bRjUOT4aMfzBlRq1FCcIlMggl4Urz2zLfjZapVYc4PvSgDMBtTC3SxD+4ScbW/pJpMXNu1IJx8SQQTEtnjRClNnUx29xF9mUwj1vASUrlc3S7j79oTCaf9I/GyY81lVsma0hvOjzE7TMSnH866hVqCipM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sPElYpZ5; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3416dc5754fso1867599a91.1
        for <linux-hyperv@vger.kernel.org>; Thu, 13 Nov 2025 14:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763074590; x=1763679390; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=BxKLVgWi122XtoiJoBFjxbdILt6Adpgcci0Yx4/UOzI=;
        b=sPElYpZ5qbvV7CgEjpxR2Dy+Yl7szuBZgwNYaWy7bX08vGSH4hqLRjN8hCBCmGFA6E
         ViaUerATWkBPozqP8UG4ROfuD4fUzQ4HN7Y+61kXldp6XSMu36u/SgM+soTLymGDemlx
         6rV00Rfozndc+gqSNdJM2XdTNuku/sU9KDTxEmusKUT5PqCwPk1NCMMWlnWosAw7+9Ak
         BRz4NRJi4Aphhbo1FFUy01HDjmrLpnuscxbxa/i1GmbbKEinTZcjDRcC/w4ppfODqBJX
         yY5irAT5Pxb2w4V+dEN6A2OGa4UdRWgG2BQ9bXhMI+vZpIW5WtFwAAiVz01YYnO8IaUq
         nA4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763074590; x=1763679390;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BxKLVgWi122XtoiJoBFjxbdILt6Adpgcci0Yx4/UOzI=;
        b=oBVPrzR6JK+AEqTHuv9eutUv/UmfJmK/sKeVJ5XhG0ozxck5OXx+ZhPsRA3aWYVygD
         jGDaHi13wjDc4O564u86iOHCcft/+gcscY+aQEmrlSVpfJPda1OMBGgQYyUIFPLHxwLZ
         c4qcv2cLFQ1TB75DKYbjwa7Ah3HoSDXzl2PnNGWQgGHZAnIPefC12s4RI+ap4CIQ4QJD
         rYb7gcAOFXoGKD1VJztIMu4jZjwHTeHUO7jyVqjSSEHAgH9yvvX0yd5bWYW+S29VNxfV
         HDrr1ovr/rqNOSEp73JjVJeX6aLRqZYX2o8KwmhjriwpvFmgekdqvQJolTRfiuCElhR3
         3ABg==
X-Forwarded-Encrypted: i=1; AJvYcCVDbUR4aYpQT55TPiFj1DJyWsP8kKfmwDJVbj9z/u5HBtVie11oebz/npNHfTcKe9aKDJ8mMbCP4tssZ/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzkEQAqFLtY0Vk2GU6GGiBoO3n9Df9Sz8aY6kOL9K2lgQVCa2j
	zM1BlIKjMpJsAki2lncM3DjFwz5/2BG4eimoR/eTB6+gFJiWj+OtvoLkTkMDtCJHPdLxRG6TCdd
	JfG7evQ==
X-Google-Smtp-Source: AGHT+IFiv3A2MIePSw/tKTb0y96BVRTrr/TBLsOXY9EWmbc08jEkv0VCYdfjj5l0yUt5Qx95CRl430wU9PY=
X-Received: from pjbgw11.prod.google.com ([2002:a17:90b:a4b:b0:343:641d:e8c3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4c48:b0:341:2b78:61b8
 with SMTP id 98e67ed59e1d1-343fa637866mr946508a91.20.1763074590204; Thu, 13
 Nov 2025 14:56:30 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 13 Nov 2025 14:56:13 -0800
In-Reply-To: <20251113225621.1688428-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251113225621.1688428-1-seanjc@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251113225621.1688428-2-seanjc@google.com>
Subject: [PATCH 1/9] KVM: nSVM: Clear exit_code_hi in VMCB when synthesizing
 nested VM-Exits
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>
Cc: kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>
Content-Type: text/plain; charset="UTF-8"

Explicitly clear exit_code_hi in the VMCB when synthesizing "normal"
nested VM-Exits, as the full exit code is a 64-bit value (spoiler alert),
and all exit codes for non-failing VMRUN use only bits 31:0.

Cc: Jim Mattson <jmattson@google.com>
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c | 2 ++
 arch/x86/kvm/svm/svm.h | 7 ++++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index fc42bcdbb520..7ea034ee6b6c 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2433,6 +2433,7 @@ static bool check_selective_cr0_intercepted(struct kvm_vcpu *vcpu,
 
 	if (cr0 ^ val) {
 		svm->vmcb->control.exit_code = SVM_EXIT_CR0_SEL_WRITE;
+		svm->vmcb->control.exit_code_hi = 0;
 		ret = (nested_svm_exit_handled(svm) == NESTED_EXIT_DONE);
 	}
 
@@ -4608,6 +4609,7 @@ static int svm_check_intercept(struct kvm_vcpu *vcpu,
 	if (static_cpu_has(X86_FEATURE_NRIPS))
 		vmcb->control.next_rip  = info->next_rip;
 	vmcb->control.exit_code = icpt_info.exit_code;
+	vmcb->control.exit_code_hi = 0;
 	vmexit = nested_svm_exit_handled(svm);
 
 	ret = (vmexit == NESTED_EXIT_DONE) ? X86EMUL_INTERCEPTED
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index c2acaa49ee1c..253a8dca412c 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -763,9 +763,10 @@ int nested_svm_vmexit(struct vcpu_svm *svm);
 
 static inline int nested_svm_simple_vmexit(struct vcpu_svm *svm, u32 exit_code)
 {
-	svm->vmcb->control.exit_code   = exit_code;
-	svm->vmcb->control.exit_info_1 = 0;
-	svm->vmcb->control.exit_info_2 = 0;
+	svm->vmcb->control.exit_code	= exit_code;
+	svm->vmcb->control.exit_code_hi	= 0;
+	svm->vmcb->control.exit_info_1	= 0;
+	svm->vmcb->control.exit_info_2	= 0;
 	return nested_svm_vmexit(svm);
 }
 
-- 
2.52.0.rc1.455.g30608eb744-goog


