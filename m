Return-Path: <linux-hyperv+bounces-8103-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C48CEAB0F
	for <lists+linux-hyperv@lfdr.de>; Tue, 30 Dec 2025 22:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 890C83008470
	for <lists+linux-hyperv@lfdr.de>; Tue, 30 Dec 2025 21:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5B932C94B;
	Tue, 30 Dec 2025 21:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="os5/JEm2"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F99E2FF14F
	for <linux-hyperv@vger.kernel.org>; Tue, 30 Dec 2025 21:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767129245; cv=none; b=ionr7/gKcjgoaxggKLx1zMjA5X4l9ybIYN0jzE5KOThTjd0wTiFNRxGeg7+wEK/cBxAHEFhDQo/Qo0wn6aGZOWXbjK/L7uuZchftpm2g6UDJI04GZqyel1u2P3mQxXcNGfVW8pnT1O6mZRYbSb22qx99pYwA2JeAPZJ1dgMZ91M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767129245; c=relaxed/simple;
	bh=EoxLt9CGajQHyT0DJbDfFAocT+/8S1HWJ5svkZDig3c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JTdXvAsoxoNKoKFKhRwGkYqVFZFKthnoDcOmLLVDWgtQeZMESmf2v39G15oGyrN8+RMdQKpXFPsTB15h+/wVt+8SVlqO3w95C0jQcVbaDnKiJ0W6UPTA/xObzPjzFydrC6jlM4Ku4Vmk4LvR5+Fw7llFcIFKvQJI+S/BvKoFzNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=os5/JEm2; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-34cc8bf226cso22964534a91.3
        for <linux-hyperv@vger.kernel.org>; Tue, 30 Dec 2025 13:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767129242; x=1767734042; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=2l8e4mfqS4ac0ofFyg/wkIl0NnSi9zztS3YUrfbABw0=;
        b=os5/JEm2Ul6c6d87T7xL5TwPVMfUfOnhhZbuxICN8a7SyAi5zKvMLFi1QeWhbIMDI+
         p63GLOcB5vhyOqQa1FEbsmQWbtseDJMrf5Ws1efl0pzOVbAoG/TPKE95/Dvxgw0+AwZb
         iw+aCBxa8s5Lg/pglHvOQksKZfdgzPMAzu7tmOqUU+dryF8JZPEP0Z29zVDXbQJRzQaN
         cE0k7c9+uiv3FDszjLozErFt6m1OgyK2w8W/tok7dASOybaBFPdTR1QoO7804Oxv7/QD
         tjOYEtJsahAGJTsUNirKFfsUYQkDY9kL5wCKw+EKGoSE6OngI6f+FbcVLxkeUzB4yGw+
         sxZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767129242; x=1767734042;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2l8e4mfqS4ac0ofFyg/wkIl0NnSi9zztS3YUrfbABw0=;
        b=FSUZRYnMbfwd7Rl6TXYiCh2cFYbMAdINSVxndqV+/Bw3wPK1i184TDMr8FPju3F8/k
         lFIF/jl9YEOG/gcEDkQnbFP7D0GLlIbJqBkWs4xln+0lBJmldlF35dnSqbL4JJswKmw5
         N0nG58MDOAFaCFdvnOwe3HOISoSyNjDWXC8HPDHf0iwpeCiduEkeYjlQNnY4b2WPBqPh
         855nQELue6G1DCIdVYMtzfitxf5Ttb43MRUmYxq0K+hj4IA2heR4+AwHs23hb+x9PxdK
         FXhsIMwPs1Lw5LDdXgXIa6IY38Vwg6GOozxP8vA6Xtg27n73c3+GSKXIMzsY8KeBkFDi
         JKnw==
X-Forwarded-Encrypted: i=1; AJvYcCUvE0geN769plSpjscnHPfapoXlPPSO6BUW4DoEvkbPBnc9s7dYnINaQn6qcX12KZPTMSB/WkUzxc0NUQA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDAZPzyP44wWGCRTfsL00XTF10u3BGaCe9N9DJqm/Mt/0s7akH
	qVhlddjzKnjqXvZFJ11mluQnH2cDzScwU20tf/XH27v5gYCR4ia2UFI8XzbXU+DtzBT9b11aU3r
	LA1jdmQ==
X-Google-Smtp-Source: AGHT+IEsJzuAlVbFq5IPl1q5CmU3amILxSyhNqXHiYg4ksn/VgJLbcnzFFETfo0s8qcklc5ptFrdojqRGHw=
X-Received: from pjbot5.prod.google.com ([2002:a17:90b:3b45:b0:34a:a5cf:dcfd])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:514b:b0:341:a9e7:e5f9
 with SMTP id 98e67ed59e1d1-34e91f6759emr24551317a91.0.1767129242518; Tue, 30
 Dec 2025 13:14:02 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 30 Dec 2025 13:13:46 -0800
In-Reply-To: <20251230211347.4099600-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251230211347.4099600-1-seanjc@google.com>
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
Message-ID: <20251230211347.4099600-8-seanjc@google.com>
Subject: [PATCH v2 7/8] KVM: SVM: Harden exit_code against being used in
 Spectre-like attacks
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>
Cc: kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>
Content-Type: text/plain; charset="UTF-8"

Explicitly clamp the exit code used to index KVM's exit handlers to guard
against Spectre-like attacks, mainly to provide consistency between VMX
and SVM (VMX was given the same treatment by commit c926f2f7230b ("KVM:
x86: Protect exit_reason from being used in Spectre-v1/L1TF attacks").

For normal VMs, it's _extremely_ unlikely the exit code could be used to
exploit a speculation vulnerability, as the exit code is set by hardware
and unexpected/unknown exit codes should be quite well bounded (as is/was
the case with VMX).  But with SEV-ES+, the exit code is guest-controlled
as it comes from the GHCB, not from hardware, i.e. an attack from the
guest is at least somewhat plausible.

Irrespective of SEV-ES+, hardening KVM is easy and inexpensive, and such
an attack is theoretically possible.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index b97e6763839b..a75cd832e194 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3477,6 +3477,7 @@ int svm_invoke_exit_handler(struct kvm_vcpu *vcpu, u64 __exit_code)
 	if (exit_code >= ARRAY_SIZE(svm_exit_handlers))
 		goto unexpected_vmexit;
 
+	exit_code = array_index_nospec(exit_code, ARRAY_SIZE(svm_exit_handlers));
 	if (!svm_exit_handlers[exit_code])
 		goto unexpected_vmexit;
 
-- 
2.52.0.351.gbe84eed79e-goog


