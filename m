Return-Path: <linux-hyperv+bounces-11347-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MPXSEWqqGWodyQgAu9opvQ
	(envelope-from <linux-hyperv+bounces-11347-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 17:02:02 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E5642604267
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 17:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5A446313A6AE
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 14:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6193EF658;
	Fri, 29 May 2026 14:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M6z/FzQZ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E98406272
	for <linux-hyperv@vger.kernel.org>; Fri, 29 May 2026 14:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780065925; cv=none; b=K8iQ+3EM1HmKg/ch2DS0T64O11lv+ROse3wK8hVCgr+jbMLSDUs53aqNP62uBmR4sGrz1m56UwFOXnMuv25OKy7b0mV5/dpH3vh74e4svwLbICTbH9wwL+trmCRKr1cTrJDxMeYdtVtNDllcH0xIsIo/Taft87e4XO515cWzGWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780065925; c=relaxed/simple;
	bh=fK2LI2CUeD0BDEX+PJXGpTUqY8RX3Vr+B1cVn7pLK3g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KDverKdCK3ipTRtpjFG7fbYxFxgZM3lD3E8m9aa0THu6Yc7tYAwuqN9NKBFEoqmzSrCFTn78lmM3yEyoThXm/nRoSqM9zsOh0LaZBP2C8OhtslCE41Oy1NsePr536SFNw/QUZxGq7w5xmvG0NG1NzkoYYYiXoOUfPZmLRf4Zdi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M6z/FzQZ; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2bd6aeb3637so312732325ad.2
        for <linux-hyperv@vger.kernel.org>; Fri, 29 May 2026 07:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780065923; x=1780670723; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=n/IQNTw72HzXqO6AWPqeABL90E8LQ8oyD69HI8J1qOQ=;
        b=M6z/FzQZ+rSilfKmg6GXtJpXAU4boYXVmLlQZsPU065dRLo6NTky91tTmeI4K1tSaw
         JqBBj7UST5re1iZ+4j59XibO46XuAkZe2fcBIQL9tkHZ8+jx6URSzC+7QJ316CkCTbq+
         S4cK1gyBMshNQU4GTn+VF9EroGt5eteLzflIcF48lM1tpWxRgeInp/kuV0i4eJ2uJsT3
         kpPKXYFnB2NbgQtKjpe/0Nvf5g2UA1PJanamHazZiUlj8JZJKM/zCJB0aKMffwrE7Ak5
         4WMEYQVbqN/vyMjJ9NT+9oXvhh3mRAA8N0KSFHMOCeSvskT5HODwJShUjNTMygGmiD6k
         EvrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780065923; x=1780670723;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n/IQNTw72HzXqO6AWPqeABL90E8LQ8oyD69HI8J1qOQ=;
        b=LjLX8fgA1/YXks8VARDykd3AxgmH9fpHLy3NPXwusXZXT375ROWXRfaLaDnaGgP40y
         3ahokBlEz2qfSjK+jHSr3W+rY94YG1DybNRcWeRbezy480llgA88XneDp+Zbe38U/PON
         ijQC/Ttz8q/dAMdDZBqZ/BTeOoKRcAqrnRH/uBFXnMnc3cBJv1dYukU5jB6nxuEnwYRf
         FPFNzkpYTfvmVnsJutEUKsvk7hODxD0rx/wDwPo///gGYLYTkoyDnY81Pyl8axsdaPtE
         kRmMTmPSFpXXXXBCznu2FSHvHlz0U97Ycu0wQrGvsxOcL9H3vhCFrxBdwkihL28ShwJ5
         5myw==
X-Forwarded-Encrypted: i=1; AFNElJ8qIvGR44PYdqKzZU2QAFzG5J2uUMlpHJrv2jkdeEIANWoijuoCcMu6SZDMXgqoPpptomq5ALGzgxxb+b4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjr9bzluToUd+x8jBnqidz1pvSxnC49fYI8r/vQbkzXWGRLXmw
	bqPjmmwAYx4rqa7CtAhEMDtpQKiq+qmfOnXg9Elm2J48xz2qLDVZuWA+BPdk0bu3tNqUurvNglL
	NffiCTA==
X-Received: from plbbj2.prod.google.com ([2002:a17:902:8502:b0:2bf:1b54:1fc4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:906:b0:2bf:13b6:dafd
 with SMTP id d9443c01a7336-2bf367ddeecmr1314895ad.18.1780065921988; Fri, 29
 May 2026 07:45:21 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 07:44:12 -0700
In-Reply-To: <20260529144435.704127-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529144435.704127-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529144435.704127-26-seanjc@google.com>
Subject: [PATCH v4 25/47] x86/kvmclock: Setup kvmclock for secondary CPUs iff CONFIG_SMP=y
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11347-lists,linux-hyperv=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,amazon.co.uk:email];
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
X-Rspamd-Queue-Id: E5642604267
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Gate kvmclock's secondary CPU code on CONFIG_SMP, not CONFIG_X86_LOCAL_APIC.
Originally, kvmclock piggybacked PV APIC ops to setup secondary CPUs.
When that wart was fixed by commit df156f90a0f9 ("x86: Introduce
x86_cpuinit.early_percpu_clock_init hook"), the dependency on a local APIC
got carried forward unnecessarily.

Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/kvmclock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 69a15fbfb779..13c728444e12 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -186,7 +186,7 @@ static void kvm_restore_sched_clock_state(void)
 	kvm_register_clock("primary cpu clock, resume");
 }
 
-#ifdef CONFIG_X86_LOCAL_APIC
+#ifdef CONFIG_SMP
 static void kvm_setup_secondary_clock(void)
 {
 	kvm_register_clock("secondary cpu clock");
@@ -326,7 +326,7 @@ void __init kvmclock_init(bool prefer_tsc)
 		x86_init.hyper.get_cpu_khz = kvmclock_get_tsc_khz;
 	x86_platform.get_wallclock = kvm_get_wallclock;
 	x86_platform.set_wallclock = kvm_set_wallclock;
-#ifdef CONFIG_X86_LOCAL_APIC
+#ifdef CONFIG_SMP
 	x86_cpuinit.early_percpu_clock_init = kvm_setup_secondary_clock;
 #endif
 	x86_platform.save_sched_clock_state = kvm_save_sched_clock_state;
-- 
2.54.0.823.g6e5bcc1fc9-goog


