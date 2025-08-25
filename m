Return-Path: <linux-hyperv+bounces-6586-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6049EB34B73
	for <lists+linux-hyperv@lfdr.de>; Mon, 25 Aug 2025 22:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFE32166AAA
	for <lists+linux-hyperv@lfdr.de>; Mon, 25 Aug 2025 20:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74E3285C8F;
	Mon, 25 Aug 2025 20:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U/6GKrcz"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA8A1DE8BB
	for <linux-hyperv@vger.kernel.org>; Mon, 25 Aug 2025 20:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756152387; cv=none; b=p+QyXbJnds4PX6fvkqdl1U9mHz/7K+01LQY7aLLEr9sg2YZSADbkN5+Bz+E2H8ffZlCp3/DP65W8hLb4u04PmM5KFKjJnAM56warT3aGALqhbYfq8nBAXR77hBbW/wNBA223tw2KANGezIgZiWljW4bdykY5U6wPbae9h04KTqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756152387; c=relaxed/simple;
	bh=e6UMH6C4QXeee3JknmCO2I9Y/5OAkfG/m9YVXqh8/eg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=V8qI7rquMmMfM2Z/BaEjUUkcPEpWBKwjpNDRXrVKpg9p+leMvVDlbnw23smWcC/RXmEHfb5mezwxjYBjjHJ0v+de/39y3LRVdaXxo7DXIPfSE7SIMVKYxgJZiSMf0BUqSXeUn2b2xdqnnUUrA9BIlvrVqRgO7r0QNih9ZYAhckk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U/6GKrcz; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32515a033a6so3304017a91.2
        for <linux-hyperv@vger.kernel.org>; Mon, 25 Aug 2025 13:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756152385; x=1756757185; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8pR7rIORhhha7uQoj/L4UbVHOw9HCPKdRxBVZAbw60c=;
        b=U/6GKrcziuMZ4ZNF4VS5URgcKX/rVLyTK/K79IwfLFkINOSFzJt4zy319jcUaT2h9Q
         ccQPA0lYTIIJ0XviX9VG1/lJyRUkxwojEHcTT3t70mBD4gK1/2SXChpXQGo+XBVKEFSm
         9l0Mg38k6xaokP35fXia8lpIvIGuH9Sdt2sU1MqW/Wsif2bZ72FamQslTM8l88dPMphl
         P8rQpeqz0OlMDrViTB23fX4DtScA/gO4/EPIVgElvP6q+p5i/pgvqbuIMXQIbfMEWkXf
         4UQ/IRDhQdOH41elIoduRkwttyqGLIMBs1fvkUMZi012qdf99BIqviyouvYX4e9rJMQ7
         1u+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756152385; x=1756757185;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8pR7rIORhhha7uQoj/L4UbVHOw9HCPKdRxBVZAbw60c=;
        b=q1pajIM25U4ApPINnLNzRz2wv49VqF+7szSbjWSFzsWJ6jSF+12a1qYjY592CpfD+H
         ZwZg7QxkUGZ0G/3vdgcJTP3hwMqTLtg/PNhNsN/NG8/OfdFd88WDBpoGx1NgeZIgw4g5
         Bp1rScCLNFRFKo1hbji9DIXWkt94OXzLPMF58Aem3/BVWj7IlgB6Xg4a/CuTXS43C+tG
         7Gzy+HWOxDmiphiNhFK5XSgnXy2VwBW1g6Wf+ZykGBWUKK4SLeGNKIJaGN+/huz2UDfk
         UsimJQKEA5Nh8/p4962IUCd+leVO6ODdEbd9zzj72A81EAqK4zaEVBr7BGE6cFnBEuV2
         L9Cg==
X-Forwarded-Encrypted: i=1; AJvYcCWxGMn6LDQu+7kf2yb2GxwisATQyQTz9hkqRCsIv6zKDbZzqYDY4zjUNmd0Ob5vAa5S6orTb5tMRZRrS7I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ6WEWFBFJWhgxyqKNbO6xzq3m+mL9sC3QFga9i3FrqjbU6VoF
	RUfn5uvMqwyKFYa8pMNynOi/+ahZE2EmfPMduEc61giQSlobJG+gpZ7TkydCaXS5hs6f5HSuxs3
	sZF+XuA==
X-Google-Smtp-Source: AGHT+IEXEoKFvYTs3DYHIb6MyIfVoxfIwlslpUf6Y9Z1lNFDWyuIZVc83JO2uwlvd4IbE+BY+ZPFpeZDEbc=
X-Received: from pjkk5.prod.google.com ([2002:a17:90b:57e5:b0:325:9fa7:5d07])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2ccd:b0:324:eac4:2968
 with SMTP id 98e67ed59e1d1-32515ee13cdmr17210596a91.33.1756152385445; Mon, 25
 Aug 2025 13:06:25 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 25 Aug 2025 13:06:17 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <20250825200622.3759571-1-seanjc@google.com>
Subject: [PATCH 0/5] Drivers: hv: Fix NEED_RESCHED_LAZY and use common APIs
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
	linux-hyperv@vger.kernel.org, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Fix a bug where MSHV root partitions don't honor NEED_RESCHED_LAZY, and then
deduplicate the TIF related MSHV code by turning the "kvm" entry APIs into
more generic "virt" APIs (which ideally would have been done when MSHV root
support was added).

Assuming all is well, maybe this could go through the tip tree?

The Hyper-V stuff and non-x86 architectures are compile-tested only.

Sean Christopherson (5):
  Drivers: hv: Move TIF pre-guest work handling fully into mshv_common.c
  Drivers: hv: Handle NEED_RESCHED_LAZY before transferring to guest
  entry/kvm: KVM: Move KVM details related to signal/-EINTR into KVM
    proper
  entry: Rename "kvm" entry code assets to "virt" to genericize APIs
  Drivers: hv: Use common "entry virt" APIs to do work before running
    guest

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
 drivers/hv/Kconfig                          |  1 +
 drivers/hv/mshv.h                           |  2 --
 drivers/hv/mshv_common.c                    | 22 ---------------
 drivers/hv/mshv_root_main.c                 | 31 ++++-----------------
 include/linux/{entry-kvm.h => entry-virt.h} | 19 +++++--------
 include/linux/kvm_host.h                    | 17 +++++++++--
 include/linux/rcupdate.h                    |  2 +-
 kernel/entry/Makefile                       |  2 +-
 kernel/entry/{kvm.c => virt.c}              | 15 ++++------
 kernel/rcu/tree.c                           |  6 ++--
 virt/kvm/Kconfig                            |  2 +-
 21 files changed, 49 insertions(+), 93 deletions(-)
 rename include/linux/{entry-kvm.h => entry-virt.h} (83%)
 rename kernel/entry/{kvm.c => virt.c} (66%)


base-commit: 1b237f190eb3d36f52dffe07a40b5eb210280e00
-- 
2.51.0.261.g7ce5a0a67e-goog


