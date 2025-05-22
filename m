Return-Path: <linux-hyperv+bounces-5634-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BCD6AC1896
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 May 2025 01:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E8B6165D49
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 May 2025 23:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD232DFA4F;
	Thu, 22 May 2025 23:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1Sekf+m9"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915242DFA29
	for <linux-hyperv@vger.kernel.org>; Thu, 22 May 2025 23:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747957973; cv=none; b=LNesjEIaZ5LwE1+Zo0OxbrHaw3PU6nYuhGQ+3h8Yqoad4Cs8xPweo/uWhyOZahk068wTK+fLXhtegKS+KcTtYnOpUNkU9Zd+uii+H8Vd8U+wVp8NObpLc03OzNDSC+iaY4wxY7LvT8buAk4Y0p2CT7eyOwd6Pi2Xd2tVFLuIbWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747957973; c=relaxed/simple;
	bh=P37+G4c2/Xetu+3X+HtrukOmywQ+BBmCzZW3DWLRSak=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uPuKHxPaPvt6ai2Y3jN4RlP5gP9s8DnZCNVOlvUckzdxcD0QWSmhI0844cUzp/Y0+LJDz3TPFTyB/0duymndqKpFBmbhzGcTGU1ycAzX7TwrqvDu5du0v4t9V+T/s3eQGi4ltt61C8Vws9JHohK9jVlrvtHKBsvMK+dbLuKFvtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1Sekf+m9; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-310a0668968so2203653a91.0
        for <linux-hyperv@vger.kernel.org>; Thu, 22 May 2025 16:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747957971; x=1748562771; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=pJUovYaxFJgcXRp1TDFKS/NrFefgEp1AkGzEV1OM9Zc=;
        b=1Sekf+m9GkXG15cXDUMyCMD51s3BnD9WoIxFeWw5vLuRptVdU/uXyPjCz/SCAEqHHN
         0AzLN1TH4qZiY4z8w5yjG32rRgpSPndz5EPnnLOQ1TMe9NRwfWSvruPPZyzVnDaTh/q5
         vvvStG7IcHJAOS9zC5bU6x/90qdqPm0lgTrZhvEtK0SYsYXW3OHIvIxtsxeo+O+hwIFE
         rAL6r5r1par1TFEweY4yfZFor1c/oTqCCEiDoOC8+XAOiIBrl2KR9RRJExE+ABH/L5S+
         +euBQR6f6p25nUNARjqefdJRJ090BsZLawko2yPLN/g8yFgVL81ok6c6HQZNOppDfGrb
         GQ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747957971; x=1748562771;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pJUovYaxFJgcXRp1TDFKS/NrFefgEp1AkGzEV1OM9Zc=;
        b=FIhsZnKUAg9/UP3RlYDJGoLlHvSVcnX1QT2+8k8rrZROjCemJJeIbSNJblf0h/pACN
         WM9Uckbq0cL9m1q25A6xaZHOSeRTbX5A/SSCktUb0FHa4sw2++HsE4Zpddp+6KMHEyv0
         +aWOGLAmMRHyhWM6dXtXywsyx+4brcgoLNNQzIdb8KkaWUNG5jaeJfpiWDH/iNeAvD6H
         8cL6Dmh1atsxHA04ozl/k3sn9WiV/Jb+1gqfLtEoKf3Gf0jwp9f0CEq1g0zep5jkOXln
         231mxr3+s4W7WDaQ4t1uYEOhjKyJ9cJmtev813OvknaaGI79py2/CPNsPUDh1eMWq6sf
         JQ1g==
X-Forwarded-Encrypted: i=1; AJvYcCWl4UVUMHJjawASKWGjlML/329PVerKnds1b1VE3P2y0ViQm6IO7USqdVrvN0YbeawY/w3+v7uAZJGj3YY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww4IAKu2K6HlpkeFM8kShjCnF8/EVAvYhNm2fQSadou/ptzpcP
	c1/l221hu3X9IsYObpnkVqCzY7VOR8ta7L62qFhMOpbIOuyN4B0WdobLCTmBzQkTJWaPNSKCdQK
	gkgUQdw==
X-Google-Smtp-Source: AGHT+IEDndqxTWcCtq5oGwy52YECfaW+Ize1PqvGwCK7FSF7/oiShVYNO6fCIsKX/sBpVCvd/V18cyz4IiY=
X-Received: from pjx8.prod.google.com ([2002:a17:90b:5688:b0:30a:31eb:ec8e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:33c2:b0:2ee:edae:780
 with SMTP id 98e67ed59e1d1-30e7d548c90mr43873310a91.15.1747957970976; Thu, 22
 May 2025 16:52:50 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 22 May 2025 16:52:20 -0700
In-Reply-To: <20250522235223.3178519-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250522235223.3178519-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250522235223.3178519-11-seanjc@google.com>
Subject: [PATCH v3 10/13] KVM: Drop sanity check that per-VM list of irqfds is unique
From: Sean Christopherson <seanjc@google.com>
To: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Shuah Khan <shuah@kernel.org>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	xen-devel@lists.xenproject.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, K Prateek Nayak <kprateek.nayak@amd.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Now that the eventfd's waitqueue ensures it has at most one priority
waiter, i.e. prevents KVM from binding multiple irqfds to one eventfd,
drop KVM's sanity check that eventfds are unique for a single VM.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/eventfd.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/virt/kvm/eventfd.c b/virt/kvm/eventfd.c
index 7b2e1f858f6d..d5258fd16033 100644
--- a/virt/kvm/eventfd.c
+++ b/virt/kvm/eventfd.c
@@ -288,7 +288,6 @@ static void kvm_irqfd_register(struct file *file, wait_queue_head_t *wqh,
 {
 	struct kvm_irqfd_pt *p = container_of(pt, struct kvm_irqfd_pt, pt);
 	struct kvm_kernel_irqfd *irqfd = p->irqfd;
-	struct kvm_kernel_irqfd *tmp;
 	struct kvm *kvm = p->kvm;
 
 	/*
@@ -328,16 +327,6 @@ static void kvm_irqfd_register(struct file *file, wait_queue_head_t *wqh,
 	if (p->ret)
 		goto out;
 
-	list_for_each_entry(tmp, &kvm->irqfds.items, list) {
-		if (irqfd->eventfd != tmp->eventfd)
-			continue;
-
-		WARN_ON_ONCE(1);
-		/* This fd is used for another irq already. */
-		p->ret = -EBUSY;
-		goto out;
-	}
-
 	list_add_tail(&irqfd->list, &kvm->irqfds.items);
 
 out:
-- 
2.49.0.1151.ga128411c76-goog


