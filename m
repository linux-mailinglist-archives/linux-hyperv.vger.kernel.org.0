Return-Path: <linux-hyperv+bounces-84-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9735D7A1277
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 Sep 2023 02:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A42191C20C0D
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 Sep 2023 00:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F072C36D;
	Fri, 15 Sep 2023 00:42:53 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579F836A
	for <linux-hyperv@vger.kernel.org>; Fri, 15 Sep 2023 00:42:52 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EFD126B8;
	Thu, 14 Sep 2023 17:42:51 -0700 (PDT)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1694738569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a5Nv1k+xXsUYXwk/e9ziT/09Rg05qWYdYAMgd1WCgzY=;
	b=i+Ppepxp2xgrRhclM1xri9EX0YzYBr9BOGJwPO0VLxk5i0tNISHr/GndA9XyPoQsZydO3/
	fPU6jPCu37GMUSlLXoJ/VJx1Dig72xOidWuPzKUu5teW7671LOcHyedQ6p6JITYjs0zpfn
	QpnoWD/MZLO9svc8yDkMdqXG9HCDE2uOp81z+FKfwcgIrkP7SvsQmKqYpqhAfXN53y0i24
	Mfn2QbbsiCaB4Ahu7cykodXYR2Iqlc/YoSgD1YSSIz7af6MFb1HZ0m9QaTZwk+agivrh2E
	qPuiNE1UakCtbDlT638zyyyTO7X8bAYUoGWEO6vGebR/3O9l97XpIXldOrbt7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1694738569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a5Nv1k+xXsUYXwk/e9ziT/09Rg05qWYdYAMgd1WCgzY=;
	b=NZIe4NWm1nl0kqQhKbNB2m9DKxzHK9ZweKqAgUy9qCDYBN7oG1v7VdnYiMMGV+r2FQXWZP
	l3rg2PHO81rZI6DQ==
To: andrew.cooper3@citrix.com, Xin Li <xin3.li@intel.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-edac@vger.kernel.org, linux-hyperv@vger.kernel.org,
 kvm@vger.kernel.org, xen-devel@lists.xenproject.org
Cc: mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, luto@kernel.org, pbonzini@redhat.com,
 seanjc@google.com, peterz@infradead.org, jgross@suse.com,
 ravi.v.shankar@intel.com, mhiramat@kernel.org, jiangshanlai@gmail.com
Subject: Re: [PATCH v10 03/38] x86/msr: Add the WRMSRNS instruction support
In-Reply-To: <7ba4ae3e-f75d-66a8-7669-b6eb17c1aa1c@citrix.com>
References: <20230914044805.301390-1-xin3.li@intel.com>
 <20230914044805.301390-4-xin3.li@intel.com>
 <6f5678ff-f8b1-9ada-c8c7-f32cfb77263a@citrix.com> <87y1h81ht4.ffs@tglx>
 <7ba4ae3e-f75d-66a8-7669-b6eb17c1aa1c@citrix.com>
Date: Fri, 15 Sep 2023 02:42:49 +0200
Message-ID: <87r0n01d2u.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 15 2023 at 00:46, andrew wrote:
> On 15/09/2023 12:00 am, Thomas Gleixner wrote:
> What I meant was "there should be the two top-level APIs, and under the
> covers they DTRT".=C2=A0 Part of doing the right thing is to wire up para=
virt
> for configs where that is specified.
>
> Anything else is going to force people to write logic of the form:
>
> =C2=A0=C2=A0=C2=A0 if (WRMSRNS && !XENPV)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wrmsr_ns(...)
> =C2=A0=C2=A0=C2=A0 else
> =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 wrmsr(...)
>
> which is going to be worse overall.

I already agreed with that for generic code which might be affected by
PV. But code which is explicitely depending on something which never can
be affected by PV _and_ is in a performance sensitive code path really
wants to be able to use the native variant explicitely.

> And there really is one example of this antipattern already in the
> series.

No. There is no antipattern in this series. The only place which uses
wrmsrns() is:

@@ -70,9 +70,13 @@ static inline void update_task_stack(str
 #ifdef CONFIG_X86_32
 	this_cpu_write(cpu_tss_rw.x86_tss.sp1, task->thread.sp0);
 #else
-	/* Xen PV enters the kernel on the thread stack. */
-	if (cpu_feature_enabled(X86_FEATURE_XENPV))
+	if (cpu_feature_enabled(X86_FEATURE_FRED)) {
+		/* WRMSRNS is a baseline feature for FRED. */
+		wrmsrns(MSR_IA32_FRED_RSP0, (unsigned long)task_stack_page(task) + THREA=
D_SIZE);
+	} else if (cpu_feature_enabled(X86_FEATURE_XENPV)) {
+		/* Xen PV enters the kernel on the thread stack. */
 		load_sp0(task_top_of_stack(task));
+	}
 #endif
 }

The XENPV condition exists already today and is required independent of
FRED, no?

I deliberately distinguished #1 and #3 on my proposed todo list exactly
because the above use case really wants #1 without the extra bells and
whistles of a generic PV patchable wrmrs_ns() variant. Why?

  No matter how clever the enhanced PV implementation might be, it is
  guaranteed to generate worse code than the straight forward native
  inline assembly. Simply because it has to prevent the compiler from
  being overly clever on optimizations as it obviously mandates wider
  register restrictions, while the pure native variant (independent of
  the availability of X86_FEATURE_WRMSRNS) ony mandates the requirements
  of WRMSR[NS], but not the extra register indirection of the call ABI.

I'm not debating that any other code pattern like you pointed out in
some generic code would be horrible, but I'm not buying your strawman
related to this particular usage site.

Thanks,

        tglx

