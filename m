Return-Path: <linux-hyperv+bounces-11735-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KE4yMJxsRWoS/woAu9opvQ
	(envelope-from <linux-hyperv+bounces-11735-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Jul 2026 21:38:04 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C80646F0F4C
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Jul 2026 21:38:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=KplWUzCW;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11735-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11735-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 55FE930388A7
	for <lists+linux-hyperv@lfdr.de>; Wed,  1 Jul 2026 19:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81D74D90C6;
	Wed,  1 Jul 2026 19:32:38 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D354CA268
	for <linux-hyperv@vger.kernel.org>; Wed,  1 Jul 2026 19:32:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782934358; cv=none; b=BThlA+EhdQwsVItdRVFpIr/MI9LdGpb/KezIMkOOoXw9+B0JADrCiWqj19GR/9Y9xzUmL2N1LjciaqT2rZHF/8Uy/YaYLJMPVkc92LuIkrehWe1WFjWD7C3AGqBDrsbUuKoAQ+GYORTHBfqtpBfaIpTAf1hm7eI0phtxXJDtriE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782934358; c=relaxed/simple;
	bh=T5bF1Z/GMWtlvXOwBd1i/KRQmfJQmniOO2jcbAhz2Ng=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=n1tIGjLjhSiTNgZdc+fOv5PeZn+oETeTGAfKyzsD879a8YomTr9MlQfu2TsCDlktbXOxezD3YvopLw8W+mznh6wdvXA50/V59CWJm+WbMVVlnZEf5r5VX7fIXW2A+kU+HXXlUqM/8xYfPII0Rb3WOYvX2uWY4ByyQ2UW86fBI+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KplWUzCW; arc=none smtp.client-ip=209.85.215.201
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c96b4f58ddcso763905a12.3
        for <linux-hyperv@vger.kernel.org>; Wed, 01 Jul 2026 12:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782934355; x=1783539155; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=IPCn9toL5FYXOHslttK0Lqj/45O4+f3kFotppLV6+ls=;
        b=KplWUzCWtVvkvc7gbwo34zHBFIH7Ib4VrMYrFBnx9ab4YlNQwOHKj/O6ya1gwD/SF0
         kJ+T0Jc52CRZvwGUthUp1HT0gFAU2gQ/ZTMKEh3Zl/2Dt67UySn8Q/hWsdaU0HT9/1RD
         Ur59pssyV9mXHIOs6fZZxAE3CGX2a9j8wHKN4Fhn8Pqv2ovGcBJhsTd/L8gtZxdC9jfc
         XUu+PtYtYSaWBIVDGJYE8jLCzo4RbZqK3hwvM2RZtxWPY1uxydEChHCZYXQ8wAtltGN/
         CsDF2z9ddkKD5ky+mEODGZYJEn5SJgVZHnHlBcFnPsxib++erqR2mQtdCXHbxqnDtal3
         qaMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782934355; x=1783539155;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IPCn9toL5FYXOHslttK0Lqj/45O4+f3kFotppLV6+ls=;
        b=S7jvE6Bo8l2D6YzkA20CVN0YXPosiuaIK893+VN2M+i9aPECNWtsqLGSwlN1gWnw6m
         LKODHaHO9gnEaBJoXBiDd6Od4/AmKWO9O9zz7IGG9Wd3AHQ8akTkk/6S4Dzvtcc9mx5u
         of+W9Hm4boB32d0xb5GM+71dba7uakGZNy4dEJXos/TCLnRnmyKysuKDHwBnloln4ilp
         4+tZn64lcYZHd2ujB7kh03BxzcLqnIJ4MqBVbBPDUm1z4GTpnHhlu/+e4R4JMC2TTvaY
         cvw92gaTq6aiO0ZKb3Hz/4iczLuN0S18SmQHHXM7x0FofU9iHxHECgHd7Aq2BgNbtAI+
         CCOA==
X-Forwarded-Encrypted: i=1; AFNElJ/LzQYCbfCXducQUk73k3t1i/KlEFGeL/OchoAJHiaSJjh5Anm3ORj9u/kUckhTjde2iXSxVI+M6M3Z/hw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF/5TfJNyHvM845vLE7gRfat1PihUqQl+j69Dm2pdxIP11Fb++
	U6d4Dp2K6yjJ0Gdg2rIN1mwjsW5vJvV4ADbu1hG5YDdilGageW9DI8mhHA0M2tM1zmcc4WfsuyH
	hPisydg==
X-Received: from pgll126.prod.google.com ([2002:a63:2584:0:b0:c85:1159:ffb2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6300:6705:b0:3bf:7bf7:7913
 with SMTP id adf61e73a8af0-3bff40c93d7mr2592804637.14.1782934354816; Wed, 01
 Jul 2026 12:32:34 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  1 Jul 2026 12:31:28 -0700
In-Reply-To: <20260701193212.749551-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260701193212.749551-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701193212.749551-8-seanjc@google.com>
Subject: [PATCH v5 07/51] x86/sev: Move check for SNP Secure TSC support to tsc_early_init()
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,amd.com:email,vger.kernel.org:from_smtp,amazon.co.uk:email];
	TAGGED_FROM(0.00)[bounces-11735-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[seanjc@google.com,linux-hyperv@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:corbet@lwn.net,m:pbonzini@redhat.com,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:kas@kernel.org,m:rick.p.edgecombe@intel.com,m:seanjc@google.com,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:ajay.kaher@broadcom.com,m:alexey.makhalov@broadcom.com,m:jan.kiszka@siemens.com,m:luto@kernel.org,m:peterz@infradead.org,m:jgross@suse.com,m:daniel.lezcano@kernel.org,m:jstultz@google.com,m:skhan@linuxfoundation.org,m:hpa@zytor.com,m:vkuznets@redhat.com,m:bcm-kernel-feedback-list@broadcom.com,m:boris.ostrovsky@oracle.com,m:sboyd@kernel.org,m:linux-doc@vger.kernel.org,m:kvm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-coco@lists.linux.dev,m:linux-hyperv@vger.kernel.org,m:virtualization@lists.linux.dev,m:xen-devel@lists.xenproject.org,m:thomas.lendacky@amd.com,m:nikunj@amd.com,m:dwmw@amazon.co.uk,m:dwmw2@infradead.org,m:mhklinux@outlook.com
 ,m:tglx@linutronix.de,s:lists@lfdr.de];
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
X-Rspamd-Queue-Id: C80646F0F4C

Move the check on having a Secure TSC to the common tsc_early_init() so
that it's obvious that having a Secure TSC is conditional, and to prepare
for adding TDX to the mix (blindly initializing *both* SNP and TDX TSC
logic looks especially weird).

No functional change intended.

Cc: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/coco/sev/core.c | 3 ---
 arch/x86/kernel/tsc.c    | 3 ++-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 665de1aea0ee..403dcea86452 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -2025,9 +2025,6 @@ void __init snp_secure_tsc_init(void)
 	unsigned long tsc_freq_mhz;
 	void *mem;
 
-	if (!cc_platform_has(CC_ATTR_GUEST_SNP_SECURE_TSC))
-		return;
-
 	mem = early_memremap_encrypted(sev_secrets_pa, PAGE_SIZE);
 	if (!mem) {
 		pr_err("Unable to get TSC_FACTOR: failed to map the SNP secrets page.\n");
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 482cc3a8999a..8f1604ffe986 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1509,7 +1509,8 @@ void __init tsc_early_init(void)
 	if (is_early_uv_system())
 		return;
 
-	snp_secure_tsc_init();
+	if (cc_platform_has(CC_ATTR_GUEST_SNP_SECURE_TSC))
+		snp_secure_tsc_init();
 
 	if (!determine_cpu_tsc_frequencies(true))
 		return;
-- 
2.55.0.rc0.799.gd6f94ed593-goog


