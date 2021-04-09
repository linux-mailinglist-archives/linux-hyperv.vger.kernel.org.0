Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFD6359682
	for <lists+linux-hyperv@lfdr.de>; Fri,  9 Apr 2021 09:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbhDIHiU (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 9 Apr 2021 03:38:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35573 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229545AbhDIHiU (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 9 Apr 2021 03:38:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617953887;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fkrozLMJPACVkdmHi98evbnJXUcRYylIKOGu+prd3Vg=;
        b=AVV5gxNk0ddxwfb/hc6IA7CKtMu465VgViEyqjZ4ZZFvbM3CZoyw5SA/IHNk9yycKIY8F2
        cvkdlWoAb0PsLQ32V8TD/bYTMYEBlK+5QT0GfpLe1IcdzZKmfhsAOp8R5OKE0R1/B2jFhP
        Ns7NTa2nrSQt6o1NZNt+1/AdKX2nGFs=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-_HVPuMOkPiW3YKYn79d3Zg-1; Fri, 09 Apr 2021 03:38:05 -0400
X-MC-Unique: _HVPuMOkPiW3YKYn79d3Zg-1
Received: by mail-ed1-f72.google.com with SMTP id l11so2259611edb.2
        for <linux-hyperv@vger.kernel.org>; Fri, 09 Apr 2021 00:38:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=fkrozLMJPACVkdmHi98evbnJXUcRYylIKOGu+prd3Vg=;
        b=J2738JLW/qVowAO1qHRtch9U1TO/hL40tP4AMngTKGzy4ApgnkXkIpXsX+26h2nyeT
         jbr4yamf9TFy9nwIO0QGHSvyi2BKExTlSs9p0g1QWuHEZSeU3VC4k1tFsP+2b7aJp+kC
         BXQ89zPXrJ554EjtZQHRhZNS3zBzGwBOEM76hX+Ue5y/amB6AsABN4nykFxDqe1fqcK0
         ZKXJjZULmCUl0M3o4Dm6i5nCp1kLF0diwGPZn4c5A7Z14PpIYwiUCgR/CyeI6KlFtvXd
         6Vu2K/GH/wFmdtuSbUKGcHRyhjdoW1TZMHkx+FKfDYFylDnft8h5ceV/x38byp6mwZHM
         CNjQ==
X-Gm-Message-State: AOAM531PAHMR4GB6J48qx+xh+RQmPOzzyWZ7i7z8Rzw74tNMoKzr+Xtw
        y19G/vtilkZje+0Bb+U7+/cOqyYl0w4sMFnET9OSLdP+eLNNNAkitk61MiN9RHWHwQPKAfc21LN
        GfjAbm84G9Pl9bTj8XtQMSmg7
X-Received: by 2002:a17:906:170d:: with SMTP id c13mr14557526eje.491.1617953884853;
        Fri, 09 Apr 2021 00:38:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw0b2ZoUfqjNAa81uHiiZD1Mdm+c8bRsxSc++bCivJSOo+DhWfXVhlCJ950VqISuyzIOO5GyQ==
X-Received: by 2002:a17:906:170d:: with SMTP id c13mr14557510eje.491.1617953884680;
        Fri, 09 Apr 2021 00:38:04 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id q18sm920852edr.26.2021.04.09.00.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 00:38:04 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Siddharth Chandrasekaran <sidcha@amazon.de>
Cc:     Alexander Graf <graf@amazon.com>,
        Evgeny Iakovlev <eyakovl@amazon.de>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 4/4] KVM: hyper-v: Advertise support for fast XMM
 hypercalls
In-Reply-To: <20210408155220.GB32315@u366d62d47e3651.ant.amazon.com>
References: <20210407211954.32755-1-sidcha@amazon.de>
 <20210407211954.32755-5-sidcha@amazon.de>
 <87blap7zha.fsf@vitty.brq.redhat.com>
 <20210408142053.GA10636@u366d62d47e3651.ant.amazon.com>
 <8735w096pk.fsf@vitty.brq.redhat.com>
 <20210408155220.GB32315@u366d62d47e3651.ant.amazon.com>
Date:   Fri, 09 Apr 2021 09:38:03 +0200
Message-ID: <87zgy77vs4.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Siddharth Chandrasekaran <sidcha@amazon.de> writes:

> On Thu, Apr 08, 2021 at 04:44:23PM +0200, Vitaly Kuznetsov wrote:
>> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
>>
>>
>>
>> Siddharth Chandrasekaran <sidcha@amazon.de> writes:
>>
>> > On Thu, Apr 08, 2021 at 02:05:53PM +0200, Vitaly Kuznetsov wrote:
>> >> Siddharth Chandrasekaran <sidcha@amazon.de> writes:
>> >>
>> >> > Now that all extant hypercalls that can use XMM registers (based on
>> >> > spec) for input/outputs are patched to support them, we can start
>> >> > advertising this feature to guests.
>> >> >
>> >> > Cc: Alexander Graf <graf@amazon.com>
>> >> > Cc: Evgeny Iakovlev <eyakovl@amazon.de>
>> >> > Signed-off-by: Siddharth Chandrasekaran <sidcha@amazon.de>
>> >> > ---
>> >> >  arch/x86/include/asm/hyperv-tlfs.h | 4 ++--
>> >> >  arch/x86/kvm/hyperv.c              | 1 +
>> >> >  2 files changed, 3 insertions(+), 2 deletions(-)
>> >> >
>> >> > diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
>> >> > index e6cd3fee562b..1f160ef60509 100644
>> >> > --- a/arch/x86/include/asm/hyperv-tlfs.h
>> >> > +++ b/arch/x86/include/asm/hyperv-tlfs.h
>> >> > @@ -49,10 +49,10 @@
>> >> >  /* Support for physical CPU dynamic partitioning events is available*/
>> >> >  #define HV_X64_CPU_DYNAMIC_PARTITIONING_AVAILABLE    BIT(3)
>> >> >  /*
>> >> > - * Support for passing hypercall input parameter block via XMM
>> >> > + * Support for passing hypercall input and output parameter block via XMM
>> >> >   * registers is available
>> >> >   */
>> >> > -#define HV_X64_HYPERCALL_PARAMS_XMM_AVAILABLE                BIT(4)
>> >> > +#define HV_X64_HYPERCALL_PARAMS_XMM_AVAILABLE                BIT(4) | BIT(15)
>> >>
>> >> TLFS 6.0b states that there are two distinct bits for input and output:
>> >>
>> >> CPUID Leaf 0x40000003.EDX:
>> >> Bit 4: support for passing hypercall input via XMM registers is available.
>> >> Bit 15: support for returning hypercall output via XMM registers is available.
>> >>
>> >> and HV_X64_HYPERCALL_PARAMS_XMM_AVAILABLE is not currently used
>> >> anywhere, I'd suggest we just rename
>> >>
>> >> HV_X64_HYPERCALL_PARAMS_XMM_AVAILABLE to HV_X64_HYPERCALL_XMM_INPUT_AVAILABLE
>> >> and add HV_X64_HYPERCALL_XMM_OUTPUT_AVAILABLE (bit 15).
>> >
>> > That is how I had it initially; but then noticed that we would never
>> > need to use either of them separately. So it seemed like a reasonable
>> > abstraction to put them together.
>> >
>>
>> Actually, we may. In theory, KVM userspace may decide to expose just
>> one of these two to the guest as it is not obliged to copy everything
>> from KVM_GET_SUPPORTED_HV_CPUID so we will need separate
>> guest_cpuid_has() checks.
>
> Makes sense. I'll split them and add the checks.
>
>> (This reminds me of something I didn't see in your series:
>> we need to check that XMM hypercall parameters support was actually
>> exposed to the guest as it is illegal for a guest to use it otherwise --
>> and we will likely need two checks, for input and output).
>
> We observed that Windows expects Hyper-V to support XMM params even if
> we don't advertise this feature but if userspace wants to hide this
> feature and the guest does it anyway, then it makes sense to treat it as
> an illegal OP.
>

Out of pure curiosity, which Windows version behaves like that? And how
does this work with KVM without your patches?

Sane KVM userspaces will certainly expose both XMM input and output
capabilities together but having an ability to hide one or both of them
may come handy while debugging.

Also, we weren't enforcing the rule that enlightenments not exposed to
the guest don't work, even the whole Hyper-V emulation interface was
available to all guests who were smart enough to know how to enable it!
I don't like this for two reasons: security (large attack surface) and
the fact that someone 'smart' may decide to use Hyper-V emulation
features on KVM as 'general purpose' features saying 'they're always
available anyway', this risks becoming an ABI.

Let's at least properly check if the feature was exposed to the guest
for all new enlightenments.

-- 
Vitaly

