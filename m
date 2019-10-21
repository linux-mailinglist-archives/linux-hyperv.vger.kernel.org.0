Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52A09DEA8E
	for <lists+linux-hyperv@lfdr.de>; Mon, 21 Oct 2019 13:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbfJULOK (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 21 Oct 2019 07:14:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35588 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727725AbfJULOK (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 21 Oct 2019 07:14:10 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DC548369AC
        for <linux-hyperv@vger.kernel.org>; Mon, 21 Oct 2019 11:14:09 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id l184so3259362wmf.6
        for <linux-hyperv@vger.kernel.org>; Mon, 21 Oct 2019 04:14:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=YCA4RLeyZ5cxaF/rep2s+GK2lGOisVp/JoNy+UckAT0=;
        b=T9NT9DbJ1Z/2dvnOCgnJax3sR08Ku+w7ZO1gn7GaDpCAyhRCwWe3Cq10BRHLN/Z3Ar
         D3jF8iooiutVHhZmgOLBEAy+6jTWMzKRVjEoM/fhLE8vWXYpVHqyJBAuUxVMNYsqiOJE
         XlpoUR4UfXjuOfzs1NuhSID7nv9Fc5UDOM2DaIzQOySQvL0Q1mWu5Yp4A8CcfTyFypSG
         MyYby5exsPNfl2ZcFxqQGGb2cVADG6Qz0Kk+ytvEmq1ZqmZ/B0OFDnJix0baJEEiO760
         ovBdsNcAr9gGaO23NOZSPCsulZGE+rssZQUuX4CF/5movTGPa4RoF9djAiYmkHWUnj5T
         ujmg==
X-Gm-Message-State: APjAAAWhjXHfpVUDr7/WUUwlajdf0Zk9u5pbdhvETWiBnp/pQ102ivHa
        VfPqPaCgE0z1vdw1FzI/f7IKV3klF1t8gIRhJuYFLg94P0xYAa6ujYJ7zSveCmiOkzQ/kKUaKh7
        qUAE6EqA3tjixYgYs59K1en9W
X-Received: by 2002:a5d:4446:: with SMTP id x6mr9185114wrr.103.1571656448431;
        Mon, 21 Oct 2019 04:14:08 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwvkvSwVN9oISg0P55xgCa7IwHp7Nwu5VyMVpZJE6YgtXWMzZ9rANazzPeDDsWT/pvBJAvLPA==
X-Received: by 2002:a5d:4446:: with SMTP id x6mr9185078wrr.103.1571656448170;
        Mon, 21 Oct 2019 04:14:08 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id w15sm4845716wro.65.2019.10.21.04.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 04:14:07 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-hyperv@vger.kernel.org, kvm@vger.kernel.org,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, pbonzini@redhat.com, rkrcmar@redhat.com,
        sean.j.christopherson@intel.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, boris.ostrovsky@oracle.com,
        jgross@suse.com, sstabellini@kernel.org, peterz@infradead.org,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "H. Peter Anvin" <hpa@zytor.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v6 3/5] x86/kvm: Add "nopvspin" parameter to disable PV spinlocks
In-Reply-To: <1571102367-31595-4-git-send-email-zhenzhong.duan@oracle.com>
References: <1571102367-31595-1-git-send-email-zhenzhong.duan@oracle.com> <1571102367-31595-4-git-send-email-zhenzhong.duan@oracle.com>
Date:   Mon, 21 Oct 2019 13:14:06 +0200
Message-ID: <87k18y1hc1.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Zhenzhong Duan <zhenzhong.duan@oracle.com> writes:

> There are cases where a guest tries to switch spinlocks to bare metal
> behavior (e.g. by setting "xen_nopvspin" on XEN platform and
> "hv_nopvspin" on HYPER_V).
>
> That feature is missed on KVM, add a new parameter "nopvspin" to disable
> PV spinlocks for KVM guest.
>
> The new 'nopvspin' parameter will also replace Xen and Hyper-V specific
> parameters in future patches.
>
> Define variable nopvsin as global because it will be used in future
> patches as above.
>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krcmar <rkrcmar@redhat.com>
> Cc: Sean Christopherson <sean.j.christopherson@intel.com>
> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> Cc: Wanpeng Li <wanpengli@tencent.com>
> Cc: Jim Mattson <jmattson@google.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Will Deacon <will@kernel.org>
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  5 ++++
>  arch/x86/include/asm/qspinlock.h                |  1 +
>  arch/x86/kernel/kvm.c                           | 34 ++++++++++++++++++++++---
>  kernel/locking/qspinlock.c                      |  7 +++++
>  4 files changed, 43 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index a84a83f..bd49ed2 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5334,6 +5334,11 @@
>  			as generic guest with no PV drivers. Currently support
>  			XEN HVM, KVM, HYPER_V and VMWARE guest.
>  
> +	nopvspin	[X86,KVM]
> +			Disables the qspinlock slow path using PV optimizations
> +			which allow the hypervisor to 'idle' the guest on lock
> +			contention.
> +
>  	xirc2ps_cs=	[NET,PCMCIA]
>  			Format:
>  			<irq>,<irq_mask>,<io>,<full_duplex>,<do_sound>,<lockup_hack>[,<irq2>[,<irq3>[,<irq4>]]]
> diff --git a/arch/x86/include/asm/qspinlock.h b/arch/x86/include/asm/qspinlock.h
> index 444d6fd..d86ab94 100644
> --- a/arch/x86/include/asm/qspinlock.h
> +++ b/arch/x86/include/asm/qspinlock.h
> @@ -32,6 +32,7 @@ static __always_inline u32 queued_fetch_set_pending_acquire(struct qspinlock *lo
>  extern void __pv_init_lock_hash(void);
>  extern void __pv_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
>  extern void __raw_callee_save___pv_queued_spin_unlock(struct qspinlock *lock);
> +extern bool nopvspin;
>  
>  #define	queued_spin_unlock queued_spin_unlock
>  /**
> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> index 249f14a..e9c76d8 100644
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c
> @@ -825,18 +825,44 @@ __visible bool __kvm_vcpu_is_preempted(long cpu)
>   */
>  void __init kvm_spinlock_init(void)
>  {
> -	/* Does host kernel support KVM_FEATURE_PV_UNHALT? */
> -	if (!kvm_para_has_feature(KVM_FEATURE_PV_UNHALT))
> +	/*
> +	 * PV spinlocks is disabled if no host side support, then native
> +	 * qspinlock will be used. As native qspinlock is a fair lock, there is
> +	 * lock holder preemption issue using it in a guest, imaging one pCPU
> +	 * running 10 vCPUs of same guest contending same lock.
> +	 *
> +	 * virt_spin_lock() is introduced as an optimization for that scenario
> +	 * which is enabled by virt_spin_lock_key key. To use that optimization,
> +	 * virt_spin_lock_key isn't disabled here.
> +	 */

My take (if I properly understood what you say) would be:

"In case host doesn't support KVM_FEATURE_PV_UNHALT there is still an
advantage of keeping virt_spin_lock_key enabled: virt_spin_lock() is
preferred over native qspinlock when vCPU is preempted."

> +	if (!kvm_para_has_feature(KVM_FEATURE_PV_UNHALT)) {
> +		pr_info("PV spinlocks disabled, no host support.\n");
>  		return;
> +	}
>  
> +	/*
> +	 * Disable PV qspinlock and use native qspinlock when dedicated pCPUs
> +	 * are available.
> +	 */
>  	if (kvm_para_has_hint(KVM_HINTS_REALTIME)) {
> +		pr_info("PV spinlocks disabled with KVM_HINTS_REALTIME hints.\n");
> +		static_branch_disable(&virt_spin_lock_key);
> +		return;
> +	}
> +
> +	if (num_possible_cpus() == 1) {
> +		pr_info("PV spinlocks disabled, single CPU.\n");
>  		static_branch_disable(&virt_spin_lock_key);
>  		return;
>  	}
>  
> -	/* Don't use the pvqspinlock code if there is only 1 vCPU. */
> -	if (num_possible_cpus() == 1)
> +	if (nopvspin) {
> +		pr_info("PV spinlocks disabled, forced by \"nopvspin\" parameter.\n");
> +		static_branch_disable(&virt_spin_lock_key);
>  		return;

You could've replaced this 'static_branch_disable(); return;' pattern
with a goto to the end of the function to save a few lines but this
looks good anyways.

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

> +	}
> +
> +	pr_info("PV spinlocks enabled\n");
>  
>  	__pv_init_lock_hash();
>  	pv_ops.lock.queued_spin_lock_slowpath = __pv_queued_spin_lock_slowpath;
> diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
> index 2473f10..75193d6 100644
> --- a/kernel/locking/qspinlock.c
> +++ b/kernel/locking/qspinlock.c
> @@ -580,4 +580,11 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
>  #include "qspinlock_paravirt.h"
>  #include "qspinlock.c"
>  
> +bool nopvspin __initdata;
> +static __init int parse_nopvspin(char *arg)
> +{
> +	nopvspin = true;
> +	return 0;
> +}
> +early_param("nopvspin", parse_nopvspin);
>  #endif

-- 
Vitaly
