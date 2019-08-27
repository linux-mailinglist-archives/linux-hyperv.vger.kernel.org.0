Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92F899E954
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 Aug 2019 15:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfH0NaE (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 27 Aug 2019 09:30:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50804 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbfH0NaB (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 27 Aug 2019 09:30:01 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 126B8C05AA61
        for <linux-hyperv@vger.kernel.org>; Tue, 27 Aug 2019 13:30:00 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id m7so11407703wrw.22
        for <linux-hyperv@vger.kernel.org>; Tue, 27 Aug 2019 06:30:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=G9L7A4nBpy1D901YxUFl9Z11bC0ZxAJnfNz+eX7/gFs=;
        b=IFgsv1vLfFf9Vb6XG45Y3qaGGZ2eqiJfdZzGoS6AnyOW0OrkxegO3frHpsLorvlESj
         Rjaq7pawB8bnARcydqYuA4LS824YtyCFY8HdjVs+Rpj5YAJdpXvZfgsM+EEYD9tL08Ji
         kjT7Y8xAopPciMRMNqgKMpTeanJA8IyIZ/fvdzHpuz+k1ciftTsASWtlIdqgi1tqsAuq
         QTifNDCDWTuBDj/NyyxCWT1yQl0yS4DbqXYS+vAKgaYqCqxdvkl9CYL0uGlkiYp+smdv
         cEFQL2G3k+GnaarACdd3K66qabkQyyehd24F8z7H0NB4LZHsL+Pulc5SENWNYupjI8Ak
         tO0w==
X-Gm-Message-State: APjAAAWioSKemXGnlguLF+XG/KZ32w03nMcU+wq6iVgK970Vf+VY4FHw
        gXPA0k6lgn/OKpVxwAes9d/5YoJVILc7k4scX8jgnwjXxPtEtA+y6ptoV1lLh7FYzek2DpcygQa
        dT2Ju+vKE95a/rE8IfBgRnGL7
X-Received: by 2002:adf:eb8c:: with SMTP id t12mr29945875wrn.84.1566912598815;
        Tue, 27 Aug 2019 06:29:58 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxmcmZOMUEodvcRMP/rKMW/fx1W1KyCJUxdSLmAlfcCk/OIrgSla8iFeT3+tZ5RICWmd9DdBw==
X-Received: by 2002:adf:eb8c:: with SMTP id t12mr29945849wrn.84.1566912598552;
        Tue, 27 Aug 2019 06:29:58 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id z2sm3154237wmi.2.2019.08.27.06.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 06:29:57 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Tianyu Lan <lantianyu1986@gmail.com>
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>, kvm <kvm@vger.kernel.org>,
        linux-doc@vger.kernel.org, linux-hyperv@vger.kernel.org,
        "linux-kernel\@vger kernel org" <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>, corbet@lwn.net,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        michael.h.kelley@microsoft.com
Subject: Re: [PATCH V3 0/3] KVM/Hyper-V: Add Hyper-V direct tlb flush support
In-Reply-To: <CAOLK0py2rvYkLPP9uQ6Q7y31Btu4XOsWr3Vsk6GtUDWvg5uUOg@mail.gmail.com>
References: <20190819131737.26942-1-Tianyu.Lan@microsoft.com> <87ftlnm7o8.fsf@vitty.brq.redhat.com> <CAOLK0pzXPG9tBnQoKGTSNHMwXXrEQ4zZH1uWn2F2mQ2ddVcoFA@mail.gmail.com> <87v9uilr5x.fsf@vitty.brq.redhat.com> <CAOLK0py2rvYkLPP9uQ6Q7y31Btu4XOsWr3Vsk6GtUDWvg5uUOg@mail.gmail.com>
Date:   Tue, 27 Aug 2019 15:29:56 +0200
Message-ID: <87sgpmlorv.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Tianyu Lan <lantianyu1986@gmail.com> writes:

> On Tue, Aug 27, 2019 at 8:38 PM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>>
>> Tianyu Lan <lantianyu1986@gmail.com> writes:
>>
>> > On Tue, Aug 27, 2019 at 2:41 PM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>> >>
>> >> lantianyu1986@gmail.com writes:
>> >>
>> >> > From: Tianyu Lan <Tianyu.Lan@microsoft.com>
>> >> >
>> >> > This patchset is to add Hyper-V direct tlb support in KVM. Hyper-V
>> >> > in L0 can delegate L1 hypervisor to handle tlb flush request from
>> >> > L2 guest when direct tlb flush is enabled in L1.
>> >> >
>> >> > Patch 2 introduces new cap KVM_CAP_HYPERV_DIRECT_TLBFLUSH to enable
>> >> > feature from user space. User space should enable this feature only
>> >> > when Hyper-V hypervisor capability is exposed to guest and KVM profile
>> >> > is hided. There is a parameter conflict between KVM and Hyper-V hypercall.
>> >> > We hope L2 guest doesn't use KVM hypercall when the feature is
>> >> > enabled. Detail please see comment of new API
>> >> > "KVM_CAP_HYPERV_DIRECT_TLBFLUSH"
>> >>
>> >> I was thinking about this for awhile and I think I have a better
>> >> proposal. Instead of adding this new capability let's enable direct TLB
>> >> flush when KVM guest enables Hyper-V Hypercall page (writes to
>> >> HV_X64_MSR_HYPERCALL) - this guarantees that the guest doesn't need KVM
>> >> hypercalls as we can't handle both KVM-style and Hyper-V-style
>> >> hypercalls simultaneously and kvm_emulate_hypercall() does:
>> >>
>> >>         if (kvm_hv_hypercall_enabled(vcpu->kvm))
>> >>                 return kvm_hv_hypercall(vcpu);
>> >>
>> >> What do you think?
>> >>
>> >> (and instead of adding the capability we can add kvm.ko module parameter
>> >> to enable direct tlb flush unconditionally, like
>> >> 'hv_direct_tlbflush=-1/0/1' with '-1' being the default (autoselect
>> >> based on Hyper-V hypercall enablement, '0' - permanently disabled, '1' -
>> >> permanenetly enabled)).
>> >>
>> >
>> > Hi Vitaly::
>> >      Actually, I had such idea before. But user space should check
>> > whether hv tlb flush
>> > is exposed to VM before enabling direct tlb flush. If no, user space
>> > should not direct
>> > tlb flush for guest since Hyper-V will do more check for each
>> > hypercall from nested
>> > VM with enabling the feauter..
>>
>> If TLB Flush enlightenment is not exposed to the VM at all there's no
>> difference if we enable direct TLB flush in eVMCS or not: the guest
>> won't be using 'TLB Flush' hypercall and will do TLB flushing with
>> IPIs. And, in case the guest enables Hyper-V hypercall page, it is
>> definitelly not going to use KVM hypercalls so we can't break these.
>>
>
> Yes, this won't tigger KVM/Hyper-V hypercall conflict. My point is
> that if tlb flush enlightenment is not enabled, enabling direct tlb
> flush will not accelate anything and Hyper-V still will check each
> hypercalls from nested VM in order to intercpt tlb flush hypercall
> But guest won't use tlb flush hypercall in this case. The check
> of each hypercall in Hyper-V is redundant. We may avoid the
> overhead via checking status of tlb flush enlightenment and just
> enable direct tlb flush when it's enabled.

Oh, I see. Yes, this optimization is possible and I'm not against it,
however I doubt it will make a significant difference because no matter
what upon VMCALL we first drop into L0 which can either inject this in
L1 or, in case of direct TLB flush, execute it by itself. Checking if
the hypercall is a TLB flush hypercall is just a register read, it
should be very cheap.

-- 
Vitaly
