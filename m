Return-Path: <linux-hyperv+bounces-8102-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4F6CEAB09
	for <lists+linux-hyperv@lfdr.de>; Tue, 30 Dec 2025 22:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 09A4F300B8DE
	for <lists+linux-hyperv@lfdr.de>; Tue, 30 Dec 2025 21:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9EF30F524;
	Tue, 30 Dec 2025 21:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RTLKa4iJ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB078320A3B
	for <linux-hyperv@vger.kernel.org>; Tue, 30 Dec 2025 21:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767129243; cv=none; b=KfEcwXbC65fp5sIvT3cGqUBpdDD1dUYusXfpirauKc1sD2i+VMsLFoCyWYvmAjq57dk0lVktWGqdF+twtal6bWoo7A4HsoTD4qp2KxUBkSwARCEnu3HrgAPsCD/gAUcRkLwAOQO9OYo01ufUIau40KZ7VKernCKyPNgZXjFGZy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767129243; c=relaxed/simple;
	bh=tZZOSec6/iCpiyzfAUT+ddNkhTixOC1p46bySbF1Lsk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AtDiYfg7DK8wlPyoj2wEfCh9/bUaApcWf+lZvYGPfXzfL82EzNdd3aYHlhV0cBb+v+pQwxmQpwUWTCo6CAw9yU1FREV85vIW477J6NG+i6J5PifS2Vfar+WkEoD/03PP6byXW+IaxfVdDgKo2vKCSx8BLvc1AYt9JSG3wQQQyjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RTLKa4iJ; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7c240728e2aso21712035b3a.3
        for <linux-hyperv@vger.kernel.org>; Tue, 30 Dec 2025 13:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767129241; x=1767734041; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=1VNAutqDSG+oAcPpulLkMbiDreEONHN5ynm2RRYnZD4=;
        b=RTLKa4iJxEMv0kdR7Ci+DS7Nhisl5cJKuff7pbFxhVp7jOx2HdQ6xE4XOAapvXnFPg
         8KhAHFyw8CqW84ukJPUbEOmXcgwHU+g3JDpuze6lXIlPGUySdHsyxTnB2kEw4OLW/Bla
         Tn+iLc25UgTDRW1nKZ08N+Ks261MSEed73sFPoZ/O8d9W2zXtcg2k4mcYvZTcd/3Aaht
         tPT/+x7ZF/WJOeWTEpxLopFFJyzwq+WRXvGTAgWuLN3TiTUkLaqWgzxliqYhS1k86J/k
         nIPtZOBiooVjd5XYitgZigwgia/XgIQ5w4JN8Z4IlMqWnWDtF2Q+gFi+Ett3JyzpOLT6
         iVoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767129241; x=1767734041;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1VNAutqDSG+oAcPpulLkMbiDreEONHN5ynm2RRYnZD4=;
        b=GHGFNSfZk07ehs4Huo6rlQ94SR2wcH7hfMRl0ytAnbsG60AaWKHQnV1igQjhiLRvzY
         uhu6BlcyuWhIp8MNNAV79Nrm/jQQ6ITgzLoVA3R3FAGvIRQDyOOMK8n28ltF1mprZc5y
         qF+erNxbr4qXbvwB3p7oCyX9GVx01vUWpJs/8OKyFJ1ItPKjXyzv8mQk7ghOLg84Ee7j
         FOBSEd2cW9b97CcJC23kDY/uPDQvQQiMIuniqKbOAiqcGz9Mf/3AVlWyRhdYCGPXC/nQ
         FR/q51GMtXtjXSvMIoPlUdI92NjnzixnC8vyzb61QL99n2nWbpcWnvKurtPtOpA3uzVp
         gYfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVZhB/AD999wHHn9uCgRJt1Ihx+pkTMybAA160JevDjoZ9urRWYrNd1KJI591prlgpghEJjY5iSiIQK3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHPiKTooCGc9CIF3o4P7x8IEVcPLAxfmRm3gbvQAPOMLXn0Yzi
	ysS+MZM3p5O+zt44r5QEneBFPx77fsVtrj8mtgQaW8DotWug/Hle96iwRBlXTnG/aCTdM4BO/+9
	NjzlNRA==
X-Google-Smtp-Source: AGHT+IH7+mef/Yt8vBYVv2MwxPLoJav7Z17cT1/FRzx/Cb02MsEGBMNYfWKFBUDmhPe7ZcDuK/w4obJ/XLg=
X-Received: from pjwx15.prod.google.com ([2002:a17:90a:c2cf:b0:34c:64d5:2aa1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:2591:b0:366:14af:9bbe
 with SMTP id adf61e73a8af0-376ab2e78f3mr34274847637.72.1767129240895; Tue, 30
 Dec 2025 13:14:00 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 30 Dec 2025 13:13:45 -0800
In-Reply-To: <20251230211347.4099600-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251230211347.4099600-1-seanjc@google.com>
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
Message-ID: <20251230211347.4099600-7-seanjc@google.com>
Subject: [PATCH v2 6/8] KVM: SVM: Limit incorrect check on SVM_EXIT_ERR to
 running as a VM
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>
Cc: kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>
Content-Type: text/plain; charset="UTF-8"

Limit KVM's incorrect check for VMXEXIT_INVALID, a.k.a. SVM_EXIT_ERR, to
running as a VM, as detected by X86_FEATURE_HYPERVISOR.  The exit_code and
all failure codes, e.g. VMXEXIT_INVALID, are 64-bit values, and so checking
only bits 31:0 could result in false positives when running on non-broken
hardware, e.g. in the extremely unlikely scenario exit code 0xffffffffull
is ever generated by hardware.

Keep the 32-bit check to play nice with running on broken KVM (for years,
KVM has not set bits 63:32 when synthesizing nested SVM VM-Exits).

Reviewed-by: Yosry Ahmed <yosry.ahmed@linux.dev>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 105f1394026e..f938679c0231 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -425,7 +425,10 @@ static __always_inline struct vcpu_svm *to_svm(struct kvm_vcpu *vcpu)
 
 static inline bool svm_is_vmrun_failure(u64 exit_code)
 {
-	return (u32)exit_code == (u32)SVM_EXIT_ERR;
+	if (cpu_feature_enabled(X86_FEATURE_HYPERVISOR))
+		return (u32)exit_code == (u32)SVM_EXIT_ERR;
+
+	return exit_code == SVM_EXIT_ERR;
 }
 
 /*
-- 
2.52.0.351.gbe84eed79e-goog


