Return-Path: <linux-hyperv+bounces-7568-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FA8C5A6ED
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Nov 2025 23:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B0D23BAA31
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Nov 2025 22:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997FA32AAB8;
	Thu, 13 Nov 2025 22:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jAI+VEn9"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198D832A3CA
	for <linux-hyperv@vger.kernel.org>; Thu, 13 Nov 2025 22:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763074603; cv=none; b=LgZNF27v1p5XZqcrOLNH2JoyJqZ6NziOwhJ/xsq/vcRcxc/tOHbxvD/1cCwZS6313b79rlnTPfbpN0SOabhdDWfB6StfJXJLlfwlHQxlFE7flPB/xfi0vDOqpx2rwfobJmOaklGspe7iM/h9Amc6W+a/m3RcBrEHn5weBzFDiME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763074603; c=relaxed/simple;
	bh=84mlhZ3JM5RfxlKomoAAeHn9Bvqc4zqHVGnlMIN+Dl0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uKdGuoOoOqNvEWCAmbMGdyBCmZkR26vyLzKBkzdb/GacBetFfVeSDcxXPgkrIRo2e6Sa+RkEcyWNjbeYKGJGx1SoeQGDWOQ3GZN56gt1WOTzVA/qwbjSfC0hflTobhf59lUOk7mrI2lbYnD5jYRvdz9QMoP/jaU+T62h0NmCil0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jAI+VEn9; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b630753cc38so2978068a12.1
        for <linux-hyperv@vger.kernel.org>; Thu, 13 Nov 2025 14:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763074601; x=1763679401; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=yAZ8dC0cSBzCHy+Gncv2WYa1BW9ysI8EoXwobyv3AdE=;
        b=jAI+VEn9/DCv7c9s80EI/zOj/Tvs3p5UzyZvFsejJTjus68hnNQtEZpGhY34vI2rJt
         M3diu0V2ar5rxDzXIw03inVQ/kAO+l2p0584qpwnhFENWyUMjRkxf/00aMTe/vaQSuIW
         OJz7Ksda6rjoqN1OF0eiEAp3gFrjJ20qsbJXMb715CK0zNKAzuEcuAKNyuNFlkOk7Kzs
         YcWgZy2g4LVe1jZZhqA8v/4zjTWYInc9SYAPQXBHsDgftaTEr9HRB1squX7RWYM8Yo6T
         QyFllCf7kPhOe/ZqMWktnCM7zncbg3DhofTIg/64XotUPRJJqGdf3/IOL1whi7U+/OHa
         NBfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763074601; x=1763679401;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yAZ8dC0cSBzCHy+Gncv2WYa1BW9ysI8EoXwobyv3AdE=;
        b=CBaYT66Pu3E/t+J4g65g8l3a2Tp8mMmohax7JWjalrPbVckzzTbnqngPMXUXknpqR9
         BzicZVyIkdGavOuXFdj66gtLzPElTpf7qvTQwzoj9K8nCpGuPiR8hOsyJfRB98H22Qpj
         bkNpv3t3NdPctWAzbRsmKJQmt021Dy9zr6l8gKpm6TO9EcEWsXfQL/gdRWfI8DI/pu0y
         zZ4gNiGQZSOIy7J9K+wU+y0P10FFT3i3F7aO6VI937Y9OrooZPAPc5cSB7NOnUIH1sFv
         3RTe3aYx6glVkhptykjkQdB1u0ukiYrVUm0Wha2lOuyLl0wEDFs+sYWQw4oMRjvqNJrD
         IuIw==
X-Forwarded-Encrypted: i=1; AJvYcCVN+SN8RKbs7ENLfJBYLgZF2s0rrz4M4/Sih6HgsTo04VZijdsLzrZElvfAEWONxj/dCsV5jV5EcncUXOA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXbbOSmhTVZ0M1hGxCwRPvRIhU+kBkZFUe9ehGoJsB1tw8d/uw
	6wZ7ORauo8ic8WA+SnwFRaaOFNSzJsWa6IiSvW+d/qudoF8ORaS/VIOk7U2JmwG8E+YXP36cAqb
	6AVt5Qg==
X-Google-Smtp-Source: AGHT+IF96SyhX4OSFYPPUcMMzzakOIf9y26xhAXkhopdVA6dBw1xWXKKHbc/n2cOWm2tylO2zP96XfNZ/fw=
X-Received: from pgdj7.prod.google.com ([2002:a05:6a02:5207:b0:bc5:3be0:b497])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3294:b0:342:5901:fd9f
 with SMTP id adf61e73a8af0-35ba16a47f6mr1429299637.28.1763074601451; Thu, 13
 Nov 2025 14:56:41 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 13 Nov 2025 14:56:20 -0800
In-Reply-To: <20251113225621.1688428-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251113225621.1688428-1-seanjc@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251113225621.1688428-9-seanjc@google.com>
Subject: [PATCH 8/9] KVM: SVM: Limit incorrect check on SVM_EXIT_ERR to
 running as a VM
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>
Cc: kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>
Content-Type: text/plain; charset="UTF-8"

Limit KVM's incorrect check for VMXEXIT_INVALID, a.k.a. SVM_EXIT_ERR, to
running as a VM, as detected by X86_FEATURE_HYPERVISOR.  The exit_code and
all failure codes, e.g. VMXEXIT_INVALID, are 64-bit values, and so checking
only bits 31:0 could result in false positives when running on non-broken
hardware, e.g. in the extremely unlikely scenario exit code 0xffffffffull
is ever generated by hardware.

Keep the 32-bit check to play nice with running on broken KVM (for years,
KVM has not set bits 63:32 when synthesizing nested SVM VM-Exits).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 31ee4f65dcc2..801dcfc64d0b 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -427,7 +427,10 @@ static __always_inline struct vcpu_svm *to_svm(struct kvm_vcpu *vcpu)
 
 static inline bool svm_is_vmrun_failure(u64 exit_code)
 {
-	return (u32)exit_code == (u32)SVM_EXIT_ERR;
+	if (cpu_feature_enabled(X86_FEATURE_HYPERVISOR))
+		return (u32)exit_code == (u32)SVM_EXIT_ERR;
+
+	return exit_code == SVM_EXIT_ERR;
 }
 
 /*
-- 
2.52.0.rc1.455.g30608eb744-goog


