Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD76E0303
	for <lists+linux-hyperv@lfdr.de>; Tue, 22 Oct 2019 13:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388706AbfJVLgj (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 22 Oct 2019 07:36:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48048 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388704AbfJVLgj (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 22 Oct 2019 07:36:39 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8AAC0C04AC50
        for <linux-hyperv@vger.kernel.org>; Tue, 22 Oct 2019 11:36:38 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id 92so3662480wro.14
        for <linux-hyperv@vger.kernel.org>; Tue, 22 Oct 2019 04:36:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=FTSbOqc/cP0++TLaNzktd3vhmDx93fKNtqalIV8xNj4=;
        b=NkKoYuy7yImz20qi7d5wcVTv3T9P0RcXI1DsdTJtGbK6M9G7p/y8yYdSwENbX15Yq0
         gaSaHzCaXfmOzWFbJsqih0uibJ73bj3gBJU4dL2Ozx4sJnMuV2e21JNJL87t0KJlP5hx
         pLNYBsgtQ3+c5+5/eNEV5FrR/wK69yDp4s+BmOLNn/K5islz+80FZU+/6tI5r7XPpRU7
         cutmLELhnsF+t2onyLb46W82bfQrIeDCoMkeYbbT2PnJPW0WxTQL3xtxHHjE69Bexnhc
         ultgF1tWa5sbcYzOutnDLHTFZVwBPoBj+bpiHgBbLzMk8VY/cmF2ky+AcdrC7/z4Dedz
         q2mA==
X-Gm-Message-State: APjAAAWeA5w0CGVFyFKYq1J6Sza8yD2DxUwGEhtCVnNdd0EMXCfEEG5i
        wk3sxpRemd57x6XE0tI0QFl3knvaHn3+Zoojn7BDQi6HhnV3t2LKPoe+RUpvAHvk86oH5cFXbSF
        rBxdVUN1JwKhq/YGSxWgi/nR6
X-Received: by 2002:a1c:814b:: with SMTP id c72mr2717173wmd.167.1571744197223;
        Tue, 22 Oct 2019 04:36:37 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw9oRJXXcWY8MVsiwOOdUQqcZhl+/UqiW9ZlmC6hc407IYb6Lv06C/pih3i1cpDDOvdsx5uGw==
X-Received: by 2002:a1c:814b:: with SMTP id c72mr2717136wmd.167.1571744196883;
        Tue, 22 Oct 2019 04:36:36 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id p10sm20019762wrx.2.2019.10.22.04.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 04:36:36 -0700 (PDT)
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
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v7 3/5] x86/kvm: Add "nopvspin" parameter to disable PV spinlocks
In-Reply-To: <1571649076-2421-4-git-send-email-zhenzhong.duan@oracle.com>
References: <1571649076-2421-1-git-send-email-zhenzhong.duan@oracle.com> <1571649076-2421-4-git-send-email-zhenzhong.duan@oracle.com>
Date:   Tue, 22 Oct 2019 13:36:34 +0200
Message-ID: <8736fl1071.fsf@vitty.brq.redhat.com>
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
> Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
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
>  arch/x86/kernel/kvm.c                           | 34 ++++++++++++++++++++-----
>  kernel/locking/qspinlock.c                      |  7 +++++
>  4 files changed, 40 insertions(+), 7 deletions(-)
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
> index 249f14a..3945aa5 100644
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c
> @@ -825,18 +825,36 @@ __visible bool __kvm_vcpu_is_preempted(long cpu)
>   */
>  void __init kvm_spinlock_init(void)
>  {
> -	/* Does host kernel support KVM_FEATURE_PV_UNHALT? */
> -	if (!kvm_para_has_feature(KVM_FEATURE_PV_UNHALT))
> +	/*
> +	 * In case host doesn't support KVM_FEATURE_PV_UNHALT there is still an
> +	 * advantage of keeping virt_spin_lock_key enabled: virt_spin_lock() is
> +	 * preferred over native qspinlock when vCPU is preempted.
> +	 */
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
> -		static_branch_disable(&virt_spin_lock_key);
> -		return;
> +		pr_info("PV spinlocks disabled with KVM_HINTS_REALTIME hints.\n");
> +		goto out;
>  	}
>  
> -	/* Don't use the pvqspinlock code if there is only 1 vCPU. */
> -	if (num_possible_cpus() == 1)
> -		return;
> +	if (num_possible_cpus() == 1) {
> +		pr_info("PV spinlocks disabled, single CPU.\n");
> +		goto out;
> +	}
> +
> +	if (nopvspin) {
> +		pr_info("PV spinlocks disabled, forced by \"nopvspin\" parameter.\n");
> +		goto out;
> +	}
> +
> +	pr_info("PV spinlocks enabled\n");
>  
>  	__pv_init_lock_hash();
>  	pv_ops.lock.queued_spin_lock_slowpath = __pv_queued_spin_lock_slowpath;
> @@ -849,6 +867,8 @@ void __init kvm_spinlock_init(void)
>  		pv_ops.lock.vcpu_is_preempted =
>  			PV_CALLEE_SAVE(__kvm_vcpu_is_preempted);
>  	}
> +out:
> +	static_branch_disable(&virt_spin_lock_key);

You probably need to add 'return' before 'out:' as it seems you're
disabling virt_spin_lock_key in all cases now).

>  }
>  
>  #endif	/* CONFIG_PARAVIRT_SPINLOCKS */
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
