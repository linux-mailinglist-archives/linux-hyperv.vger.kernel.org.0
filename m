Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E48846C1E7
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 Dec 2021 18:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239735AbhLGRjk (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 7 Dec 2021 12:39:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235271AbhLGRjj (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 7 Dec 2021 12:39:39 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F366DC061574;
        Tue,  7 Dec 2021 09:36:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4BBF0CE1C69;
        Tue,  7 Dec 2021 17:36:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30882C341C7;
        Tue,  7 Dec 2021 17:36:05 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="da3Ng9ts"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1638898561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JEncML74KciRPTHUJgcoLxaU8ezhg4AbnyMOEsP2sas=;
        b=da3Ng9tsRKzsp8tl85MW2VQvCdklOGVMgGS8WnJdm3AWElMx7KiuvNJsgt3ls6lewKwYnQ
        waM/y9TxWAgRX0oxqHPNfIYs/Az0gXZI291ylH5KfSVlNo/9B3+n4glTigph/ky7AjvHRC
        vgQ+G0o7na07oRlHS9qVxBD3T49ZP7M=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 1a0e2178 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 7 Dec 2021 17:36:01 +0000 (UTC)
Received: by mail-yb1-f178.google.com with SMTP id v64so42908102ybi.5;
        Tue, 07 Dec 2021 09:36:01 -0800 (PST)
X-Gm-Message-State: AOAM5339kCqsoRe2v5qHpuL8dSUmje5xE4veAQ8TJFCTelTeRospmtNo
        2JNBoMRDlUTFrx+lxjQZKJgMFxu0RSdwfFuqBFY=
X-Google-Smtp-Source: ABdhPJxRJE8S3O5YmMCANueUK4lz2zAh9leN0CI2YWuhcKT6tZY7G2N6BNxEXlbxocENbttygA4qsIaHDoPu+GtuChM=
X-Received: by 2002:a25:1e83:: with SMTP id e125mr49691951ybe.32.1638898558882;
 Tue, 07 Dec 2021 09:35:58 -0800 (PST)
MIME-Version: 1.0
References: <20211207121737.2347312-1-bigeasy@linutronix.de> <20211207121737.2347312-2-bigeasy@linutronix.de>
In-Reply-To: <20211207121737.2347312-2-bigeasy@linutronix.de>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 7 Dec 2021 18:35:47 +0100
X-Gmail-Original-Message-ID: <CAHmME9oSD-XkYaozFAiDnr1n4qBjTb8febw5mt6LS_DfzLUo7A@mail.gmail.com>
Message-ID: <CAHmME9oSD-XkYaozFAiDnr1n4qBjTb8febw5mt6LS_DfzLUo7A@mail.gmail.com>
Subject: Re: [PATCH 1/5] random: Remove unused irq_flags argument from add_interrupt_randomness().
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dexuan Cui <decui@microsoft.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Ingo Molnar <mingo@redhat.com>,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org,
        X86 ML <x86@kernel.org>,
        Sultan Alsawaf <sultan@kerneltoast.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Dec 7, 2021 at 1:17 PM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> Since commit
>    ee3e00e9e7101 ("random: use registers from interrupted code for CPU's w/o a cycle counter")
>
> the irq_flags argument is no longer used.
>
> Remove unused irq_flags irq_flags.
>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Dexuan Cui <decui@microsoft.com>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: K. Y. Srinivasan <kys@microsoft.com>
> Cc: Stephen Hemminger <sthemmin@microsoft.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Wei Liu <wei.liu@kernel.org>
> Cc: linux-hyperv@vger.kernel.org
> Cc: x86@kernel.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  arch/x86/kernel/cpu/mshyperv.c | 2 +-
>  drivers/char/random.c          | 4 ++--
>  drivers/hv/vmbus_drv.c         | 2 +-
>  include/linux/random.h         | 2 +-
>  kernel/irq/handle.c            | 2 +-
>  5 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> index ff55df60228f7..2a0f836789118 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -79,7 +79,7 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_hyperv_stimer0)
>         inc_irq_stat(hyperv_stimer0_count);
>         if (hv_stimer0_handler)
>                 hv_stimer0_handler();
> -       add_interrupt_randomness(HYPERV_STIMER0_VECTOR, 0);
> +       add_interrupt_randomness(HYPERV_STIMER0_VECTOR);
>         ack_APIC_irq();
>
>         set_irq_regs(old_regs);
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index 605969ed0f965..c8067c264a880 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -200,7 +200,7 @@
>   *     void add_device_randomness(const void *buf, unsigned int size);
>   *     void add_input_randomness(unsigned int type, unsigned int code,
>   *                                unsigned int value);
> - *     void add_interrupt_randomness(int irq, int irq_flags);
> + *     void add_interrupt_randomness(int irq);
>   *     void add_disk_randomness(struct gendisk *disk);
>   *
>   * add_device_randomness() is for adding data to the random pool that
> @@ -1242,7 +1242,7 @@ static __u32 get_reg(struct fast_pool *f, struct pt_regs *regs)
>         return *ptr;
>  }
>
> -void add_interrupt_randomness(int irq, int irq_flags)
> +void add_interrupt_randomness(int irq)
>  {
>         struct entropy_store    *r;
>         struct fast_pool        *fast_pool = this_cpu_ptr(&irq_randomness);
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 392c1ac4f8193..7ae04ccb10438 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -1381,7 +1381,7 @@ static void vmbus_isr(void)
>                         tasklet_schedule(&hv_cpu->msg_dpc);
>         }
>
> -       add_interrupt_randomness(vmbus_interrupt, 0);
> +       add_interrupt_randomness(vmbus_interrupt);
>  }
>
>  static irqreturn_t vmbus_percpu_isr(int irq, void *dev_id)
> diff --git a/include/linux/random.h b/include/linux/random.h
> index f45b8be3e3c4e..c45b2693e51fb 100644
> --- a/include/linux/random.h
> +++ b/include/linux/random.h
> @@ -35,7 +35,7 @@ static inline void add_latent_entropy(void) {}
>
>  extern void add_input_randomness(unsigned int type, unsigned int code,
>                                  unsigned int value) __latent_entropy;
> -extern void add_interrupt_randomness(int irq, int irq_flags) __latent_entropy;
> +extern void add_interrupt_randomness(int irq) __latent_entropy;
>
>  extern void get_random_bytes(void *buf, int nbytes);
>  extern int wait_for_random_bytes(void);
> diff --git a/kernel/irq/handle.c b/kernel/irq/handle.c
> index 27182003b879c..68c76c3caaf55 100644
> --- a/kernel/irq/handle.c
> +++ b/kernel/irq/handle.c
> @@ -197,7 +197,7 @@ irqreturn_t handle_irq_event_percpu(struct irq_desc *desc)
>
>         retval = __handle_irq_event_percpu(desc, &flags);
>
> -       add_interrupt_randomness(desc->irq_data.irq, flags);
> +       add_interrupt_randomness(desc->irq_data.irq);
>
>         if (!irq_settings_no_debug(desc))
>                 note_interrupt(desc, retval);
> --
> 2.34.1
>

Thanks for this. Sultan noticed the same thing a while back:
https://lore.kernel.org/lkml/20180430031222.mapajgwprkkr6p36@sultan-box/

I'll apply this and the subsequent one.

Regards,
Jason
