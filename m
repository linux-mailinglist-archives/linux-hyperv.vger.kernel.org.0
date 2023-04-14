Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28FE06E1D23
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Apr 2023 09:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjDNH25 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 14 Apr 2023 03:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDNH24 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 14 Apr 2023 03:28:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866308E;
        Fri, 14 Apr 2023 00:28:55 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681457333;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=klyLf10+PhwThcHh9soCY6U6nng+9nhGiH3nrdUWw/A=;
        b=n5HqlRQoJKez1bTC0V+hKAlgNUkdClqh62yfeIbIOIb3LuyNV9P5QSmSk295Rkpnmly3zZ
        FsynLdTeGSoMYvO61BcUg2zPfC4Pk4a9YJnVKjfWczAd9q+ESnNtAD/OpLgxI3BzBzjMat
        QWqUc9YI3xIVKy40rqcTxZxsk9Qmb4hVFkBys76EbrcW+xU4VJMKkwBb2oofQJwADRK5Fr
        kuTcp+Vl0/xOqLyf5vS2SsxMRraQvw9pXM401BUVfioziJlktZ5ITV9Yd5v+fSY9oZKXgD
        FRavhzjYIuhWbDJ4xwcQnmEwvWJt5RVcQi77fwOl9U+lPKiAsy5v2fLWDCKekA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681457333;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=klyLf10+PhwThcHh9soCY6U6nng+9nhGiH3nrdUWw/A=;
        b=skxnFpdMvzah/yejhlu25op+2G5P9jmRb4f8CnwJghZTL+hHVHVO+76Mr3FwEeqgDkjEsG
        LXzy7pvKmILBBRCQ==
To:     Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc:     Stanislav Kinsburskii <stanislav.kinsburskii@gmail.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] x86/hyperv: Expose an helper to map PCI interrupts
In-Reply-To: <20230412163616.GA1535@skinsburskii.localdomain>
References: <168079806973.14175.17999267023207421381.stgit@skinsburskii.localdomain>
 <168079870998.14175.16015623662679754647.stgit@skinsburskii.localdomain>
 <87o7nrzy9e.ffs@tglx> <20230412161951.GA894@skinsburskii.localdomain>
 <20230412163616.GA1535@skinsburskii.localdomain>
Date:   Fri, 14 Apr 2023 09:28:52 +0200
Message-ID: <878reuzzuz.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Stanislav!

On Wed, Apr 12 2023 at 09:36, Stanislav Kinsburskii wrote:
> On Wed, Apr 12, 2023 at 09:19:51AM -0700, Stanislav Kinsburskii wrote:
>> > > +	affinity = irq_data_get_effective_affinity_mask(data);
>> > > +	cpu = cpumask_first_and(affinity, cpu_online_mask);
>> > 
>> > The effective affinity mask of MSI interrupts consists only of online
>> > CPUs, to be accurate: it has exactly one online CPU set.
>> > 
>> > But even if it would have only offline CPUs then the result would be:
>> > 
>> >     cpu = nr_cpu_ids
>> > 
>> > which is definitely invalid. While a disabled vector targeted to an
>> > offline CPU is not necessarily invalid.
>
> Although this patch only tosses the code and doens't make any functional
> changes, I guess if the fix for the used cpu id is required, it has to
> be in a separated patch.

Sure.

> Would you mind to elaborate more of the problem(s)?
> Do you mean that the result of cpumask_first_and has to be checked for not
> being >= nr_cpus_ids?
> Or do you mean that there is no need to check the irq affinity against
> cpu_online_mask at all and we can simply take any first bit from the
> effective affinity mask?

As of today the effective mask of MSI interrupts contains only online
CPUs. I don't see a reason for that to change.

> Also, could you elaborate more on the disabled vector targeting an
> offline CPU? Is there any use case for such scenario (in this case we
> might want to support it)?

I'm not aware of one today. That was more a theoretical reasoning.

> I guess the goal of this code is to make sure that hypervisor won't be
> configured to deliver an MSI to an offline CPU.

Correct, but if the interrupt _is_ masked at the MSI level then the
hypervisor must not deliver an interrupt at all.

The point is that it is valid to target a masked MSI entry to an offline
CPU under the assumption that the hardware/emulation respects the
masking. Whether that's a good idea or not is a different question.

The kernel as of today does not do that. It targets unused but
configured MSI[-x] entries towards MANAGED_IRQ_SHUTDOWN_VECTOR on CPU0
for various reasons, one of them being paranoia.

But in principle there is nothing wrong with that and it should either
succeed or being rejected at the software level and not expose a
completely invalid CPU number to the hypercall in the first place.

So if you want to be defensive, then keep the _and(), but then check the
result for being valid and emit something useful like a pr_warn_once()
instead of blindly handing the invalid result to the hypercall and then
have that reject it with some undecipherable error code.

Actually it would not necessarily reach the hypercall because before
that it dereferences cpumask_of(nr_cpu_ids) here:

	nr_bank = cpumask_to_vpset(&(intr_desc->target.vp_set),	cpumask_of(cpu));

and explode with a kernel pagefault. If not it will read some random
adjacent data and try to create a vp_set from it. Neither of that is
anywhere close to correct.

Thanks,

        tglx
