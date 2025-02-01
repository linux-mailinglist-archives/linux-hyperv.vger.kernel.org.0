Return-Path: <linux-hyperv+bounces-3822-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D93A246C7
	for <lists+linux-hyperv@lfdr.de>; Sat,  1 Feb 2025 03:22:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4EDE1682B8
	for <lists+linux-hyperv@lfdr.de>; Sat,  1 Feb 2025 02:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326A81C5F09;
	Sat,  1 Feb 2025 02:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O5aMMLDS"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EED1C3C06
	for <linux-hyperv@vger.kernel.org>; Sat,  1 Feb 2025 02:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738376277; cv=none; b=GIo8Pm8veJsZrXSoW7MRNdQe1RIz/2CzvSZjyTHeAlgwhf2DgDgnpoYtkIaxs+G+frmw3PtNRjrow+yqQcv/Z9z/rU6U0g/YFdC3ZuEvYaJN+tFjcDUFIhcbMhVps7QFjsWC18u2rqWA4hpHY1towFmaYkivRsjyhoy+E2UWKjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738376277; c=relaxed/simple;
	bh=MHFjgcDixq+MEkE5s8mB+CTWIGx9I1EGKDIGAXqaNs4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cQhhYBcByteYmVW/6WLs7rUbg6XV89dZhzMYwBaTAyH5rLiZMIHDH68Mbu/FnFAs7Kw74TVpijpKl1fngnbM/3x5nmnyqWcReyTRgsdGpgnJ42ojq7cGsnCCx/x9Ypi8YBoGTNEDE5n1kCkTS5g3pFDHNIeVSfMtcZ3Q+REZrUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O5aMMLDS; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ee5616e986so7263367a91.2
        for <linux-hyperv@vger.kernel.org>; Fri, 31 Jan 2025 18:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738376273; x=1738981073; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MLts4lXwUIqNNu2uIA1UT+VV0O42NNK5wDATllLGuXo=;
        b=O5aMMLDSt8Kfql33/NVAoPicJA/J/uSh633yPyj0gx6E3+cXpQ3rtUEAVmtWbKueJZ
         +CKvLUoADHco7b7WZs0ISKAewa8jJ3vHUjN88Z3dkgVbHkaVGVT3f8UOGrpb0z8temPH
         WCTo9ldY9eIqo2jEEwpbiUz5E+qQT2P5M2tUMKGm1kqAnWFiGvrcXMt8hs9mPuofuRIP
         6BrrGFU6yzworAKIvmJVIGdmsU/MAwfe1TDnR7VpO+ZHkD1KFXsbyBY77sb85wu9G6Dq
         m0cZNHNGqfU8GKi76PtGW/pCkYMVQ2VxUEOuTqEIPzFjymmaknjkj8WJ7JhRhkna3p75
         pT4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738376273; x=1738981073;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MLts4lXwUIqNNu2uIA1UT+VV0O42NNK5wDATllLGuXo=;
        b=GhUB2tkxiBszd408/RQ+QDhZey6w1wHrtJSStWiREHVW3rdxBPWjcaX7TA0K2iHDFP
         tro0rxDXk/lTAA3DhQmk3ar1zOm0VdacxqcibxSZh3dR2hCjhLHs/ZORpPq8ehR+PYML
         TeF1PhHBFWz6J0BY3rcrBjXJkYDb/h+4Vflhz81yhYgzYPmcejeMfIphaNudU39CkOB1
         LIk6Fb/iPC9Tx3GhNjVOy0xIgfF6vS8y+49yJO7/D0fyHHAN4sUTXvarGlANpQdK4n9P
         2WRwWaKL5UvOXpiUgY8xdbnfrmAlt50VF09aJfaqvXxbgoQki2DugJDpqlWDwzpG5qrS
         Q8IQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLaJRqkqXcPRTBawlvSj3taYuSazfy3uu+u+jtgS3xj9x38DKf5VTpaLgGR2DRSsAWrxVnC3Hqezs0ynw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ2aichIiYluECY9HTBR6qT2zk1wsQAPbofCIAPgsh+p6S8grB
	zL1PBzNdPTR6xma0segQvKJ5sPEjW6PNju4R0H+J73tgO4nMmF5WqyYKhMqvmluqlKOfYbTHxLB
	nCw==
X-Google-Smtp-Source: AGHT+IFZkSSDE4sQNSYE1P+oxZtfHJOA6RLwDBSraCmTI0kfGCTz9b39MqhkWv/tuyQdm2uggkOJw5pWH7U=
X-Received: from pjbfr16.prod.google.com ([2002:a17:90a:e2d0:b0:2ea:5c73:542c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:53c4:b0:2ee:d63f:d77
 with SMTP id 98e67ed59e1d1-2f83abd7ccfmr20755900a91.9.1738376273601; Fri, 31
 Jan 2025 18:17:53 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 31 Jan 2025 18:17:17 -0800
In-Reply-To: <20250201021718.699411-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250201021718.699411-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250201021718.699411-16-seanjc@google.com>
Subject: [PATCH 15/16] x86/kvmclock: Stuff local APIC bus period when core
 crystal freq comes from CPUID
From: Sean Christopherson <seanjc@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Juergen Gross <jgross@suse.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Ajay Kaher <ajay.kaher@broadcom.com>, 
	Alexey Makhalov <alexey.amakhalov@broadcom.com>, Jan Kiszka <jan.kiszka@siemens.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	virtualization@lists.linux.dev, linux-hyperv@vger.kernel.org, 
	jailhouse-dev@googlegroups.com, kvm@vger.kernel.org, 
	xen-devel@lists.xenproject.org, Sean Christopherson <seanjc@google.com>, 
	Nikunj A Dadhania <nikunj@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>
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
index 0ec867807b84..9d05d070fe25 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -106,8 +106,18 @@ static unsigned long kvm_get_tsc_khz(void)
 {
 	unsigned int __tsc_khz, crystal_khz;
=20
-	if (!cpuid_get_tsc_freq(&__tsc_khz, &crystal_khz))
+	/*
+	 * Prefer CPUID over kvmclock when possible, as CPUID also includes the
+	 * core crystal frequency, i.e. the APIC timer frequency.  When the core
+	 * crystal frequency is enumerated in CPUID.0x15, KVM's ABI is that the
+	 * (virtual) APIC BUS runs at the same frequency.
+	 */
+	if (!cpuid_get_tsc_freq(&__tsc_khz, &crystal_khz)) {
+#ifdef CONFIG_X86_LOCAL_APIC
+		lapic_timer_period =3D crystal_khz * 1000 / HZ;
+#endif
 		return __tsc_khz;
+	}
=20
 	return pvclock_tsc_khz(this_cpu_pvti());
 }
--=20
2.48.1.362.g079036d154-goog


