Return-Path: <linux-hyperv+bounces-11340-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6PWaLC6pGWomyQgAu9opvQ
	(envelope-from <linux-hyperv+bounces-11340-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 16:56:46 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A482604133
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 16:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CF60330AC938
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 14:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0353FFADB;
	Fri, 29 May 2026 14:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iCpF4V/x"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C56E3FD96E
	for <linux-hyperv@vger.kernel.org>; Fri, 29 May 2026 14:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780065916; cv=none; b=lSxoTbHnqvLhETfXhf/fZs+H/q2KEKqra8zwWwyUWD/zeIxKjDcQcJ7B7NsT1jsJoxRMtce2uyQtJavutumsGOO1vQ9kQ168NdGfyxEcsvXBtomhf/F0TUw9A6rH/VZthI8OUt9xM+Pc9RXQ88W3knjp9rhYvCd0eUB534Xi+tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780065916; c=relaxed/simple;
	bh=UUytjfT9SVOtFZ9usAuTuI+mwQ/wQQjELPCBSRuUOk4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GApwJLijxsBAw2xiOdiW0x25QqHp5lhw7Fb9KfH6CoWZAV+Yz+P7JeG32BehkD4OauVOHLRTzEmpaCpjzKnFRIVgbD4LVpmIqGgcXjPT855RL1LTKEUZmNczXHDK3zxVhB6ChTpsJSV2BJZidm/062M1tBKI3sKLTFF8sBIX/pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iCpF4V/x; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bc763c7256so290876395ad.3
        for <linux-hyperv@vger.kernel.org>; Fri, 29 May 2026 07:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780065914; x=1780670714; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Xkng2ObvqyeOAHFFD1k5jEREhKyPX3M1bjFdIhQCaZo=;
        b=iCpF4V/xS5L0CFm1qHNNHZwnKS6VtCDsbO/RHMZ8YtoccNuNMMOPzh2J8WcPMjgvyJ
         Y4GQpx6hyof7WijKJ5VV0qeUJWD2OOKA114Zmnp9lj+enYGrVuoZ2SVRLGAPgcRTQX0U
         y1EOYx2337M0INVoXhOMN8AaveqlnZ/e3WUC8jIjpEPzVwfkiFckTdQI5nKaGx2uSLoq
         FzEKZTMjChRvb476h4al7lO9t57KLSH7mdg4ueNGe6xFN0ttOcBoFPpRzdBMF6/Zeff2
         EVOm8goRREj09Im9RSQUp4ka78wZCQbqLxSzTC0+vkpXhsS2CupMlGjd4HmgjPsCJmcu
         BUJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780065914; x=1780670714;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xkng2ObvqyeOAHFFD1k5jEREhKyPX3M1bjFdIhQCaZo=;
        b=mkRqYge1W9W3rMZQ1vQHeT6doxVxyITYbsvuxjLxZPsAh3c/mzZUYAlbwWazAUNqnD
         1khLR5nphw8xEH5RV+bs9drU9mF170XKntAewWpkec75yP21B34/IhvToPeN6htbzV4z
         6IvEgucNmhjxAuukQ9DoyTYdPJ2IXP4RgbAf6XFGmmApFMSFgigUyAq8NHhLO95m1K6r
         QQJ92cS33EiemKTri7OTUnmXoEUe1+2aPldbR1K9fMA65koOr7+H4wXw1e+Z9k9woimt
         x6cGVuF47YHtJ5RrIskUOZ2fTn/JasPdE8BTp8GsN+SSs3NAI8rtrVbWj90BmRKs6BUy
         JAiA==
X-Forwarded-Encrypted: i=1; AFNElJ+/BMc5JOMDrU3iv1fESl5mAgkaQa3J5WxYuyFL3gY4XPxKXD8cdbPqzu+6kijNoe/yIangaQ4S04Xvf0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpY8y2SoPgTcrUmU63fBwIEOxkA0xIFZhztonXs2/b/W4udPS6
	5PiDdOn425wM8u1DVwxFh2QAmsFFpoVBJpFTulAg2VgQyBcL9AifxedbyshfPAMGfSflyXovIOG
	VgTPptw==
X-Received: from plhl2.prod.google.com ([2002:a17:903:1202:b0:2b0:5b0d:f4db])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1508:b0:2bc:b141:8551
 with SMTP id d9443c01a7336-2bf36833ef4mr1185145ad.19.1780065913278; Fri, 29
 May 2026 07:45:13 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 07:44:05 -0700
In-Reply-To: <20260529144435.704127-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529144435.704127-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529144435.704127-19-seanjc@google.com>
Subject: [PATCH v4 18/47] x86/kvm: Get local APIC bus frequency from PV CPUID
 Timing Info
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Kiryl Shutsemau <kas@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, John Stultz <jstultz@google.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, 
	xen-devel@lists.xenproject.org, David Woodhouse <dwmw@amazon.co.uk>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, 
	David Woodhouse <dwmw2@infradead.org>, Michael Kelley <mhklinux@outlook.com>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11340-lists,linux-hyperv=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[39];
	FREEMAIL_CC(0.00)[zytor.com,intel.com,redhat.com,broadcom.com,oracle.com,kernel.org,vger.kernel.org,lists.linux.dev,lists.xenproject.org,amazon.co.uk,amd.com,infradead.org,outlook.com,linutronix.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[seanjc@google.com];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 8A482604133
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When running as a KVM guest with PV timing info provided by the host,
stuff the APIC timer period/frequency with the local APIC bus frequency
reported in CPUID.0x40000010.EBX instead of trying to calibrate/guess the
frequency.

Note, the unit of measurement for lapic_timer_period is "ticks per HZ", not
Khz.

See Documentation/virt/kvm/x86/cpuid.rst for details.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/kvm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 4fe9c69bf40b..c1139182121d 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -977,6 +977,7 @@ static void __init kvm_init_platform(void)
 		.mask_lo = (u32)(~(SZ_4G - tolud - 1)) | MTRR_PHYSMASK_V,
 		.mask_hi = (BIT_ULL(boot_cpu_data.x86_phys_bits) - 1) >> 32,
 	};
+	u32 apic_khz __maybe_unused;
 	u32 timing_info_leaf;
 	bool tsc_is_reliable;
 
@@ -1039,6 +1040,13 @@ static void __init kvm_init_platform(void)
 			x86_init.hyper.get_tsc_khz = kvm_get_tsc_khz;
 			x86_init.hyper.get_cpu_khz = kvm_get_tsc_khz;
 		}
+
+#ifdef CONFIG_X86_LOCAL_APIC
+		/* The leaf also includes the local APIC bus/timer frequency.*/
+		apic_khz = cpuid_ebx(timing_info_leaf);
+		if (apic_khz)
+	               lapic_timer_period = apic_khz * 1000 / HZ;
+#endif
 	}
 
         /*
-- 
2.54.0.823.g6e5bcc1fc9-goog


