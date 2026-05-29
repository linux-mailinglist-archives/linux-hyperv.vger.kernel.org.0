Return-Path: <linux-hyperv+bounces-11359-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KMIJIGuGWpyyQgAu9opvQ
	(envelope-from <linux-hyperv+bounces-11359-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 17:19:29 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F969604845
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 17:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BDBBC30AB13A
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 15:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220853FC5B8;
	Fri, 29 May 2026 15:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wjh3olIL"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE523FB060
	for <linux-hyperv@vger.kernel.org>; Fri, 29 May 2026 15:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780067294; cv=none; b=ZrlIpoDhrx6hcmq/floXTZVd3ejlLg8xr+vnpoO0aFcIpdIhY+7g5z0T0wmdPDOrsN/WBtMVQcWY0WjgeiMztyHJddG7K0yN+ncuwDVV03IryROrQvVp4k6chMHR5Y+2n1oyWxmxvO3TyMgpKT/wL+HRiTBrF8i5Chyb+3+yheQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780067294; c=relaxed/simple;
	bh=exJIaYP606/6I81t2u+ZeN9QwrdKHiAhDu05aj2jV5A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NSxsMUnoxVG3Ljt0sDusHpW3lcGuXnnZ5uKD8z3Yuk7F9KpwiXmSY1BHZTlEV4mdQKz04DeLOu6ZZwqnlG6Ekcz/C50jg/4szl5SNrTRA8qTMm6LH0AAzlDlmbLD5LIg/FghdtQlwibFpFW3gQ4gPyv1BeqLlEKNs15ngdy2Z0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wjh3olIL; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36bc380fbf9so892687a91.3
        for <linux-hyperv@vger.kernel.org>; Fri, 29 May 2026 08:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780067292; x=1780672092; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=0jsX4kmzCmqMaCGwN5oKHLOUS2DjjzJWXK44/xdBtv0=;
        b=Wjh3olILxBugqfvoOFwFG+iNdahIJViFHp8S3c2YjV6zCK91YWRtTVvfUNVirjBcky
         hg7By0k/06qv+0FDkThy3f2YA3TwhEaQ1haPIKELN8pCwXfmNed5MdcLzC5VUD3YnD9F
         xBrrQo5iUhu1WlGlSV7EyIx3xBuRUfyhKa/npGyzsNLPmYlgkCrlXuiG6BYqbKeROFxO
         2YD7huKY7UmeKEHUkTvSqeryRbzcA/F8WOtHieIZO091SZxsXNQYkMTZXHR0mqviR0sQ
         gCWOhrCbrLRUGezc79zzKWWfC9ba4VbZhr0KJqgov6DzGWEvYHQYr0WbFK5PWDnt+xi4
         47SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780067292; x=1780672092;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0jsX4kmzCmqMaCGwN5oKHLOUS2DjjzJWXK44/xdBtv0=;
        b=SPMk25kfjlGAvTX1naAed1UJbSjt5axogSA4O+Jssd1OgpS6XNmnOE02n7DnKJnogQ
         MId9HJqv3LN+TceO4HT53T8ioirnus8rJf+8RRvI97JqpZmRMUzxrWWMtTseIsW6MzCy
         Pt/6HzKc7TbwxxeVaOsLA50Pirq4coDNOyuYZfbKo52gbacVb9Ta2amupbVVDAHTz7vW
         wdwVNbo9cXzZl0PzqHY0H2NHN9eZu+qCfhUK49s4IJSds4c3VHccBH4CAn3qzHZnVM2+
         lBO5kgyCn2LK44VLWMHKCwSk+buuu/6BJlvFYdwsBwMrkQ0fzLmJ8kXlwIT0Z0+vHyvA
         ImxA==
X-Forwarded-Encrypted: i=1; AFNElJ8+R5DmbN0buwdOpIeDvPPjpEyko3aXtN/Hn4FpUDhJJy2NCcW6eweIsFKCDcDh0Kb7xw9Fk/9prAD0/Vg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9ev6XE3PADJbPUPN8zcmqJX5qF/XCHde8/+CuEdcss365ZZF1
	2aZmhaJGeCvwGbVXrunCdXRdl0AocfQkjEBJ1T2HFLpCaeLy0PQ9m6zlad1xMdO5S+rzmkImUgp
	v60swtA==
X-Received: from pgvi5.prod.google.com ([2002:a65:61a5:0:b0:c82:2dd8:9d49])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6b87:b0:3b3:d4a:793b
 with SMTP id adf61e73a8af0-3b411e5b284mr4378476637.43.1780067291927; Fri, 29
 May 2026 08:08:11 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 08:08:10 -0700
In-Reply-To: <20260529144435.704127-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529144435.704127-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529150810.714572-1-seanjc@google.com>
Subject: [PATCH v4 37/47] x86/pvclock: WARN if pvclock's valid_flags are overwritten
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
	TAGGED_FROM(0.00)[bounces-11359-lists,linux-hyperv=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amazon.co.uk:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
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
X-Rspamd-Queue-Id: 3F969604845
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

WARN if the common PV clock valid_flags are overwritten; all PV clocks
expect that they are the one and only PV clock, i.e. don't guard against
another PV clock having modified the flags.

Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/pvclock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/pvclock.c b/arch/x86/kernel/pvclock.c
index a51adce67f92..8d098841a225 100644
--- a/arch/x86/kernel/pvclock.c
+++ b/arch/x86/kernel/pvclock.c
@@ -21,6 +21,7 @@ static struct pvclock_vsyscall_time_info *pvti_cpu0_va __ro_after_init;
 
 void __init pvclock_set_flags(u8 flags)
 {
+	WARN_ON(valid_flags);
 	valid_flags = flags;
 }
 
-- 
2.54.0.823.g6e5bcc1fc9-goog


