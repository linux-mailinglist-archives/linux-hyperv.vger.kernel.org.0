Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF1A258DF0
	for <lists+linux-hyperv@lfdr.de>; Fri, 28 Jun 2019 00:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbfF0W2x (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 27 Jun 2019 18:28:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:56326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726445AbfF0W2x (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 27 Jun 2019 18:28:53 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 542FE2063F;
        Thu, 27 Jun 2019 22:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561674532;
        bh=6gDuV+DVL5Bbj1QRS6t+kNeAHKtQQVMNQqIxE+766Lk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Owhjj5MUM+bk7m39E3qMZJQshMRs1inLMvVheIBkFQTyF1mnp8ZzEOlEORXuaAObe
         AiLVAMrJZMh39QZV0FMyLxhbhwTS09aSMZuyntRYJwA8vHGiH5h1bGgws0e2EAdF66
         r1e6HA5Vs/cItxOEJOsnHPmiikj34gPmTPz2Ji3A=
Date:   Thu, 27 Jun 2019 18:28:51 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Zhenzhong Duan <zhenzhong.duan@oracle.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org,
        bp@alien8.de, hpa@zytor.com, boris.ostrovsky@oracle.com,
        jgross@suse.com, sstabellini@kernel.org, peterz@infradead.org,
        srinivas.eeda@oracle.com, Waiman Long <longman@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Ingo Molnar <mingo@redhat.com>, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH v2 6/7] locking/spinlocks, paravirt, hyperv: Correct the
 hv_nopvspin case
Message-ID: <20190627222851.GC11506@sasha-vm>
References: <1561377779-28036-1-git-send-email-zhenzhong.duan@oracle.com>
 <1561377779-28036-7-git-send-email-zhenzhong.duan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1561377779-28036-7-git-send-email-zhenzhong.duan@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Jun 24, 2019 at 08:02:58PM +0800, Zhenzhong Duan wrote:
>With the boot parameter "hv_nopvspin" specified a Hyperv guest should
>not make use of paravirt spinlocks, but behave as if running on bare
>metal. This is not true, however, as the qspinlock code will fall back
>to a test-and-set scheme when it is detecting a hypervisor.
>
>In order to avoid this disable the virt_spin_lock_key.
>
>Same change for XEN is already in Commit e6fd28eb3522
>("locking/spinlocks, paravirt, xen: Correct the xen_nopvspin case")
>
>Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
>Cc: Waiman Long <longman@redhat.com>
>Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
>Cc: "K. Y. Srinivasan" <kys@microsoft.com>
>Cc: Haiyang Zhang <haiyangz@microsoft.com>
>Cc: Stephen Hemminger <sthemmin@microsoft.com>
>Cc: Sasha Levin <sashal@kernel.org>
>Cc: Thomas Gleixner <tglx@linutronix.de>
>Cc: Ingo Molnar <mingo@redhat.com>
>Cc: Borislav Petkov <bp@alien8.de>
>Cc: linux-hyperv@vger.kernel.org
>---
> arch/x86/hyperv/hv_spinlock.c | 3 +++
> 1 file changed, 3 insertions(+)
>
>diff --git a/arch/x86/hyperv/hv_spinlock.c b/arch/x86/hyperv/hv_spinlock.c
>index 07f21a0..d90b4b0 100644
>--- a/arch/x86/hyperv/hv_spinlock.c
>+++ b/arch/x86/hyperv/hv_spinlock.c
>@@ -64,6 +64,9 @@ __visible bool hv_vcpu_is_preempted(int vcpu)
>
> void __init hv_init_spinlocks(void)
> {
>+	if (unlikely(!hv_pvspin))
>+		static_branch_disable(&virt_spin_lock_key);

This should be combined in the conditional under it, which already
attempts to disable PV spinlocks, note how hv_pvspin is checked there.
hc_pvspin isn't the only reason we would disable PV spinlocks on hyperv.

Also, there's no need for the unlikely() here, it's only getting called
once...

--
Thanks,
Sasha
