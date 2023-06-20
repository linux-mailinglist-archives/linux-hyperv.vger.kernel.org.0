Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B769473645C
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Jun 2023 09:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbjFTHVh (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 20 Jun 2023 03:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjFTHVg (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 20 Jun 2023 03:21:36 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A26E7;
        Tue, 20 Jun 2023 00:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uYLeKz7CtPLIuBievrQxgmZUSwGBkqjnNayiyMmgK3M=; b=jcPw1aVbWJ4FXuugKXEX0kTRZj
        RffNTyB0eEcsVpSmqG2B7rIhT84FlDdB3ule03g1AfNUBsjktvGUbFT4736H3oNVkkKcSH7f8uO7Y
        w1DBjsmNPR3i7AG+nMWNDuDcNokDha6GNQDsG7VkYzlJ10XXIygkXWKGf83NwQ1JMHQdjl3WgUtZg
        C5NeDJLZbNqrsPwhtay5wpS3zswXL22SgbyZjwu1JHS+rmXDSx4wrZddK9Jk3Q/hw6R+ezpGc+ZFv
        CtGNfTUPowA7O9w5Gosgrw5k3fWeIvXSi7PA+CeXifr+kVyBf54oE59kOZ1HMQQOYX46Xk/bhJmw7
        SMGsgLFA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qBVfV-00Fxtf-2Q;
        Tue, 20 Jun 2023 07:20:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C789A30020B;
        Tue, 20 Jun 2023 09:20:47 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4AF2F21440F48; Tue, 20 Jun 2023 09:20:47 +0200 (CEST)
Date:   Tue, 20 Jun 2023 09:20:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Xin Li <xin3.li@intel.com>
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        iommu@lists.linux.dev, linux-hyperv@vger.kernel.org,
        linux-perf-users@vger.kernel.org, x86@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, steve.wahl@hpe.com,
        mike.travis@hpe.com, dimitri.sivanich@hpe.com,
        russ.anderson@hpe.com, dvhart@infradead.org, andy@infradead.org,
        joro@8bytes.org, suravee.suthikulpanit@amd.com, will@kernel.org,
        robin.murphy@arm.com, kys@microsoft.com, haiyangz@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, dwmw2@infradead.org,
        baolu.lu@linux.intel.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        seanjc@google.com, jiangshanlai@gmail.com, jgg@ziepe.ca,
        yangtiezhu@loongson.cn
Subject: Re: [PATCH 2/3] x86/vector: Replace IRQ_MOVE_CLEANUP_VECTOR with a
 timer callback
Message-ID: <20230620072047.GS4253@hirez.programming.kicks-ass.net>
References: <20230619231611.2230-1-xin3.li@intel.com>
 <20230619231611.2230-3-xin3.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230619231611.2230-3-xin3.li@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Jun 19, 2023 at 04:16:10PM -0700, Xin Li wrote:

> +/*
> + * Called with vector_lock held
> + */

Instead of comments like that, I tend to add a lockdep_assert*()
statement to the same effect. Which unlike comment actually validate the
claim and since it's code it tends to not go stale like comments do.

> +static void __vector_cleanup(struct vector_cleanup *cl, bool check_irr)
>  {
>  	struct apic_chip_data *apicd;
>  	struct hlist_node *tmp;
> +	bool rearm = false;

	lockdep_assert_held(&vector_lock);

> +	hlist_for_each_entry_safe(apicd, tmp, &cl->head, clist) {
>  		unsigned int irr, vector = apicd->prev_vector;
>  
>  		/*
>  		 * Paranoia: Check if the vector that needs to be cleaned
> +		 * up is registered at the APICs IRR. That's clearly a
> +		 * hardware issue if the vector arrived on the old target
> +		 * _after_ interrupts were disabled above. Keep @apicd
> +		 * on the list and schedule the timer again to give the CPU
> +		 * a chance to handle the pending interrupt.
> +		 *
> +		 * Do not check IRR when called from lapic_offline(), because
> +		 * fixup_irqs() was just called to scan IRR for set bits and
> +		 * forward them to new destination CPUs via IPIs.
>  		 */
> +		irr = check_irr ? apic_read(APIC_IRR + (vector / 32 * 0x10)) : 0;
>  		if (irr & (1U << (vector % 32))) {
> +			pr_warn_once("Moved interrupt pending in old target APIC %u\n", apicd->irq);
> +			rearm = true;
>  			continue;
>  		}
>  		free_moved_vector(apicd);
>  	}
>  
> +	/*
> +	 * Must happen under vector_lock to make the timer_pending() check
> +	 * in __vector_schedule_cleanup() race free against the rearm here.
> +	 */
> +	if (rearm)
> +		mod_timer(&cl->timer, jiffies + 1);
> +}
> +
> +static void vector_cleanup_callback(struct timer_list *tmr)
> +{
> +	struct vector_cleanup *cl = container_of(tmr, typeof(*cl), timer);
> +
> +	/* Prevent vectors vanishing under us */
> +	raw_spin_lock_irq(&vector_lock);
> +	__vector_cleanup(cl, true);
> +	raw_spin_unlock_irq(&vector_lock);
>  }
