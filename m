Return-Path: <linux-hyperv+bounces-10929-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CD1jOY9yB2pX3wIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10929-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 21:22:55 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED361556B5C
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 21:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CF957301FDC8
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 19:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB6338398B;
	Fri, 15 May 2026 19:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U8YlEJ6H"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FB037B3F4
	for <linux-hyperv@vger.kernel.org>; Fri, 15 May 2026 19:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778872833; cv=none; b=Id/+Z+HPOumE09dOYO8oJO/Ka4fH0hbcU2+3S3FIYPScomSE7kqeHajqfZK6JQ1aztPvymHsM47AVVD/d8SwgfigcgckrCzi5T2l5pfb51FzmzhjvJZ7g9fJzqLn0ByChOPDoyna6vrZSi/6dfFbhO9NhRYZJ3ipyu7btKG689s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778872833; c=relaxed/simple;
	bh=IfVwAYhwhIxzw01+s7FehLy05itlzurZzA6D640hoDk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rhB1K64C/Xw6RLWgWarf2mMuEdoUhSbdxja9EvhqZ9HMEICq9010Bb9evRzojpKh6Tii663uN2ErwPTuTrzd0w/ckbr6hoAsxIYEyJzyD19nrhKH89OMydYvrIbUPZ37xaCO+kmzwLpzbaXpFtKpZYFFpDf/mt8PXSKdRgE8V6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U8YlEJ6H; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3662e7756f0so82344a91.1
        for <linux-hyperv@vger.kernel.org>; Fri, 15 May 2026 12:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778872831; x=1779477631; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=SQlmIR1hnrcjkd+R45vwU7fSi2OSjNiqFudElplFZs0=;
        b=U8YlEJ6HoUh6A3rfbMaIEGAWKIKPo9Cqf3U9VjLgbA9gTesU0m1V6n0Z0/EFksMpwG
         50q39fdTt/uOr8EWix+h3ZZEc+7UuNI5r2hfGqAiDP9UVZENlziy+RGmNvAOxWztKcEU
         uIONtnG8sodHjaEBrG8ZGIRtkOnmzbimc9BAb41bnLD8soUc1zoU+Ir8eBLN+aZLq3FO
         6914PtcUZRRkK2SD++Ddsfyf/FLq0wPk/2pC0C5o14L2vCV7Dw4qfk5EXEswwJhzk2gD
         VPl/9JQNjc/+dtjtSvJ3WjkdqtjyXY0pv7boLFHHKQGBIcmiuSYzi3Iwmydrp1V4GyIV
         y15g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778872831; x=1779477631;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SQlmIR1hnrcjkd+R45vwU7fSi2OSjNiqFudElplFZs0=;
        b=MGFnZTOOjMchuhK6B+YYLJenWaZI97pokgpPKJGm/NLf6APKNEesFFizeHoErTyojN
         Bf2OKRAsIMD6QyJR3DCYS1fTNWndMzLa+Wzoq0m2xiQlCaxs43fxPZ+UGKEWEHEkUgeY
         ElukrJpczusNcUFGQ1uLyZs6qhdO4IDI1e8tpbYNij3LH1bAJjKdAt4q4vyMA1H2QGZf
         cEN0r+Egcf3mC9Y45OCrSUHlXapMb9xqP4GfwDq2ekNRneIgKYBlKewHT3I2bW+QWOay
         R34yAN3agVE9c86h2nL4fFp7FTFEMA3oUzbdMd9tC54bO5zvhAHs2pmhdVE/SHQc5lvv
         ihmg==
X-Forwarded-Encrypted: i=1; AFNElJ/Jh+s2SoZeSjcEaDjMb1AOBICEfsNt1FW3QAeM50tCSsZLpa8oqPSEZ9AA7LS73zKdcvzna2/kY2BYCCM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkrbGH9GUaxTlFGZJEzrURElagLsZLqfyohaDAaSt8Gt5qcaH9
	o2bo0BTx8jcKIuxiM1OKdPz6Mpw65awmkdmmurDTn4iDxcu8yZtX01GpohqNJuyQx6WSS7do5OK
	QgqKcPA==
X-Received: from pgmt14.prod.google.com ([2002:a63:224e:0:b0:c80:2399:151])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2fc4:b0:368:85fb:7b8b
 with SMTP id 98e67ed59e1d1-36951cb936amr5644652a91.22.1778872830766; Fri, 15
 May 2026 12:20:30 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 15 May 2026 12:19:07 -0700
In-Reply-To: <20260515191942.1892718-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515191942.1892718-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515191942.1892718-7-seanjc@google.com>
Subject: [PATCH v3 06/41] x86/acrn: Mark TSC frequency as known when using
 ACRN for calibration
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
X-Rspamd-Queue-Id: ED361556B5C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10929-lists,linux-hyperv=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action

Mark the TSC frequency as known when using ACRN's PV CPUID information.
Per commit 81a71f51b89e ("x86/acrn: Set up timekeeping") and common sense,
the TSC freq is explicitly provided by the hypervisor.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/cpu/acrn.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/cpu/acrn.c b/arch/x86/kernel/cpu/acrn.c
index c1506cb87d8c..2da3de4d470e 100644
--- a/arch/x86/kernel/cpu/acrn.c
+++ b/arch/x86/kernel/cpu/acrn.c
@@ -29,6 +29,7 @@ static void __init acrn_init_platform(void)
 	/* Install system interrupt handler for ACRN hypervisor callback */
 	sysvec_install(HYPERVISOR_CALLBACK_VECTOR, sysvec_acrn_hv_callback);
 
+	setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
 	tsc_register_calibration_routines(acrn_get_tsc_khz,
 					  acrn_get_tsc_khz);
 }
-- 
2.54.0.563.g4f69b47b94-goog


