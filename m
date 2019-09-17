Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD4FB4A86
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Sep 2019 11:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbfIQJda (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 17 Sep 2019 05:33:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42298 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727590AbfIQJda (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 17 Sep 2019 05:33:30 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BE3398553F
        for <linux-hyperv@vger.kernel.org>; Tue, 17 Sep 2019 09:33:29 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id k184so1005922wmk.1
        for <linux-hyperv@vger.kernel.org>; Tue, 17 Sep 2019 02:33:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=USt1kKGPYmtgyFTYD/y0A1jODqobnZ9DDJDhO5ylVlA=;
        b=Bqx97xac/SE+piUHJBWJeVqJ9htwA7XU8mbAgFXmaJS4gba1kCsY7ZoLU7CQTsbXo+
         lmTp1s4pEf80UjRa/OqIDKQOiYernstk5H/+fSrMbYKEhuNMOK/z0ipc9eCVcUTvgqb8
         1fH0wUtMzXh/gllHfuAuoPRO3piDpsDozfgg8OiGew20BmdNDrJD6QW9qv8c2J4W2vu8
         za9+5N/IBTeQxsZoheDGeznVNoO9ABmAprgY8IbmiUyUCyJLX1rCK9Rr0jRgJJFeMPr4
         ZVpsmmF4XmHvoT9f5X6YLre5P3f3+AKJ4gflHS1gY+9Ak8BeNo/oVACnMq3/9TixiCcc
         RiBQ==
X-Gm-Message-State: APjAAAVJ9WmrwTVTJSkApwtxq46GrPenVdJVhv3aH8M4N+7bTqWpSXLG
        3jQ9AMufRodU3E9ih9YnGfgRV8XoFCL82RPHFYii6zGCdjs9XVNd2ZUfKN2cm0zcKpZXZrC9Qiw
        knTvg9DBwcjhBB5c8XSFEh0JI
X-Received: by 2002:a05:600c:22da:: with SMTP id 26mr2538069wmg.177.1568712808285;
        Tue, 17 Sep 2019 02:33:28 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxE0OwLxxEExBqqFmu5jEGpfsU1LN8pNgOQBJRy2TH+nRrjttR1HYteSzAvN5aajblv2RTsXQ==
X-Received: by 2002:a05:600c:22da:: with SMTP id 26mr2538044wmg.177.1568712808057;
        Tue, 17 Sep 2019 02:33:28 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id g185sm4109888wme.10.2019.09.17.02.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 02:33:27 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Jim Mattson <jmattson@google.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-hyperv@vger.kernel.org,
        the arch/x86 maintainers <x86@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra \(Intel\)" <peterz@infradead.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Roman Kagan <rkagan@virtuozzo.com>
Subject: Re: [PATCH 2/3] KVM: x86: hyper-v: set NoNonArchitecturalCoreSharing CPUID bit when SMT is impossible
In-Reply-To: <CALMp9eRa0-HO+JWGDoAFO1zOtNjrutfT7d4pLxjsxn-XiAJwwQ@mail.gmail.com>
References: <20190916162258.6528-1-vkuznets@redhat.com> <20190916162258.6528-3-vkuznets@redhat.com> <CALMp9eRa0-HO+JWGDoAFO1zOtNjrutfT7d4pLxjsxn-XiAJwwQ@mail.gmail.com>
Date:   Tue, 17 Sep 2019 11:33:26 +0200
Message-ID: <87ef0fb72x.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Jim Mattson <jmattson@google.com> writes:

> On Mon, Sep 16, 2019 at 9:23 AM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>>
>> Hyper-V 2019 doesn't expose MD_CLEAR CPUID bit to guests when it cannot
>> guarantee that two virtual processors won't end up running on sibling SMT
>> threads without knowing about it. This is done as an optimization as in
>> this case there is nothing the guest can do to protect itself against MDS
>> and issuing additional flush requests is just pointless. On bare metal the
>> topology is known, however, when Hyper-V is running nested (e.g. on top of
>> KVM) it needs an additional piece of information: a confirmation that the
>> exposed topology (wrt vCPU placement on different SMT threads) is
>> trustworthy.
>>
>> NoNonArchitecturalCoreSharing (CPUID 0x40000004 EAX bit 18) is described in
>> TLFS as follows: "Indicates that a virtual processor will never share a
>> physical core with another virtual processor, except for virtual processors
>> that are reported as sibling SMT threads." From KVM we can give such
>> guarantee in two cases:
>> - SMT is unsupported or forcefully disabled (just 'disabled' doesn't work
>>  as it can become re-enabled during the lifetime of the guest).
>> - vCPUs are properly pinned so the scheduler won't put them on sibling
>> SMT threads (when they're not reported as such).
>
> That's a nice bit of information. Have you considered a mechanism for
> communicating this information to kvm guests in a way that doesn't
> require Hyper-V enlightenments?
>

(I haven't put much thought in this) but can we re-use MD_CLEAR CPUID
bit for that? Like if the hypervisor can't guarantee usefulness
(e.g. when two random vCPUs can be put on sibling SMT threads) of
flushing, is there any reason to still make the guest think the feature
is there?

-- 
Vitaly
