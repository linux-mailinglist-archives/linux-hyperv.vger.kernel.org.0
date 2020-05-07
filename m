Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34E3E1C8406
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 May 2020 09:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgEGH5b (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 7 May 2020 03:57:31 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50785 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725849AbgEGH5a (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 7 May 2020 03:57:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588838248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=94+p4rTx3aXgc1s8HtnXaNBbbzovzVYBrsIG0gSLOL0=;
        b=LsbqhuD2B6op4fGxCob2Yx6k+Wt9TnzPACzj7U/pKYJa+ekOu98pNpjUOtej3avElgWGcg
        Sx0OSBGgWU2wWQmWigCUOmKtAUcNqewtE2Zjkk5i4xls0gyfa4ey5gQl7Mual9s79RrCCe
        sCD99cd+BN6RuSRDrIJuMbAO+5GSAV0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-4IFWx2PWPl2h26WPZiwNyw-1; Thu, 07 May 2020 03:57:27 -0400
X-MC-Unique: 4IFWx2PWPl2h26WPZiwNyw-1
Received: by mail-wr1-f69.google.com with SMTP id u4so2927396wrm.13
        for <linux-hyperv@vger.kernel.org>; Thu, 07 May 2020 00:57:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=94+p4rTx3aXgc1s8HtnXaNBbbzovzVYBrsIG0gSLOL0=;
        b=XJtN5P6BeMavY2H6+ix+i9IBwaJaHCGSbAQi7kvWPGxwmJCxaXQs7l19nq1jbQpwDr
         1tMCRvS+sBAknD7mzpu+KBJ9QD7zuu8iscF9ARqU7ey9pSUQyODvCCApDlriUR9z2v+8
         JHktVgB3MXNmOijhLFfPyTHAGKcNmq0+KTUXnTDEUkbjKoy1Lfp6UnEEZt5ZGXA7LYhi
         nh4zrOHGM/jx09nxoWJq9lihIoGPl/BcnO5ZsThFHztQ5RQx0JuV4+Z1S2qvogqmhzUp
         QoI/k3EzfQ7FMsyRaCehhoNDPI3C28r78AkEuoIMFYObntRPnmTcwKRlW1Au92XU+KC5
         bulQ==
X-Gm-Message-State: AGi0PuZQBXjRGrwJ3MLRSx+6Qe8/cZ3bssThM587wjX+TdtXyGtzLeDH
        fkQctl4qfs/Ev1IDk3pwfKic8FhC2zwtgNGNHZFHMHIZlD5ABrErv2vs86uHydUFwaDkdWRwQ6s
        W2MlFtJ2AOBkkpTC5ezcr/Kw/
X-Received: by 2002:a1c:5402:: with SMTP id i2mr8528338wmb.2.1588838245995;
        Thu, 07 May 2020 00:57:25 -0700 (PDT)
X-Google-Smtp-Source: APiQypLS9zfhthG/IcPQ1OXwTaDPpA5GtnV/LzhaWTU+KmBhNY4Vze9DeatJeXZ7ts1IL1uZA+t+sQ==
X-Received: by 2002:a1c:5402:: with SMTP id i2mr8528315wmb.2.1588838245719;
        Thu, 07 May 2020 00:57:25 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:8d3e:39e5:cd88:13cc? ([2001:b07:6468:f312:8d3e:39e5:cd88:13cc])
        by smtp.gmail.com with ESMTPSA id v124sm4823503wme.45.2020.05.07.00.57.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2020 00:57:25 -0700 (PDT)
Subject: Re: [PATCH v11 0/7] x86/kvm/hyper-v: add support for synthetic
 debugger
To:     Jon Doron <arilou@gmail.com>, kvm@vger.kernel.org,
        linux-hyperv@vger.kernel.org
Cc:     vkuznets@redhat.com
References: <20200424113746.3473563-1-arilou@gmail.com>
 <20200507030141.GF2862@jondnuc>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d1a07fdd-c9ae-a042-3325-54a5cf42dab5@redhat.com>
Date:   Thu, 7 May 2020 09:57:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200507030141.GF2862@jondnuc>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 07/05/20 05:01, Jon Doron wrote:
> Paolo was this merged in or by any chance in the queue?

No, I'll get to it today.

Paolo

> Thanks,
> -- Jon.
> 
> On 24/04/2020, Jon Doron wrote:
>> Add support for the synthetic debugger interface of hyper-v, the
>> synthetic debugger has 2 modes.
>> 1. Use a set of MSRs to send/recv information (undocumented so it's not
>>   going to the hyperv-tlfs.h)
>> 2. Use hypercalls
>>
>> The first mode is based the following MSRs:
>> 1. Control/Status MSRs which either asks for a send/recv .
>> 2. Send/Recv MSRs each holds GPA where the send/recv buffers are.
>> 3. Pending MSR, holds a GPA to a PAGE that simply has a boolean that
>>   indicates if there is data pending to issue a recv VMEXIT.
>>
>> The first mode implementation is to simply exit to user-space when
>> either the control MSR or the pending MSR are being set.
>> Then it's up-to userspace to implement the rest of the logic of
>> sending/recving.
>>
>> In the second mode instead of using MSRs KNet will simply issue
>> Hypercalls with the information to send/recv, in this mode the data
>> being transferred is UDP encapsulated, unlike in the previous mode in
>> which you get just the data to send.
>>
>> The new hypercalls will exit to userspace which will be incharge of
>> re-encapsulating if needed the UDP packets to be sent.
>>
>> There is an issue though in which KDNet does not respect the hypercall
>> page and simply issues vmcall/vmmcall instructions depending on the cpu
>> type expecting them to be handled as it a real hypercall was issued.
>>
>> It's important to note that part of this feature has been subject to be
>> removed in future versions of Windows, which is why some of the
>> defintions will not be present the the TLFS but in the kvm hyperv header
>> instead.
>>
>> v11:
>> Fixed all reviewed by and rebased on latest origin/master
>>
>> Jon Doron (6):
>>  x86/kvm/hyper-v: Explicitly align hcall param for kvm_hyperv_exit
>>  x86/kvm/hyper-v: Simplify addition for custom cpuid leafs
>>  x86/hyper-v: Add synthetic debugger definitions
>>  x86/kvm/hyper-v: Add support for synthetic debugger capability
>>  x86/kvm/hyper-v: enable hypercalls without hypercall page with syndbg
>>  x86/kvm/hyper-v: Add support for synthetic debugger via hypercalls
>>
>> Vitaly Kuznetsov (1):
>>  KVM: selftests: update hyperv_cpuid with SynDBG tests
>>
>> Documentation/virt/kvm/api.rst                |  18 ++
>> arch/x86/include/asm/hyperv-tlfs.h            |   6 +
>> arch/x86/include/asm/kvm_host.h               |  14 +
>> arch/x86/kvm/hyperv.c                         | 242 ++++++++++++++++--
>> arch/x86/kvm/hyperv.h                         |  33 +++
>> arch/x86/kvm/trace.h                          |  51 ++++
>> arch/x86/kvm/x86.c                            |  13 +
>> include/uapi/linux/kvm.h                      |  13 +
>> .../selftests/kvm/x86_64/hyperv_cpuid.c       | 143 +++++++----
>> 9 files changed, 468 insertions(+), 65 deletions(-)
>>
>> -- 
>> 2.24.1
>>
> 

