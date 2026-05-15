Return-Path: <linux-hyperv+bounces-10955-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LZWKpl1B2pL4QIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10955-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 21:35:53 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A1208556EF4
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 21:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 31CE73071148
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 19:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2989740EBBA;
	Fri, 15 May 2026 19:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oVHVF2BY"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7B2400167
	for <linux-hyperv@vger.kernel.org>; Fri, 15 May 2026 19:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778872874; cv=none; b=rxCG75NRSkogY0edlWMHTQ7o8SOdRg3rxRtdNeRc8XK02hHZuIM4hID7ccyZsfw2H2jX6pd0JlSoXVrqBWNzd6GYVtyRl88Lsgb1az3N0tC7ANQE/X4lHyFbILck+1c4fLHIDqjXrCY1B1XseTPt+iLpon8Mc/HRk+b9oFJMXJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778872874; c=relaxed/simple;
	bh=7fNZAyvHkd4hTsuWucV5ADSCdPdtVNOHGfWpS1jSTro=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RydGo9s3yO1jmdT3Z7Ygilqaz4qjbTfZsRMF36Gh8BwQOUcBVZFfd8/Aak0/PAaqB+YpOpIf4wYoD4vkj8h+0K0a7KSRyCxqWTKIIiGv9sK7UcIJ3sPdz/3Cyu7qDS8Xde7VR9xaFXhECGsHeJTXh6VqJEuVFGuX5mRpNSIoAos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oVHVF2BY; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-837d43e9ff3so95389b3a.2
        for <linux-hyperv@vger.kernel.org>; Fri, 15 May 2026 12:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778872871; x=1779477671; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=HRAsSS8xU7yGk1K8a9fV0Bzp4HNJreTB4TmSZ4FXvc4=;
        b=oVHVF2BYlX76Y+d7LcjozAnixTwMgfDODWxvgpdYfY2UUzLJsJPOlV8lQ+IjKrG2LA
         zrvnqjFfSTyc3zpx/yevDZLIzNHZ6dDIgoWXRlXK7GijtDO992XLcCwvaM2g9imFTQ6l
         U1iniYxYclV9gZjVhBUnExG6SrazXxpfr/OLtCzZAmNsw+F/nh1Zn2fNgqDn5hQuh3QJ
         8wPeaVfyBTq8gDox+SbNuhSF2mQRpRN7SoK+i0BcX4Da6e/RpJs+j7esxatDoOD1AwKB
         fsdJroPPCq/erWa2nUBsJTe7AsqMrAVW0kpT6OpA005oDbggec+OHV258SqESRrIaJlK
         Z39A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778872871; x=1779477671;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HRAsSS8xU7yGk1K8a9fV0Bzp4HNJreTB4TmSZ4FXvc4=;
        b=bgZ3DYHc3P3Rx+C5jXoU+aeKsi2oMyNHPnqG6DhMbmF2zxXRICJpPd9jKHfNHl1zev
         MdZ2dIfv8BB+XYuWNsVElvogPX4QgAFyT4Oe2uuwJ2uGVzzF5CkzX5AnWl4SiLcR8W0F
         DrpLitbY2gOK5IDcXW55zxTn3eq8bv+pKmSpA0NxEwP0AwGdpbAf5e8kSAOOwzZ4zt0M
         AJ/qWOX1MUVTdskswSeNqCYVbd4Xp16eIDj1JoHc0fz4FgfGuuHwsf6wLhMb7kyJWCnM
         rkeCRrh30+EEZtnP2Sd4rPXgAav9V+xF44OHeTUXaaJHrf/q7awYeqfNAyiP90VBRcak
         OZww==
X-Forwarded-Encrypted: i=1; AFNElJ8VJ/B/ha/oFflaDhLQdagEnyB8yvUJMVC9s/+Ufb9dUKH5cYnQSI/tC2Oqswem4ZZ2qqqaKlUoN4XuLWI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLWk9LXbGhRAWT9oonYeQBDdlj6Z2mPCGcN3P3n7bi9Pvk1joF
	C6DNkMYFUSgeund2iFFBUbWMuGmelpbWQelALDq5DD4QC/XjnPWeQHdpILTOuonF8TB2kG4Hwh+
	9afrlJA==
X-Received: from pfdc5.prod.google.com ([2002:aa7:8c05:0:b0:82f:a75b:f7fa])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:ab0d:b0:839:e27c:6cce
 with SMTP id d2e1a72fcca58-83f33d97d9amr5480931b3a.37.1778872871152; Fri, 15
 May 2026 12:21:11 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 15 May 2026 12:19:33 -0700
In-Reply-To: <20260515191942.1892718-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515191942.1892718-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515191942.1892718-33-seanjc@google.com>
Subject: [PATCH v3 32/41] x86/tsc: Rejects attempts to override TSC
 calibration with lesser routine
From: Sean Christopherson <seanjc@google.com>
To: Kiryl Shutsemau <kas@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	John Stultz <jstultz@google.com>
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>, x86@kernel.org, 
	linux-coco@lists.linux.dev, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	xen-devel@lists.xenproject.org, Michael Kelley <mhklinux@outlook.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, David Woodhouse <dwmw@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: A1208556EF4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10955-lists,linux-hyperv=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	FREEMAIL_CC(0.00)[intel.com,redhat.com,broadcom.com,oracle.com,kernel.org,lists.linux.dev,vger.kernel.org,lists.xenproject.org,outlook.com,amd.com,linutronix.de,amazon.co.uk];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[seanjc@google.com];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action

When registering a TSC frequency calibration routine, sanity check that
the incoming routine is as robust as the outgoing routine, and reject the
incoming routine if the sanity check fails.

Because native calibration routines only mark the TSC frequency as known
and reliable when they actually run, the effective progression of
capabilities is: None (native) => Known and maybe Reliable (PV) =>
Known and Reliable (CoCo).  Violating that progression for a PV override
is relatively benign, but messing up the progression when CoCo is
involved is more problematic, as it likely means a trusted source of
information (hardware/firmware) is being discarded in favor of a less
trusted source (hypervisor).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/tsc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 98bef1d06fa9..7a261214fa3e 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1319,8 +1319,13 @@ void tsc_register_calibration_routines(unsigned long (*calibrate_tsc)(void),
 
 	if (properties & TSC_FREQUENCY_KNOWN)
 		setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
+	else if (WARN_ON(boot_cpu_has(X86_FEATURE_TSC_KNOWN_FREQ)))
+		return;
+
 	if (properties & TSC_RELIABLE)
 		setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
+	else if (WARN_ON(boot_cpu_has(X86_FEATURE_TSC_RELIABLE)))
+		return;
 
 	x86_platform.calibrate_tsc = calibrate_tsc;
 	if (calibrate_cpu)
-- 
2.54.0.563.g4f69b47b94-goog


