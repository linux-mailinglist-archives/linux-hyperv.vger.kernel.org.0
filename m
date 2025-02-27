Return-Path: <linux-hyperv+bounces-4101-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0630A4727A
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 Feb 2025 03:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8F2F16B05B
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 Feb 2025 02:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2201F5847;
	Thu, 27 Feb 2025 02:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WLccEHwF"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7321EFF9F
	for <linux-hyperv@vger.kernel.org>; Thu, 27 Feb 2025 02:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740622772; cv=none; b=kXUNdr6Vrhbgjw6m0yIopzYKdE9CqKQHy87mGnlxqcGvqBd3+xj84e02SjnqIQrXX2OcZm+gbr4FpFd2fDvUKcoZ5kp6vArm+i0vZTLRWq+0hmxEa1kDfbMoxIVyWTBP6za+xVti+mY5+khOiULZd9TZMYWgMtErPsTJ2fj1GeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740622772; c=relaxed/simple;
	bh=Ct4a9oRRcb4uCHXZ3lSQwfqmCTAwLfdRFXjQ6iMkxFY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=c/P0vtzwSOo1J4dusMB/xuKie2zQb0BJNo7I/IEu3mfNjVSAyGblAwokTCTmk+OHdDq6Wjo1yUNZqOjWBKuQ3eEbeLlKl8kD1UiQ+MU+pdq31hFh98IzWFHblXuPejfH8DQdjPRsX9XEEM4DU0Qq0gYivg4KrKuTQKPSqmBW5as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WLccEHwF; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fc43be27f8so1571027a91.1
        for <linux-hyperv@vger.kernel.org>; Wed, 26 Feb 2025 18:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740622771; x=1741227571; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Cdk6AVEMbYJ/6Avsp+2Egdk5E71fbrI/hFT7BN4L+X8=;
        b=WLccEHwFFmO1MV/Sx2o9uqoN4m/rnZV4iLX37pdEs5bXz0rgQ4vXgUq2/rLOUh1+oI
         cgbeDiBarE5LltOCTUEdyqVovJfe88UflAY3dbiRJ1MkUtlTiW9pKU84Y+WjDhA0HrkX
         nlUkRBI1tI1jKoC7zFN5rKNmoPL38BzvEfE8izv48MQuwfoOHObXX51lSh0v3pG5vK40
         rhRbvu3uCCTBiv6nDMlZ3z4XRP7YeLVabhCqNNkQu4MW8kDpZnjkk+/tP02ML9+85/yq
         LuaY/eX4+szxEMqugecY4mopoDqZTXH41KtN7f4Ih/JMnoG8bsXtNfa8TrPVX/nnwnND
         qNrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740622771; x=1741227571;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cdk6AVEMbYJ/6Avsp+2Egdk5E71fbrI/hFT7BN4L+X8=;
        b=LhSs+6VW17Ov2R5zyqhCdG0l9GTJ/kixPhqQHyaowX+JkszmCXXucJqKfbStYrjyO3
         yvjLLw1nyhiCbHFLnRcpKv+IZe1Ezg0TZsaP6jFQL4AmWtQfJTFePmUvSPlLyAV0AGks
         XuTBrQQBrYBeIghqQ7CL30DInXcO2B0RLGrqEvBj4Kn1/wbCzN+W/ZpC+FQsq3/RzkXw
         vFJR08pusby6IPab78KtLdShT+11TNJ/pWJWx6gImCEpQkUd+h9By9HM90oTi5tfcPFa
         Wi8wiZgjvdMkFBFHdlHcig3jYe7mARkCTlDxvZ07wi+zyd0kHzn8vf4kCl22b8d0njdw
         dRPA==
X-Forwarded-Encrypted: i=1; AJvYcCVBAJkMhMeDSOIN9esHUO/KRMwfV+NyIgdk5ufcsnm8OBz/zpAZrEpwI5U+WtjHvTAAYncpKiiBj3io8ZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOzFXLHPS1srg4sMqC2QSALSAI+1Tf5uBVZRjd+bH0E+yzyhNL
	oiha5u+r8xtRnObXuprkkhzV7arkXFuxDiCZmlNrgUUF0P0JaxSGlek5OOLYaC/ZvTSYUqUuIRy
	1wQ==
X-Google-Smtp-Source: AGHT+IGFILkiLdlR4RAAXuJxcaVfe/0bxh03RUlKL7+1zFXEwiB1qD3NnSdVhpPB8u60HxzWl62A5c233Wg=
X-Received: from pjbdb4.prod.google.com ([2002:a17:90a:d644:b0:2fc:2ee0:d385])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5688:b0:2ee:a4f2:b307
 with SMTP id 98e67ed59e1d1-2fe7e2eaca6mr8295061a91.4.1740622771119; Wed, 26
 Feb 2025 18:19:31 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Feb 2025 18:18:32 -0800
In-Reply-To: <20250227021855.3257188-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250227021855.3257188-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250227021855.3257188-17-seanjc@google.com>
Subject: [PATCH v2 16/38] x86/vmware: Nullify save/restore hooks when using
 VMware's sched_clock
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

Nullify the sched_clock save/restore hooks when using VMware's version of
sched_clock.  This will allow extending paravirt_set_sched_clock() to set
the save/restore hooks, without having to simultaneously change the
behavior of VMware guests.

Note, it's not at all obvious that it's safe/correct for VMware guests to
do nothing on suspend/resume, but that's a pre-existing problem.  Leave it
for a VMware expert to sort out.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/cpu/vmware.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index d6f079a75f05..d6eadb5b37fd 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -344,8 +344,11 @@ static void __init vmware_paravirt_ops_setup(void)
 
 	vmware_cyc2ns_setup();
 
-	if (vmw_sched_clock)
+	if (vmw_sched_clock) {
 		paravirt_set_sched_clock(vmware_sched_clock);
+		x86_platform.save_sched_clock_state = NULL;
+		x86_platform.restore_sched_clock_state = NULL;
+	}
 
 	if (vmware_is_stealclock_available()) {
 		has_steal_clock = true;
-- 
2.48.1.711.g2feabab25a-goog


