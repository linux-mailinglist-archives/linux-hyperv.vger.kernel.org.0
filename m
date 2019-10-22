Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36486E049E
	for <lists+linux-hyperv@lfdr.de>; Tue, 22 Oct 2019 15:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbfJVNLY (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 22 Oct 2019 09:11:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49397 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731714AbfJVNLY (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 22 Oct 2019 09:11:24 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A1248C058CBD
        for <linux-hyperv@vger.kernel.org>; Tue, 22 Oct 2019 13:11:23 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id m68so2493340wme.7
        for <linux-hyperv@vger.kernel.org>; Tue, 22 Oct 2019 06:11:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=AWIpPvm7UprL2uTNf2oKMNhafTTRgSL5RG8YF9O+sQ0=;
        b=IlQYqfi3ZUfC8p1c0/Ls6KQE87SoLP0o7VMEkka3BCqPejoH/vUtX2nzN4iLul2FoE
         A7j4094Hsh1dO3dCBDxSPicz9CaGHII74QH/ZRi0yGJG4rICu22VX9rqwWJNoJkaufxS
         aOCpej5Ga37lO6NFjoQMUp/9dGwgYtJFfQadX+QENwGBRqPZ69k0SwXMGrpoca+RzCP+
         Y8zYp+pt4+7iqCAvCVtyVLbViC+nuWcD/FbueuVW6bFnVLIR/oDjnPy2YhjNOUJ3z2lD
         BL2wWUK1bbIGqbFhqy3Gzw5bBUsRXdAKnEAEH2u55LLkImWJuRbS9bcmi84Scns5deez
         k9PQ==
X-Gm-Message-State: APjAAAWPejbhDXuD9Z/PMy9bopta1iUCU5ySJ5M5nJkqJMPPM+OXJMvP
        uI1r62Lk/yY3+tQAFh0iN3iP4IVeKj/2dLIIvNIwVgo1PmFpz3ZMEsJfHbWQEDR+PESj1zW5t/A
        m8iBlqz1BngOjVCPzGBUXW7Go
X-Received: by 2002:a05:6000:118f:: with SMTP id g15mr245429wrx.242.1571749882082;
        Tue, 22 Oct 2019 06:11:22 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzAEy/wjVyqz3gSBY2lKtBGQuAlLyTMHI7PFn5YaAc9NTp8p4NIJGat0PwLnzZzfUSMKXzEJw==
X-Received: by 2002:a05:6000:118f:: with SMTP id g15mr245385wrx.242.1571749881755;
        Tue, 22 Oct 2019 06:11:21 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id c14sm11510623wru.24.2019.10.22.06.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 06:11:21 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com,
        sean.j.christopherson@intel.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, boris.ostrovsky@oracle.com,
        jgross@suse.com, peterz@infradead.org, will@kernel.org,
        linux-hyperv@vger.kernel.org, kvm@vger.kernel.org,
        mikelley@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, sashal@kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v7 3/5] x86/kvm: Add "nopvspin" parameter to disable PV spinlocks
In-Reply-To: <dbc50272-a4f5-ce7c-ba71-75031521f420@oracle.com>
References: <1571649076-2421-1-git-send-email-zhenzhong.duan@oracle.com> <1571649076-2421-4-git-send-email-zhenzhong.duan@oracle.com> <8736fl1071.fsf@vitty.brq.redhat.com> <dbc50272-a4f5-ce7c-ba71-75031521f420@oracle.com>
Date:   Tue, 22 Oct 2019 15:11:19 +0200
Message-ID: <87tv81ylfs.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Zhenzhong Duan <zhenzhong.duan@oracle.com> writes:

> Hi Vitaly,
>
> On 2019/10/22 19:36, Vitaly Kuznetsov wrote:
>
>> Zhenzhong Duan<zhenzhong.duan@oracle.com>  writes:
>>
> ...snip
>
>>> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
>>> index 249f14a..3945aa5 100644
>>> --- a/arch/x86/kernel/kvm.c
>>> +++ b/arch/x86/kernel/kvm.c
>>> @@ -825,18 +825,36 @@ __visible bool __kvm_vcpu_is_preempted(long cpu)
>>>    */
>>>   void __init kvm_spinlock_init(void)
>>>   {
>>> -	/* Does host kernel support KVM_FEATURE_PV_UNHALT? */
>>> -	if (!kvm_para_has_feature(KVM_FEATURE_PV_UNHALT))
>>> +	/*
>>> +	 * In case host doesn't support KVM_FEATURE_PV_UNHALT there is still an
>>> +	 * advantage of keeping virt_spin_lock_key enabled: virt_spin_lock() is
>>> +	 * preferred over native qspinlock when vCPU is preempted.
>>> +	 */
>>> +	if (!kvm_para_has_feature(KVM_FEATURE_PV_UNHALT)) {
>>> +		pr_info("PV spinlocks disabled, no host support.\n");
>>>   		return;
>>> +	}
>>>   
>>> +	/*
>>> +	 * Disable PV qspinlock and use native qspinlock when dedicated pCPUs
>>> +	 * are available.
>>> +	 */
>>>   	if (kvm_para_has_hint(KVM_HINTS_REALTIME)) {
>>> -		static_branch_disable(&virt_spin_lock_key);
>>> -		return;
>>> +		pr_info("PV spinlocks disabled with KVM_HINTS_REALTIME hints.\n");
>>> +		goto out;
>>>   	}
>>>   
>>> -	/* Don't use the pvqspinlock code if there is only 1 vCPU. */
>>> -	if (num_possible_cpus() == 1)
>>> -		return;
>>> +	if (num_possible_cpus() == 1) {
>>> +		pr_info("PV spinlocks disabled, single CPU.\n");
>>> +		goto out;
>>> +	}
>>> +
>>> +	if (nopvspin) {
>>> +		pr_info("PV spinlocks disabled, forced by \"nopvspin\" parameter.\n");
>>> +		goto out;
>>> +	}
>>> +
>>> +	pr_info("PV spinlocks enabled\n");
>>>   
>>>   	__pv_init_lock_hash();
>>>   	pv_ops.lock.queued_spin_lock_slowpath = __pv_queued_spin_lock_slowpath;
>>> @@ -849,6 +867,8 @@ void __init kvm_spinlock_init(void)
>>>   		pv_ops.lock.vcpu_is_preempted =
>>>   			PV_CALLEE_SAVE(__kvm_vcpu_is_preempted);
>>>   	}
>>> +out:
>>> +	static_branch_disable(&virt_spin_lock_key);
>> You probably need to add 'return' before 'out:' as it seems you're
>> disabling virt_spin_lock_key in all cases now).
>
> virt_spin_lock_key is kept enabled in !kvm_para_has_feature(KVM_FEATURE_PV_UNHALT)
> case which is the only case virt_spin_lock() optimization is used.
>
> When PV qspinlock is enabled, virt_spin_lock() isn't called in
> __pv_queued_spin_lock_slowpath() in which case we don't care
> virt_spin_lock_key's value.
>

True, my bad: I though we still need it enabled for something.

> So adding 'return' or not are both ok, I chosed to save a line,
> let me know if you prefer to add a 'return' and I'll change it.

No, please ignore.

>
> btw: __pv_queued_spin_lock_slowpath() is alias of queued_spin_lock_slowpath()
>
> Thanks
> Zhenzhong
>

-- 
Vitaly
