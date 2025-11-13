Return-Path: <linux-hyperv+bounces-7560-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C50A3C5A67B
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Nov 2025 23:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63E643A67BB
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Nov 2025 22:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D4032693C;
	Thu, 13 Nov 2025 22:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GlS1JJCj"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012E62D7D47
	for <linux-hyperv@vger.kernel.org>; Thu, 13 Nov 2025 22:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763074590; cv=none; b=qRCdwoGXrG3+h5XaeeYdb7KSp84xF6uWqaaluibgk/32zVpebC5iUNDWu1pxjzjmF1YPz0gJ6YNsHh4bvYDxv5FnfoTZRT/Z9AzLwrK7RWPOd+uqPN8Hau3SmFBzjsjQM0wpKEuZTdGi+joiDa9u2J2dTiQP1RXa8dm4T1TkX8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763074590; c=relaxed/simple;
	bh=JpkwLkYqfTWH2af+ev8jNXHZlL9P9xWFIzFSqfC4azA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hhkSNAPpg6tT5ySRj8MGqBi43htRrKCpYNU1zlFTBWtNx5osRih7UWrd3xsAWJdua4p/3JOeYxu0WWFv8MkYY1ib4JofRmIc9FQ9EpIBkCh/CFY2cqE3INGWiraJzysSUZHgWjJ9GWESJlJogvCGmph7UEviaIFtae7AMQui0cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GlS1JJCj; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-29848363458so33091165ad.2
        for <linux-hyperv@vger.kernel.org>; Thu, 13 Nov 2025 14:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763074588; x=1763679388; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wx3PLPcjBq2xtoETuBloY8IxxCjDmn23349GjtidbtI=;
        b=GlS1JJCjqo7c7XjeL1zYxj2ihqyWblpQqv07CHRNR3NJYcTgyql5WVJxd+E+xQVnL9
         LRepsqG8H4HaXAWpGFEfRBcygNvGP9CYWxxlUX6xSxlQ+FFy7xyUnnP9r7nsL85bY9Nm
         QdHj2gfYOeLwKiTy45E4mySy8QEsVNBHATHgxwqyUMD6T7id91r3+Gspmkvw7ly2IqRy
         bQuc5M2Lk4EgcFuQ84kAv9CAtgXFpDdGdmzxHpAlIcgVKGe8oboXi1o2FtInnJQdv4RN
         tRKKN2d70iiKK0DRHjA2lE9L4TsmkES90tRISJ06jJAcr9OI4g3D/x13KHy0HG92+IUK
         K7VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763074588; x=1763679388;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wx3PLPcjBq2xtoETuBloY8IxxCjDmn23349GjtidbtI=;
        b=i+kmt6yLM3kGFbyfm0Uj40r+S34goxTmYNzH6Ep3JP+4458V/giec967yZ9rP7r72I
         5aZu3ej01gL6r/eu3TV/tIwm7XLov2twKxA07glUT0FVjDESbjzUhRXoR5RkCegZN+bg
         j2ZrBKCUOLbrwyH1yhjRuqln4B3/mNtc9oqApGPLBhjoEwFGebwaiH0FtFNnM+qre0hj
         OGA8tjtGUyxajiitLkL/FsKUt0vG8XO05XVdMgBV6isknaC1nF1U4VBnic/Oyv+3N2an
         kwXGi9qnx/xIrclHrZFMIkVlm/MeOBJKmJ0J5HTYNStEyGuKF3cDTaaSqddufq9nO38q
         hVmg==
X-Forwarded-Encrypted: i=1; AJvYcCXkFZwRPSrsslg0ohZXyH3QF5pvRUL6PUoDTGQS8yhvpXP5MneRbCi6HHQy9oSxuwGWxF9PjiXxSFZ3mQA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY7q0eS50I7wZm0dXxOwrnWwRThmGdIoR4kd8pfSRtY0Q3jjf6
	DrgHurkG+Rp8Ir+E2zgnmvIkVi6GsdGRhHo3iAg3tRetnJCrw+Xc48F44AgNhYw5hfs6ylp0s/Y
	f0Qw1CA==
