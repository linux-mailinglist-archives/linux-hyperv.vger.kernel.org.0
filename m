Return-Path: <linux-hyperv+bounces-80-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3627A1201
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 Sep 2023 01:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09D6D281A60
	for <lists+linux-hyperv@lfdr.de>; Thu, 14 Sep 2023 23:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF012D505;
	Thu, 14 Sep 2023 23:46:36 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA04033F2
	for <linux-hyperv@vger.kernel.org>; Thu, 14 Sep 2023 23:46:34 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F3326AB
	for <linux-hyperv@vger.kernel.org>; Thu, 14 Sep 2023 16:46:33 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-530199bca8eso2397428a12.0
        for <linux-hyperv@vger.kernel.org>; Thu, 14 Sep 2023 16:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1694735192; x=1695339992; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jEsOE3VahVBRrZQB+F/BuNrsfqTbbzggGN9bcwX+LFw=;
        b=WBmURdAIViqySOYd4mwoL5+CGavhBHlAcQZJOFnePa/0bAXu0bgybRI3OcGj4HTG2j
         c4WP2JsR5jpOWTsFRjLuua//y/QQpf3bQLoZvnXtVvdNZZ0OV5Ll75KL7oUytg7KbJMU
         ZOjCMe/ghixf3/EUuPcV+lYqQ1FwmK9/STj1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694735192; x=1695339992;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jEsOE3VahVBRrZQB+F/BuNrsfqTbbzggGN9bcwX+LFw=;
        b=senRBoiod9KqrrVvVMj1BhrdKAybfoOifWHVM6jDG1IrBeVzpsnIGKMAtVrk66xjkP
         7XrXnqq6QLGmQo6g9IjsOQ0FRSFPua5hVzmE6efdW1CzNxBdsisR8lSWKBuInj8oOYrr
         +5aOqUDKkfKmGW0KVARW/1hWUVSu0YoAI3it55/Rhxk0bCB8whI40wveOxPW8TaLA9Qz
         ofHYaYQwcD7q40LXGoKc/KeHaCGwvxyLxIQgX6LV71OnYcFK6eZBkAAhvrOmDVI89RJm
         /6Bmi3slNzggGZaLpvXg+x6FIdQZFjUoIIQXpzIqLaQvNO6KCnpBUt7T18OlrCQ0hRge
         7eRg==
X-Gm-Message-State: AOJu0Yxv5A5ER/c5xhUVbGSNJQWW5IapOraoT+wdwffKizhpZb4LTPBJ
	7ID3J/hwS7ALUvvNFeuI/oX2pg==
X-Google-Smtp-Source: AGHT+IFdLzHxkpcWBSKfZyEmhUJiAzFwTc5lp2rJbnp1c8teqkmJckhwUBhX6fJYxYR6W8lj/upGVQ==
X-Received: by 2002:a17:906:51d0:b0:9a1:fda6:2e2a with SMTP id v16-20020a17090651d000b009a1fda62e2amr179416ejk.9.1694735191861;
        Thu, 14 Sep 2023 16:46:31 -0700 (PDT)
Received: from [192.168.1.10] (host-92-12-44-130.as13285.net. [92.12.44.130])
        by smtp.gmail.com with ESMTPSA id m21-20020a1709060d9500b009937dbabbd5sm1623158eji.220.2023.09.14.16.46.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 16:46:31 -0700 (PDT)
Message-ID: <7ba4ae3e-f75d-66a8-7669-b6eb17c1aa1c@citrix.com>
Date: Fri, 15 Sep 2023 00:46:30 +0100
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
From: andrew.cooper3@citrix.com
Subject: Re: [PATCH v10 03/38] x86/msr: Add the WRMSRNS instruction support
Content-Language: en-GB
To: Thomas Gleixner <tglx@linutronix.de>, Xin Li <xin3.li@intel.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-edac@vger.kernel.org, linux-hyperv@vger.kernel.org,
 kvm@vger.kernel.org, xen-devel@lists.xenproject.org
Cc: mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, luto@kernel.org, pbonzini@redhat.com,
 seanjc@google.com, peterz@infradead.org, jgross@suse.com,
 ravi.v.shankar@intel.com, mhiramat@kernel.org, jiangshanlai@gmail.com
