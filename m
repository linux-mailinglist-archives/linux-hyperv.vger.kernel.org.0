Return-Path: <linux-hyperv+bounces-6612-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 579E0B38F7B
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 Aug 2025 02:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 134C020539A
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 Aug 2025 00:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8721F3A1D2;
	Thu, 28 Aug 2025 00:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ULDox51p"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62832CA6B
	for <linux-hyperv@vger.kernel.org>; Thu, 28 Aug 2025 00:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756339325; cv=none; b=bejfhaswRyKhNoaozGuFdhNsVFelvNcULXCS//CAvtTaU/pA53saQEgC25amJUEzci8EZflwLZe/8MrRbcGURcwMniwdt74kzuDiUHR8rYpBeRxWzK91luxqOalQ8E1q8JOSqbl9XWzS074rDRzMRCKRSyWa9oTgIlSJOqNq1nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756339325; c=relaxed/simple;
	bh=zswYe5h9Zux3BU3V6n/2Y7ArjSVkrrMm1xmCzQlsrI0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=UA/5iyAwlKeC/M00lH3V6BPUErt2ehjfMIRH292o03poFzMBlvDuIu9//2908NA9aJE6ZCPpXXEKfN/pPb5qv1ey4xci3ghXNNzUHLET5aeZXYLB9M+6Xsf/1fcRbTJQz2Kqqkdd3Wt6rlNglgmy3UHUtcGkOuOLb6QmxlBalvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ULDox51p; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3259ff53c2eso545111a91.1
        for <linux-hyperv@vger.kernel.org>; Wed, 27 Aug 2025 17:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756339322; x=1756944122; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a1KBCmOkm9jj1CVFgQDrkKT5Cri9uMCD3k1Mkup3E5M=;
        b=ULDox51p5hSGZ6/VeJDLPyY1PcgS6WXqWEy9y79/gBw4SL9Q9We70cyEVuQj3eNBcK
         mGNdEMACiek4OMWOPaHAyICUohH77ZyC7OiiQ9X3qlBKZTRJ8L6cMGgVnTa22zUowuUR
         kSvb/4ogA+VrfYcKHzAPtQv2Pw15Co1QPuJIyzPnxmnigvDCkX9dwNjutDLLJCmh0Isq
         +4Zjqf8Gey4ZU7PqUoyJdYH3qwxzvQdtVCfNfOJlGDQmUQWSbJaq+aE6tWJpWfwGIE+N
         oyZPN5emAH4oq6Or/2vNcS1NXdgeLHNW1+LgH6gY0SO1zjXfGQItthkH5IxHexaOiuoi
         gaDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756339322; x=1756944122;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a1KBCmOkm9jj1CVFgQDrkKT5Cri9uMCD3k1Mkup3E5M=;
        b=O/1+Sm4YhJ/6k+Q28DHAYsUOKFp8aTkM/fclDnxLuObR6MXHRKlEA3/Gk53OF9HIao
         zwFQQD+M25UjlGHN5gEx8Mf3+jswplvRui6VjJdW9WaNUgtruQ+MVMIxLQLhgJ5E9zKJ
         OqHcRMU6+DTziHHoBiN8xRTdWj5s8H0wBfgN3ZhPtoYJ/YUVm9P1nLN1EI7pzQp7rmqV
         RA74+rRM26JL71qjX+SXxxJbuPsJibtmBFgyRqcojokaqJSuByxtQWRKrpdFOleOpica
         hYEg7x0taBKAgjRJZUNClHBfaNjTY4V7AIeP1ieK9GbZYW99jGa/MYMSO5KmTh8AYPAI
         hO7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXAOQ/LQP2VzjD/iWxRC1Biq4DjRvOZe9/qwx8jcHWwMCK1z+Mu3HupRAnMFeRsiCZCmIlstykTHq2qtag=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0GAJwuM7mIywys3ixQr/4QLpTYYtIq4lRytsEv//f+mIEDnjf
	eYRQQa3tg38hHBSVz8k8u5MRNb2APLZ0zNeZA978HwuH8MXLlz+3FuUef0XW0AWqlFDVWNXmPeN
	fWLY2Rg==
