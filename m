Return-Path: <linux-hyperv+bounces-6745-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B90B8B44D9C
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Sep 2025 07:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70102A00513
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Sep 2025 05:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00CEA26F28F;
	Fri,  5 Sep 2025 05:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lQwzYtm2"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D371EE7B7
	for <linux-hyperv@vger.kernel.org>; Fri,  5 Sep 2025 05:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757050787; cv=none; b=iH44UChGJJxzUf2/5cX2dNUEEzhFhIYNUIvPBfUeAkNEuaUbyk+vcw3bUjuhT/Hi+7EgJBxAfhlv5I/4lKU3+FtYTv5uOkvmlF1NkRDEBcV0GVQgdX1WO2JcavXpB1mA+QVeLNifKlNQJW8S52335zHW85OnQTeYs7xOj1xHOD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757050787; c=relaxed/simple;
	bh=wP0Nh39SvLrrUzcjoVyfrVPxYIzy1SY/V7/2kWcMIHU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=syfz38fyMxFnv8ispU9TFzADUr5x5QPLdmpbJylR3kpbiVYYgaYuwl//2F0ZxUCZ4z5FXaBmBPpUrqcrUuwXCdIcgB0IgfqwIY+z/0OuCn1HFhl4ceQby3mxWMIM4/FR7mtQEJcXc5IVTh7fuc/LWBvjkDFoGmznIM0LHGehs0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lQwzYtm2; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32b698861d8so1810646a91.2
        for <linux-hyperv@vger.kernel.org>; Thu, 04 Sep 2025 22:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757050785; x=1757655585; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3udnh9xsllR+FkjIGPPOo5bX8r6scLid4vmBPD5wmTc=;
        b=lQwzYtm2NV4Io4r/i3BCtkCOVhcIr4Ap4aY1jaLJulrXaLdfg75M9pjFwojB5+NfTR
         yHNRD18Y2qWcloAz3pRVhvfcE1ozVRkyC4xMA5+5XuqA3HgIOgoAZRLlWS5Ar0NFszU2
         OZ6iyQ1zLlPxMtI7rbEhXVGLS65b9oBWuz2O2LPIJQnIddCHaMwaA2q3X5/wVYuPCV4A
         ltJ6N26FjQ5ruch2n5EzaV7VzoWAeO0rn+jMgaJhMYg0zGD/lnaNlFwReK6FUlwFh67/
         VIMIFskP0SM4Yl9o+nH4nt9Ysq/iV1lH3rr4bl8GwXz8DWXh+4346twU30d/LpBESjku
         9DOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757050785; x=1757655585;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3udnh9xsllR+FkjIGPPOo5bX8r6scLid4vmBPD5wmTc=;
        b=Zqum8cNpYFqcDagKgdvfO++6rWT7tk9dxx2zEu00A4MzutNMt5WoqKm1E4Xmh6yBol
         iQ0RPciX0Z3/fdCCuxfDAC/YhBBzPduUXx7s4Zs1OxTS2hesBpBiCXDJ7darLZLyGsiX
         3JRv5aWAabqCkHPS17EU/yAnJNBISVa0mZw7aGh8+a+tx4EkQNuQcxdiUDXU5uwg0oLz
         0pxpp/k+CZ5C1GiCtecAd/r1OYvJaPeh1yLYs7PJdQ8I9esjAExruCy5eQO2/7gd1d2g
         MKWl4M/7bDTnG1CYHpbjfMTH/bQQWmQLxazkUTDUj3vqKgEt9bHKnqCGBNxSGqUdHdPa
         nKDg==
X-Forwarded-Encrypted: i=1; AJvYcCV4TtYUs2LLzxdmxD/eamB+XoszlLN8xv8mcPTJufVM9sHXf8Brat8F5FI9Fi6coLUgbNzG9jXnrZu7m30=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl/c/g9oIHXGtkaLMB4DUJy4JhNS5djEMyrBDRo7lL16sE24e1
	uz+CZ4RVREtnB6AjeTLAeRYMawx1tFKzud0zvJylC+c8jagyu9KnkZ/ZtMXZ6fz/6ZYiWp7oTxg
	E+xfzAg==
