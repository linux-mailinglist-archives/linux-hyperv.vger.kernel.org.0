Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB1D535875A
	for <lists+linux-hyperv@lfdr.de>; Thu,  8 Apr 2021 16:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbhDHOol (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 8 Apr 2021 10:44:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21752 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231370AbhDHOok (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 8 Apr 2021 10:44:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617893067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ND/bD1NdJfIUtWvmn9cztv2pnJuFNG076aZGLQ1xAK8=;
        b=iI8Hg8N1GLL15HYLvjwwlIjFxDcmSzaat/K3tyaQrOYrQXZl+NYxzZxja0PEsYIo4QLpJo
        dfjQtgN8kvdjZ9XDQYvFifclhC66JqalWKnRoGH60TBEhYy/V/zDGNw4EtKWLXksySwndK
        dtB11C/tm4RgcZxtORloEM2A3V6TlUY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-aknELrmzNgaIl1y-e3Gejg-1; Thu, 08 Apr 2021 10:44:26 -0400
X-MC-Unique: aknELrmzNgaIl1y-e3Gejg-1
Received: by mail-wr1-f71.google.com with SMTP id a15so1070930wrf.19
        for <linux-hyperv@vger.kernel.org>; Thu, 08 Apr 2021 07:44:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=ND/bD1NdJfIUtWvmn9cztv2pnJuFNG076aZGLQ1xAK8=;
        b=azF9d05kus2Jk2aFOvWESH4G5y/W4jeGyIlR7Knv8huvCND3P21xn90XlztgQ1Ld+P
         9AWiJ4vzPy1g4K2f9CW7YFr8NSAQ+vCgvVM5sjIsmdkCz9K1xQKbtEdhpj7n5qHhpVz4
         lL9ACPQ+5idDdjyC7xyC3XNktNxJ64XbXUHsN3r2tl3NyE8MMaySAMN3sXqob0ORp85W
         RtWRgNGbxoehN0ay77iXFVMHiObMSSQo+qrOFJHDUORRRdQzaoIHpePBA+aKBCgzIdwU
         0udaePNhBvLwgNo6vYDeSzpMbImEzvY37Dr0wCI9Da3Tt/3rwc8LR8+bNChW++fjkzru
         PJGQ==
X-Gm-Message-State: AOAM530vdrRaWts4wMo357JYKlMc9ByzH3wnbKX6Xa9Xl90nnYJ4YfmW
        8GNoTWSqZeEMX/gpZTnQ/Gh9XuKrAgE7KXQT4UFP7f0j0mMTJ2NpZib5tRI2+t3xQJJ4/coSrrA
        P1Q3DG80WLDn0NlHc4/HQ/FxM
X-Received: by 2002:adf:83e3:: with SMTP id 90mr11839849wre.153.1617893065317;
        Thu, 08 Apr 2021 07:44:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyTH+kdqLFdolRPxnu0qsP1VMV2il2nyLsAe0ntsvnHjriOiow9QvQwik3um6iZMqwUrlPMpQ==
X-Received: by 2002:adf:83e3:: with SMTP id 90mr11839814wre.153.1617893065111;
        Thu, 08 Apr 2021 07:44:25 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id c2sm14162512wmr.22.2021.04.08.07.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 07:44:24 -0700 (PDT)
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
In-Reply-To: <20210408142053.GA10636@u366d62d47e3651.ant.amazon.com>
References: <20210407211954.32755-1-sidcha@amazon.de>
 <20210407211954.32755-5-sidcha@amazon.de>
 <87blap7zha.fsf@vitty.brq.redhat.com>
 <20210408142053.GA10636@u366d62d47e3651.ant.amazon.com>
Date:   Thu, 08 Apr 2021 16:44:23 +0200
Message-ID: <8735w096pk.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Siddharth Chandrasekaran <sidcha@amazon.de> writes:

> On Thu, Apr 08, 2021 at 02:05:53PM +0200, Vitaly Kuznetsov wrote:
>> Siddharth Chandrasekaran <sidcha@amazon.de> writes:
>>
>> > Now that all extant hypercalls that can use XMM registers (based on
>> > spec) for input/outputs are patched to support them, we can start
>> > advertising this feature to guests.
>> >
>> > Cc: Alexander Graf <graf@amazon.com>
>> > Cc: Evgeny Iakovlev <eyakovl@amazon.de>
>> > Signed-off-by: Siddharth Chandrasekaran <sidcha@amazon.de>
>> > ---
>> >  arch/x86/include/asm/hyperv-tlfs.h | 4 ++--
>> >  arch/x86/kvm/hyperv.c              | 1 +
>> >  2 files changed, 3 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
>> > index e6cd3fee562b..1f160ef60509 100644
>> > --- a/arch/x86/include/asm/hyperv-tlfs.h
>> > +++ b/arch/x86/include/asm/hyperv-tlfs.h
>> > @@ -49,10 +49,10 @@
>> >  /* Support for physical CPU dynamic partitioning events is available*/
>> >  #define HV_X64_CPU_DYNAMIC_PARTITIONING_AVAILABLE    BIT(3)
>> >  /*
>> > - * Support for passing hypercall input parameter block via XMM
>> > + * Support for passing hypercall input and output parameter block via XMM
>> >   * registers is available
>> >   */
>> > -#define HV_X64_HYPERCALL_PARAMS_XMM_AVAILABLE                BIT(4)
>> > +#define HV_X64_HYPERCALL_PARAMS_XMM_AVAILABLE                BIT(4) | BIT(15)
>>
>> TLFS 6.0b states that there are two distinct bits for input and output:
>>
>> CPUID Leaf 0x40000003.EDX:
>> Bit 4: support for passing hypercall input via XMM registers is available.
>> Bit 15: support for returning hypercall output via XMM registers is available.
>>
>> and HV_X64_HYPERCALL_PARAMS_XMM_AVAILABLE is not currently used
>> anywhere, I'd suggest we just rename
>>
>> HV_X64_HYPERCALL_PARAMS_XMM_AVAILABLE to HV_X64_HYPERCALL_XMM_INPUT_AVAILABLE
>> and add HV_X64_HYPERCALL_XMM_OUTPUT_AVAILABLE (bit 15).
>
> That is how I had it initially; but then noticed that we would never
> need to use either of them separately. So it seemed like a reasonable
> abstraction to put them together.
>

Actually, we may. In theory, KVM userspace may decide to expose just
one of these two to the guest as it is not obliged to copy everything
from KVM_GET_SUPPORTED_HV_CPUID so we will need separate
guest_cpuid_has() checks.

(This reminds me of something I didn't see in your series:
we need to check that XMM hypercall parameters support was actually
exposed to the guest as it is illegal for a guest to use it otherwise --
and we will likely need two checks, for input and output).

Also, (and that's what triggered my comment) all other HV_ACCESS_* in
kvm_get_hv_cpuid() are single bits so my first impression was that you
forgot one bit, but then I saw that you combined them together.

-- 
Vitaly

