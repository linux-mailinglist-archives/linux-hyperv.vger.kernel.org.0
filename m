Return-Path: <linux-hyperv+bounces-10953-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yGIaJIB1B2pL4QIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10953-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 21:35:28 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AABE7556EDC
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 21:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E9E583032FFD
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 19:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E523400160;
	Fri, 15 May 2026 19:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oWA4z6kn"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C965B40D1F5
	for <linux-hyperv@vger.kernel.org>; Fri, 15 May 2026 19:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778872872; cv=none; b=oouURUT29cKfWnmh4VRjLGzyTjecfyS4byIi0Q7fatauoJzM8Zl7N/u7RD/pTMed/f5Jk23TBGu+lnB91LUL3xswhXScmFI8ubJnsyYbzA+BIJyIb+cSCcjzc9IHyvLvCduQwC9M3GhiYvIKbhx7D1H80UcvHTdK0VnWgkBxoxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778872872; c=relaxed/simple;
	bh=HQc+XSE41PFV7TKfdfxzuaNckcb4A4qOikHfqQvrKd4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YszL7FxL99DkBPP8hEyp2KOCNLh03T2jXyoVvNBaulTOtmEIGXrPqvpwox9QHBglhIsxGMd1a+g23cYDlkmbP6Kxq1okLEoT9X9W6E9etnrABQ5A323+Yo8W4O73C0dNgG4IaQoQpWJLCfyBjXWxupMtEsC9hdCGlXF4epM2mmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oWA4z6kn; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-83eefe4867eso166893b3a.1
        for <linux-hyperv@vger.kernel.org>; Fri, 15 May 2026 12:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778872869; x=1779477669; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=teddAWkuf/46YtH4MCYfAbMCm8nV+WgxKaJ2tNA73Cw=;
        b=oWA4z6kn5eNKhuItZj0wrAFY0RwVdX+/QqtJ55/4FkoBQeiqc+x6KyO8m3lkuFi8PF
         BELPeMEwpeYsy19FJesCeoPr0wlE50Wsour6gWVJ/THIxd5FHiJNHTT6kiSLy5YPGHBW
         icBrI9HROCBA4e4fYBwQeQq8FddYVh8FySmoWJqZp+ZEKsD5ypN2yNm2wyjGBeXVMnCD
         tUrkdZwLExwB6RUEMGc3ELts3ttna2Bk9Voy0R6lQLm9l+p6QAIGKMdKjJ3nps9GD30u
         XvFhez5OxZSw/bGZ6UW7lGDSmJ131RFRnEt5l7nBQ8IiBxh9XiFtA55iFXhqk2OAqpUe
         DAyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778872869; x=1779477669;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=teddAWkuf/46YtH4MCYfAbMCm8nV+WgxKaJ2tNA73Cw=;
        b=bnb6oPg36mqpLbggXxIdJWf7CedUhsyw7h3BezGpb0kGoGFaUn6ab9QdC3iME0M1ry
         cJmvQwwTy9i84dm9MhmwwBxeeEK/boMCfzYuRfF3aHdcOt2S2GiAwlGFB4MrfQnoRUM4
         ohzt2H1Y8hH+QSl/ZVnHrAWK5zSg0gXiNQaaWldO7bffOY3ePOaWXeocCB+IgbSP+/cS
         VcTr3vlCWowQ/Kfyem0nExkFV5RJI/0h+VHL3+yVzcIKba5gJ5pWmyevzoU4V1JV2piJ
         79e8ak0LMKVSmSMw4mmATQRyQpvHiRGFSuIyK9eqJiPDVzNm00GWhekdNT5CiNm2z9jY
         JsYQ==
X-Forwarded-Encrypted: i=1; AFNElJ/8hK1xL9Rm2HVg/zi20Uh1yvGLy08+ub5mpYlS3TrtuFLLkuYU8oFxFMCLfO7ToCgFmlKPs0RV2fo1KRo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxc4eIILkTiObjrbfMmqRAR99sI620dBb6uzmJCrO5gYrZ+ymF
	uykoWIE4Ls2gkU41i+ir4AaKBeLT9WkxOQF0JIlaq1vPCBXzLS6EuSBSlnrBpeqKKHuzNi3EhDK
	gmkzgEw==
X-Received: from pfbdu21.prod.google.com ([2002:a05:6a00:2b55:b0:82f:6245:a6ec])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:950f:b0:838:c01a:7a50
 with SMTP id d2e1a72fcca58-83f33d8c1ddmr5490444b3a.30.1778872868844; Fri, 15
 May 2026 12:21:08 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 15 May 2026 12:19:31 -0700
In-Reply-To: <20260515191942.1892718-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515191942.1892718-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515191942.1892718-31-seanjc@google.com>
Subject: [PATCH v3 30/41] x86/paravirt: Don't use a PV sched_clock in CoCo
 guests with trusted TSC
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
X-Rspamd-Queue-Id: AABE7556EDC
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
	TAGGED_FROM(0.00)[bounces-10953-lists,linux-hyperv=lfdr.de];
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

Silently ignore attempts to switch to a paravirt sched_clock when running
as a CoCo guest with trusted TSC.  In hand-wavy theory, a misbehaving
hypervisor could attack the guest by manipulating the PV clock to affect
guest scheduling in some weird and/or predictable way.  More importantly,
reading TSC on such platforms is faster than any PV clock, and sched_clock
is all about speed.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/tsc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 3c15fc10e501..ac4abfec1f05 100644
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
2.54.0.563.g4f69b47b94-goog