X-Google-Smtp-Source: AGHT+IEl3aDxdJxOeFOgsIqqYfLRUExl039yXm0dtHzzby5zYzVGU35ZbpW1dVjZIdU0C50mCLd9IUYMCJw=
X-Received: from pjuw15.prod.google.com ([2002:a17:90a:d60f:b0:325:5e4e:4bd4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3809:b0:329:dff0:701b
 with SMTP id 98e67ed59e1d1-329dff070c6mr19066965a91.17.1757050784899; Thu, 04
 Sep 2025 22:39:44 -0700 (PDT)
Date: Thu, 4 Sep 2025 22:39:37 -0700
In-Reply-To: <aLojpyTwAMdb1z6D@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250828000156.23389-1-seanjc@google.com> <aLojpyTwAMdb1z6D@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
Message-ID: <aLp3makY6FzuUwor@google.com>
Subject: Re: [PATCH v2 0/7] Drivers: hv: Fix NEED_RESCHED_LAZY and use common APIs
From: Sean Christopherson <seanjc@google.com>
To: Wei Liu <wei.liu@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Anup Patel <anup@brainfault.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Dexuan Cui <decui@microsoft.com>, Peter Zijlstra <peterz@infradead.org>, 
	Andy Lutomirski <luto@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett <josh@joshtriplett.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, loongarch@lists.linux.dev, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-hyperv@vger.kernel.org, 
	rcu@vger.kernel.org, Nuno Das Neves <nunodasneves@linux.microsoft.com>, 
	Mukesh R <mrathor@linux.microsoft.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Sep 04, 2025, Wei Liu wrote:
> On Wed, Aug 27, 2025 at 05:01:49PM -0700, Sean Christopherson wrote:
> > Fix a bug where MSHV root partitions (and upper-level VTL code) don't honor
> > NEED_RESCHED_LAZY, and then deduplicate the TIF related MSHV code by turning
> > the "kvm" entry APIs into more generic "virt" APIs.
> > 
> > This version is based on
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git hyperv-next
> > 
> > in order to pickup the VTL changes that are queued for 6.18.  I also
> > squashed the NEED_RESCHED_LAZY fixes for root and VTL modes into a single
> > patch, as it should be easy/straightforward to drop the VTL change as needed
> > if we want this in 6.17 or earlier.
> > 
> > That effectively means the full series is dependent on the VTL changes being
> > fully merged for 6.18.  But I think that's ok as it's really only the MSHV
> > changes that have any urgency whatsoever, and I assume that Microsoft is
> > the only user that truly cares about the MSHV root fix.  I.e. if the whole
> > thing gets delayed, I think it's only the Hyper-V folks that are impacted.
> > 
> > I have no preference what tree this goes through, or when, and can respin
> > and/or split as needed.
> > 
> > As with v1, the Hyper-V stuff and non-x86 architectures are compile-tested
> > only.
> > 
> > v2:
> >  - Rebase on hyperv-next.
> >  - Fix and converge the VTL code as well. [Peter, Nuno]
> > 
> > v1: https://lore.kernel.org/all/20250825200622.3759571-1-seanjc@google.com
> > 
> 
> I dropped the mshv_vtl changes in this series and applied the rest
> (including the KVM changes) to hyperv-next.

mshv_do_pre_guest_mode_work() ended up getting left behind since its removal was
in the last mshv_vtl patch.

  $ git grep mshv_do_pre_guest_mode_work
  drivers/hv/mshv.h:int mshv_do_pre_guest_mode_work(ulong th_flags);
  drivers/hv/mshv_common.c:int mshv_do_pre_guest_mode_work(ulong th_flags)
  drivers/hv/mshv_common.c:EXPORT_SYMBOL_GPL(mshv_do_pre_guest_mode_work);

Want to squash this into 3786d7d6b3c0 ("mshv: Use common "entry virt" APIs to do
work in root before running guest")?

---
 drivers/hv/mshv.h        |  2 --
 drivers/hv/mshv_common.c | 22 ----------------------
 2 files changed, 24 deletions(-)

diff --git a/drivers/hv/mshv.h b/drivers/hv/mshv.h
index 0340a67acd0a..d4813df92b9c 100644
--- a/drivers/hv/mshv.h
+++ b/drivers/hv/mshv.h
@@ -25,6 +25,4 @@ int hv_call_set_vp_registers(u32 vp_index, u64 partition_id, u16 count,
 int hv_call_get_partition_property(u64 partition_id, u64 property_code,
 				   u64 *property_value);
 
-int mshv_do_pre_guest_mode_work(ulong th_flags);
-
 #endif /* _MSHV_H */
diff --git a/drivers/hv/mshv_common.c b/drivers/hv/mshv_common.c
index eb3df3e296bb..aa2be51979fd 100644
--- a/drivers/hv/mshv_common.c
+++ b/drivers/hv/mshv_common.c
@@ -138,25 +138,3 @@ int hv_call_get_partition_property(u64 partition_id,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(hv_call_get_partition_property);
-
-/*
- * Handle any pre-processing before going into the guest mode on this cpu, most
- * notably call schedule(). Must be invoked with both preemption and
- * interrupts enabled.
- *
- * Returns: 0 on success, -errno on error.
- */
-int mshv_do_pre_guest_mode_work(ulong th_flags)
-{
-	if (th_flags & (_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL))
-		return -EINTR;
-
-	if (th_flags & (_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY))
-		schedule();
-
-	if (th_flags & _TIF_NOTIFY_RESUME)
-		resume_user_mode_work(NULL);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(mshv_do_pre_guest_mode_work);

base-commit: 3786d7d6b3c0a412ebe4439ba4a7d4b0e27d9a12
--