X-Google-Smtp-Source: AGHT+IH8hcBLZQlPdbuJlMzm1zBVW2nQnz2ncq3rgCivH92im1o3royXQQqD/TFcgKzEMyHzondAYjwZTLk=
X-Received: from plmd10.prod.google.com ([2002:a17:903:eca:b0:27e:4187:b4d3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c942:b0:296:ec5:ab3d
 with SMTP id d9443c01a7336-2986a782c9cmr6357595ad.61.1763074588214; Thu, 13
 Nov 2025 14:56:28 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 13 Nov 2025 14:56:12 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251113225621.1688428-1-seanjc@google.com>
Subject: [PATCH 0/9] KVM: SVM: Fix (hilarious) exit_code bugs
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>
Cc: kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>
Content-Type: text/plain; charset="UTF-8"

Hyper-V folks, y'all are getting Cc'd because of a change in
include/hyperv/hvgdk.h to ensure HV_SVM_EXITCODE_ENL is an unsigned value.
AFAICT, only KVM consumes that macro.  That said, any insight you can provide
on relevant Hyper-V behavior would be appreciated :-)


Fix bugs in SVM that mostly impact nested SVM where KVM treats exit codes
as 32-bit values instead of 64-bit values.  I have no idea how KVM ended up
with such an egregious flaw, as the blame trail goes all the way back to
commit 6aa8b732ca01 ("[PATCH] kvm: userspace interface").  Maybe there was
pre-production hardware or something?

I'm also fairly surprised no one has noticed, as at least Xen treats exit
codes as 64-bit values.  Maybe the only people that run hypervisor tests on
top of KVM are also running KVM, or similarly buggy tests?  /shrug

The most dangerous aspect of the mess is that simply fixing KVM would likely
break KVM-on-KVM setups if only L1 is patched.  To try and avoid such
breakage while also fixing KVM, I opted to have KVM retain its checks on
only bits 31:0 if KVM is running as a VM (as detected by
X86_FEATURE_HYPERVISOR).

I stumbled on this when trying to resolve a array_index_nospec() build failure
on 32-bit kernels (array_index_nospec() requires the index to fit in an
"unsigned long").

Oh, and I have KUT changes to detect the nSVM bugs.

Because of the potential for breakage, I tagged only the nSVM fixes for
stable@.  E.g. I almost botched things by sending this as two separate
series, which would have create a window where svm_invoke_exit_handler()
would process a 64-bit code when running KVM-on-KVM and thus break if L0
KVM left gargage in bits 63:32.

Sean Christopherson (9):
  KVM: nSVM: Clear exit_code_hi in VMCB when synthesizing nested
    VM-Exits
  KVM: nSVM: Set exit_code_hi to -1 when synthesizing SVM_EXIT_ERR
    (failed VMRUN)
  KVM: SVM: Add a helper to detect VMRUN failures
  KVM: SVM: Open code handling of unexpected exits in
    svm_invoke_exit_handler()
  KVM: SVM: Check for an unexpected VM-Exit after RETPOLINE "fast"
    handling
  KVM: SVM: Filter out 64-bit exit codes when invoking exit handlers on
    bare metal
  KVM: SVM: Treat exit_code as an unsigned 64-bit value through all of
    KVM
  KVM: SVM: Limit incorrect check on SVM_EXIT_ERR to running as a VM
  KVM: SVM: Harden exit_code against being used in Spectre-like attacks

 arch/x86/include/asm/svm.h      |  3 +-
 arch/x86/include/uapi/asm/svm.h | 32 ++++++++++-----------
 arch/x86/kvm/svm/hyperv.c       |  1 -
 arch/x86/kvm/svm/nested.c       | 29 +++++++------------
 arch/x86/kvm/svm/sev.c          | 36 ++++++++----------------
 arch/x86/kvm/svm/svm.c          | 49 +++++++++++++++++++--------------
 arch/x86/kvm/svm/svm.h          | 17 ++++++++----
 arch/x86/kvm/trace.h            |  2 +-
 include/hyperv/hvgdk.h          |  2 +-
 9 files changed, 82 insertions(+), 89 deletions(-)


base-commit: 16ec4fb4ac95d878b879192d280db2baeec43272
-- 
2.52.0.rc1.455.g30608eb744-goog


