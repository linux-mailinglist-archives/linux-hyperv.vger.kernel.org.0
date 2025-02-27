Return-Path: <linux-hyperv+bounces-4121-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A877A472EA
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 Feb 2025 03:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 205041889269
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 Feb 2025 02:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A212417FB;
	Thu, 27 Feb 2025 02:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xDWDxp79"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C22E2405F9
	for <linux-hyperv@vger.kernel.org>; Thu, 27 Feb 2025 02:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740622808; cv=none; b=UZT0baZ//hKymYViU5zPs0sRdsalWtdpsrApdkdBhBtYYElKab4WUct0Eo91kAGmZAt2/MqP8WBUVNIKjqYNeLXzZQfNEVLx93p9KEaIgoU68NgS1f0RWgb8gLlJTtteUsas2qHuBZ2hx0O2uayy0JESB5RHJ1e29Y32yWT9dv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740622808; c=relaxed/simple;
	bh=KkUJ82b9H7sinf/zXMFW+qV85JdkMspMIEMKpj9sh/I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j8ZPesKIydY6xi+eSPJH92+RoETJB57tv2APukses1O9mZOOa9eGvwGqdJ1P7o8xte7BPemyt101a0AI3ON2vujCsiPlAoVJlznRMc43gmFZK+3WWpUuaa7i10Wkf/hLjnDxoyuSRAzosfmBIsPQtqVvlhuLpy5bTNCdq4Z+cAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xDWDxp79; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-220f0382404so8352615ad.1
        for <linux-hyperv@vger.kernel.org>; Wed, 26 Feb 2025 18:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740622805; x=1741227605; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pIteN/a7AZFre1KWgiuGeMT9S5HjiwYxYNebWBQLyrA=;
        b=xDWDxp79/1M3lU1GI0eNK0+ov4M4OQhhtamiQ2b5jpTvZt57VQVra8dae2Cq/IkdNu
         HldMFBMhLlBUsb7IsKR0lkNGVts9WVZT442m6HhowMFMIFPRZz/Y+zhoIDyJbWNPeG7E
         ssOTG8b83s48PlRX7a4JVDZCAsejjhW4sG1PHRqy80BFX1E4Wqc+Xuunr2/fNaCjJNYF
         CGzYEvzo2TQi483h25AE98d5KqQJE/LkSfbN/mcxL3XOr1fA0Hf96d4DBs2i0myXUQGu
         UQJN4ByTXK00xz7Ybmd11NvuwYT/HEgbZOrRVZzrpOdSPgaqd7r7+YIkl6+aWHh4M8YP
         68mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740622805; x=1741227605;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pIteN/a7AZFre1KWgiuGeMT9S5HjiwYxYNebWBQLyrA=;
        b=pElFBMdnunDaIeahK1pJ3k0cGdQzsYN5K+RKXZ9apfDIjxnT7vSH9LUVbAs3JV7MBj
         m8cNBDVua51ht7pLadep0neQYDIYg31cwxzqxmJz7fil4yPIky8xKoKQCYJ9LoXgTLnY
         9rsPzYzdb2EwCrsswlaQzjeKltXgrMeJAg1JQVS2ZioUlPClcckMeu80j/uEJ1Egy1f/
         /zPLLmKfw9RPBbAwmnldF9zB8coVqiJk5SPcM5jkGJzLbh2oN6HNQYv0u0QjVVoIkihg
         x7treCCSO0ft9C/bgbFldFrW31lnUoC9dK/nTt17G1gU/m1EwsnZ/7uGvxamRgasWyOz
         K9LQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+xA65/DekxmnHG+7N1m41B4wdp772QNCwUiJBGLA5JCMt8Q9JU0TbdH6K03BuvJgfMRH/AdJMRyZPYKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuqH2HfUg2ZrnAIlnc5Xmz4wS6e0O4FO1LnHhwUjrZo5bEE4w4
	Bo0lfG9ACRH2MsfyodGgQ5h/QnPJ4WWO4tBiWZF0O6xTRlaZPmnr5Vj/8ExEayMV5eLeHYU0RXq
	Pig==
X-Google-Smtp-Source: AGHT+IGP2cZX6cw4gCRMv2fLrFe/TXNI5NPzTOobUK44ADJodiEA9LQbSXwMRfyGc0rCQ4WOggdSpeUhPyc=
X-Received: from pfhk13.prod.google.com ([2002:aa7:998d:0:b0:730:479d:3482])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2181:b0:731:ff1b:dd6a
 with SMTP id d2e1a72fcca58-7348be4c455mr8342588b3a.20.1740622805598; Wed, 26
 Feb 2025 18:20:05 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Feb 2025 18:18:52 -0800
In-Reply-To: <20250227021855.3257188-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250227021855.3257188-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250227021855.3257188-37-seanjc@google.com>
Subject: [PATCH v2 36/38] x86/kvmclock: Stuff local APIC bus period when core
 crystal freq comes from CPUID
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
Content-Transfer-Encoding: quoted-printable

When running as a KVM guest with kvmclock support enabled, stuff the APIC
timer period/frequency with the core crystal frequency from CPUID.0x15 (if
CPUID.0x15 is provided).  KVM's ABI adheres to Intel's SDM, which states
that the APIC timer runs at the core crystal frequency when said frequency
is enumerated via CPUID.0x15.

  The APIC timer frequency will be the processor=E2=80=99s bus clock or cor=
e
  crystal clock frequency (when TSC/core crystal clock ratio is enumerated
  in CPUID leaf 0x15).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/kvmclock.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 3efb837c7406..80d9c86e0671 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -192,8 +192,18 @@ static unsigned long kvm_get_tsc_khz(void)
 {
 	struct cpuid_tsc_info info;
=20
-	if (!cpuid_get_tsc_freq(&info))
+	/*
+	 * Prefer CPUID over kvmclock when possible, as CPUID also includes the
+	 * core crystal frequency, i.e. the APIC timer frequency.  When the core
+	 * crystal frequency is enumerated in CPUID.0x15, KVM's ABI is that the
+	 * (virtual) APIC BUS runs at the same frequency.
+	 */
+	if (!cpuid_get_tsc_freq(&info)) {
+#ifdef CONFIG_X86_LOCAL_APIC
+		lapic_timer_period =3D info.crystal_khz * 1000 / HZ;
+#endif
 		return info.tsc_khz;
+	}
=20
 	return pvclock_tsc_khz(this_cpu_pvti());
 }
--=20
2.48.1.711.g2feabab25a-goog


