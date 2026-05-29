Return-Path: <linux-hyperv+bounces-11343-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPtZCbivGWqiyQgAu9opvQ
	(envelope-from <linux-hyperv+bounces-11343-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 17:24:40 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7911A6049C3
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 17:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1CA6D33E6BBC
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 14:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B470912F585;
	Fri, 29 May 2026 14:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W75w8Rkb"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CEF400E1E
	for <linux-hyperv@vger.kernel.org>; Fri, 29 May 2026 14:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780065919; cv=none; b=fN7Af9LbWQQn5iGnVujODcr/+Ee2Ic5GaJj4e9OY+fzTds61S/BpWr+TgyOfTlSONePl6nqV0IMT01IUMUjS+7jv+H0C8PtigrLKA62g+CHibzW35iU5E52CFEvO0YIJIeomOkJ2fvyLaJmqzJFZgcgxvDhPx2YGj33eLy9v4Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780065919; c=relaxed/simple;
	bh=dN1xTlAsuZlAzy1KoKelGX7Cs0cog4o00BEDXP2Nha4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=G5T58gRM2lOsbZnYkLEcTYo6kdrQ6S8wfYq3orBycwL+7JNG+XwnrtRegwbvv7Tr7yaja2jqmDodsBXc1OWzbp1PBieg93ylB1w9IRb7siv3yBSkxAo4XPcK229flB1YwGoqMHp4b6dWwjWxT4sR8FZXdnBZ6XuST4UKr9/5+AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W75w8Rkb; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c828b1b7fddso8197744a12.3
        for <linux-hyperv@vger.kernel.org>; Fri, 29 May 2026 07:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780065917; x=1780670717; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=YpIj1ucaijezC9S67db1/B7YVcsq/H2nz/z97RNrYsc=;
        b=W75w8RkbDqqn3B/I3TWYpwFs35i6eAEAc/w2xPPrIiW69cfp+0yYMPlAAziTUJwLp3
         v5HGFFCF1HLqOPEzqHRBq6axmd0rF9mkPU9KMKZLTma77BOzR4BzWPU7AX2kgQ9+z85j
         A+TugnF80XjTXxjCV3Jdnvyq0Qt0XWM/XcK8QyL1en6QbukFP6pMKOIafCZHsAOlNUIu
         Mxr+uR3BVEdsvf7A7MuF58OEVNUITLUlREN72NTgh2RgJZOE/8LpEYtsVZpDssOsLnBn
         kDyn5krQwduVjVYhuEl85udZMAEGH6YJmtPu4LZepj2kh98UKMqgyLbBjAJUSPBJS2zC
         2Vyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780065917; x=1780670717;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YpIj1ucaijezC9S67db1/B7YVcsq/H2nz/z97RNrYsc=;
        b=XKf7T3hrW9lt3SUXECmQZiE3jhLwySJDmCBaitqgquz/Kn8uBT0tfrgsANh440ml7V
         18KNwGCjOKlU1wwDdKUrkpSQVnVNcM50sqHT/tYQJ2v+DgjMWhGhPgTUJMf66Y+IQ8Q1
         SFK2wUEi0lkhdFNzsoVB4mhq4Kq618fdYNoN35VmB8/MAVc06v9jlgkRIF5nOOzJOZPl
         15tN7lP9oNq/H3T/IUBxUSS7gJvoK77dmqHSof5CBV7HKJqHiGgcg1jDGf8JThDGU2km
         eGG9ebMG9uCPGGRajumzkCTbZFnkpza85UdQTvFivq0vzBa34oSxY5+C39QFxo5As8sF
         mlhQ==
X-Forwarded-Encrypted: i=1; AFNElJ9mhvqnGJyspRew+6TBT3bjfGjf/ytmJWLkEVPNYSNqPIjPM6r5RzKYQ2f/PE/vAh8jzXQZRMkWcoYDw7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAY7btKoem1l+/2OjKtMTzT9YdgEgRS81lVIjtTR2dwn7lGOq+
	Dq/luAMpBBZ2eUjtLBRVWg30IPcD9181TqrmyoWezXv4JyclAq98Kyni1hTA2zHKzBoaLfF9R16
	4T2RZqg==
X-Received: from pgnm19.prod.google.com ([2002:a63:7d53:0:b0:c79:1600:6a09])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:244f:b0:3a0:67d:bba9
 with SMTP id adf61e73a8af0-3b4120a47c0mr3641480637.45.1780065916828; Fri, 29
 May 2026 07:45:16 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 07:44:08 -0700
In-Reply-To: <20260529144435.704127-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529144435.704127-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529144435.704127-22-seanjc@google.com>
Subject: [PATCH v4 21/47] x86/xen: Obtain TSC frequency from CPUID if present
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
	TAGGED_FROM(0.00)[bounces-11343-lists,linux-hyperv=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,amazon.co.uk:email];
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
X-Rspamd-Queue-Id: 7911A6049C3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: David Woodhouse <dwmw@amazon.co.uk>

The Xen CPUID leaf 3, sub-leaf 0, ECX provides the guest TSC frequency
in kHz directly. Use it when available instead of reverse-calculating
the frequency from the pvclock tsc_to_system_mul and tsc_shift values,
which loses precision.

This mirrors the equivalent change for KVM guests using the generic
0x40000010 timing leaf.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
[sean: drop non-Xen changes]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/xen/time.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/xen/time.c b/arch/x86/xen/time.c
index 487ad838c441..36d66abf5379 100644
--- a/arch/x86/xen/time.c
+++ b/arch/x86/xen/time.c
@@ -42,6 +42,17 @@ static unsigned int __init xen_tsc_khz(void)
 {
 	struct pvclock_vcpu_time_info *info =
 		&HYPERVISOR_shared_info->vcpu_info[0].time;
+	u32 base = xen_cpuid_base();
+	u32 eax, ebx, ecx, edx;
+
+	/*
+	 * If Xen provides the guest TSC frequency directly in CPUID
+	 * (leaf 3, sub-leaf 0, ECX), use that instead of reverse-
+	 * calculating from the pvclock mul/shift.
+	 */
+	cpuid_count(base + 3, 0, &eax, &ebx, &ecx, &edx);
+	if (ecx)
+		return ecx;
 
 	return pvclock_tsc_khz(info);
 }
-- 
2.54.0.823.g6e5bcc1fc9-goog


