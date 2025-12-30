Return-Path: <linux-hyperv+bounces-8099-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FE7CEAB1E
	for <lists+linux-hyperv@lfdr.de>; Tue, 30 Dec 2025 22:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B111303C20A
	for <lists+linux-hyperv@lfdr.de>; Tue, 30 Dec 2025 21:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401A4306B08;
	Tue, 30 Dec 2025 21:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="swrQSEnX"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82B125C80D
	for <linux-hyperv@vger.kernel.org>; Tue, 30 Dec 2025 21:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767129238; cv=none; b=ZB6abEvhBEVcqaBVOgGE9Gdq25/i/hUbkaSVK9kHDnYf2soRGTgu+y/sBWfu8UiSDItqUgos+uzEAOgknE9ffhPqyLsoacQ8pNhdPnStILNZ5/usV5ZU6qMqkn61hSgF2JCzUELTgNPsg9bNEtzNWHfjC/1ZLJPSOhhV+xKFYVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767129238; c=relaxed/simple;
	bh=dFYvwKO0rAM5gd+DQa6wT7749+Cjr6pisryKGAR8XHI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UG/MUzGYxCHSMwKp4Zbbajg33/GjeEY7rLhKpUZwhgmsJmpsz1PIm5LXiUgAARGScl2az3YQ9wntrdG+stbHJskypHaU0T1WXgu5p9x0GSu4ELhEu10xQX2Wvl2sHuS68RCmfWVlH2k+A8M0PLfap8f0bUW4HiWN1MrAuC2HdtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=swrQSEnX; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-29f26fc6476so168737495ad.1
        for <linux-hyperv@vger.kernel.org>; Tue, 30 Dec 2025 13:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767129236; x=1767734036; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=OP9hotpCQrsVZqE8v5eRxWNMJZgi8k5mDCW7kmyDFTA=;
        b=swrQSEnX12C3++X4mU5FO25yCDLIaVsgFNv8gPCgdAsBePsTO9fQgoBerVBSje06y5
         STgaKGOWQdDhyCvrl7lNTsXlGWFUBVZDh3l0x2K0UQLiZoZZoGPLZEbell3P5Hkb05Jx
         yEPRA6X6o9ZejCPZuoddf2kcUYmZe572ThMN1fh6QA5/z8XxrkVnED/+35bQMu79jNBp
         +wdlox8HSwv2SyXKaMneaVnevTSVomvjUOY8RG7CaCtiVXWy6xC0xbnTnGHZ2XSZLROb
         8xSynvtZxkfWdcpOpQl6fP4MjVLH7B1CdSD8aLIW7GAQOEsW0gnQpHyzVv0nUC/5loEl
         Jmtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767129236; x=1767734036;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OP9hotpCQrsVZqE8v5eRxWNMJZgi8k5mDCW7kmyDFTA=;
        b=k3JSh5w8Ifych94+uzA0PSnfVzbT/XcAvd/YdsTLPo3h5AvGWa7DdOUcm+2I78ma6P
         tOxh34sa/t8ynxPdCAIvLYD7CLH84dWf/X+1vWMmKyTr+wZAuUkfqZip0ijm3nTweOtg
         zT/OCSyzXneUo+4nQnKJX3k9qwIjwYjA9So6LZ1QTzsdq1xz6hCi9vrXsyA6x0wbcRVK
         mjL2tDmpCwGHbT7mUWq6KuW40Pbc4WnHmZSASKedo1YszB7jKB1T23cNvKDKGZXGh8UU
         HFEB5H1Ivfql+cVSQvGFmzrjvNY8RDUZEsXBF2jiiAYTFP3qS0Bmtrx48mnfQCa80ggz
         GD9g==
X-Forwarded-Encrypted: i=1; AJvYcCWXKyY1fntkyAgIwN1TpuaNG9rkKszxzMKegujZ7jsJtToa8KL4IB1oRwetf0wdtht+3cRZsSDAL6IiLMU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx+bk+wcbwczsHxjVnW59XB+e+ILFL7spfRhTPayrBtl7JUB8I
	7OgKiac8XGS+uSZFQj93SGk1UIymG0xX6cnZQM9VrW/3TnsQTcmqmRj1i6PSmT2agnHbcFbLdO+
	U0g8k2g==
X-Google-Smtp-Source: AGHT+IGUJEnlpUD6Gd1YvivFP9uFX0/uZZ/iPrK157AWfRyC2+k/meCq+u7wH7O0QvzOvD9z3tsbRw5bG4o=
X-Received: from pjbqb12.prod.google.com ([2002:a17:90b:280c:b0:34a:4aa7:b774])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f78d:b0:2a0:c35c:572e
 with SMTP id d9443c01a7336-2a2f2836480mr346664485ad.30.1767129235953; Tue, 30
 Dec 2025 13:13:55 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 30 Dec 2025 13:13:42 -0800
In-Reply-To: <20251230211347.4099600-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251230211347.4099600-1-seanjc@google.com>
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
Message-ID: <20251230211347.4099600-4-seanjc@google.com>
Subject: [PATCH v2 3/8] KVM: SVM: Check for an unexpected VM-Exit after
 RETPOLINE "fast" handling
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>
Cc: kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>
Content-Type: text/plain; charset="UTF-8"

Check for an unexpected/unhandled VM-Exit after the manual RETPOLINE=y
handling.  The entire point of the RETPOLINE checks is to optimize for
common VM-Exits, i.e. checking for the rare case of an unsupported
VM-Exit is counter-productive.  This also aligns SVM and VMX exit handling.

No functional change intended.

Reviewed-by: Yosry Ahmed <yosry.ahmed@linux.dev>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index a523011f0923..e24bedf1fc81 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3445,12 +3445,6 @@ static void dump_vmcb(struct kvm_vcpu *vcpu)
 
 int svm_invoke_exit_handler(struct kvm_vcpu *vcpu, u64 exit_code)
 {
-	if (exit_code >= ARRAY_SIZE(svm_exit_handlers))
-		goto unexpected_vmexit;
-
-	if (!svm_exit_handlers[exit_code])
-		goto unexpected_vmexit;
-
 #ifdef CONFIG_MITIGATION_RETPOLINE
 	if (exit_code == SVM_EXIT_MSR)
 		return msr_interception(vcpu);
@@ -3467,6 +3461,12 @@ int svm_invoke_exit_handler(struct kvm_vcpu *vcpu, u64 exit_code)
 		return sev_handle_vmgexit(vcpu);
 #endif
 #endif
+	if (exit_code >= ARRAY_SIZE(svm_exit_handlers))
+		goto unexpected_vmexit;
+
+	if (!svm_exit_handlers[exit_code])
+		goto unexpected_vmexit;
+
 	return svm_exit_handlers[exit_code](vcpu);
 
 unexpected_vmexit:
-- 
2.52.0.351.gbe84eed79e-goog


