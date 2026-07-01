Return-Path: <linux-hyperv+bounces-11747-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jxJHEOtuRWqZAAsAu9opvQ
	(envelope-from <linux-hyperv+bounces-11747-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Jul 2026 21:47:55 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C23C6F110B
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Jul 2026 21:47:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=bzSY0zfV;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11747-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11747-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A5CB93092D78
	for <lists+linux-hyperv@lfdr.de>; Wed,  1 Jul 2026 19:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66674EA36F;
	Wed,  1 Jul 2026 19:32:52 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692CA4DD6EB
	for <linux-hyperv@vger.kernel.org>; Wed,  1 Jul 2026 19:32:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782934372; cv=none; b=Sq1Up80vPf1SUO/QjKnO0gzQTqir+nEo3e6cNAvCOgcURMwQEAGBDJNvKmt97fURE0Ok2jo03Oc5H6mTsAGqMq+DcJNP+Nxro6phUC/xbFadOhTwm9HVqKF2BVyJCeNSRt3QUlP5xUKGK1ByWt/U0r0PBcwqJD/nqkxYgBpJF18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782934372; c=relaxed/simple;
	bh=BNbYGSH55jffEq4VtE+b969iyJXTMV1HTMSCzkA3sgE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=puR3zsDN+dgEccu0vQ/a/vMoqtuUgpCON2zWw4K9yMYtoveLo0iostY/d1bnGSU/loHe9g45VgUs/rLeDQNHte1CQ4fdYjjVjcMfsZsa5r+87ZW7seTK9wfK7t7s4rEXlR3Gl5ypF9PKlXeu/wUNqiO+1X4rvsLHfJAmfm+Oc54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bzSY0zfV; arc=none smtp.client-ip=209.85.214.201
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ca3b314193so12002965ad.1
        for <linux-hyperv@vger.kernel.org>; Wed, 01 Jul 2026 12:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782934370; x=1783539170; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=/Hl8ESM1aN3u3Me6yWngcHpVlzQnDyaS4TqcnFx8YJ8=;
        b=bzSY0zfV3sQISOLEXSMU9Rx+LaG7hgWOWuH9eD/j7Y6W2CWaYmQZoPO8EKrcaXttvq
         pDZlvC18OrMwrFpHQPoD/UwNqo/QdoUVlw5+ufy/WujzdTn8jZq0asEB4fAXGf4ncekk
         NWR6ABCslXLJ6aNRnEGVbS7UVNFZNrkv35/2eA/aGR9FeIDzz2xnYH0anm2UOnILKGdb
         FWKOlsPm33iHyNZGqPCsGu8YI4o9ezLRE2/+9XUM+F0nlks1ovwQNnbhx8rRUSaRNstX
         xyynBX4Sbm342TanQgv2IA04LPU53tVzCDYFGHPj8sFrYyfYd89wFAczHvefjrg/kwR5
         8CtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782934370; x=1783539170;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Hl8ESM1aN3u3Me6yWngcHpVlzQnDyaS4TqcnFx8YJ8=;
        b=YiB5xtQQCKjD5pYpl+TNyBdLAYZDNpngumgfGaBVTtxkDjIKJkJd7ruQ3sbM2fk1sI
         HntGEjRIYWETtwjqzTdFIaUt/PtZVBzkmI+5VEW6SAaz8TbOkqgtj3eGtbC6VXslraVL
         wukCYFVNsYbHYyjgv/T/fddEWaKEY8oEO1qJeGAXO3khiz8Xag8u85zg2AVFh36+tNrF
         9Cs+1EHzPoCA3s4qjFGkNgZkoD75E2S7LG7FIQpo2bL1bIGLc5WZ0TLkS8tOOKSNtJK8
         lKO53lEHLZUXS6rqToD5+6waclM2LLsGug6k//L1E05TJE+PHEbOjVbW+qMqZfuUtEHL
         3qNw==
X-Forwarded-Encrypted: i=1; AHgh+RrEc8RMFTwh/MDwf6oiLGiMNYL9n3Qzvmg3P251qzuqUhwfNqYlB6+GUs+ZXK6GXhg7/KUQDrJPkGhA98M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMItjUVaV4k/8wu7rRJjZzov6tI772VBKxsna/ciCl4XpPDWHx
	lHOP1kZjL0D4O6hCOwqwy9Iuvc4X7gVkZdck0Kzi0b9TTJMUoo4wkFTeg6xF6NMXFDqZAJUY12w
	7Qs6OXQ==
X-Received: from plrx15.prod.google.com ([2002:a17:902:b40f:b0:2c0:bd65:1a98])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:18e:b0:2c9:e86e:a9f5
 with SMTP id d9443c01a7336-2ca7e73cbd7mr31240015ad.18.1782934369266; Wed, 01
 Jul 2026 12:32:49 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  1 Jul 2026 12:31:40 -0700
In-Reply-To: <20260701193212.749551-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260701193212.749551-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701193212.749551-20-seanjc@google.com>
Subject: [PATCH v5 19/51] x86/kvmclock: Drop dead check on TSC being unstable
 during kvmclock_init()
From: Sean Christopherson <seanjc@google.com>
To: Jonathan Corbet <corbet@lwn.net>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Sean Christopherson <seanjc@google.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, John Stultz <jstultz@google.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>, "H. Peter Anvin" <hpa@zytor.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>, linux-doc@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, 
	xen-devel@lists.xenproject.org, Tom Lendacky <thomas.lendacky@amd.com>, 
	Nikunj A Dadhania <nikunj@amd.com>, David Woodhouse <dwmw@amazon.co.uk>, 
	David Woodhouse <dwmw2@infradead.org>, Michael Kelley <mhklinux@outlook.com>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	TAGGED_FROM(0.00)[bounces-11747-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:corbet@lwn.net,m:pbonzini@redhat.com,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:kas@kernel.org,m:rick.p.edgecombe@intel.com,m:seanjc@google.com,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:ajay.kaher@broadcom.com,m:alexey.makhalov@broadcom.com,m:jan.kiszka@siemens.com,m:luto@kernel.org,m:peterz@infradead.org,m:jgross@suse.com,m:daniel.lezcano@kernel.org,m:jstultz@google.com,m:skhan@linuxfoundation.org,m:hpa@zytor.com,m:vkuznets@redhat.com,m:bcm-kernel-feedback-list@broadcom.com,m:boris.ostrovsky@oracle.com,m:sboyd@kernel.org,m:linux-doc@vger.kernel.org,m:kvm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-coco@lists.linux.dev,m:linux-hyperv@vger.kernel.org,m:virtualization@lists.linux.dev,m:xen-devel@lists.xenproject.org,m:thomas.lendacky@amd.com,m:nikunj@amd.com,m:dwmw@amazon.co.uk,m:dwmw2@infradead.org,m:mhklinux@outlook.com
 ,m:tglx@linutronix.de,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[seanjc@google.com,linux-hyperv@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[42];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,zytor.com,redhat.com,broadcom.com,oracle.com,kernel.org,vger.kernel.org,lists.linux.dev,lists.xenproject.org,amd.com,amazon.co.uk,infradead.org,outlook.com,linutronix.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[seanjc@google.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RWL_MAILSPIKE_POSSIBLE(0.00)[104.64.211.4:from];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7C23C6F110B

As pointed out by Sashiko[*], kvmclock_init() runs before __setup() and
thus before notsc_setup() or tsc_setup() can mark the TSC unstable.
kvmclock_init() also runs well before tsc_init(), and even before
tsc_early_init().  Simply delete the check, as it's been dead code since
it was introduced.

Note, odds are good the check_tsc_unstable() call was copied from Xen's
xen_time_init()+xen_tsc_safe_clocksource() logic (as so much of KVM's PV
code was).  However, xen_time_init() runs via x86_init.timers.timer_init(),
which is invoke from x86_late_time_init(), and thus after params have been
parsed.

Alternatively, kvmclock could register itself later on, or tsc_setup()
could be parsed as an early param.  Given that there's zero evidence there
was any meaningful intent or need to actually check for an unstable TSC,
go with the simplest option.

Fixes: 7539b174aef4 ("x86: kvmguest: use TSC clocksource if invariant TSC is exposed")
Link: https://lore.kernel.org/all/20260529181213.0B27A1F00893@smtp.kernel.org [*]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/kvmclock.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 061a22d31dea..29ca37e9a3bc 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -362,8 +362,7 @@ void __init kvmclock_init(void)
 	 *
 	 */
 	if (boot_cpu_has(X86_FEATURE_CONSTANT_TSC) &&
-	    boot_cpu_has(X86_FEATURE_NONSTOP_TSC) &&
-	    !check_tsc_unstable())
+	    boot_cpu_has(X86_FEATURE_NONSTOP_TSC))
 		kvm_clock.rating = 299;
 
 	clocksource_register_hz(&kvm_clock, NSEC_PER_SEC);
-- 
2.55.0.rc0.799.gd6f94ed593-goog


