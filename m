Return-Path: <linux-hyperv+bounces-11327-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +L30Md+oGWruyAgAu9opvQ
	(envelope-from <linux-hyperv+bounces-11327-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 16:55:27 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C6DEA6040B1
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 16:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 43ABD30A7BA7
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 14:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74D13F23B6;
	Fri, 29 May 2026 14:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rgCitiK1"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECFA3F0A99
	for <linux-hyperv@vger.kernel.org>; Fri, 29 May 2026 14:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780065900; cv=none; b=THQq7h1b+zLfMt+P/+lcqo0zUmWiLazoa17tnKEFKz7L08yFuYlTowb6Rg58SCU5L4lPQW9KVyoLWy5efttyToTCfMDdowmvG3HyKAiuspHUAUhRcAzr5Ew7kLrZOX+l7vmZ67Mry4vDQVtNz4Jef5wVwmZPolDH8rgFBMIHwjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780065900; c=relaxed/simple;
	bh=4J2pj4ueUfr2Orv6DMZFsQiWACDGMV6nbqR/DR58gVc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=afO9pe+1t1MsOPjcnbZXd1dTV9YwUncv52XXoxfWRCPF5EuU+nl5TiLDpQ9JKC4pISAW/8LtafJrbZqCU0HBxUxWq0wX6X2lcmt4t9x7VChKnCnRorDbKwuznXR/riuzLSOwQt/Zhge4be3buV4aElsGMfHfFcLz7gf//WOLYRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rgCitiK1; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3663cbff31cso9157919a91.2
        for <linux-hyperv@vger.kernel.org>; Fri, 29 May 2026 07:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780065898; x=1780670698; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=xjTz/hwdMHYqh+2ceX2noAC2jls+xA7f9jce5I1nRMU=;
        b=rgCitiK18GDofwjwtQ0ZsWfPX5FXGInzu91gk2/+VEEL/yPndT/zHFd7b7wyq9RDtB
         kF1Gx8bItGdEuMJYpTuRTbkiV37uoamSgE7ipVcmMqyxL8lDbJ6dVMVBahyTJsWtQ+Nn
         OVwgKc6dPoyk02U0iXKfmhahqaG7giJQCGyyjIZa08SiIKG1e0Vg+2NEHdm0vWdUpn+b
         K6cWTCWTsp9SVUeM2VM2fEL6Hi5ULa2r2iTXVLsppORbKcs8XxDFdb2wltZOWpuNI6fO
         U9pdjFCqqykSI2tVJI5Lv03hDdEBWs0mM/QCM2HopyG0hdabGYzHOZFZ94BRKDXpgi8H
         x++g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780065898; x=1780670698;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xjTz/hwdMHYqh+2ceX2noAC2jls+xA7f9jce5I1nRMU=;
        b=glo3yFAe1JstOCAW3pBUV98x+uIV84RqfCVKMygwcmf6Umgs4uWl+5Gv218U8iPxrf
         86JZGdh5ALDkA0Th4LauNaH+4SBDXX04p9wl1t8yp1PfJgqPVPH1XfPh4ffbZTDzOAgz
         T98J9cNEWnDHGBBXVzuYej3SJuL9QqA5yxuMx2RtJaq6jwDcGegsL2yESePq6hqNQwRG
         /ycblZzmmyk0MSygYyvu46ScYNMndSK5dK10C5GpyrrMpgR8bJp2iJfWuZKstgcSX/l2
         5hTXjVUlwygXnYrlb8RjGqXJws/1EXPtMLCdR+3SIfOSmAk/0X6h8qeq54DsSWZxVgaZ
         F7eQ==
X-Forwarded-Encrypted: i=1; AFNElJ9kgci/Fohfw1zZRcCl0PE0fS5ax5lHa5WPqg1eYmX+p1o84D5sh7D/keXWlBTf2plxEFtmPd/dtuMnLiY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFSxRZOukSCBAGZU9f+0pkdRagQz3VHfo0RxEwtvDykgQI8vKq
	YFRGaydax7ED3nQ80oUlYIrvTQA4yBrvkH7b+wWf7v3fTOViTkLn0DDK9fr0UOZPGimaj08/+sC
	MFME/kQ==
X-Received: from pjl14.prod.google.com ([2002:a17:90b:2f8e:b0:36b:be8c:b289])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4cca:b0:36b:82cf:f779
 with SMTP id 98e67ed59e1d1-36bbd1305dcmr3958387a91.21.1780065897442; Fri, 29
 May 2026 07:44:57 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 07:43:52 -0700
In-Reply-To: <20260529144435.704127-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529144435.704127-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529144435.704127-6-seanjc@google.com>
Subject: [PATCH v4 05/47] x86/sev: Move check for SNP Secure TSC support to tsc_early_init()
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11327-lists,linux-hyperv=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amazon.co.uk:email,amd.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: C6DEA6040B1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
index f7f561722efa..833eed5c048a 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1543,7 +1543,8 @@ void __init tsc_early_init(void)
 	if (is_early_uv_system())
 		return;
 
-	snp_secure_tsc_init();
+	if (cc_platform_has(CC_ATTR_GUEST_SNP_SECURE_TSC))
+		snp_secure_tsc_init();
 
 	if (!determine_cpu_tsc_frequencies(true))
 		return;
-- 
2.54.0.823.g6e5bcc1fc9-goog


