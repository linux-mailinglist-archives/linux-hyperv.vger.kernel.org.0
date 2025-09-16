Return-Path: <linux-hyperv+bounces-6884-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77018B59AEE
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Sep 2025 16:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21A131BC4C2E
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Sep 2025 14:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9352A3164BC;
	Tue, 16 Sep 2025 14:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wK3l/APS"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067C430CD9B
	for <linux-hyperv@vger.kernel.org>; Tue, 16 Sep 2025 14:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758034366; cv=none; b=DEIDC/cgbfrpMVTpufOcNZiEhSYoArCdbWlhPGh5PNXC3/TdjuLXzL1MrLyRkGp7ixtctMHmf5faqdC2foGjZxxSG9zSXTBCLZ0Miu8tBAYcGLLP6B5+D/Hj47jEpE5nqPS8i49FQGkfYKGMrUGUkrYk5Nw8iPzwb8//ej9y1aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758034366; c=relaxed/simple;
	bh=m2KOOvaQcGDrt/TmvHVj0MM4XbMIsCoimcHdlZ8dRwg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cNfa3k1DSVHdQsC1YBNlahbLjGmYpNvhUv+NzrzAmNtsC/ocdZ8HaDz9X8/fi7iuVuOwgXsb8GqT6VoYIgVm9fkVD601ZwohQIk1xPZjLDTC6pFJnvodOemFZ1GDOaLZZGFxD9MVJ+Eo8iKDUAcpuqMUV4dpWJ1rZDEFo6ql/vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wK3l/APS; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32e09eaf85dso3972373a91.1
        for <linux-hyperv@vger.kernel.org>; Tue, 16 Sep 2025 07:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758034364; x=1758639164; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5E3qnbdqRNKYtwnt8hzs7H9oNeW9zi+yEz9lSm4V2OA=;
        b=wK3l/APSVW/g1b1DqbjdWNqm0xuGuSfMp4lGC9uO0sOG9CGWRZ8mDHS59uPu9zyMOe
         kTpqRbcoRu4i4ZQ+KSs4x8eK+iYqEAJk1S77eEca5ALdsTJVV9iCW4Io/zWgo7snqVSt
         Fx1DPkvpoOuGzRxR5G6hr4gb1RFWL+xCW1m3irAiH4pdaMQm+u0O9AWtjjxrdsYRTS4M
         jvtZMX30q3MjLh7bh8USeBeZTzG8SSeQOK6jVMl9Vfa7GPDewhKioID3FkL1ek5HX0KM
         aliIzIIpqU3mdgxwu1swpCS2WTrIvwwpmVmpGY8WABZTcsupquVIfPeiJrzC8W4cvJX7
         PCEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758034364; x=1758639164;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5E3qnbdqRNKYtwnt8hzs7H9oNeW9zi+yEz9lSm4V2OA=;
        b=tfc9fSn1SjIbYggELjF7bATess6Ey/aqj++T9tQljr6diZKLAb+mioK8Qe1g1ZEbDu
         Ha6rQVgw3pKoMvoCnhNBzhDJdXZbn+fCWCt/2bbvZkAHqOFUvd1Dy/Y6J8eK5KZGayd1
         pzZtSEl6WhmUmVEamAe1xos3gWzubiJx82++FLh3L6dklEKRB3m0cadiSgF4w2VYzgwt
         yER+H8AJxWWuWryoqgx/4mNdjeGcOsG3V/5cqZWxRMLtX9Ax1kcgzjKvxaqhUSjmVCS4
         EHHUac0ZwlhEVYxnGLrHWc8d3TQVzynvCyJc0EJuJycmcOOTcLs3DIHL+EWu+fuAqwE4
         I15Q==
