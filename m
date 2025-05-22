Return-Path: <linux-hyperv+bounces-5635-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E071FAC189A
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 May 2025 01:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22F79173CFC
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 May 2025 23:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B082E336F;
	Thu, 22 May 2025 23:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gm251MBb"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C862DFA48
	for <linux-hyperv@vger.kernel.org>; Thu, 22 May 2025 23:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747957974; cv=none; b=G5X8u3JVXfg++4WqvV3yB6bS5o/nACTPV66YDtUn87V+MiQwMg4A+me2EypbRLxmN8wEDGHdfago7Vgr+Hwu1Yqf7jfAJh39V+OEWsVPo5RhJzY3DUh8kyfiUF5LQEzsmUcAJ3C63VOU5kSj6hDsrbkX6Tqmo8SqnBPxdVx0KWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747957974; c=relaxed/simple;
	bh=gmLT2D1WB9vmr8rFdHxMOpHNwXh7MFDJ6xUGtYQhimw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NLtsXv0REG5EK/fxTpLx5fkgkUyu1ZKSM6u/orLJ8/XyuWaM9lvE1vbqRQ9sE+c0vUoCuSAGJPph3nCyro7TBoeud9Ol7C+IPXlavVktsbOaAUwfMDi3lkFGF/D0u9ZZApfFoHP/oMwz55kOCRPcXk9U+nOjZP6K2r1n5MfZLQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gm251MBb; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-30e7f19c8cfso9487692a91.2
        for <linux-hyperv@vger.kernel.org>; Thu, 22 May 2025 16:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747957972; x=1748562772; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=jjMNjs+bdNtZTb3Wdy6sSLCs56ksmcfEkIHqJR2gBFc=;
        b=Gm251MBbxSTPwRH8ghuckno+ronDdEVl9sRm7VO9nmeiheBfzwBds6nbGRsRwcK7yd
         waCOi+bmfnP5ESrxPGUNt/ILIpm4yL8O/zCKI88eggpbSfA+oP4+ormkJhme3Do7huYt
         w51fnUMn7VRahjSMoyFfxbtlrdSysOJjoqXf4aaAjGu9ZuhkV9ClZw4ax+NqABswOwqX
         FC/W5QndXARcH0lEWopnRD0yHOPHaBneQcYSyuM6VFS04Nw7i9zqLXZVwa7QO2LurjDU
         1d+4C3XWtG+oy3HZFOV0l+GEhj9eyi1UvZUt7mIebsMmWRcqXumfC2Kt6/SF79hAPmrr
         l0UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747957972; x=1748562772;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jjMNjs+bdNtZTb3Wdy6sSLCs56ksmcfEkIHqJR2gBFc=;
        b=Bg/T6Vpvq6y1wx8wE/qbWwhYO48lmLcLaJkxabt2kjv8N8j6E4oALiYfKTn5Zafypy
         HjGnm7DY6Sj3zJCFKOJlvTu2hsAg9t9MAyy1uhSFw2cAe3/BUHN8QAS/yrBQWLi4/kly
         TDkMKWmrWvuYKjnR+WqHRUQjBPsyjqDXREC2rmqPBrngeMVUZmXj/h3rkk55Z0whjCTm
         YazbINy27TDt7Fb05H6tJullIaHXCilWPA6sWCXauDgoQ8DfZ1zKr3qct5+mx40Xsqrh
         CiGzRl+zdk1NGBFxUYUDmcV8I/2HxMh8oh2q++fjHW5EeUQ5wLKl7M6B1hf4Nnsx96WX
         lNYg==
X-Forwarded-Encrypted: i=1; AJvYcCWTmjB9R0dP+bEGn6xyeMRbVMHYFEkeiz0s0ZUFiWb5Qud35k8tXppYRfnl3uu+ClFqsYnp5yfQ3aPVRLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YztAH4eGDh4bIgI+pRc7+Z/wjXscS0g1FbBE8fEy96jau3jvBKY
	Vl4ZPTI1e8/1/AUwUE7lHK59H9JQCifwp0F63qXz+0TFWsguMixIHe6k5cCn5H8X3YZpNieey6l
	vO0mAFA==
X-Google-Smtp-Source: AGHT+IH+y/4Vqk1KMF3LjOCFUbppIPh5ZUErAvUoiEDW2SE/2hXGiqyTLKxlZ9Xh8ZuSjxO0WF45GST49oM=
X-Received: from pjbdy5.prod.google.com ([2002:a17:90b:6c5:b0:2fc:1356:bcc3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:510f:b0:2ff:58e1:2bb1
 with SMTP id 98e67ed59e1d1-310e973e510mr1311217a91.32.1747957972660; Thu, 22
 May 2025 16:52:52 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 22 May 2025 16:52:21 -0700
In-Reply-To: <20250522235223.3178519-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250522235223.3178519-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250522235223.3178519-12-seanjc@google.com>
Subject: [PATCH v3 11/13] KVM: selftests: Assert that eventfd() succeeds in
 Xen shinfo test
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

Assert that eventfd() succeeds in the Xen shinfo test instead of skipping
the associated testcase.  While eventfd() is outside the scope of KVM, KVM
unconditionally selects EVENTFD, i.e. the syscall should always succeed.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/x86/xen_shinfo_test.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/xen_shinfo_test.c b/tools/testing/selftests/kvm/x86/xen_shinfo_test.c
index 287829f850f7..34d180cf4eed 100644
--- a/tools/testing/selftests/kvm/x86/xen_shinfo_test.c
+++ b/tools/testing/selftests/kvm/x86/xen_shinfo_test.c
@@ -548,14 +548,11 @@ int main(int argc, char *argv[])
 
 	if (do_eventfd_tests) {
 		irq_fd[0] = eventfd(0, 0);
+		TEST_ASSERT(irq_fd[0] >= 0, __KVM_SYSCALL_ERROR("eventfd()", irq_fd[0]));
+
 		irq_fd[1] = eventfd(0, 0);
+		TEST_ASSERT(irq_fd[1] >= 0, __KVM_SYSCALL_ERROR("eventfd()", irq_fd[1]));
 
-		/* Unexpected, but not a KVM failure */
-		if (irq_fd[0] == -1 || irq_fd[1] == -1)
-			do_evtchn_tests = do_eventfd_tests = false;
-	}
-
-	if (do_eventfd_tests) {
 		irq_routes.info.nr = 2;
 
 		irq_routes.entries[0].gsi = 32;
-- 
2.49.0.1151.ga128411c76-goog


