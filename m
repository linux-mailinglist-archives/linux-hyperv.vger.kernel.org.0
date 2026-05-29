Return-Path: <linux-hyperv+bounces-11357-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wM6yNiSxGWqiyQgAu9opvQ
	(envelope-from <linux-hyperv+bounces-11357-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 17:30:44 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E37A604BC3
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 17:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D5E6F320C5DD
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 15:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E7F3F9268;
	Fri, 29 May 2026 15:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u3wQ4poY"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BBE3F8EB5
	for <linux-hyperv@vger.kernel.org>; Fri, 29 May 2026 15:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780067288; cv=none; b=EwuDuCGNW0AXOPrmz0YrzLO8TZIGmlcy/4/xJ7/S3mcviAxSrPEADUhqncXsF0d47O0ePB3byAFpjjikUAYtZpuetIgW0FUrgd7tCvPPWmiPRW0Bgqu1WHXCBe6wqLJY8YVPayxGO/2xu4MfmUT62D5vkLP86VP4RNC6obi8NLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780067288; c=relaxed/simple;
	bh=he0WfZWWdERYD7ChG87MeYfoSX2HSFZ+ZmjDHyI6dIA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OVNC+CopLO8gB/j3BLu6QOyuRKa91LjqlUTg3D/44TSbYCI05NHNlI8tSWZzUZeMSTKjmKAk36KZgHYnTsYlHesWVCSvwELwEdPoMbPwU381bX3iMYok5udTsuKoohXf6uxGozcwKSz7dFde31hiypNzIeT0QHlFODr8oRQNT24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u3wQ4poY; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b4530a90fdso105002485ad.1
        for <linux-hyperv@vger.kernel.org>; Fri, 29 May 2026 08:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780067287; x=1780672087; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=juhHvibOKBbL5R/8TYL0oDxVwG80NiQFMLoZ+aO+Nyo=;
        b=u3wQ4poYP2eSyy1zEVjY0WHILnDf1cSwHDndkUc7IvC/yCRmr2YBGSs8oNtQBEs1cP
         Vf21HPDas7ZFNepSdMVYgkFhXqS6lPxlxJqUK36CwJvgz+nskIpSIxOkbx6g6izn/A6X
         Yjrszv/vE7z/P3kzocBh1R0QG16IwLr9Iz6X9EGr+Wd+4vzZulRSWG8EuJeTM5EPwbHv
         lE37h0CnR0DES0ojJtVtMXCKNV8+QV2ctneAXeIqK9Fpn/PMvCRgVd2sNAPH1c1t0SLN
         j4tbZefDK3OnstUvTwVHuqNBUxCbHFJJVL3t2xJBEK6gKO+pMGb2M6jOK0i15Cqsz5Bi
         8Ckg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780067287; x=1780672087;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=juhHvibOKBbL5R/8TYL0oDxVwG80NiQFMLoZ+aO+Nyo=;
        b=mixsolrvLiNZVfPHh1Qdgqm8Fzk+9Ux9tMODWtTDeC3dP4oQZV/RNsrFc5k6BB+92p
         mFTSMRh5ktBv9lNQcoPMGfA+6xsgkE/8UFr4X1sCrc9anqvrQ4X33MFH6VlYSvIR45GX
         Iuu2Ead1Pf9DULAYKAWXODQJAhI5gcvafg2A9QOoafrMR3n7N79oJsUMT3jt8rf6F2WV
         UdmAUy+2JD7Bxw8cNUOLTSTti7L00JYyMvBfMsgoIB0gTqeJBhV8OouS+Yi5a1NDfG1y
         rINGQbBhijyYbWuHQRgzPuuXPdKUnh3yrn0uip0fzlh15nyzL2ZKISFMLKhUr3Pl4m9J
         C6Cw==
X-Forwarded-Encrypted: i=1; AFNElJ/aKM5zs22QSGWzgebtmwjtcx/MVIZ0gZkDnP9qzBDAkNYdAoAcMTqQQIUfck+hyExIMmxqRS7FFCSr+Qk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywtoa935Z82pOSLd9Rvu4faO+RNJOkewCceFay9OqM5454ZyFku
	ZvwRXQ7GREk9s2WnLGPpZ+MJtbXiDd021LJniTS0Ps5t0BPnYEm/SB9bmIle2wil/BB5mI5JS3R
	HYlT9IA==
X-Received: from plrf5.prod.google.com ([2002:a17:902:ab85:b0:2b0:5538:b55b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e88c:b0:2bf:2188:a90f
 with SMTP id d9443c01a7336-2bf3687a3f3mr2296425ad.32.1780067286623; Fri, 29
 May 2026 08:08:06 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 08:08:03 -0700
In-Reply-To: <20260529144435.704127-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529144435.704127-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529150803.714504-1-seanjc@google.com>
Subject: [PATCH v4 35/47] x86/xen/time: Mark xen_setup_vsyscall_time_info() as __init
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11357-lists,linux-hyperv=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amazon.co.uk:email];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 7E37A604BC3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Annotate xen_setup_vsyscall_time_info() as being used only during kernel
initialization; it's called only by xen_time_init(), which is already
tagged __init.

Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/xen/time.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/xen/time.c b/arch/x86/xen/time.c
index 91ef83b1e540..8f4511f91d16 100644
--- a/arch/x86/xen/time.c
+++ b/arch/x86/xen/time.c
@@ -454,7 +454,7 @@ void xen_restore_time_memory_area(void)
 	xen_sched_clock_offset = xen_clocksource_read() - xen_clock_value_saved;
 }
 
-static void xen_setup_vsyscall_time_info(void)
+static void __init xen_setup_vsyscall_time_info(void)
 {
 	struct vcpu_register_time_memory_area t;
 	struct pvclock_vsyscall_time_info *ti;
-- 
2.54.0.823.g6e5bcc1fc9-goog


