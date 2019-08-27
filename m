Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 653E09E819
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 Aug 2019 14:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfH0MiX (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 27 Aug 2019 08:38:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35404 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726552AbfH0MiW (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 27 Aug 2019 08:38:22 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D3158A76C
        for <linux-hyperv@vger.kernel.org>; Tue, 27 Aug 2019 12:38:21 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id x13so1017544wmj.9
        for <linux-hyperv@vger.kernel.org>; Tue, 27 Aug 2019 05:38:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=mhQh216D8KPUhpQBQ77haDbZ+wPiEolIAFs33u9E+Zo=;
        b=b/UmlgvmbKIXmjQH7N4Agg08PkFyarh9cmkjRWPmOgX2ueG/aXKpxouAR2Q1nUu1CO
         xBxLrlElzfQB9hKVQXUTkVO80sER3Zgsdjv2/pHXrDp/iNr3FrfCCe3YGHTUhOJvLDx9
         ZA4JaCfd/8at1y/H2tswCv20Th8vBd1mQpEn5sT/Kgbt8cbQEclSipmeExTU9RU7VE0P
         xAjt5lxuXen296rRQudnv6WUOpz2Wd4nlN73lkVgEYi6p4AfImNNv30QbgVkhXWB4i85
         tS2QH71ZdDLXcEcCWN9Hd+YMjARepkXg80/GKkdJE5WlQZKTSbWqF3fm335rBA4uqUAR
         89Pg==
X-Gm-Message-State: APjAAAVsa4bETHYxOvxhO9Y0OPsvVNhPmslYei2qBuz7Mygu0QZRmdRg
        f2+T6LxORvc/ZgkANj+iJAn1aHR0qBi7Jbf4XCP97yMjQ7RlpqXWB5Tx4mlKp5l/bJFq2laoyJ5
        yDIKdFbrMp4A5w3rlneoCBBR1
X-Received: by 2002:adf:f481:: with SMTP id l1mr25892208wro.123.1566909500318;
        Tue, 27 Aug 2019 05:38:20 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwI/jOubxVQ3m1X/ohXNC7Qj8WcNWE6wblvwS3EBzKXpryhrcDiEf/YNoTuRfvbBF8ToWpKXQ==
X-Received: by 2002:adf:f481:: with SMTP id l1mr25892187wro.123.1566909500126;
        Tue, 27 Aug 2019 05:38:20 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id x10sm16906584wrn.39.2019.08.27.05.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 05:38:19 -0700 (PDT)
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
In-Reply-To: <CAOLK0pzXPG9tBnQoKGTSNHMwXXrEQ4zZH1uWn2F2mQ2ddVcoFA@mail.gmail.com>
References: <20190819131737.26942-1-Tianyu.Lan@microsoft.com> <87ftlnm7o8.fsf@vitty.brq.redhat.com> <CAOLK0pzXPG9tBnQoKGTSNHMwXXrEQ4zZH1uWn2F2mQ2ddVcoFA@mail.gmail.com>
Date:   Tue, 27 Aug 2019 14:38:18 +0200
Message-ID: <87v9uilr5x.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Tianyu Lan <lantianyu1986@gmail.com> writes:

> On Tue, Aug 27, 2019 at 2:41 PM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>>
>> lantianyu1986@gmail.com writes:
>>
>> > From: Tianyu Lan <Tianyu.Lan@microsoft.com>
>> >
>> > This patchset is to add Hyper-V direct tlb support in KVM. Hyper-V
>> > in L0 can delegate L1 hypervisor to handle tlb flush request from
>> > L2 guest when direct tlb flush is enabled in L1.
>> >
>> > Patch 2 introduces new cap KVM_CAP_HYPERV_DIRECT_TLBFLUSH to enable
>> > feature from user space. User space should enable this feature only
>> > when Hyper-V hypervisor capability is exposed to guest and KVM profile
>> > is hided. There is a parameter conflict between KVM and Hyper-V hypercall.
>> > We hope L2 guest doesn't use KVM hypercall when the feature is
>> > enabled. Detail please see comment of new API
>> > "KVM_CAP_HYPERV_DIRECT_TLBFLUSH"
>>
>> I was thinking about this for awhile and I think I have a better
>> proposal. Instead of adding this new capability let's enable direct TLB
>> flush when KVM guest enables Hyper-V Hypercall page (writes to
>> HV_X64_MSR_HYPERCALL) - this guarantees that the guest doesn't need KVM
>> hypercalls as we can't handle both KVM-style and Hyper-V-style
>> hypercalls simultaneously and kvm_emulate_hypercall() does:
>>
>>         if (kvm_hv_hypercall_enabled(vcpu->kvm))
>>                 return kvm_hv_hypercall(vcpu);
>>
>> What do you think?
>>
>> (and instead of adding the capability we can add kvm.ko module parameter
>> to enable direct tlb flush unconditionally, like
>> 'hv_direct_tlbflush=-1/0/1' with '-1' being the default (autoselect
>> based on Hyper-V hypercall enablement, '0' - permanently disabled, '1' -
>> permanenetly enabled)).
>>
>
> Hi Vitaly::
>      Actually, I had such idea before. But user space should check
> whether hv tlb flush
> is exposed to VM before enabling direct tlb flush. If no, user space
> should not direct
> tlb flush for guest since Hyper-V will do more check for each
> hypercall from nested
> VM with enabling the feauter..

If TLB Flush enlightenment is not exposed to the VM at all there's no
difference if we enable direct TLB flush in eVMCS or not: the guest
won't be using 'TLB Flush' hypercall and will do TLB flushing with
IPIs. And, in case the guest enables Hyper-V hypercall page, it is
definitelly not going to use KVM hypercalls so we can't break these.

-- 
Vitaly
