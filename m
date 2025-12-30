Return-Path: <linux-hyperv+bounces-8104-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A497CEAB15
	for <lists+linux-hyperv@lfdr.de>; Tue, 30 Dec 2025 22:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CE014300B8E6
	for <lists+linux-hyperv@lfdr.de>; Tue, 30 Dec 2025 21:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9BD6301472;
	Tue, 30 Dec 2025 21:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nuzBUEO/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE38832BF35
	for <linux-hyperv@vger.kernel.org>; Tue, 30 Dec 2025 21:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767129246; cv=none; b=fov0GCCbL88ud+ldYIvInssHYlxwHjqDyEOfHvU9ucjz0cVeywRWytdeccoyWXrkUtzo0I6nay0YnoeHxnDe92Epnpuz4hcU04TIp42oxLykqECLISfbj/cYE5vLHSBUVZOUWnAxzNNGZsba9Fz3tjPiD0XuiaMjzJ19y5vu9Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767129246; c=relaxed/simple;
	bh=HJ4XqLT0jDF3jn5B2II3Oe/iMA/CkcZuvDCcogN2UCI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fVz0QP/plRoHf3cLX+B0H4oDykGZiVyXfK1ifMzZqHLq38OR65tOZ2VzaDQ59yKJ4ijkTUudBj/F9qacU22MzH/H98ZmsQHaCOZK6JiGHrzflBUgI6uOG2zu9R6C7KRw5J5B69gvajAMrczVBqxHZ1pbuvxltoK90llb6V6tWzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nuzBUEO/; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-29f1f69eec6so129748685ad.1
        for <linux-hyperv@vger.kernel.org>; Tue, 30 Dec 2025 13:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767129244; x=1767734044; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=XsseyC8LpXkejrQLUQtTZ6AiUdHm1+Ya+dND1b51e8M=;
        b=nuzBUEO/r7GNfZDfupqYZ1tqabW2Q3sRxZHV2hwQSt0HkBg027pqwpUWuC+OXkgA+3
         xbwKr2l8MOEWq6OFQomB62a9cfsP1uTdOKUBs74wErRnXvD7xpX5/BHprBzNIqOQoYc/
         LQT4f0h8lm0ajXgkESKJDCCqrX76GX7Xm7jiLpWJMfG9HrpUtEIAvnIikZJcNvOTc2xQ
         1BiSK6rjohIo7a6WT4/yH3LunjfMSU6EH1jAXRgavOrPkZDPFXWb0u/yR0E3gskAWkMh
         TrKNzoXFhYYzfuctk5w1JsxTsTwvI/KHs/XmADj69kugbnTirVC7xwSWVoarpSyCdoT6
         w46A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767129244; x=1767734044;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XsseyC8LpXkejrQLUQtTZ6AiUdHm1+Ya+dND1b51e8M=;
        b=ev23nS82hhV3j/mwiYdTZTK4b9EZ2PV2pKiu5A4zKHIHiugLvvLGnJ+F3D4Y2PMFty
         SKxCkj4zn3FgO+48GvidHlhWf4to3UbHl8ea15TRSaoEewnY4MhrJ8dh+O/jEOCGM6QF
         4D9GimCeGbIfM42Hs9CmESLyWI6GlBYhQ5e3rpW4dg9hKqLK7v34qT9fcGUMucI3FDEN
         IV3zb2kYBgMQjj3FbEdLcSTo3LFdEhqJDS6pn5owqkKQRMhLKM96d11aYmpOjOabmd2z
         0uLYbrASwKfIUNGedX1FYVmeYXmB96tcqGSG8Chj5cD5zkg9VVP5Cd78VfBWjkt09iZ2
         rOFA==
X-Forwarded-Encrypted: i=1; AJvYcCVsLC4xRB6ZQVLG+ZsStAjWM/QmGXgcvOomKkdL5pEej07VKoSFindQFUOi/Mv7aCk72/0D+1j/MnCRsfg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIvN5pwTp97l0/ZtolDbhb+P0VgQhNay/r8A7SUkybliGOLbV3
	DJvuf6g84bL+Jh1tFd9EUE+fMDS9lUflhcrkgJ+CA6AWTS1XxOrZq4wR3np11cjOHe6+UFPAv8c
	boEFETQ==
X-Google-Smtp-Source: AGHT+IE//Ytz9zMUfHCR02XePiAuIy+TlWHCW2xgVPHTiRzkpHTVtEE56Y8+nZktCmfwELz3dGzt6UzrllU=
X-Received: from pjbnk22.prod.google.com ([2002:a17:90b:1956:b0:34c:4c6d:ad4f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f708:b0:298:efa:511f
 with SMTP id d9443c01a7336-2a2f283680cmr312460165ad.39.1767129244235; Tue, 30
 Dec 2025 13:14:04 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 30 Dec 2025 13:13:47 -0800
In-Reply-To: <20251230211347.4099600-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251230211347.4099600-1-seanjc@google.com>
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
Message-ID: <20251230211347.4099600-9-seanjc@google.com>
Subject: [PATCH v2 8/8] KVM: SVM: Assert that Hyper-V's HV_SVM_EXITCODE_ENL == SVM_EXIT_SW
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>
Cc: kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>
Content-Type: text/plain; charset="UTF-8"

Add a build-time assertiont that Hyper-V's "enlightened" exit code is that,
same as the AMD-defined "Reserved for Host" exit code, mostly to help
readers connect the dots and understand why synthesizing a software-defined
exit code is safe/ok.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/hyperv.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/kvm/svm/hyperv.c b/arch/x86/kvm/svm/hyperv.c
index 3ec580d687f5..4f24dcb45116 100644
--- a/arch/x86/kvm/svm/hyperv.c
+++ b/arch/x86/kvm/svm/hyperv.c
@@ -10,6 +10,12 @@ void svm_hv_inject_synthetic_vmexit_post_tlb_flush(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 
+	/*
+	 * The exit code used by Hyper-V for software-defined exits is reserved
+	 * by AMD specifically for such use cases.
+	 */
+	BUILD_BUG_ON(HV_SVM_EXITCODE_ENL != SVM_EXIT_SW);
+
 	svm->vmcb->control.exit_code = HV_SVM_EXITCODE_ENL;
 	svm->vmcb->control.exit_info_1 = HV_SVM_ENL_EXITCODE_TRAP_AFTER_FLUSH;
 	svm->vmcb->control.exit_info_2 = 0;
-- 
2.52.0.351.gbe84eed79e-goog


