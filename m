Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEA4D2B1A77
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Nov 2020 13:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgKMMCj (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 13 Nov 2020 07:02:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbgKMMCU (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 13 Nov 2020 07:02:20 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB54FC0613D1;
        Fri, 13 Nov 2020 03:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2BFjpIJS3Ek7vvcQR8a3dEMj7hT9eTVke3P+0ikvr/c=; b=O5mfO4wXfqoiBfsdjUihOBRfLB
        LVpLkKj8Q+KiRH5RMREs7LaduWm4YurS3ioKC774cEO2zZILqaGHG/IsyIzcieCTEAsdnuU5/PXtI
        nQJ5yBiclDw8Zhy9WmxS3oq18T0nAeOaUt0wx60rpLFB4+aO4KW5I4kDpzLmyIQMTJZRN73RhjMsx
        bLK3MM6TF0vGRaO2Hobp5ETePX5Jqi7O9Y5WxL4VAmvDRDuED9Vm/TwrqLRKLhGOebJs9dbBevi/v
        JeEG/y9fOVH67PhgcgPyl0TsKkxKSKaZ0l3suNMkO9jjStHzeB8C7wTs4UptyBCPqRbWLgatZ8ME+
        tzJwelFA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kdXej-0002nD-FV; Fri, 13 Nov 2020 11:54:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CB620301324;
        Fri, 13 Nov 2020 12:54:16 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B4E3E2B770416; Fri, 13 Nov 2020 12:54:16 +0100 (CET)
Date:   Fri, 13 Nov 2020 12:54:16 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [RFC] lockdep: Put graph lock/unlock under lock_recursion
 protection
Message-ID: <20201113115416.GY2611@hirez.programming.kicks-ass.net>
References: <20201113110512.1056501-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113110512.1056501-1-boqun.feng@gmail.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Nov 13, 2020 at 07:05:03PM +0800, Boqun Feng wrote:
> A warning was hit when running xfstests/generic/068 in a Hyper-V guest:
> 
> [...] ------------[ cut here ]------------
> [...] DEBUG_LOCKS_WARN_ON(lockdep_hardirqs_enabled())
> [...] WARNING: CPU: 2 PID: 1350 at kernel/locking/lockdep.c:5280 check_flags.part.0+0x165/0x170
> [...] ...
> [...] Workqueue: events pwq_unbound_release_workfn
> [...] RIP: 0010:check_flags.part.0+0x165/0x170
> [...] ...
> [...] Call Trace:
> [...]  lock_is_held_type+0x72/0x150
> [...]  ? lock_acquire+0x16e/0x4a0
> [...]  rcu_read_lock_sched_held+0x3f/0x80
> [...]  __send_ipi_one+0x14d/0x1b0
> [...]  hv_send_ipi+0x12/0x30
> [...]  __pv_queued_spin_unlock_slowpath+0xd1/0x110
> [...]  __raw_callee_save___pv_queued_spin_unlock_slowpath+0x11/0x20
> [...]  .slowpath+0x9/0xe
> [...]  lockdep_unregister_key+0x128/0x180
> [...]  pwq_unbound_release_workfn+0xbb/0xf0
> [...]  process_one_work+0x227/0x5c0
> [...]  worker_thread+0x55/0x3c0
> [...]  ? process_one_work+0x5c0/0x5c0
> [...]  kthread+0x153/0x170
> [...]  ? __kthread_bind_mask+0x60/0x60
> [...]  ret_from_fork+0x1f/0x30
> 
> The cause of the problem is we have call chain lockdep_unregister_key()
> -> <irq disabled by raw_local_irq_save()> lockdep_unlock() ->
> arch_spin_unlock() -> __pv_queued_spin_unlock_slowpath() -> pv_kick() ->
> __send_ipi_one() -> trace_hyperv_send_ipi_one().
> 
> Although this particular warning is triggered because Hyper-V has a
> trace point in ipi sending, but in general arch_spin_unlock() may call
> another function having a trace point in it, so put the arch_spin_lock()
> and arch_spin_unlock() after lock_recursion protection to fix this
> problem and avoid similiar problems.
> 
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>

Works for me, thanks!
