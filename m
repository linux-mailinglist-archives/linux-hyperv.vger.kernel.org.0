Return-Path: <linux-hyperv+bounces-11330-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SDkxKu+uGWpyyQgAu9opvQ
	(envelope-from <linux-hyperv+bounces-11330-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 17:21:19 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 452DA6048D8
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 17:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3237531CFAFA
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 14:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6283F58D1;
	Fri, 29 May 2026 14:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N/6io0P4"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F095A3F44FF
	for <linux-hyperv@vger.kernel.org>; Fri, 29 May 2026 14:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780065904; cv=none; b=QwKPO1SlOnm+DPv97fiEe8tk//QYxXhRM84Ho5u/BVfaQCwPCCP9lqyhyPpTxPvDnzcd2UO9DcBkk5qllta8j82cQTC5c9/Ev+PskatMZWk6hkC0l4U9AEw+jk2qNCibaCFmezAAgHe9UXnIcdCQtnj2OOmjtrEwU2CROvujj+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780065904; c=relaxed/simple;
	bh=eotALkKBLw2yWarXNKTm3nPmBYb4JWK2U7pCUvm8B4E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iC6Bt6lXEjd9SY+/tXEzqE3DTS5dO9S9mbLK9c7HPOfuBISKM/OFsz7NC2K7oDrOkb0C19DOov8zc79U5drfsOGLE1K4gPVq1YrLOP/3rzXFryc5a1kvXzWJvK4bWSZrPrhAscfeVmnii9Z+v3b9R6rpzDPDMNHPttX2MGh+Wig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N/6io0P4; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2beb9002a00so68689595ad.0
        for <linux-hyperv@vger.kernel.org>; Fri, 29 May 2026 07:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780065902; x=1780670702; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Cv3iY8yWhIG9MApRDLOLL6ifa8DISlk6XR/KWuM4GwE=;
        b=N/6io0P4lTZ9+gBDKpYNm2I2TcplViuIkQuxEoprD3Qcuw5rROYd/iKXYGv1sD5pO+
         /kApdM2CFOReZpXeFYCyCBe5/xnuwyXhqB1o//VjxRMGSQKA9Xs1E1k6WpZe1kHyEwSq
         C+SLomuD4R7oVd1Gef/hJ6d1iNbXSg1NmLfbj1/7kQqI1SDYepWJ57blrxAAEzvFO+To
         ek1TJB8Bvuut/W9fy9IlisNiq+fYENPA56pwFPKukT1QzY5v8AqOB8CFnimKWCKNrKz2
         ajVk5REqt9G/rVIDCIIGvXvodriRo/siow94vFDfGwhL/BgNm0NgvXkbJpPv4uYRBFaQ
         H6hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780065902; x=1780670702;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cv3iY8yWhIG9MApRDLOLL6ifa8DISlk6XR/KWuM4GwE=;
        b=cc3U8lHNnco+nn/hLPXWF71YtYHW9U4PiSknXcMT9hK+Sq/AuiqwVkprWH2WkajFY+
         u3md1kVwHL3Tdj4TZhBF9IcGYZnSbDtenmwvlG9jIPlmZ+Mto/u0d7JCWwSwr7HB6P1x
         zPIrA6DbsMCEBxAV+/x4FshdoaiUdY3yzUxKshAlo8lwsKfVc6GtIVwzWdMwRr9lBYka
         y3JIVq5AG67pNh7iTzqIvA3RuYro54Yjgs5uEPvvdxD6wex9IY8YjIUWKV6mdhAtGg+g
         W8VQYe1YBeZXn+8o2idkXuKLy87ktol9ZFk4x7Yzig/6XRjiOK4CGEfFNN61d945jlEZ
         f08A==
X-Forwarded-Encrypted: i=1; AFNElJ/f0c1P7UHBglyVflsh6EFFljJb2zc6yopPZzYQGa1XoKxTmhu15hsTrS/DUdZnj4c71Ld097HbcU1SARI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB0iAEXIA60M61tQU99pRxN3FysnG2D2Hkk7GL9ZsSinYQvAut
	RscXPt8e1nsgbNnryZ4/PYefN+nY70gTvoV9sAQIEk89QoQ2yf/eClExBu8t2aRyqOT1F4+/WFq
	B6GLgng==
X-Received: from plem4.prod.google.com ([2002:a17:902:e404:b0:2bc:f203:12a1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1983:b0:2bf:23ad:8595
 with SMTP id d9443c01a7336-2bf367b260amr1523355ad.4.1780065902031; Fri, 29
 May 2026 07:45:02 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 07:43:56 -0700
In-Reply-To: <20260529144435.704127-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529144435.704127-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529144435.704127-10-seanjc@google.com>
Subject: [PATCH v4 09/47] x86/acrn: Mark TSC frequency as known when using
 ACRN for calibration
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11330-lists,linux-hyperv=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 452DA6048D8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Mark the TSC frequency as known when using ACRN's PV CPUID information.
Per commit 81a71f51b89e ("x86/acrn: Set up timekeeping") and common sense,
the TSC freq is explicitly provided by the hypervisor.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/cpu/acrn.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/cpu/acrn.c b/arch/x86/kernel/cpu/acrn.c
index ad8f2da8003b..0303fe6a2efa 100644
--- a/arch/x86/kernel/cpu/acrn.c
+++ b/arch/x86/kernel/cpu/acrn.c
@@ -33,6 +33,8 @@ static void __init acrn_init_platform(void)
 {
 	/* Install system interrupt handler for ACRN hypervisor callback */
 	sysvec_install(HYPERVISOR_CALLBACK_VECTOR, sysvec_acrn_hv_callback);
+
+	setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
 }
 
 static bool acrn_x2apic_available(void)
-- 
2.54.0.823.g6e5bcc1fc9-goog


