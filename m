Return-Path: <linux-hyperv+bounces-11773-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yCFCKRpuRWonAAsAu9opvQ
	(envelope-from <linux-hyperv+bounces-11773-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Jul 2026 21:44:26 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 178806F106F
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Jul 2026 21:44:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=tYeK7jVr;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11773-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11773-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2F7E83067C88
	for <lists+linux-hyperv@lfdr.de>; Wed,  1 Jul 2026 19:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0245142C4DB;
	Wed,  1 Jul 2026 19:33:25 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFBF42B315
	for <linux-hyperv@vger.kernel.org>; Wed,  1 Jul 2026 19:33:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782934404; cv=none; b=X4EQcDg30RY16mhKq57z6MZSQYSs2U+Ps9gcMy6pm1Q7v3lrKqQuaxHPTdsICwIRILkZEUHO58JfH1+1VLXP0DXaM3TwSEikKWFsJIF3MBMI/8nzLJHbaXzUW2pGixTneaXLKIyCHm5yph9LwtSahGJEKkpVjRUDgjwi8ph1LHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782934404; c=relaxed/simple;
	bh=UExHFmJ65vTRSuxY6XqQx736Zu2Yk6LZG1h2YXf36Dc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=E53yFvEHV6e578JO5yyqZ9YAiAdNek0THKDoFMDe+cCEAcoThqmqsliO2teqyjFmZB0IpV52ELFhObgMeRcSUeQy9bwRPhigC5dMaG02EG417D1sH4O189BH/D9CWT6BF5grWMvY/JVSuwpaQ98akJykJ1rRFdU0Md15YfPHcXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tYeK7jVr; arc=none smtp.client-ip=209.85.214.202
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ca3b3141a6so13439485ad.1
        for <linux-hyperv@vger.kernel.org>; Wed, 01 Jul 2026 12:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782934402; x=1783539202; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Z1gCn97n2OaQgcF7BGVq6zaJwKJkpkAfWBIFdTpXq3s=;
        b=tYeK7jVr9pte1MjlrhhuhdAOMYT93kUFcQW3zUg6ggB8NhFyZa5dV4BnqLumk/00TC
         HayvniQdI5OCkhm9Qgx/zaF1gAQJLIs58EX+hNAgZXaLW8OsVB9d3djooUz3rtJE/Egt
         cAQBxko4rv8z2LYlBJz9N/Xb7lrLbtLfpUJQmy30UK3xlpQx2l6qnsq6XoNHi1lnz9jZ
         C2QvzYkT/KC0GZ4pGiDQ+03EbS9y4b9sLphEVaf3ZtYpk3rB6wQTQQ4tnGyEvGJVbmLm
         kLHp4uojtiJjjSQozBzmUiBJXPZu7Xcbeuc4OFUZ5kSPYW+YeaM1FLQd18ayKQhrgfcQ
         3O7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782934402; x=1783539202;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z1gCn97n2OaQgcF7BGVq6zaJwKJkpkAfWBIFdTpXq3s=;
        b=WTHHPyKQ9j5od3W4f/v1v+o/gPYBaEnYr7QajmxwRUuH94nUyGnddu1gJx+vGZYu1Z
         Ywb9GjMH2oEbotiYFjb9QWSa2dSvKqU5rGWo9HKlJgs6+6TS+6oEVQqT5fuVNKWOfBTh
         5A2Oo4QwDD5pHJaaNKpQnJNXIIcbE99ohcgDDU6Y9lRPY/KnHfJfZ9jI5N58rzjtXl5E
         lI5S9kIbmhRqVYuS1uJRZ7Ux7Nh+7aWm8mOkIZyAauOq27k/q8GGFNFDdWAvGbOWx4uX
         ka4GrTaeMjyvZDLVspU7XIaNtGm6TjOCoM+RJWeN9UcuqlhPZQJOYF3D/H0CmONOBrgz
         3XMg==
X-Forwarded-Encrypted: i=1; AHgh+RoOutQ9wI5AYgkZEr7ql/NFe8xDh3Gp4J7g1IGANu9g3Uhgz+31qCKdBxXtrVbL9lR8tr7TUqNNlaAdlEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkIOPPRjKuiLZDuI96zS7spjWBi9iIiMfpEYUHeymFp+PWVsKD
	k3UXquRYUcSnASGnJqvYWQtJP/14qfCI11KY+IEvum0QfdR8e3TUVdR0FNYmeYVOTBoUS8a5bDt
	wiILq/w==
X-Received: from plgo7.prod.google.com ([2002:a17:902:d4c7:b0:2c0:b770:dcd7])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1245:b0:2c9:fd62:a709
 with SMTP id d9443c01a7336-2ca7e6838d3mr33515195ad.10.1782934401463; Wed, 01
 Jul 2026 12:33:21 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  1 Jul 2026 12:32:06 -0700
In-Reply-To: <20260701193212.749551-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260701193212.749551-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701193212.749551-46-seanjc@google.com>
Subject: [PATCH v5 45/51] x86/paravirt: Mark __paravirt_set_sched_clock() as __init
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:corbet@lwn.net,m:pbonzini@redhat.com,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:kas@kernel.org,m:rick.p.edgecombe@intel.com,m:seanjc@google.com,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:ajay.kaher@broadcom.com,m:alexey.makhalov@broadcom.com,m:jan.kiszka@siemens.com,m:luto@kernel.org,m:peterz@infradead.org,m:jgross@suse.com,m:daniel.lezcano@kernel.org,m:jstultz@google.com,m:skhan@linuxfoundation.org,m:hpa@zytor.com,m:vkuznets@redhat.com,m:bcm-kernel-feedback-list@broadcom.com,m:boris.ostrovsky@oracle.com,m:sboyd@kernel.org,m:linux-doc@vger.kernel.org,m:kvm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-coco@lists.linux.dev,m:linux-hyperv@vger.kernel.org,m:virtualization@lists.linux.dev,m:xen-devel@lists.xenproject.org,m:thomas.lendacky@amd.com,m:nikunj@amd.com,m:dwmw@amazon.co.uk,m:dwmw2@infradead.org,m:mhklinux@outlook.com
 ,m:tglx@linutronix.de,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,amazon.co.uk:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[seanjc@google.com,linux-hyperv@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[42];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-11773-lists,linux-hyperv=lfdr.de];
	DKIM_TRACE(0.00)[google.com:+];
	HAS_REPLYTO(0.00)[seanjc@google.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,zytor.com,redhat.com,broadcom.com,oracle.com,kernel.org,vger.kernel.org,lists.linux.dev,lists.xenproject.org,amd.com,amazon.co.uk,infradead.org,outlook.com,linutronix.de];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 178806F106F

Annotate __paravirt_set_sched_clock() as __init, and make its wrapper
__always_inline to ensure sanitizers don't result in a non-inline version
hanging around.  All callers run during __init, and changing sched_clock
after boot would be all kinds of crazy.

No functional change intended.

Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/timer.h | 10 +++++-----
 arch/x86/kernel/tsc.c        |  4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/timer.h b/arch/x86/include/asm/timer.h
index e97cd1ae03d1..96ae7feac47c 100644
--- a/arch/x86/include/asm/timer.h
+++ b/arch/x86/include/asm/timer.h
@@ -14,12 +14,12 @@ extern int no_timer_check;
 extern bool using_native_sched_clock(void);
 
 #ifdef CONFIG_PARAVIRT
-void __paravirt_set_sched_clock(u64 (*func)(void), bool stable,
-				void (*save)(void), void (*restore)(void));
+void __init __paravirt_set_sched_clock(u64 (*func)(void), bool stable,
+				       void (*save)(void), void (*restore)(void));
 
-static inline void paravirt_set_sched_clock(u64 (*func)(void),
-					    void (*save)(void),
-					    void (*restore)(void))
+static __always_inline void paravirt_set_sched_clock(u64 (*func)(void),
+						     void (*save)(void),
+						     void (*restore)(void))
 {
 	__paravirt_set_sched_clock(func, true, save, restore);
 }
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 83353d643150..0f92b29adecc 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -280,8 +280,8 @@ bool using_native_sched_clock(void)
 	return static_call_query(pv_sched_clock) == native_sched_clock;
 }
 
-void __paravirt_set_sched_clock(u64 (*func)(void), bool stable,
-				void (*save)(void), void (*restore)(void))
+void __init __paravirt_set_sched_clock(u64 (*func)(void), bool stable,
+				       void (*save)(void), void (*restore)(void))
 {
 	if (!stable)
 		clear_sched_clock_stable();
-- 
2.55.0.rc0.799.gd6f94ed593-goog


