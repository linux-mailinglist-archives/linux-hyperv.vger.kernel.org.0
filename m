Return-Path: <linux-hyperv+bounces-4105-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C68A47291
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 Feb 2025 03:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 216F43ACE4C
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 Feb 2025 02:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E0822AE7F;
	Thu, 27 Feb 2025 02:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X1zL7se1"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851572206AC
	for <linux-hyperv@vger.kernel.org>; Thu, 27 Feb 2025 02:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740622780; cv=none; b=Ntwx4qy4uVEgG3cMhl8Hv4Hc3+s80hXgHkpZ9ki1U1ga6tsetXXV2qYU3fTHjW68P7c7X7OwsBg4EnYmsvYkht2I7dj0xnksaBOgDu2+wJYbhnXmR4BtPYdOop3BH0LhO8f90A5yLWOug+DzOwDEkxITbzQ730aLMEFh0GmRd1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740622780; c=relaxed/simple;
	bh=EvFWgyIbvQaWWwWHzVo5uP3rkhFuLRC5lAG1scfhHho=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=piM5ENIYIcEtp91ShaeMLAeH/5+gzWUW55DSVnR9n1LcRHGSznJYuLzAXV8min/5DgYh6iLqLy/ddyC8DObzHcHdEdLdYLTMebs+GaAyFp4Xp7hLMUKnlk2YgapqWcKJHgV6ixsRjW4s7FvLDmUsikN1A9Rf79ONN9nNgFWjTPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X1zL7se1; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2217a4bfcc7so6991175ad.3
        for <linux-hyperv@vger.kernel.org>; Wed, 26 Feb 2025 18:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740622778; x=1741227578; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Fan7xWhbYPUjoe6Gj73DFLAXBBtIUty3w4hEBXyAFt4=;
        b=X1zL7se16+Y15iD7qpRznCwf0+Gn1F8PWtxotjxAL9p3L6n4taifamPCuKE7/zxX3O
         DtNHfCZNcJO3cHqpHWFKjTjg3sSyZUCpEL63gb29qQpEgXkinrmfblDIsKPjMfxdZsW0
         7ADNYtWcpjiGLiCq5qdtgsG1kSiCk0wL/0g1wX7zNzdiGi7ad7V605XJNP9oNdX5ofgI
         QVy6AmtBuIOQO5eBtoc6M+IGso7CXkBTP3NZYXC3PdskDEDwxU+jcTuwgEskwRNZ+LqL
         makxbBwWcd0SjHjffhMjHyK+tJtz7Ka+o51OQIifB9OkT4lIQCJkxzEg/JGJHclOpz1P
         ZcFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740622778; x=1741227578;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fan7xWhbYPUjoe6Gj73DFLAXBBtIUty3w4hEBXyAFt4=;
        b=kpLK+fgCJCqZbXkze4+k4UsRphoRnJWbhJKEY4xcScjk5DYJxWdEY7+VX0fSBX2LCF
         sl2vF7fn/y8B3k68yjQm4gm+VVIRdw13B583Z7NHwv+ZobvVen7/PLjiSUd6y6FW5Imc
         fZFDh6qzpw4eqAZscIs1SPRPvXjlXKN3kj0j9isgiY9ePkPp/QAkeYvatRy4/h+AGrwp
         nzVnIN5gAO+CwEYbT7b6aDs1OFYn+TNYEb1qcmKhtfRtKCLNCsGckbSip0DXrtbUEMHi
         TYP0t2mFyjExtI+wvEJ+LY7Df/eXQN/Ws7HTpckPxy0FS4diCmaOEwEXfOvjzIWMcUtT
         Gjwg==
X-Forwarded-Encrypted: i=1; AJvYcCWBweArv1Y6PwdLNavkxjJa1HX06PE72h4F6yLOqQ1w3zBmAgvvuYuWHsv8YbYvxKBo/03FZBT0qrlRHsY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX30116szKtIiK2TvA/CpRBzykgawSH8UnwIavWgAeFB8NmVBP
	7a80jflaXGrQ29TUeSoKarfFmfeOzIT2noBNRBr2pnUVpA7Co9XmPJY3+ouUO0UjmAgL/3S7S8N
	RTw==
X-Google-Smtp-Source: AGHT+IEIDOZ4TbuvBdNqbq0BRf/iBYYL2tXyd/xxECXyr6rznFcwd1mvvnFfD4EHjsDge5bCz6C8+YGYPK0=
X-Received: from plbje3.prod.google.com ([2002:a17:903:2643:b0:223:4e55:d29a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e80d:b0:220:f5d7:6405
 with SMTP id d9443c01a7336-221a0edbfc3mr358957175ad.16.1740622777972; Wed, 26
 Feb 2025 18:19:37 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Feb 2025 18:18:36 -0800
In-Reply-To: <20250227021855.3257188-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250227021855.3257188-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250227021855.3257188-21-seanjc@google.com>
Subject: [PATCH v2 20/38] x86/xen/time: Mark xen_setup_vsyscall_time_info() as __init
From: Sean Christopherson <seanjc@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Juergen Gross <jgross@suse.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Ajay Kaher <ajay.kaher@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	John Stultz <jstultz@google.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-hyperv@vger.kernel.org, xen-devel@lists.xenproject.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>
Content-Type: text/plain; charset="UTF-8"

Annotate xen_setup_vsyscall_time_info() as being used only during kernel
initialization; it's called only by xen_time_init(), which is already
tagged __init.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/xen/time.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/xen/time.c b/arch/x86/xen/time.c
index 3179f850352d..13e5888c4501 100644
--- a/arch/x86/xen/time.c
+++ b/arch/x86/xen/time.c
@@ -441,7 +441,7 @@ void xen_restore_time_memory_area(void)
 	xen_sched_clock_offset = xen_clocksource_read() - xen_clock_value_saved;
 }
 
-static void xen_setup_vsyscall_time_info(void)
+static void __init xen_setup_vsyscall_time_info(void)
 {
 	struct vcpu_register_time_memory_area t;
 	struct pvclock_vsyscall_time_info *ti;
-- 
2.48.1.711.g2feabab25a-goog


