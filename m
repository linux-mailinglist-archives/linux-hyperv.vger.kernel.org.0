Return-Path: <linux-hyperv+bounces-11762-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IeUJOs5vRWrNAAsAu9opvQ
	(envelope-from <linux-hyperv+bounces-11762-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Jul 2026 21:51:42 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1F96F11A4
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Jul 2026 21:51:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=Z9pbLP8R;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11762-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11762-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD70D323EE52
	for <lists+linux-hyperv@lfdr.de>; Wed,  1 Jul 2026 19:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC9B4D2ED4;
	Wed,  1 Jul 2026 19:33:12 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02A04229CC
	for <linux-hyperv@vger.kernel.org>; Wed,  1 Jul 2026 19:33:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782934392; cv=none; b=XVDURUT/IjtOS6MkM7TB74toMabfKnRRh4BVr7PMaP560o6MqCNvOBqnKRxQCV6NOz6uEqrLgkbyRsgD1KMXftrP6wMUWMylPaBRbkNC1fVk6zQ+j/XUjwxpg/JcEHDvWgZIuIKOD/x7nrN7rLTxsApHCYO1BCoCcW+/hfsaF10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782934392; c=relaxed/simple;
	bh=odtTAw4qAyKVMoQOFS9NQKiMBl8SSPflZ8sexqq+tVc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=alVCwtE4ANKeeTk9+8BC44TVSCw56f0+Kd0/gjZ9fWZEG/YIqOp5brP0zzQh5jJmg+2r02NoJuErJC7kE4fr0S+jXcyNNbvvGdCJ8Qg7dmvki4oB9DbBW4Y4OZyfcyw9c8m90jk0Hc6r/itGQDQgvBqau6LjubY3P5mySCQD1Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z9pbLP8R; arc=none smtp.client-ip=209.85.210.202
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-847a225cd91so899198b3a.2
        for <linux-hyperv@vger.kernel.org>; Wed, 01 Jul 2026 12:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782934388; x=1783539188; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=qFfbhUmYyCU6tRW/uev50JnnPJRuq59CtmTnO4qaTps=;
        b=Z9pbLP8RzwzuKuLzlfrm5Prb7daDS39w3We9CUaV2F7dzjc6vupfNsHYXJ/uNF7kwk
         1/CQ7RZDZAMKJdACXon7ImfdCh18M3GAaYVJ5JUuOI2qob2Dsuvg2RDEYnbMsP1qHk1r
         V4r3aOAeOAmlVLsq3rExkfbeX/iZg7F1Jm7MNss9hgyXbbzPLh2YglTzpzAqm70HHsXr
         +r4oesTjqHEgu94n6ZOkXp5DK/LfSKpT5llxFjm0Grku+sZiy5fLD+XKQ5KE8xTenb//
         ibgdBS3M/qzvqtJO3yFXP8N2WZfIVjx5edXZeg/w3UvEpsLMZu3rC7y0CG4TbeTmQQzC
         3bEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782934388; x=1783539188;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qFfbhUmYyCU6tRW/uev50JnnPJRuq59CtmTnO4qaTps=;
        b=ecU1zHhrcztWiiwIBH4k4gpCfl/9x5bIQb0FVVLveLEF8zg5sBCMlilj0yfhXT7CYG
         zTZHWecY5yXkHT/CyKTSw3vp1NfB2GHzgCNge1f/2PPZfZqTNxdmmwd4FfGtds/izq8u
         Qabhsr3iXypiWWxIozxWA51O+g1C2fulVNbGlWde1qw4eNXq4f82H44Lf/pl6yzEqyvd
         hCj4AY8q9czB/L/KzvjqVzIPWkMi3pZts3jEQykIV2G1zMiBvJ8EJgVJyKcAZ3YYCV3c
         Vrht1pt6VNkd7Lxl8DsIBOwHpFn6Zgt+UEc4tMD+TDaYZNu5rN+2yG04hivnU2yP30X6
         C6Vg==
X-Forwarded-Encrypted: i=1; AFNElJ+bR5Hn9lPZPYaVfRqlyKxQEUx1IgLoh947lpzCDqcXMfhme4QsE0UnIYNSlz7bfby1fCz1TkKgORfVpdE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYZHyPTqGnAm/zY/jZeyrFXX69sD5W5XOUxHwgBynIMgmHa6U3
	pdMaGp4IMlzs3/neZBP9CUhFWapJCIO+BE9kDnlcFsUbzlwUF0SZzUsv4Binr5HZC/5Neh22iTj
	ZZ1MXBA==
X-Received: from pfvx7.prod.google.com ([2002:a05:6a00:2707:b0:847:8f34:1b76])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:8f0a:b0:847:86d8:5937
 with SMTP id d2e1a72fcca58-847c51e4a35mr1955201b3a.50.1782934387701; Wed, 01
 Jul 2026 12:33:07 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  1 Jul 2026 12:31:54 -0700
In-Reply-To: <20260701193212.749551-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260701193212.749551-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701193212.749551-34-seanjc@google.com>
Subject: [PATCH v5 33/51] x86/xen/time: NOP-ify x86_platform's sched_clock
 save/restore hooks
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:corbet@lwn.net,m:pbonzini@redhat.com,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:kas@kernel.org,m:rick.p.edgecombe@intel.com,m:seanjc@google.com,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:ajay.kaher@broadcom.com,m:alexey.makhalov@broadcom.com,m:jan.kiszka@siemens.com,m:luto@kernel.org,m:peterz@infradead.org,m:jgross@suse.com,m:daniel.lezcano@kernel.org,m:jstultz@google.com,m:skhan@linuxfoundation.org,m:hpa@zytor.com,m:vkuznets@redhat.com,m:bcm-kernel-feedback-list@broadcom.com,m:boris.ostrovsky@oracle.com,m:sboyd@kernel.org,m:linux-doc@vger.kernel.org,m:kvm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-coco@lists.linux.dev,m:linux-hyperv@vger.kernel.org,m:virtualization@lists.linux.dev,m:xen-devel@lists.xenproject.org,m:thomas.lendacky@amd.com,m:nikunj@amd.com,m:dwmw@amazon.co.uk,m:dwmw2@infradead.org,m:mhklinux@outlook.com
 ,m:tglx@linutronix.de,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amazon.co.uk:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[seanjc@google.com,linux-hyperv@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[42];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-11762-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5C1F96F11A4

NOP-ify the x86_platform sched_clock save/restore hooks when setting up
Xen's PV clock to make it somewhat obvious the hooks aren't used when
running as a Xen guest (Xen uses a paravirtualized suspend/resume flow).

Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/xen/time.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/xen/time.c b/arch/x86/xen/time.c
index 487ad838c441..477441752f40 100644
--- a/arch/x86/xen/time.c
+++ b/arch/x86/xen/time.c
@@ -567,6 +567,12 @@ static void __init xen_init_time_common(void)
 	xen_sched_clock_offset = xen_clocksource_read();
 	static_call_update(pv_steal_clock, xen_steal_clock);
 	paravirt_set_sched_clock(xen_sched_clock);
+	/*
+	 * Xen has paravirtualized suspend/resume and so doesn't use the common
+	 * x86 sched_clock save/restore hooks.
+	 */
+	x86_platform.save_sched_clock_state = x86_init_noop;
+	x86_platform.restore_sched_clock_state = x86_init_noop;
 
 	x86_init.hyper.get_tsc_khz = xen_tsc_khz;
 	x86_platform.get_wallclock = xen_get_wallclock;
-- 
2.55.0.rc0.799.gd6f94ed593-goog


