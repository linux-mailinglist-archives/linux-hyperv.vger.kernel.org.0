Return-Path: <linux-hyperv+bounces-10926-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4CdzL0FyB2qZ3wIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10926-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 21:21:37 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41739556AFF
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 21:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EB8E73017380
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 19:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0C738398B;
	Fri, 15 May 2026 19:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NzRMwtA4"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5374A37F019
	for <linux-hyperv@vger.kernel.org>; Fri, 15 May 2026 19:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778872829; cv=none; b=Pg2wZAuy5bafQMdLqZPZ8bdkLJzrzTRRAJahZIYnHlYtSfkiS6Yi9K2RLWYWQ5d2WEM8NSQoqC7wh8bSdWwKdf/pz8yisaBwFojrtSTfseodeTnpNtLuCr5upvVUDlEW11F+KMhwoXXr3kr2Yem0bpOYcRzA0XezgzRsWdfPaQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778872829; c=relaxed/simple;
	bh=EM4Aa/jhLL0HBAZa7II73CeQqmh6W0AY88xO0q2PZyY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WHo6hlEcH2YhoMBQNNe5YxHLYe0m64QigIgIP8to7H6prN6IqIvtl3p8U8HpnbLOdxw0IbaTWL0H6al9vSQyAYMBgYya56qhW1oMIrRef1Q5GZewJ8HjPY3IkHx58eoy10r1dMJc1gOog7Pw2JWvEWT4jtbCW1kMpxYtseHy18k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NzRMwtA4; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-835444b6ce1so196695b3a.1
        for <linux-hyperv@vger.kernel.org>; Fri, 15 May 2026 12:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778872828; x=1779477628; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=f8J88NcF7oH9XUSV/4XAna5n7NY6XY4d9JdR9Rumg2w=;
        b=NzRMwtA4Tniis8rxkcEs6qVkGAvzl9NWGVcXMRgCa0EcI3XiS38MhzkrGFXzbHy67Q
         ik3Qje66pE8efCtE7WCN0fC2NINgptBuFd3z1A1ZnRHAtObQYjJa4W94RsdGVClkC+sf
         txj3OTy4q5lLZyCsh63BlDTIORDRF69SLJB5CiuI0z3zmFKZmoYPXEKMENL65bzFN479
         Zdud5VozFzXo3ZNXtIiTSnyL5TqeHA/GxB1euXSEKJhITweAGQhiXqMKEAzQK7Y0+2B7
         tSZNJ/QkKTycOHD50xOW9+YmkNspCXASAOiPkszZbhPvyaZ+Y0aq9vMDvS1ADrZFtTM8
         GQew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778872828; x=1779477628;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f8J88NcF7oH9XUSV/4XAna5n7NY6XY4d9JdR9Rumg2w=;
        b=nyMp4yhBQfIy1IUtHLG6NWeygBBFocbEsEnztJkdAIQzBsn+Im61/dptxAt1xjqeqV
         BCSEorGfK9w1+v6HwRNPgh6JlRbZ4DQ9WwfMpZQi6+fLBilIHgERkp24KmbWoQHpPQVG
         B9n0VdNPmeRgnxyAMOH0Eo5eiIk3oibjMv3xHkQ9yPCfuU0Kr8NImMXqwcxDYren1uSm
         BuutYfH3r+LkhL1/tEfo2aKYizvji2KxrEI8OKSnzMic6Sia0PDBGSIoKTSZpZi2BImd
         XYT80J2jH6BtPLwUir1BvdBqqoSBfa8O/le6zgnsrChMt0sigankPg5hfGilQHm8cCKv
         kDzA==
X-Forwarded-Encrypted: i=1; AFNElJ/jVl3cv8eMKjI1nQ/9++V2A+i3iW2bOWaUvURn1Bmu8HQuz5ehQ3JwrmRfkTC1c6dCDkIp5Y1WJCCxk7I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkhIpu3lIplaWSDc0zSe/lliPak0uZ8srAPOBdmUNOi/sY7Jif
	C12wiaviSOhEH59dm7WgFmcRE/0xrdBT+qR6ZQDhpRDvskV6F3kq0ulC28KnCY5u8xXOtxzwP64
	Eiv1hfA==
X-Received: from pfch22.prod.google.com ([2002:a05:6a00:1716:b0:82f:6a26:5f78])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:12e4:b0:835:405a:7e68
 with SMTP id d2e1a72fcca58-83f33d9dd83mr5936320b3a.32.1778872827310; Fri, 15
 May 2026 12:20:27 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 15 May 2026 12:19:04 -0700
In-Reply-To: <20260515191942.1892718-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515191942.1892718-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515191942.1892718-4-seanjc@google.com>
Subject: [PATCH v3 03/41] x86/sev: Mark TSC as reliable when configuring
 Secure TSC
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
X-Rspamd-Queue-Id: 41739556AFF
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-10926-lists,linux-hyperv=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,amd.com:email];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action

Move the code to mark the TSC as reliable from sme_early_init() to
snp_secure_tsc_init().  The only reader of TSC_RELIABLE is the aptly
named check_system_tsc_reliable(), which runs in tsc_init(), i.e.
after snp_secure_tsc_init().

This will allow consolidating the handling of TSC_KNOWN_FREQ and
TSC_RELIABLE when overriding the TSC calibration routine.

Cc: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/coco/sev/core.c      | 2 ++
 arch/x86/mm/mem_encrypt_amd.c | 3 ---
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index d27cf8f8b025..14ced854cd83 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -2041,6 +2041,8 @@ void __init snp_secure_tsc_init(void)
 	secrets = (__force struct snp_secrets_page *)mem;
 
 	setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
+	setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
+
 	rdmsrq(MSR_AMD64_GUEST_TSC_FREQ, tsc_freq_mhz);
 
 	/* Extract the GUEST TSC MHZ from BIT[17:0], rest is reserved space */
diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.c
index 2f8c32173972..6c3af974c7c2 100644
--- a/arch/x86/mm/mem_encrypt_amd.c
+++ b/arch/x86/mm/mem_encrypt_amd.c
@@ -535,9 +535,6 @@ void __init sme_early_init(void)
 		 */
 		x86_init.resources.dmi_setup = snp_dmi_setup;
 	}
-
-	if (sev_status & MSR_AMD64_SNP_SECURE_TSC)
-		setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
 }
 
 void __init mem_encrypt_free_decrypted_mem(void)
-- 
2.54.0.563.g4f69b47b94-goog


