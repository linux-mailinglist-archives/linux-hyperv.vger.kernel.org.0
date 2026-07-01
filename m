Return-Path: <linux-hyperv+bounces-11734-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zQVAHQptRWpF/woAu9opvQ
	(envelope-from <linux-hyperv+bounces-11734-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Jul 2026 21:39:54 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4576F0F81
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Jul 2026 21:39:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=Hn9tEGsg;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11734-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11734-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B16C3054F53
	for <lists+linux-hyperv@lfdr.de>; Wed,  1 Jul 2026 19:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FAF84C8FE3;
	Wed,  1 Jul 2026 19:32:37 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63934D2EF1
	for <linux-hyperv@vger.kernel.org>; Wed,  1 Jul 2026 19:32:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782934357; cv=none; b=Pn/mfO4r7vH4NftJoV/8kSNwZdmP1xLhZqTBsHRJIbDbI46aB6OUozX1GUB7mR6XGrXLqTLlkhv3/YL7M4F3d+rvCVtD8hmF3eLO9SvSop0E/Yeue7sVCtgwM28K4KEv8kLQivqBedFhjEbuFqpRwghun81uPogLMacPWVm2Qx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782934357; c=relaxed/simple;
	bh=p5tLZkB3crC07vF32aPnSFAmwAQDDSFCr6tkFys+CMo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ja53STJVrKgl2l7YqCL97UjhOh2o05StFaLaoPawYp6+hIByR4tje/mk28Lw62Qp7aI4hOhhJD3Pc3hOpX1fbpwdpCLAQqKrzGQYaTWA2VOFduJpeyVX2DTz9VzNAuRQbkJjqpLGYoN3HP0J1t9UAz7xDtLJc3xwXjsbDSbYLRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hn9tEGsg; arc=none smtp.client-ip=209.85.214.202
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c9f0073e20so11863225ad.1
        for <linux-hyperv@vger.kernel.org>; Wed, 01 Jul 2026 12:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782934354; x=1783539154; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=evwxLM71EsC76xUKnJUsM6sZDhf4kmGP6xo/jdNLobw=;
        b=Hn9tEGsg81obPWeBySjt9n3Y/aqivac4a9GG7opEcrcdjO73D94oWJMEzYPjq7sKgZ
         egiSEepBrJCPb89Fsla+BxHujqnLcrY9W+antf9uHGsglS+BMY2hbPnvsK47XeOFw4ji
         IdhEqvi6pZQR3vDX4d+HbJbUG8V7r37a3g343+2HR1tvSA1geiccFk+1FbBVE8XFFbbv
         jHZ6O0mdWMdD6PxN5KIbAkHXwK30XRblPp74DsJTfLZN2Uvo0wJid7Xr8DOuidFJP7lo
         HW2F06uKrgcR4yJN2GZZuwx8f1aqVd6HfGzMxmDRPL3DsJouJ4AZ5AMPUgzJYkgNi6jf
         3wMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782934354; x=1783539154;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=evwxLM71EsC76xUKnJUsM6sZDhf4kmGP6xo/jdNLobw=;
        b=PPdh5Y2CONfX3kicq0SlFdqMbgbbXCP6qNk22Wt2SCEv/5VTQdN3cOZSuvwY0U+/ov
         v0A2iifi1JSrverbzIxSzSuwQZjPXopTeUoShr9TIU5//C+uRjXLqlCch4KQ9SI8h8Bq
         FMNsmjZCywczN4SXVk63R66AwnGwWs6WOk9tOkOkJq9yclkFXI2QFYS4GPVv1jSGo0D5
         P1QcXnW1EcGBGoJy1iibgEp1FuMBIqoA5X59GuCfDhz5akwgjZWBi17OamJmTCLUPLKh
         PaW6a35gXSiSVlFeepVlrgM9Gd1S4EJtfPBSd/Z3rUPjZhexHuovbyo7VGJ1au5GloEc
         DCEA==
X-Forwarded-Encrypted: i=1; AHgh+RqdZ86HhbJoedttj2cATH4PIYqOMfeHEppUp0TW9K6OOy8CEROeKE3lI1NiNgFqVBR/DfngDF7nDSKM35M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfouMHIwitdklY1Cf2MxpvreRPbXVry/7qGDN3Jvh+Mj+85OWH
	dEHCRs/mu3qal8NgXZmTgrx4MuppCwEjomwGkz686JnRUkoDtFBeJCtT800NuXcfyVKSneFbUhp
	F0sgqfA==
X-Received: from plha8.prod.google.com ([2002:a17:902:ecc8:b0:2c6:a75b:2129])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:f8c:b0:2c7:d603:117f
 with SMTP id d9443c01a7336-2ca7e754b82mr34808385ad.26.1782934353608; Wed, 01
 Jul 2026 12:32:33 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  1 Jul 2026 12:31:27 -0700
In-Reply-To: <20260701193212.749551-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260701193212.749551-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701193212.749551-7-seanjc@google.com>
Subject: [PATCH v5 06/51] x86/sev: Don't override CPU frequency calibration
 for SNP's Secure TSC
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:corbet@lwn.net,m:pbonzini@redhat.com,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:kas@kernel.org,m:rick.p.edgecombe@intel.com,m:seanjc@google.com,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:ajay.kaher@broadcom.com,m:alexey.makhalov@broadcom.com,m:jan.kiszka@siemens.com,m:luto@kernel.org,m:peterz@infradead.org,m:jgross@suse.com,m:daniel.lezcano@kernel.org,m:jstultz@google.com,m:skhan@linuxfoundation.org,m:hpa@zytor.com,m:vkuznets@redhat.com,m:bcm-kernel-feedback-list@broadcom.com,m:boris.ostrovsky@oracle.com,m:sboyd@kernel.org,m:linux-doc@vger.kernel.org,m:kvm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-coco@lists.linux.dev,m:linux-hyperv@vger.kernel.org,m:virtualization@lists.linux.dev,m:xen-devel@lists.xenproject.org,m:thomas.lendacky@amd.com,m:nikunj@amd.com,m:dwmw@amazon.co.uk,m:dwmw2@infradead.org,m:mhklinux@outlook.com
 ,m:tglx@linutronix.de,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,amd.com:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[seanjc@google.com,linux-hyperv@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[42];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-11734-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0C4576F0F81

Don't override the kernel's CPU frequency calibration routine when
registering SNP's Secure TSC calibration routine.  SNP (the architecture)
provides zero guarantees that the CPU runs at the same frequency as the
TSC.  The justification for clobbering the CPU routine was:

  Since the difference between CPU base and TSC frequency does not apply
  in this case, the same callback is being used.

but that's simply not true.  E.g. if APERF/MPERF is exposed to the VM, then
the CPU frequency absolutely does matter.

While relying on heuristics and/or the untrusted hypervisor to provide the
CPU frequency isn't ideal, it's at least not outright wrong.

Fixes: 73bbf3b0fbba ("x86/tsc: Init the TSC for Secure TSC guests")
Cc: Nikunj A Dadhania <nikunj@amd.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/coco/sev/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index ed0ac52a765e..665de1aea0ee 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -2046,7 +2046,6 @@ void __init snp_secure_tsc_init(void)
 
 	snp_tsc_freq_khz = SNP_SCALE_TSC_FREQ(tsc_freq_mhz * 1000, secrets->tsc_factor);
 
-	x86_platform.calibrate_cpu = securetsc_get_tsc_khz;
 	x86_platform.calibrate_tsc = securetsc_get_tsc_khz;
 
 	early_memunmap(mem, PAGE_SIZE);
-- 
2.55.0.rc0.799.gd6f94ed593-goog


