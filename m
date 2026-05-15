Return-Path: <linux-hyperv+bounces-10964-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Iq8Nh91B2pL4QIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10964-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 21:33:51 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B18556E70
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 21:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ACFBD30F87E4
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 19:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA8B413D6B;
	Fri, 15 May 2026 19:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P9QOwJpd"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C99E403403
	for <linux-hyperv@vger.kernel.org>; Fri, 15 May 2026 19:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778872889; cv=none; b=PO+fyPEXqpjeCXsgWY3nBPlrFN8vcvEx2pZFcOS+fk6dDc79VUTS5TarYhG+23B9l66p8pwpwqx0q54nsEgv1+LFosj5PPv5u0t9jM0yD59sjATg38FOjnB3GuEX/3WOSwVF3XodGPcSOlpmAKYD6J/jeofvClpdT+GhqF6v5ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778872889; c=relaxed/simple;
	bh=QioBrwKpRdsCytYFTzNNbiVitx8MQJE4M4sQvpXgFXY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EsO92Uc+EPVRVKIXmbGtQXoTiuFe1nJ8wSwLxlLQQQihca5FEQuudFaBJCKOcL9XEtoDnzamjTIuE8/DEexi9We8f3KKSPLmztaff5Sn71uWLoAoqpv00HMg95QVmIiz/yy/lEpp+2VKsAa/v1br5MkSWswohjHrvv4aGfxrOBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P9QOwJpd; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c8294d8c48eso84475a12.0
        for <linux-hyperv@vger.kernel.org>; Fri, 15 May 2026 12:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778872885; x=1779477685; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=5BJQi7ZR1svDe2KF7RHkPrmL6MBNA7Dkc8gFvThdUD0=;
        b=P9QOwJpddaMglO39lPf0W/+PPdE6u0psiu5iecAPCxFkcs757Wlu8ETiXkl5hEcowr
         jmvrew7GOeId8lK0efHUa4xsgA4plYxpv9jnp99U/nbLgtvGVlkLqPGFMBEZjESX0rOe
         YyidFNALdrhx3LxCNU4u1sWjfEuF1iiBtln5eYs/kfLgeYSMEKgoOKGZc2A7XXEEIEZX
         D9BUqV+TQxMgnUtQGIgW7PBBCxJPs+Uvyjo/bpLmX/5uhtZxxdnGf8LoIprNT1le3tWd
         73SdMlbEi00ryg3w7tScK67q1hFcv4vbzjtQ/ZDzzMMM+AGe+EblAU3BR2R8Y+HWPevT
         Gzhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778872885; x=1779477685;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5BJQi7ZR1svDe2KF7RHkPrmL6MBNA7Dkc8gFvThdUD0=;
        b=UnOlfrH5alYc0NMWNoO0CTAJaE62pgRTnZV0g5L8AyyZ4UgzYOMPGfeUbsgJOki5ON
         NIGqAV0SSAnQ19X27QQsRgHOiWmS6aENrAxE1bhz+L/TETdN1kmGtKXF15dWru0FUuS2
         vJzZ9zvxkaHgG7bKpMZgm7lnmm7BglwQrpsC4qMOxocbq5MPnVSLfFKyr7M6I4GWfBwK
         ekwpnAbtw9UYM9eTz0GxgqctJgPQ54kWxALzYvrSVq86ndQtyA3zjZmNV+Jdp910MdYj
         +I0ShQrdUkfUMpol0ZpaguE8OpJIG4uG9k2K9kmtHJojHpqRSVE4hP7PdkONAP+6q7P0
         BQGg==
X-Forwarded-Encrypted: i=1; AFNElJ889JaCmPEIvsrzNG87eo+P1OV92euV7CFngSezdV+uRARCBSahi+vL5oIUFZcgVKWBYBKxh1dNsZ1CX6g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO4qsNHiAZNTVgu/1VpAlmJMQL59zmmeyZKpKDIemwK3BWc/8v
	HhXrSNJECQaSsyVc2yeeoxPsCDi+OFMH8P6YuWyUlzUO85z+8hrSpdF/oNgLY+c42q6HpkcrBT5
	mUgOWqg==
X-Received: from pfbeq4.prod.google.com ([2002:a05:6a00:37c4:b0:82f:344e:386a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:9502:b0:838:1c02:2763
 with SMTP id d2e1a72fcca58-83f33ab667bmr5736284b3a.9.1778872884225; Fri, 15
 May 2026 12:21:24 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 15 May 2026 12:19:42 -0700
In-Reply-To: <20260515191942.1892718-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515191942.1892718-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515191942.1892718-42-seanjc@google.com>
Subject: [PATCH v3 41/41] x86/kvmclock: Get CPU base frequency from CPUID when
 it's available
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
X-Rspamd-Queue-Id: 58B18556E70
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10964-lists,linux-hyperv=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action

If CPUID.0x16 is present and valid, use the CPU frequency provided by
CPUID instead of assuming that the virtual CPU runs at the same
frequency as TSC and/or kvmclock.  Back before constant TSCs were a
thing, treating the TSC and CPU frequencies as one and the same was
somewhat reasonable, but now it's nonsensical, especially if the
hypervisor explicitly enumerates the CPU frequency.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/kvmclock.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 62c8ea2e6769..7607920ae386 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -190,6 +190,20 @@ void kvmclock_cpu_action(enum kvm_guest_cpu_action action)
 	}
 }
 
+static unsigned long kvm_get_cpu_khz(void)
+{
+	unsigned int cpu_khz;
+
+	/*
+	 * Prefer CPUID over kvmclock when possible, as the base CPU frequency
+	 * isn't necessarily the same as the kvmlock "TSC" frequency.
+	 */
+	if (!cpuid_get_cpu_freq(&cpu_khz))
+		return cpu_khz;
+
+	return pvclock_tsc_khz(this_cpu_pvti());
+}
+
 /*
  * If we don't do that, there is the possibility that the guest
  * will calibrate under heavy load - thus, getting a lower lpj -
@@ -434,7 +448,7 @@ void __init kvmclock_init(void)
 		kvm_sched_clock_init(stable);
 	}
 
-	tsc_register_calibration_routines(kvm_get_tsc_khz, kvm_get_tsc_khz,
+	tsc_register_calibration_routines(kvm_get_tsc_khz, kvm_get_cpu_khz,
 					  tsc_properties);
 
 	x86_platform.get_wallclock = kvm_get_wallclock;
-- 
2.54.0.563.g4f69b47b94-goog


