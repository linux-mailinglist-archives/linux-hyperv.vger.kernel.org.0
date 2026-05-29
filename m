Return-Path: <linux-hyperv+bounces-11353-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMqzD/ezGWr3yQgAu9opvQ
	(envelope-from <linux-hyperv+bounces-11353-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 17:42:47 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DC047604F30
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 17:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 872CE32E28B9
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 15:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88403F44EC;
	Fri, 29 May 2026 15:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MTT5H/Bt"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0CF3F39ED
	for <linux-hyperv@vger.kernel.org>; Fri, 29 May 2026 15:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780067276; cv=none; b=lBCmy/mUlJ7SGPpDwetornLB3hKshpMTrxWYEbuR3MrhoTHhbuZboqu3PQci3f6E24Sggjm/LFaQh2+hcLpEcwZNQOWE+uiHo06Gp1Z7E8LrMwgOtAgymSaTwlHkfgQxpDIFKZVpeFr3S3Jd+qZ41jrUyIB80gOZjvlb0BTN1zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780067276; c=relaxed/simple;
	bh=kqQGoMW+oi+5ZrWtSd7Fuu/ZnSkBt2VrapqrWKwhgpU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BQWv2pFBJSQFC3LrApDrWxWbdXeTfnR/Tq+z5vR3UPD01nvXUWxyF6trN5B1PuahBfmwnkU5U5l+5kHJEUHZ6zDUehR1Gq/hSmERzS8+QA5X4KbNv3ohp/nfgvfJ0ULLKNMr8Vgt3LXwt92TsAH0WsLImsaXMWrt7XlxJpEgM5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MTT5H/Bt; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bf30576aa3so2304545ad.3
        for <linux-hyperv@vger.kernel.org>; Fri, 29 May 2026 08:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780067275; x=1780672075; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=yp4siaZu6zeBY6Dr4EV8ib3+ttfMwXywWsfu9IVNNX0=;
        b=MTT5H/BtD+VFkskx8pg2WGgy9tBTjt0xmG/mVmPDB5HDINY7uY0sh2YZNENGAKQaR6
         elA/yMLkf2gW7nm74tCnIZl/En4kVC2BQOGAYlLncL2OPfugNssLQUwOa95Y0cNqti18
         WMRa456+c7TmN85m7rGc5xmh4JFhRhJ426yVCFdTch7M9da28PCWHiuH9UzxRKDrkwQr
         dL502CMO93fxnVQJcEgZxTeTAS1wz4baF8XdQv5+DDp6x1TW9neghY8z66Tsdfqwd3W0
         VaWBdPLbcWuThwCZOJg5/t6JrLXn1WoM/2I1k5x8ckYKO38eIPFlcMx4f+w9YG+CS6Od
         zRcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780067275; x=1780672075;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yp4siaZu6zeBY6Dr4EV8ib3+ttfMwXywWsfu9IVNNX0=;
        b=WhaPBpUA1R+AgukgyWBhNUo+dy/rpHw9gXBW/9h59MbL00VsxVRBno3XYqFahSRZK0
         UXWkIXhjKi+KmmJ80BjULhjhLVrs+/w0z60snh7JOlGoh7gLllJ2MPZNdquYzc3bi9d9
         oXbAkWIRLOosSoNoz2nEO8l96gcYZCvOLwUROtY+oY48ItfA+FAbR8XDhLNaZ/nUzlmK
         ONhA8yUASnX6/CBgtGmIKBLFUe61DZk0f55LGgfYvitY0GOoeQkNqlVBiTPHnsOiHFyh
         jVJPlpKxsWlN47Pv9jKBcqQzX7oFrH20cvGmGZO+6p5jGueNNaffpCkPmheLORmmIAWB
         uBWA==
X-Forwarded-Encrypted: i=1; AFNElJ8J3TBoOXocH/NnDIhHqU6bfPX4M6F6KNcwgKS4PLzKseaAoD8jvqcAlaLThI+xg2SJfUA3YJQ1GtcIlxc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv04iI0Z1rqLI2Wtk14ginlqSoYNJ9PEB4a8D4giKSnHS9bW3d
	nBeWyP2xHYV4cljPQqltTmMij2CfxYO85umqMfQreuh5WrHESrdKY6+p5yohbNvT9zI9gx666UG
	Khi/IyQ==
X-Received: from plgv8.prod.google.com ([2002:a17:902:e8c8:b0:2bf:2f05:e721])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2450:b0:2ba:6ca2:be0
 with SMTP id d9443c01a7336-2bf36798a4emr3028165ad.4.1780067274515; Fri, 29
 May 2026 08:07:54 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 08:07:52 -0700
In-Reply-To: <20260529144435.704127-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529144435.704127-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529150753.714296-1-seanjc@google.com>
Subject: [PATCH v4 31/47] x86/vmware: NOP-ify save/restore hooks when using
 VMware's sched_clock
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11353-lists,linux-hyperv=lfdr.de];
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
X-Rspamd-Queue-Id: DC047604F30
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

NOP-ify the sched_clock save/restore hooks when using VMware's version of
sched_clock.  This will allow extending paravirt_set_sched_clock() to set
the save/restore hooks, without having to simultaneously change the
behavior of VMware guests.

Note, it's not at all obvious that it's safe/correct for VMware guests to
do nothing on suspend/resume, but that's a pre-existing problem.  Leave it
for a VMware expert to sort out.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/cpu/vmware.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index 2d0624c66799..051ef89029a7 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -347,8 +347,11 @@ static void __init vmware_paravirt_ops_setup(void)
 
 	vmware_cyc2ns_setup();
 
-	if (vmw_sched_clock)
+	if (vmw_sched_clock) {
 		paravirt_set_sched_clock(vmware_sched_clock);
+		x86_platform.save_sched_clock_state = x86_init_noop;
+		x86_platform.restore_sched_clock_state = x86_init_noop;
+	}
 
 	if (vmware_is_stealclock_available()) {
 		has_steal_clock = true;
-- 
2.54.0.823.g6e5bcc1fc9-goog


