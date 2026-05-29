Return-Path: <linux-hyperv+bounces-11342-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uMfSOeOpGWodyQgAu9opvQ
	(envelope-from <linux-hyperv+bounces-11342-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 16:59:47 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB6F60420B
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 16:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F01253071ED8
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 14:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ADF740244D;
	Fri, 29 May 2026 14:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XiIBNBOX"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6533FFAC1
	for <linux-hyperv@vger.kernel.org>; Fri, 29 May 2026 14:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780065919; cv=none; b=r2MqhrewsxYw2+EysTVBBwYqpLS/k6QwXah7B1a+zWuXOa0Gt4VRwFTw76zYcHfYrO0rJs7JxB40nadF3klDYXk9dW5Z/WuCdoO0zWcfLlGaJhEi8hdaJ15RIoplOsU3+5y0vPauGIk0X1izoE/mCQ/smDEj+e7Vd63U5gRBL9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780065919; c=relaxed/simple;
	bh=CoPJIZSI46YKZQvif20N8ynjdQo2BPPlyBaBoo8Emxw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hpsQIX3yN1ZjIqrBQJSgAe/ffwiLkGwgYKzfxvdfEtmmWv2xn/n8IARzszg1p2MiSfW98pFh0WUeIy5PfgR0Y264TazED0PyghzMf+v1PStizD/YZJiTyInAYHtiS0D0sZUhqgjSI7bRJ73y+tMuQTC9+C1kvh222GbJXtcUXek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XiIBNBOX; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-369467ab5bfso12129299a91.0
        for <linux-hyperv@vger.kernel.org>; Fri, 29 May 2026 07:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780065916; x=1780670716; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=uWYqy9oq3guwZeX1CT7rpLN1sV47Joj/CY0UrflMOfk=;
        b=XiIBNBOXOefMQ5nZn9iDj18xQBRQQXjW140UyNW1pHArVir09dE9ukJxg6UKMEVNpC
         lxlKRUAfNMHt5aStt7G+r304cHEkiMfeoki4q6TlZjkWhWFLqeXFDyKLwPoFnB92+Pgx
         bq79ZVy7auUlq8PnLfk+qy7Rg5Vs7DkRjUqDtWmBQje4xz8Z4/YdV2rIP509tUF7ajHO
         WAkT5hNbjazrkeYALqqUccSgxK0+SwMFQbKasK0EdnlGr1pTCYpD9yuoZhgqrFhCRlT5
         UzIIhmcXDEbY7sBxULSquKeXJtlVNXwrOd4UzqShEDhaO0M4+I1/d0ONP7q42kWmOOTx
         YXEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780065916; x=1780670716;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uWYqy9oq3guwZeX1CT7rpLN1sV47Joj/CY0UrflMOfk=;
        b=HJicmbvJ9yekGZ+kCa3DoX2cwqWbRLh//yluvGzHQ7cWQho1U0saNRZTHfjQ2Poqbo
         gppWnVZOygR+L5JP7cQPq+/VWRQCZjVRlCUQKtQY7mKqWUgEaybEX1zA4SGjN/4NCakE
         tEueg6xxZzHvxoSXq+SndWgK5VcV2ItmbN5ltRBXlM9BG7j51syqNsU948vfN5UV0eDV
         hv7F/Uv1g92AAAz35FsUHluAkIfsl7YdKpI3e+kPF77qL1ruFOgH10EDIMxGv7cKrOsE
         Ua6JY2qPIkKsc4mjvp/Bk5XAQGzSdvufamPAzk7ikc8UpH9xYhpr8WChrrn2LStJ7CK2
         xREw==
X-Forwarded-Encrypted: i=1; AFNElJ/UxdZcLsbEfAegGGJVISC9biddc66UwbtE1dLl2grIYr+fgJNc7CyTZTO2MTuuXr5E4iIg17e6NyVNAWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtRyl4x8gViUEPH3/sIzveUHqB8NcK5f24WNDb7giCOAVk3y5m
	78KFZ/SV/pA3Cmkj1Kas2iSApr2a+IQQqoqqLlJfDmi10pQh2j1ssI1RN9WySMvW0m/pV7GrAQF
	JZFYTKg==
X-Received: from pgce4.prod.google.com ([2002:a05:6a02:1c4:b0:c82:7a7f:9bf6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:4d02:b0:39f:aa3:5e56
 with SMTP id adf61e73a8af0-3b412058e7dmr3539717637.14.1780065915613; Fri, 29
 May 2026 07:45:15 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 07:44:07 -0700
In-Reply-To: <20260529144435.704127-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529144435.704127-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529144435.704127-21-seanjc@google.com>
Subject: [PATCH v4 20/47] x86/kvm: Get CPU base frequency from CPUID when it's available
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11342-lists,linux-hyperv=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 8BB6F60420B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

If CPUID.0x16 is present and valid, use the CPU frequency provided by
CPUID instead of assuming that the virtual CPU runs at the same
frequency as TSC and/or kvmclock.  Back before constant TSCs were a
thing, treating the TSC and CPU frequencies as one and the same was
somewhat reasonable, but now it's nonsensical, especially if the
hypervisor explicitly enumerates the CPU frequency.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/kvm.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index c1139182121d..c81a24d0efdf 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -50,6 +50,7 @@
 #include <asm/e820/api.h>
 
 static unsigned int kvm_tsc_khz_cpuid __initdata;
+static unsigned int kvm_cpu_khz_cpuid __initdata;
 
 DEFINE_STATIC_KEY_FALSE_RO(kvm_async_pf_enabled);
 
@@ -928,6 +929,11 @@ static unsigned int __init kvm_get_tsc_khz(void)
 	return kvm_tsc_khz_cpuid;
 }
 
+static unsigned int __init kvm_get_cpu_khz(void)
+{
+	return kvm_cpu_khz_cpuid;
+}
+
 unsigned int kvm_arch_para_features(void)
 {
 	return cpuid_eax(kvm_cpuid_base() | KVM_CPUID_FEATURES);
@@ -1049,6 +1055,14 @@ static void __init kvm_init_platform(void)
 #endif
 	}
 
+	/*
+	 * Prefer CPUID.0x16 over KVM's PV CPUID when possible, as the base CPU
+	 * frequency isn't necessarily the same as the TSC frequency.
+	 */
+	kvm_cpu_khz_cpuid = __cpu_khz_from_cpuid();
+	if (kvm_cpu_khz_cpuid)
+		x86_init.hyper.get_cpu_khz = kvm_get_cpu_khz;
+
         /*
          * If the TSC counts at a constant frequency across P/T states, counts
          * in deep C-states, and the TSC hasn't been marked unstable, treat the
-- 
2.54.0.823.g6e5bcc1fc9-goog