X-Google-Smtp-Source: AGHT+IF6kzCkrmSsnzkeC4ntTYmLEyMfD8fyiYTiSQm4IQpQL6BrLCB4IIHTXj0uI8vGzJiOm/SE6wuxA5g=
X-Received: from pjbsv16.prod.google.com ([2002:a17:90b:5390:b0:325:4747:a99b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5627:b0:31e:ec58:62e2
 with SMTP id 98e67ed59e1d1-32515eaafdcmr30552688a91.19.1756339321553; Wed, 27
 Aug 2025 17:02:01 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 27 Aug 2025 17:01:49 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.268.g9569e192d0-goog
Message-ID: <20250828000156.23389-1-seanjc@google.com>
Subject: [PATCH v2 0/7] Drivers: hv: Fix NEED_RESCHED_LAZY and use common APIs
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Anup Patel <anup@brainfault.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Peter Zijlstra <peterz@infradead.org>, 
	Andy Lutomirski <luto@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett <josh@joshtriplett.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, kvm@vger.kernel.org, loongarch@lists.linux.dev, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-hyperv@vger.kernel.org, rcu@vger.kernel.org, 
	Nuno Das Neves <nunodasneves@linux.microsoft.com>, Mukesh R <mrathor@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"

Fix a bug where MSHV root partitions (and upper-level VTL code) don't honor
NEED_RESCHED_LAZY, and then deduplicate the TIF related MSHV code by turning
the "kvm" entry APIs into more generic "virt" APIs.

This version is based on

  git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git hyperv-next

in order to pickup the VTL changes that are queued for 6.18.  I also
squashed the NEED_RESCHED_LAZY fixes for root and VTL modes into a single
patch, as it should be easy/straightforward to drop the VTL change as needed
if we want this in 6.17 or earlier.

That effectively means the full series is dependent on the VTL changes being
fully merged for 6.18.  But I think that's ok as it's really only the MSHV
changes that have any urgency whatsoever, and I assume that Microsoft is
the only user that truly cares about the MSHV root fix.  I.e. if the whole
thing gets delayed, I think it's only the Hyper-V folks that are impacted.

I have no preference what tree this goes through, or when, and can respin
and/or split as needed.

As with v1, the Hyper-V stuff and non-x86 architectures are compile-tested
only.

v2:
 - Rebase on hyperv-next.
 - Fix and converge the VTL code as well. [Peter, Nuno]

v1: https://lore.kernel.org/all/20250825200622.3759571-1-seanjc@google.com


Sean Christopherson (7):
  Drivers: hv: Handle NEED_RESCHED_LAZY before transferring to guest
  Drivers: hv: Disentangle VTL return cancellation from SIGPENDING
  Drivers: hv: Disable IRQs only after handling pending work before VTL
    return
  entry/kvm: KVM: Move KVM details related to signal/-EINTR into KVM
    proper
  entry: Rename "kvm" entry code assets to "virt" to genericize APIs
  Drivers: hv: Use common "entry virt" APIs to do work in root before
    running guest
  Drivers: hv: Use "entry virt" APIs to do work before returning to
    lower VTL

 MAINTAINERS                                 |  2 +-
 arch/arm64/kvm/Kconfig                      |  2 +-
 arch/arm64/kvm/arm.c                        |  3 +-
 arch/loongarch/kvm/Kconfig                  |  2 +-
 arch/loongarch/kvm/vcpu.c                   |  3 +-
 arch/riscv/kvm/Kconfig                      |  2 +-
 arch/riscv/kvm/vcpu.c                       |  3 +-
 arch/x86/kvm/Kconfig                        |  2 +-
 arch/x86/kvm/vmx/vmx.c                      |  1 -
 arch/x86/kvm/x86.c                          |  3 +-
 drivers/hv/Kconfig                          |  2 ++
 drivers/hv/mshv.h                           |  2 --
 drivers/hv/mshv_common.c                    | 22 ---------------
 drivers/hv/mshv_root_main.c                 | 31 ++++-----------------
 drivers/hv/mshv_vtl_main.c                  | 23 +++++++--------
 include/linux/{entry-kvm.h => entry-virt.h} | 19 +++++--------
 include/linux/kvm_host.h                    | 17 +++++++++--
 include/linux/rcupdate.h                    |  2 +-
 kernel/entry/Makefile                       |  2 +-
 kernel/entry/{kvm.c => virt.c}              | 15 ++++------
 kernel/rcu/tree.c                           |  6 ++--
 virt/kvm/Kconfig                            |  2 +-
 22 files changed, 60 insertions(+), 106 deletions(-)
 rename include/linux/{entry-kvm.h => entry-virt.h} (83%)
 rename kernel/entry/{kvm.c => virt.c} (66%)


base-commit: 03ac62a578566730ab3c320f289f7320798ee2e1
-- 
2.51.0.268.g9569e192d0-goog