X-Forwarded-Encrypted: i=1; AJvYcCWVgAb7Xo1fJCzcKu65158UAt6bV2uM3lUixJDHaLQ75yzw9gYJbKeiQK9y/vh3vSfIffDoVQz42iH1kfE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx43JkAsKxETARj9yZxlCZwY/tKgiEVYiQun8P5JTaJjA6Yj2If
	o5G4cSVV3V7AZlRKYASxnIKOTRG8tJWzPNvI1CIRDqkTn5Dmid/ka+nv942cj9Rripq6XqYlms+
	CT/GckQ==
X-Google-Smtp-Source: AGHT+IGjfmJpQ4lC0iEqMON72LWTyS6jym2vxg8R+T/51zsgl4TA6F8PBYAw3kwQhUfPdOeDMTUPr0z2AnE=
X-Received: from pjh16.prod.google.com ([2002:a17:90b:3f90:b0:32e:8014:992f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3a8a:b0:32e:1213:1ea0
 with SMTP id 98e67ed59e1d1-32e121321dbmr13796123a91.16.1758034364191; Tue, 16
 Sep 2025 07:52:44 -0700 (PDT)
Date: Tue, 16 Sep 2025 07:52:42 -0700
In-Reply-To: <27e50bb7-7f0e-48fb-bdbc-6c6d606e7113@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250825055208.238729-1-namjain@linux.microsoft.com>
 <20250825094247.GU3245006@noisy.programming.kicks-ass.net>
 <f154d997-f7a6-4379-b7e8-ac4ba990425c@linux.microsoft.com>
 <20250826120752.GW4067720@noisy.programming.kicks-ass.net>
 <efc06827-e938-42b5-bb45-705b880d11d9@linux.microsoft.com> <27e50bb7-7f0e-48fb-bdbc-6c6d606e7113@redhat.com>
Message-ID: <aMl5ulY1K7cKcMfo@google.com>
Subject: Re: [PATCH] x86/hyperv: Export hv_hypercall_pg unconditionally
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Roman Kisel <romank@linux.microsoft.com>, Peter Zijlstra <peterz@infradead.org>, 
	Naman Jain <namjain@linux.microsoft.com>, "K . Y . Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mhklinux@outlook.com
Content-Type: text/plain; charset="us-ascii"

On Tue, Sep 16, 2025, Paolo Bonzini wrote:
> On 8/27/25 01:04, Roman Kisel wrote:
> > On 8/26/2025 5:07 AM, Peter Zijlstra wrote:
> > > I do not know what OpenHCL is. Nor is it clear from the code what NMIs
> > > can't happen. Anyway, same can be achieved with breakpoints / kprobes.
> > > You can get a trap after setting CR2 and scribble it.
> > > 
> > > You simply cannot use CR2 this way.
> > 
> > The code in question runs with interrupts disabled, and the kernel runs
> > without the memory swapping when using that module - the kernel is
> > a firmware to host a vTPM for virtual machines. Somewhat similar to SMM.
> > That should've been reflected somewhere in the comments and in Kconfig,
> > we could do better. All in all, the page fault cannot happen in that
> > path thus CR2 won't be trashed.
> > 
> > Nor this kind of code can be stepped through in a self-hosted
> > kernel debugger like kgdb. There are other examples of such code iiuc:
> 
> As Sean mentioned, you do have to make sure that this is annotated as
> noinstr (not instrumentable).  And also just use assembly - KVM started with
> a similar asm block, though without the sketchy "register asm",

Ooh, yeah, don't use "register asm".  I missed that when I peeked at the code.
Using "register asm" will most definitely cause problems, because the compiler
doesn't track usage in C code, i.e. will happily use the GPR and clobber your
asm value in the process.  That inevitably leads to very confusing and somewhat
transient errors.  E.g. if someone inserts a printk for debugging, the call to
printk can clobber the very state it's trying to print.

> and I was initially skeptical but using a dedicated .S file was absolutely
> the right thing to do.

+1000 to putting the assembly in a .S file.  I too was a bit skeptical about
moving the entire sequence into proper assembly; thankfully, some non-KVM folks
talked us into it :-)

