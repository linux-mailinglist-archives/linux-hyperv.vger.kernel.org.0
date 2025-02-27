Return-Path: <linux-hyperv+bounces-4090-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9D9A47232
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 Feb 2025 03:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE10A3B2939
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 Feb 2025 02:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7291922D4;
	Thu, 27 Feb 2025 02:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NYBCZS58"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C351B6CEC
	for <linux-hyperv@vger.kernel.org>; Thu, 27 Feb 2025 02:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740622754; cv=none; b=rweN16V6iINU7v1DOrxxMrBL/Exk+XHklQlnumS+crYARzj5J1NeSHS1O0pQGO8ArtRvcnfYy1ASZNBAy0DCHt/HYMNrt4XcRAVN9JAe5wh4Du1PS3gNh9MU72vQxnt2G+IGIuiYOT21Bg8oO+850MmWVuB8XSDYt9K7bxz9yOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740622754; c=relaxed/simple;
	bh=zouDyKCvgpfKjJTRdNmQrbmUt1upitIlri45/tL/V2s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=S+o6c4qcnBLJVUT7IJabirKFA1Me0HAr0U0o0poOYoo77YpoiW/0nHeXBpkjGWfn+ux9C4kyyCGSiw7N8YFowZ6J9yvw13flBsuZCMlHRKCvnEZE8hLjwZmMBnVJ9r8Cfz0lYQSV1iz3pm3rMzV7wt7b+yASy9PnWhUXvHYebX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NYBCZS58; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fe8c5dbdb0so1061061a91.3
        for <linux-hyperv@vger.kernel.org>; Wed, 26 Feb 2025 18:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740622752; x=1741227552; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=JV0vL5ay0SjXSCwSvRRqMw5uYQ06F8yr+AS2fSIuB98=;
        b=NYBCZS58L0f/9PeWx7lqjHczttpcvhByhEy6/htzrG7ZDmbRs4hbvRKAcpiViwVFkp
         z/ACXB4U3NN5K5CSAcZTmLbUQETJVhXMbu6mKpoBpDewcv9usu16GoOTYsAiaBEUzNOk
         bW8f5iTVnyfNMEHPxcrkJ24qAJfi9rIocHPwjjklffa3yD7/2WExma/gQ/mT50f/Y4Jk
         XyZWkX3qHgOMVIYeOay1xgirs2AyZJUmScRp6r+AG+/UpKpXxKGi6VjNKGE3Q/t2OMhC
         JKXwadCWKCDJ2QXP7DkiIHl0BGP9c4W3B/+pVyY2qBPHf1oYQ9aoieGyGgLdZ8KvT72E
         ldXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740622752; x=1741227552;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JV0vL5ay0SjXSCwSvRRqMw5uYQ06F8yr+AS2fSIuB98=;
        b=M9wC8N1FUPi6m9waynCQkR3lDvxBP0MH/0CQb1G+0dpD+Uzva8d5rs97PRuTo8ovF6
         BCOQRyP7wUsio8rQxeqWWqBPRvAJOP54FG1UrH8qOrpqgHvQ6yfH1SvqcBGrCWIyd0eS
         vZK+XCMxiDngGQDX5C8DXLUSsWGQ1543fsarVa4gKc9EoZGK/H6sO1qWERvrW2nwicK/
         zKGJluoZhQ33UwlZIAg2hRju0oxclkm53LP7lusSjAE635qJK/2lRmr2tchgcm0/3ZVi
         LiSe0kFni4bho1bbdID1UU4Pg/oOn/jRTpJHBQpaj7wRt7+ELm9KvvP/I+khVvkmMue0
         pMcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWo1nCn5N7riCXTHy4M1/jH4FyqWJHh6eqmA6+Q1njGoBMDv8uRjQJXSGW+EInlp2KkKi7XYZHSvfCOK+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCMANzfgcLbE64zlhMIKvxHI1DdjoSi4xNqgPsRpewovXzon3E
	BSrkvuOhAjcRByPjihbgCtPMMdUglbUcpU6OLTTZt91k/rJwxN9O3PW/HrJVWc1Hry4eHkAAQ/q
	SJQ==
X-Google-Smtp-Source: AGHT+IEvNph7CiMpObG1u+jVz8JxqMtO0a8+Wef5S19XtPgcpuEdHq4SZt8ZBvsmjyd64opTzInKcYcJX7E=
X-Received: from pjbsw14.prod.google.com ([2002:a17:90b:2c8e:b0:2fc:11a0:c546])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3b48:b0:2fc:9967:acd8
 with SMTP id 98e67ed59e1d1-2fe7e3b327fmr9422757a91.33.1740622751672; Wed, 26
 Feb 2025 18:19:11 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Feb 2025 18:18:21 -0800
In-Reply-To: <20250227021855.3257188-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250227021855.3257188-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250227021855.3257188-6-seanjc@google.com>
Subject: [PATCH v2 05/38] x86/sev: Move check for SNP Secure TSC support to tsc_early_init()
From: Sean Christopherson <seanjc@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Juergen Gross <jgross@suse.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Ajay Kaher <ajay.kaher@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	John Stultz <jstultz@google.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-hyperv@vger.kernel.org, xen-devel@lists.xenproject.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>
Content-Type: text/plain; charset="UTF-8"

Move the check on having a Secure TSC to the common tsc_early_init() so
that it's obvious that having a Secure TSC is conditional, and to prepare
for adding TDX to the mix (blindly initializing *both* SNP and TDX TSC
logic looks especially weird).

No functional change intended.

Cc: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/coco/sev/core.c | 3 ---
 arch/x86/kernel/tsc.c    | 3 ++-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index e6ce4ca72465..dab386f782ce 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -3284,9 +3284,6 @@ void __init snp_secure_tsc_init(void)
 {
 	unsigned long long tsc_freq_mhz;
 
-	if (!cc_platform_has(CC_ATTR_GUEST_SNP_SECURE_TSC))
-		return;
-
 	setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
 	setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
 
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index d65e85929d3e..6a011cd1ff94 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1563,7 +1563,8 @@ void __init tsc_early_init(void)
 	if (is_early_uv_system())
 		return;
 
-	snp_secure_tsc_init();
+	if (cc_platform_has(CC_ATTR_GUEST_SNP_SECURE_TSC))
+		snp_secure_tsc_init();
 
 	if (!determine_cpu_tsc_frequencies(true))
 		return;
-- 
2.48.1.711.g2feabab25a-goog


