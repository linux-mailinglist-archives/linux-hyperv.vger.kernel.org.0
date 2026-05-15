Return-Path: <linux-hyperv+bounces-10945-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHt2GFV0B2r03wIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10945-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 21:30:29 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A76556DA2
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 21:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E36A1305752E
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 19:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA654F7993;
	Fri, 15 May 2026 19:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eq494Ve/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF5F382F1D
	for <linux-hyperv@vger.kernel.org>; Fri, 15 May 2026 19:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778872857; cv=none; b=WEG7TybmsA+CJkc/NV4xpzkB+l4jSkHRBXfSbCny15jythYMPuzLkRwtmGBMKOKIu4lfpnkOgF5eVa/GJ7/+OMx5H5eRlqL1z9T6/CJXxrrDV7T9w5ah5/w0yiQDRak2qbd1aiib12Zt3MflrRI8j7aY0i8gvDA0qWd1DSld2Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778872857; c=relaxed/simple;
	bh=lbZq5HMMUdoKD8t+V1QOxdv8UCq5RsQl+bpxwZwTljc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VOc/UcQl4xDkTQ33wJtrPOGdaGDqfBgpjmjXCL5sMTJDoeoiQ8zp/SRLPtmAl1zVbi9SDe5UYR3uqTlWpa7QINYqaM2VPGpufAUSARB7kgLw6E30zYhCwNMtVPHQSQbffoY0JG0wQBmONS0P9VxWh4PYTZNw6afyggOYnt5wFJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eq494Ve/; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c8279604464so193716a12.1
        for <linux-hyperv@vger.kernel.org>; Fri, 15 May 2026 12:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778872855; x=1779477655; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=BtD3/8r1rxxPL0bRTCD1R2r93qIzEoWuEeKvRfTm7KE=;
        b=eq494Ve/TYFJex7FCne50MgPTq4OKBcYwIkoPj6cyggtcnY9i1TmQKg6ZTM+Txku8j
         kOJLYYGTyllSNMsjN675NMMSDIreI122ZtDQybkdBKcKczZMzfs/fVvmMoo+cO7wiHGx
         snpSgiqZNq1lXeJ6ISiHbGho7Efzlyqrjuo6M7FxHkVaB5NPGX4Y79BQHAx5s0WPrZUt
         7nTE+lZKutQv/wmMzKvsiD0EGjkDTj9L7meotK49TrMWpSfRBq3VsECae/R0hEyElNDr
         zYFTZ0KHgXzfaZ38nkbtqdzrwZ0nEE2KlefKRSjCMnc0a9LCe5VZUhwQVLVFIusR8uim
         fe/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778872855; x=1779477655;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BtD3/8r1rxxPL0bRTCD1R2r93qIzEoWuEeKvRfTm7KE=;
        b=XoTEpyWyJxxVdKXlr89/Zn2OwrwCILSS99tYKiF3JGzvCY87vKBL0XYU6eBC+gD4MT
         t9UnAw4a5yKt5g3Xg7ov7eeij+uFqyxc09oamMkbca/Lxwe2U2XsfHwQbvvuUkRUMJaw
         N4aB0gyJwlD42W15dtLkscaOGTpYQib9RHxj1/Gx7nRpyjFrEBxYC/Whzy0+ivk2PHU0
         q5JRiqS1OL04Ub2ZzQPHGD6ZGPMz7C0optMh6NTXv8dV1yaRTmSz3YDd0B9paHLdntTp
         sFVJSArkbmk8UrAYjO98WV2cfoXquyadN/ISAypzv4Tpy2DORmH71Kb5fx72XIgZ7HZw
         A1iw==
X-Forwarded-Encrypted: i=1; AFNElJ+0ZPI1oNDpujGPHKv2MCkEnEIMTZ+MEBkHjUZWDLUGeKiEX3GEbHGFaLVAUxSzRlmsheV8e0S163y67Lw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyxisNHr1UjsPApwVVga3H2OS2ENOU2BHBFmvAaTa1px4Lyk+B
	eSUvcUHY/9zTiLOhO0pn2iEtNdrrLFRr2rjf2MUdoQGbmbbvEKKOZ69l6MQ9sp6A4Zc4SL7oNEt
	1GX4hzg==
X-Received: from pfbly26.prod.google.com ([2002:a05:6a00:759a:b0:82f:a4cc:2fb3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:ac86:b0:82a:805a:7e2
 with SMTP id d2e1a72fcca58-83f33c4ed90mr5838917b3a.9.1778872854522; Fri, 15
 May 2026 12:20:54 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 15 May 2026 12:19:23 -0700
In-Reply-To: <20260515191942.1892718-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515191942.1892718-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515191942.1892718-23-seanjc@google.com>
Subject: [PATCH v3 22/41] x86/pvclock: WARN if pvclock's valid_flags are overwritten
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
X-Rspamd-Queue-Id: 61A76556DA2
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
	TAGGED_FROM(0.00)[bounces-10945-lists,linux-hyperv=lfdr.de];
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

WARN if the common PV clock valid_flags are overwritten; all PV clocks
expect that they are the one and only PV clock, i.e. don't guard against
another PV clock having modified the flags.

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
2.54.0.563.g4f69b47b94-goog


