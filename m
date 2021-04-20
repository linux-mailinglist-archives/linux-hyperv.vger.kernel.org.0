Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04BE2365CB8
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Apr 2021 17:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232835AbhDTP54 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 20 Apr 2021 11:57:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58934 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232174AbhDTP54 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 20 Apr 2021 11:57:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618934244;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SvH4spO145jmMethyK98T8GRtAPXYe7MWQzYtlj/MQk=;
        b=ZA2Z4ahuu90AP6a6edg5JnBUY7YNW6BGVR1EJ5u/nZp5VTzUig3Y/0igUsT/ke7efF6JAr
        2IkEcsU6b+yiJi8+bLChmwUjH86ZB+A4fUqx6MLU4v06JC+Qly340xI4YC0u98I7RaBOq8
        F2AAF5gxCF5zbCLUHJLCcf76NGkwN9c=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-534-J6w9Ri72MACZSjlRqQE-9A-1; Tue, 20 Apr 2021 11:57:22 -0400
X-MC-Unique: J6w9Ri72MACZSjlRqQE-9A-1
Received: by mail-ed1-f71.google.com with SMTP id f9-20020a50fe090000b02903839889635cso11394719edt.14
        for <linux-hyperv@vger.kernel.org>; Tue, 20 Apr 2021 08:57:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=SvH4spO145jmMethyK98T8GRtAPXYe7MWQzYtlj/MQk=;
        b=HUnCPVbx5qyEtqRb2ajuQLHq0OX2DVNdhLCc/J+QKE2EY5Kqfx0zIU5wZw2fuJWde7
         I72KuyrV5BKGGXRyjPwR3xMuKmkgqDyKtcWmfThOOqKGwX8w1QsRttIoFOVn7pmlby0v
         BMzswSfGPC79/PBaTlrZ+1Dbvqei6XwYoFuA8Z49wJPkocY0E3GaKaEmSvE79gjj3ASJ
         7HvdlUdAa7yycmaU16lLgC41YqydutK86xQIdk13aXn+y+jkgs+r3RXOStvT4qytVE+L
         TYMfMoY1zySNNnmcDa/iLTRSjclF07xWQUcGz2bXuInK47yUzybJO/7NHswsSg54IMZ8
         FQSQ==
X-Gm-Message-State: AOAM532Px3xy/nfieM90s91lje5EKPm3eKKpmW2VsObiWIdg8jZRYeKZ
        8umdDDbV2zQMhFWZUYFs9R+mREVveI6AZxnsZymoZpcqR7V2f6vhOB2kTFuFCPAPAZuFQ/v9C+D
        0LgBsqJUkqnUsFTBRaIDBazeh
X-Received: by 2002:a17:906:168f:: with SMTP id s15mr28369014ejd.144.1618934241219;
        Tue, 20 Apr 2021 08:57:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx3uF5D/pSoiaHMLpHm8CDL6lyniez0u3OyuO4dDYSchmAPAbAdV3sU2eqwNdHyFbxL1j3BsQ==
X-Received: by 2002:a17:906:168f:: with SMTP id s15mr28368992ejd.144.1618934241061;
        Tue, 20 Apr 2021 08:57:21 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id cz2sm16550602edb.13.2021.04.20.08.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 08:57:20 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Vineeth Pillai <viremana@linux.microsoft.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "K. Y. Srinivasan" <kys@microsoft.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org,
        Lan Tianyu <Tianyu.Lan@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, Wei Liu <wei.liu@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        viremana@linux.microsoft.com
Subject: Re: [PATCH v2 3/7] KVM: x86: hyper-v: Move the remote TLB flush
 logic out of vmx
In-Reply-To: <a01a13e4-4c11-962b-83ad-e7fc64cc3be8@linux.microsoft.com>
References: <cover.1618492553.git.viremana@linux.microsoft.com>
 <92207433d0784e123347caaa955c04fbec51eaa7.1618492553.git.viremana@linux.microsoft.com>
 <87y2di7hiz.fsf@vitty.brq.redhat.com>
 <a01a13e4-4c11-962b-83ad-e7fc64cc3be8@linux.microsoft.com>
Date:   Tue, 20 Apr 2021 17:57:19 +0200
Message-ID: <87eef5hrts.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Vineeth Pillai <viremana@linux.microsoft.com> writes:

> On 4/16/2021 4:36 AM, Vitaly Kuznetsov wrote:
>>
>>>   struct kvm_vm_stat {
>>> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
>>> index 58fa8c029867..614b4448a028 100644
>>> --- a/arch/x86/kvm/hyperv.c
>>> +++ b/arch/x86/kvm/hyperv.c
>> I still think that using arch/x86/kvm/hyperv.[ch] for KVM-on-Hyper-V is
>> misleading. Currently, these are dedicated to emulating Hyper-V
>> interface to KVM guests and this is orthogonal to nesting KVM on
>> Hyper-V. As a solution, I'd suggest you either:
>> - Put the stuff in x86.c
>> - Create a dedicated set of files, e.g. 'kvmonhyperv.[ch]' (I also
>> thought about 'hyperv_host.[ch]' but then I realized it's equally
>> misleading as one can read this as 'KVM is acting as Hyper-V host').
>>
>> Personally, I'd vote for the later. Besides eliminating confusion, the
>> benefit of having dedicated files is that we can avoid compiling them
>> completely when !IS_ENABLED(CONFIG_HYPERV) (#ifdefs in C are ugly).
> Makes sense, creating new set of files looks good to me. The default 
> hyperv.c
> for hyperv emulation also seems misleading - probably we should rename it
> to hyperv_host_emul.[ch] or similar. That way, probably I can use 
> hyperv.[ch]
> for kvm on hyperv code. If you feel, thats too big of a churn, I shall use
> kvm_on_hyperv.[ch] (to avoid reading the file differently). What do you 
> think?

I agree that 'hyperv.[ch]' is not ideal but I'm on the fence whether
renaming it is worth it. If we were to rename it, I'd suggest just
'hyperv_emul.[ch]' to indicate that here we're emulating Hyper-V.

I don't think reusing 'hyperv.[ch]' for KVM-on-Hyper-V is a good idea,
it would be doubly misleading and not friendly to backporters. Let's not
do that.

>
>
>>> @@ -10470,7 +10474,6 @@ void kvm_arch_free_vm(struct kvm *kvm)
>>>   	vfree(kvm);
>>>   }
>>>   
>>> -
>> Stray change?
> It was kinda leftover, but I thought I'd keep it as it removes and 
> unnecessary line.

The idea is to have meaninful patches as concise as possible splitting
off cleanup / preparatory patches which don't actually change anything;
this way big series are much easier to review.

>
> Thanks,
> Vineeth
>

-- 
Vitaly

