Return-Path: <linux-hyperv+bounces-7564-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 50632C5A6DB
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Nov 2025 23:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BB46E4E5F76
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Nov 2025 22:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67295328B5C;
	Thu, 13 Nov 2025 22:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bkrMYktg"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D116C32860E
	for <linux-hyperv@vger.kernel.org>; Thu, 13 Nov 2025 22:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763074597; cv=none; b=pdajZJinEGvt/JWcyyi0ghoILKBIIGe+RbH+S4hkH7niLLZxB1GD5jLRPuPoA5cqYPs6qYwCKqxDUNzulpy1wHZuluF+M46Bz6tidXp2dSTBZTU6bzul0gdbk7xFFX6KXeHy+e20tKDZjDm1blJcoTadxC8BQBYECnhgEQMdLCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763074597; c=relaxed/simple;
	bh=3ZKH73v//RDZ3fRn2i/PSc16YVjKg39gkH1Xa11RzC8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WznjAkuO0pTTWOt2f3uGRl+M+UGuNtXcGg1ZDlDbwv+snBU8JaTI+0XlB1jYGOvd/aEw3xEIdcQrYO0+iXkpFBBIi43MWzQ47ZREmCf58hM8XnMSW81bxTaf+Z0FIgcxuEbU2xpf9kKcRkUWMvAf4PDmI5JiwoPqJffrFT1iFac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bkrMYktg; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-29848363458so33092835ad.2
        for <linux-hyperv@vger.kernel.org>; Thu, 13 Nov 2025 14:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763074595; x=1763679395; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=44sHkalx4c+buJJlySyLatvfmOk9JIz0iW1u4PfgOGQ=;
        b=bkrMYktguQLziZS8oZIiD2611kMJzuTmPUNSEk0JmR/GZ7jjvY4u9XSVlBNSVZxvTX
         IUTqURSqNPqBHZBKwH13iGTtOpIdl19ga9LzO2r857mHVF6c+ipQjC0StFkrQ6EKVuuw
         scPc0ewPzJywxNGeIQOLfpMuiTe+w4AbjU2ykKqAbbNURvMotvvATK6Q3kieGpWjjBDB
         PX5Rdx4khzyVx6rbLn+MDrolQ8UIE8Gbs2elfwThDqsE+QKz7Ni7hS4VR1vHF1jUw6By
         PUTDNpELRCKJSjNNpzhFYT+quA7/Qb+d+bi0ZE2IlEo2Iby+bXSx2l/uitKkpj0jtNOu
         GroA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763074595; x=1763679395;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=44sHkalx4c+buJJlySyLatvfmOk9JIz0iW1u4PfgOGQ=;
        b=awKqkOddUCsOz0H4NngiEFrxBhS+s3syQUxenrc9apFjg05dVWgjn+s48zmXtXUtoL
         cl58NF8eR4HAfaTdytBXbDNnAPqydn+CO+adJpvg5vaw7jl5ysvzxX+r8snNAyaXm1Kj
         VpBcR4h2AYIGPLniFajkr0KD0oJKoe/DEChP4BPdg+1/hXDABlOug52Bm6bXxG7YVcNj
         4IHXUra1MXITSViHZlGbJrXupPegmkKlcFAxwTzzao8dAhAzP/BG5BKqi3reyfU3Nsoy
         0wADLZTEz6TKecznbxzMHRCB9qE6odq+xN4NmhLtNidbIlf48xBzmqBtAEVWOXP7a1q4
         hIVQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4WtiQw2BzjoHbSAu+ZO6u0sS2H4nx29onvtsznvrhr3WKCiZTnksI2dR9S3+79sgWXdGhXUb6GfNyAmg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhVR46noJ32hHHElg+W0EFO+Y2PBhPAGJAO07FrRjYOBTUqDln
	AERvz/RrMos/woSpUqVzHylx53meiE+Cxrysk90UCl6B9cILAlY5aC/1nrQYGhvMvIwsCREETwd
	nQQzGxg==
X-Google-Smtp-Source: AGHT+IGqAKWqFoUFyf2m0vap9g7gkzKL0KXcEIHMGW0cbM1JyDMMiT3yzbCUGWEfKZvzY/3IrvdaWAPUMuQ=
X-Received: from pldr17.prod.google.com ([2002:a17:903:4111:b0:27e:dc53:d244])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f790:b0:297:f8dd:4d8e
 with SMTP id d9443c01a7336-2986a741b93mr7487325ad.30.1763074595173; Thu, 13
 Nov 2025 14:56:35 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 13 Nov 2025 14:56:16 -0800
In-Reply-To: <20251113225621.1688428-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251113225621.1688428-1-seanjc@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251113225621.1688428-5-seanjc@google.com>
Subject: [PATCH 4/9] KVM: SVM: Open code handling of unexpected exits in svm_invoke_exit_handler()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>
Cc: kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>
Content-Type: text/plain; charset="UTF-8"

Fold svm_check_exit_valid() and svm_handle_invalid_exit() into their sole
caller, svm_invoke_exit_handler(), as having tiny single-use helpers makes
the code unncessarily difficult to follow.  This will also allow for
additional cleanups in svm_invoke_exit_handler().

No functional change intended.

Suggested-by: Yosry Ahmed <yosry.ahmed@linux.dev>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 52b759408853..638a67ef0c37 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3433,23 +3433,13 @@ static void dump_vmcb(struct kvm_vcpu *vcpu)
 		sev_free_decrypted_vmsa(vcpu, save);
 }
 
-static bool svm_check_exit_valid(u64 exit_code)
-{
-	return (exit_code < ARRAY_SIZE(svm_exit_handlers) &&
-		svm_exit_handlers[exit_code]);
-}
-
-static int svm_handle_invalid_exit(struct kvm_vcpu *vcpu, u64 exit_code)
-{
-	dump_vmcb(vcpu);
-	kvm_prepare_unexpected_reason_exit(vcpu, exit_code);
-	return 0;
-}
-
 int svm_invoke_exit_handler(struct kvm_vcpu *vcpu, u64 exit_code)
 {
-	if (!svm_check_exit_valid(exit_code))
-		return svm_handle_invalid_exit(vcpu, exit_code);
+	if (exit_code >= ARRAY_SIZE(svm_exit_handlers))
+		goto unexpected_vmexit;
+
+	if (!svm_exit_handlers[exit_code])
+		goto unexpected_vmexit;
 
 #ifdef CONFIG_MITIGATION_RETPOLINE
 	if (exit_code == SVM_EXIT_MSR)
@@ -3468,6 +3458,11 @@ int svm_invoke_exit_handler(struct kvm_vcpu *vcpu, u64 exit_code)
 #endif
 #endif
 	return svm_exit_handlers[exit_code](vcpu);
+
+unexpected_vmexit:
+	dump_vmcb(vcpu);
+	kvm_prepare_unexpected_reason_exit(vcpu, exit_code);
+	return 0;
 }
 
 static void svm_get_exit_info(struct kvm_vcpu *vcpu, u32 *reason,
-- 
2.52.0.rc1.455.g30608eb744-goog


