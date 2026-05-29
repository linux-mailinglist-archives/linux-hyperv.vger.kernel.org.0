Return-Path: <linux-hyperv+bounces-11366-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6CRuDNixGWrJyQgAu9opvQ
	(envelope-from <linux-hyperv+bounces-11366-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 17:33:44 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F40604CCF
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 17:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 39B0731438A0
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 15:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47BA7341650;
	Fri, 29 May 2026 15:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OjDkYNp/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED077403EB8
	for <linux-hyperv@vger.kernel.org>; Fri, 29 May 2026 15:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780067312; cv=none; b=BUUVRiPvZTrVvR9mPNRfeyt+Gss4Vnb+sD6lNx7NGUq4k8aX+dHe0w02RQJZQ8VpFwHEpFJVgkkjWSg34RiX401ikwe1MM8HRm7LIOy9Wyf2yfS4uCyqdrG0zFBHYWhcKePAYpl9iF1OUmmaEkVdDqAg9Jok663MfmKKnwYhPmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780067312; c=relaxed/simple;
	bh=DEZgJF7aGT/S6bfnpIcTdfbLyrYZ4GO7q+5YqQ+zuvQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DQF4H9sDBVno3NUssknjDiG9quVJ4LTnGyjoJ1Qz9nDvptlDcpstvgJWX2GYHFQBceFJwv4DrQ90QGcoynIuw7mJQVJQ01zSOT3JrvlpaCukQaOWx+tFVHHxXHUI/E0YZAEK/vh0RLdCuRkmUSu0+mmtYp4rj70fNdSyAS3xrjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OjDkYNp/; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2beb9002a00so68915015ad.0
        for <linux-hyperv@vger.kernel.org>; Fri, 29 May 2026 08:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780067309; x=1780672109; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=EFwMDca4i0UUfWhYRWZx1hhbmviPyyt5LCM1/HLShPA=;
        b=OjDkYNp/bjefUjjqylc0ZG5QKyTGM4IYbYKh9icibqrJsfy8F23z6wCUBiFBYKoiY9
         hPaIj6/rkeEFJdKe7ehVOmq47UIU0H4UuHerVE77SywccOyiJ2oarNOc0VPyIu201hfv
         N3m12OVhUbaz+B5f5JkdXIX/LulNuVSMZSqeM8COYXaGcDOnI1mz/D2a8VNvuIbJrefy
         T6rbGJVGu7zSqFZQYk9PylcZrvUkORMxRrO0ilUaNf8rqM0vtpDbPjSwfN3MCmTZm5ir
         ctQ/4Yd2YEsli6O/Xto1HR8WGFfpLCIi796tDkK8JwuSc9Z3uy5Cp0cSZhthkT7TFiez
         aTjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780067309; x=1780672109;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EFwMDca4i0UUfWhYRWZx1hhbmviPyyt5LCM1/HLShPA=;
        b=NGXFOuwlsDExLfAmvJ76G1fCFwTduReLil5u5OC7l1osYD98AE4o+S6ugp9nge4a7w
         rZ52eIH6r+zmjrZ+/0/p29iDf0p7F6eTcjqsOjV2qImbmXKq+n1ohNKhcFcodF3KUg0n
         cWurPl11n5zEPEAxefmQvJFzUL6oMKQeif7WRH6kZqbrgvlVm9wqF4I7hQ0/o/fpEbTX
         +jTfJz1/7zgOzWvolB8aigpSrSVk7pukSVIU8wD3PKcMpBJD8ivutuJ/53Jq44rDrQpk
         yK6+vviOpqXT1ZVoHme/l7ZODvc6QXnVLinclZ0cjGxkC/1U3n5bvAPqZ7mO05B0+hmr
         vnJQ==
X-Forwarded-Encrypted: i=1; AFNElJ/PWe3C5LFmOu/JJHWsSwfZO33poRGHzCLZ7QE1lWW7DqHxB5zYS7cSoP7W9nkWCku9tP230NsLWETpbNE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFcoRJFviaIX3/1HzjzcZPFyq9O9CeEsUT43rh+b71TJ8N9agZ
	l9Ofnu19DDGKGrW1TLztQdqWK7FpODNTA6/zzGRD0tjlrJETvacwGJw5uvmFHt9IfJjsbHDi3TF
	0jzOLUQ==
X-Received: from plbjy6.prod.google.com ([2002:a17:903:42c6:b0:2bd:d2c2:2776])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:eccf:b0:2bf:3126:44b6
 with SMTP id d9443c01a7336-2bf368bd5dfmr2325645ad.40.1780067309070; Fri, 29
 May 2026 08:08:29 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 08:08:26 -0700
In-Reply-To: <20260529144435.704127-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529144435.704127-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529150827.714968-1-seanjc@google.com>
Subject: [PATCH v4 44/47] x86/paravirt: Don't use a PV sched_clock in CoCo
 guests with trusted TSC
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Kiryl Shutsemau <kas@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	"K . Y . Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, John Stultz <jstultz@google.com>
Cc: "H . Peter Anvin" <hpa@zytor.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11366-lists,linux-hyperv=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,amazon.co.uk:email];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: A3F40604CCF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Silently ignore attempts to switch to a paravirt sched_clock when running
as a CoCo guest with trusted TSC.  In hand-wavy theory, a misbehaving
hypervisor could attack the guest by manipulating the PV clock to affect
guest scheduling in some weird and/or predictable way.  More importantly,
reading TSC on such platforms is faster than any PV clock, and sched_clock
is all about speed.

Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/tsc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 7bcf757bf551..036916953f4a 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -283,6 +283,15 @@ bool using_native_sched_clock(void)
 int __init __paravirt_set_sched_clock(u64 (*func)(void), bool stable,
 				      void (*save)(void), void (*restore)(void))
 {
+	/*
+	 * Don't replace TSC with a PV clock when running as a CoCo guest and
+	 * the TSC is secure/trusted; PV clocks are emulated by the hypervisor,
+	 * which isn't in the guest's TCB.
+	 */
+	if (cc_platform_has(CC_ATTR_GUEST_SNP_SECURE_TSC) ||
+	    boot_cpu_has(X86_FEATURE_TDX_GUEST))
+		return -EPERM;
+
 	if (!stable)
 		clear_sched_clock_stable();
 
-- 
2.54.0.823.g6e5bcc1fc9-goog


