Return-Path: <linux-hyperv+bounces-4089-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 252F8A4722E
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 Feb 2025 03:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FD6B1887785
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 Feb 2025 02:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24151A5BAD;
	Thu, 27 Feb 2025 02:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ncjvrqUj"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAE21B21AC
	for <linux-hyperv@vger.kernel.org>; Thu, 27 Feb 2025 02:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740622752; cv=none; b=qQHkF8CxumojtbYtBAvVVh8LVBGYRXlZWGy35jT3l4PDf0d29X9ZfAif+25zivoyBpHSiP220dqVP27F9Ps326VBkzwFZGg8MM1eOtWAQZ1r6kRelDBgS3DKVnNwcdQ7N5sOjsFBYfkAbn8MqGRv9HjubrIJinLchkcTUS/IryI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740622752; c=relaxed/simple;
	bh=cbbEYbCk5kmrOnFY4+pyu6dZHx8scVaupy5RtKUOy+Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lFynxlUWw0N+OegXqPba1EtfO2WUp+LZC7bAE1Hbh2iBhVEYTF3JKc6LUDO0RLWtmnLJ/mSh5BxrUTUGc6OecxfVug1/5qVG7jcv40oxOPcrgl+lkPacBUdQSmkwsib/2TyhKXeTD6D5kmuzlWRM/c/XsK1l973jTEgEGvTXqFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ncjvrqUj; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fe8fdfdd94so1107579a91.0
        for <linux-hyperv@vger.kernel.org>; Wed, 26 Feb 2025 18:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740622750; x=1741227550; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=HbJ/1jLoPDWkVBe7cDWaMugTDenciqtu5nrTgQ9Zvm0=;
        b=ncjvrqUjmwekXY/o6eo006FvZWNuLjcP7sMTBFtsvpzy+wYAIYQmiUVOGEesPBXkgk
         qi8lChh/EZIbByPRtylkt5u29R8AVGqX3i65f/Oe79ryIK1SY4GA82w14jZFUp3IbDDQ
         8FMOcu35hbdaLFWwFdVarqPuOHJY/s6oIGMvgBAoaUWcOFpD/xONrY2JWODhMmKBGGfY
         IlBDfDsysZ88OeBO1xK4XmvE8gUYGdBPunuO+cYQNY9cuIo32nmNdCnhzYDIyXGryHzk
         qIMgsmmfDJB68KhtxLWgHSkwsaZ8VdWlfyjFUU/gzDJDzJxrO0NSDuLzetvZDnhl9jeD
         9LWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740622750; x=1741227550;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HbJ/1jLoPDWkVBe7cDWaMugTDenciqtu5nrTgQ9Zvm0=;
        b=KqgTY3oNou6SnVu8BGiGv8ixJ/pDCPjPPUrJUfAEt9ja8nE75ajmTrUJLDw9zKKJcN
         23qsSNyMf6uKylXzIFi0mR28yr4re/quOICfVMWpql0UZetgjN45odtZ/2f29yDKjQfy
         jyGk+xvCEAmV6j8HAoW0HFvPrzsKUubuXq1g9Adl+TiM8EwnuHwX+RIOcHojpH7PJ6bS
         /2MozouQIdIGyfBRrTothWCeAbUhxJ2UKj6r58toC6ag7HT8aplMT+wOatUlQLKAWsVu
         l6O391OMKSh8pOl7vZSFsAS31FWWE3CeICNqUDK8KmLK6bfj4tLCZ+F59zGGrVVt+eKM
         OL0g==
X-Forwarded-Encrypted: i=1; AJvYcCWcGbVU6Bv7Vmxb28T7j1Y6YZh+x/xR3kHT5UdLz1fg34++NN7FlFeEEmErRFSWk6rmDK215KN42iiMk5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFLnZmGaGTDtpfGYYIwpEJjNjXtEmiWhbj2OlObwZP2oUlZsoi
	9joD5fCfIAK5TSaWtVViifNqcWDYIJusLUF/JWzaeEX0GY51F+vCpuf4nVttt62Lmm2dJyODjlV
	DxQ==
X-Google-Smtp-Source: AGHT+IFmgEsUJJ1z3bRk5Nf8mtm9mdRWiQdO+4qbvCwBd/hyjI3jP5eNnlt+3d6bfd4x/QDsZrTqSfxiFQY=
X-Received: from pjbsw3.prod.google.com ([2002:a17:90b:2c83:b0:2fa:15aa:4d2b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:56cc:b0:2f1:2fa5:1924
 with SMTP id 98e67ed59e1d1-2fe7e39f2afmr7133368a91.26.1740622749803; Wed, 26
 Feb 2025 18:19:09 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Feb 2025 18:18:20 -0800
In-Reply-To: <20250227021855.3257188-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250227021855.3257188-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250227021855.3257188-5-seanjc@google.com>
Subject: [PATCH v2 04/38] x86/sev: Mark TSC as reliable when configuring
 Secure TSC
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

Move the code to mark the TSC as reliable from sme_early_init() to
snp_secure_tsc_init().  The only reader of TSC_RELIABLE is the aptly
named check_system_tsc_reliable(), which runs in tsc_init(), i.e.
after snp_secure_tsc_init().

This will allow consolidating the handling of TSC_KNOWN_FREQ and
TSC_RELIABLE when overriding the TSC calibration routine.

Cc: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/coco/sev/core.c      | 2 ++
 arch/x86/mm/mem_encrypt_amd.c | 3 ---
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 684cef70edc1..e6ce4ca72465 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -3288,6 +3288,8 @@ void __init snp_secure_tsc_init(void)
 		return;
 
 	setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
+	setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
+
 	rdmsrl(MSR_AMD64_GUEST_TSC_FREQ, tsc_freq_mhz);
 	snp_tsc_freq_khz = (unsigned long)(tsc_freq_mhz * 1000);
 
diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.c
index b56c5c073003..774f9677458f 100644
--- a/arch/x86/mm/mem_encrypt_amd.c
+++ b/arch/x86/mm/mem_encrypt_amd.c
@@ -541,9 +541,6 @@ void __init sme_early_init(void)
 	 * kernel mapped.
 	 */
 	snp_update_svsm_ca();
-
-	if (sev_status & MSR_AMD64_SNP_SECURE_TSC)
-		setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
 }
 
 void __init mem_encrypt_free_decrypted_mem(void)
-- 
2.48.1.711.g2feabab25a-goog


