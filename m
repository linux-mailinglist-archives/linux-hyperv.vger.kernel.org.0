Return-Path: <linux-hyperv+bounces-11322-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIseK5muGWpyyQgAu9opvQ
	(envelope-from <linux-hyperv+bounces-11322-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 17:19:53 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5347960487C
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 17:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D41F33DC0EB
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 14:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A8F3ECBCD;
	Fri, 29 May 2026 14:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vrFJBqI+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3484F3E2AD6
	for <linux-hyperv@vger.kernel.org>; Fri, 29 May 2026 14:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780065894; cv=none; b=aqRyg7rmQfWEihUHv8WzdVKIS9L6GoXLOk3HkkNDorMgPwC8P4DxhF6bTCSXDcLBGmlJ5UrUW96dl1iqf+8MM2AZApy7y2a6aOHahnYBcWzAMvfSiMZvUuh8xkVRNqYc/7cKmw5G+6228uQ9Kg2EGlgPharecqMqqbwts5Bi3Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780065894; c=relaxed/simple;
	bh=XDZ/SxBGCrg/x8VTpeNWDH8FGBeUvAAaHIVl6yABrEg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JLwOSois87qwLPyNDV7IPWv+MAhh1lQm+osz8jswwT0TfdU38EDZzuesuHvLZLnX62301NwoWDhWVvRbpZay4B6PQ8Pi8zRi8l8969sq2aheBC2oAP+LQgjVG0Icn4IPlGuGNhhYAioZH3hZDJoOR/I8/A/Cu/y9nbFYUAJ581E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vrFJBqI+; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36ba98cc003so1023772a91.1
        for <linux-hyperv@vger.kernel.org>; Fri, 29 May 2026 07:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780065892; x=1780670692; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=L0mUatEZLxv6BfkDJUt0JsLCmFdWpOkVYX50Nml1d/w=;
        b=vrFJBqI+lpj3r+Ql/zJvilD2p07aldC+Y+2it8WqM2v5wv9zI/VYeiKh+dgUbzgaaY
         sv1weZwkQs8RoEx8c6HP49CTxZL7P98dAFEP+mdJjPCTIW6xNoTkVDyxDPXZmI/m9xXo
         L0Q1l2nTEaoQfx2Bou8lC6hH/Z6WJymrhZk94SAMiiY7c2KtlosvxCLc1eX/nITjb4Wl
         Jb4taRys3wJHvO0Zqq9mRxYqx0rD3Yv4nS4qzM34SELNjn08jfpH6FGT0fG/XRAXS+ZK
         6jhqePPnCiTiLG8M6dDFGDLmtJXESPhnznEGT3GYmtnRFppEflSlNAm7aLIgfAwPHSgs
         dZ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780065892; x=1780670692;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L0mUatEZLxv6BfkDJUt0JsLCmFdWpOkVYX50Nml1d/w=;
        b=PXduzqDKjKa0gGim9sherFGEJ1BaT+E5MWUCxzUAttLovPKmbv9GrF1OvtY0QxDXUQ
         hOMQ7jk9Uq8Q4ndKmDvotVGOP3+LfxP3quvOE4I7Yc/+qk2ouIK6U8T/+tH7M/l8dvG5
         tKeIIIukAn4CTRazCVKLkRIi+aeIIp1fPZAdgzrERcqcFR24ngk2T8FosulEA9pfP2Zk
         FtbtiOQU4GTKuxKl00li1xU48+JYSFq6RX2fuzQyUb7mO93rttNrf5ybwF+MtD6jaCn1
         LYWux5A/bWBjw0nPhhuHx2Q9XUxdflCL9eUn5z6uZNTCvSY8GHM2bgH88fZCw9+B6uDc
         QQ5A==
X-Forwarded-Encrypted: i=1; AFNElJ/ZTgOyrt6eSdOc9ZZA1aPeeDvFqmR/0mlz+dIzdZy8OrCoGDxoslVNWc2agMIhxc+DAQW7dQFa/dgejw0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCLU4Mm9i3s+jPjPyfgmLSoBhxR8AOAb0j0qTONUov74R+8rPN
	cAy3BuMrqhR+JNRbHlNFF9I56K8DanzzULo1xgxz7T+ZlPPZSsW+bwVhyl3zOeGjdesHkL3AgN4
	x0ykCcg==
X-Received: from pjbev8.prod.google.com ([2002:a17:90a:eac8:b0:36b:d883:98c2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:e707:b0:36a:d6dd:9fee
 with SMTP id 98e67ed59e1d1-36bbcd6f8c3mr3583126a91.12.1780065892195; Fri, 29
 May 2026 07:44:52 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 07:43:48 -0700
In-Reply-To: <20260529144435.704127-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529144435.704127-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529144435.704127-2-seanjc@google.com>
Subject: [PATCH v4 01/47] x86/tsc: Never re-calibrate TSC frequency if its
 exact timing is known
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11322-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 5347960487C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Don't re-calibrate the TSC frequency if the TSC is known to run at a fixed
frequency.  In practice, this is likely one big nop, as re-calibration is
used only for SMP=n kernels, and only for hardware that is 20+ years old,
i.e. is extremely unlikely to collide with TSC_KNOWN_FREQ.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/tsc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index c5110eb554bc..08cf6625d484 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -946,7 +946,8 @@ void recalibrate_cpu_khz(void)
 		return;
 
 	cpu_khz = x86_platform.calibrate_cpu();
-	tsc_khz = x86_platform.calibrate_tsc();
+	if (!boot_cpu_has(X86_FEATURE_TSC_KNOWN_FREQ))
+		tsc_khz = x86_platform.calibrate_tsc();
 	if (tsc_khz == 0)
 		tsc_khz = cpu_khz;
 	else if (abs(cpu_khz - tsc_khz) * 10 > tsc_khz)
-- 
2.54.0.823.g6e5bcc1fc9-goog