References: <20230914044805.301390-1-xin3.li@intel.com>
 <20230914044805.301390-4-xin3.li@intel.com>
 <6f5678ff-f8b1-9ada-c8c7-f32cfb77263a@citrix.com> <87y1h81ht4.ffs@tglx>
In-Reply-To: <87y1h81ht4.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 15/09/2023 12:00 am, Thomas Gleixner wrote:
>> and despite what Juergen said, I'm going to recommend that you do wire
>> this through the paravirt infrastructure, for the benefit of regular
>> users having a nice API, not because XenPV is expecting to do something
>> wildly different here.
> I fundamentaly hate adding this to the PV infrastructure. We don't want
> more PV ops, quite the contrary.

What I meant was "there should be the two top-level APIs, and under the
covers they DTRT".  Part of doing the right thing is to wire up paravirt
for configs where that is specified.

Anything else is going to force people to write logic of the form:

    if (WRMSRNS && !XENPV)
        wrmsr_ns(...)
    else
        wrmsr(...)

which is going to be worse overall.  And there really is one example of
this antipattern already in the series.


> For the initial use case at hand, there is an explicit FRED dependency
> and the code in question really wants to use WRMSRNS directly and not
> through a PV function call.
>
> I agree with your reasoning for the more generic use case where we can
> gain performance independent of FRED by using WRMSRNS for cases where
> the write has no serialization requirements.
>
> But this made me look into PV ops some more. For actual performance
> relevant code the current PV ops mechanics are a horrorshow when the op
> defaults to the native instruction.
>
> Let's look at wrmsrl():
>
> wrmsrl(msr, val
>  wrmsr(msr, (u32)val, (u32)val >> 32))
>   paravirt_write_msr(msr, low, high)
>     PVOP_VCALL3(cpu.write_msr, msr, low, high)
>
> Which results in
>
> 	mov	$msr, %edi
> 	mov	$val, %rdx
> 	mov	%edx, %esi
> 	shr	$0x20, %rdx
> 	call	native_write_msr
>
> and native_write_msr() does at minimum:
>
> 	mov    %edi,%ecx
> 	mov    %esi,%eax
> 	wrmsr
>         ret

Yeah, this is daft.  But it can also be fixed irrespective of WRMSRNS.

WRMSR has one complexity that most other PV-ops don't, and that's the
exception table reference for the instruction itself.

In a theoretical future ought to look like:

    mov    $msr, %ecx
    mov    $lo, %eax
    mov    $hi, %edx
    1: {call paravirt_blah(%rip) | cs...cs wrmsr | cs...cs wrmsrns }
    _ASM_EXTABLE(1b, ...)

In paravirt builds, the CALL needs to be the emitted form, because it
needs to function in very early boot.

But once the paravirt-ness has been chosen and alternatives run, the
as-native paths are fully inline.

The alternative which processes this site wants to conclude that, in the
case it does not alter from the CALL, to clobber the EXTABLE reference. 
CALL instructions can #GP, and you don't want to end up thinking you're
handling a WRMSR #GP when in fact it was a non-canonical function pointer.

> In the worst case 'ret' is going through the return thunk. Not to talk
> about function prologues and whatever.
>
> This becomes even more silly for trivial instructions like STI/CLI or in
> the worst case paravirt_nop().

STI/CLI are already magic.  Are they not inlined?

> The call makes only sense, when the native default is an actual
> function, but for the trivial cases it's a blatant engineering
> trainwreck.
>
> I wouldn't care at all if CONFIG_PARAVIRT_XXL would be the esoteric use
> case, but AFAICT it's default enabled on all major distros.
>
> So no. I'm fundamentally disagreeing with your recommendation. The way
> forward is:
>
>   1) Provide the native variant for wrmsrns(), i.e. rename the proposed
>      wrmsrns() to native_wrmsr_ns() and have the X86_FEATURE_WRMSRNS
>      safety net as you pointed out.
>
>      That function can be used in code which is guaranteed to be not
>      affected by the PV_XXL madness.
>
>   2) Come up with a sensible solution for the PV_XXL horrorshow
>
>   3) Implement a sane general variant of wrmsr_ns() which handles
>      both X86_FEATURE_WRMSRNS and X86_MISFEATURE_PV_XXL
>
>   4) Convert other code which benefits from the non-serializing variant
>      to wrmsr_ns()

Well - point 1 is mostly work that needs reverting as part of completing
point 3, and point 2 clearly needs doing irrespective of anything else.

Thanks,

~Andrew

