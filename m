Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAC4646BB88
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 Dec 2021 13:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbhLGMsL (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 7 Dec 2021 07:48:11 -0500
Received: from mail-wm1-f45.google.com ([209.85.128.45]:54075 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbhLGMsK (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 7 Dec 2021 07:48:10 -0500
Received: by mail-wm1-f45.google.com with SMTP id y196so10615416wmc.3;
        Tue, 07 Dec 2021 04:44:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pN83c85bka+q5D7YAhZzC6sSAnlsUaiM8jJHT16MFzc=;
        b=a3FoKmBOVUeVak2ofD/vscCuWQJJeo1wVJ70+fHFC6zdHOc+adECuDYjPEy6c8NUI3
         yphNzAoKrCozuF8hL1zN7QdAeD7wkHCGU660lwXEKSHwYbJZIfXNLczdkp+lP21C5qpk
         LSAsgYreC72ubFJLW6Oa20ZQld5kSF46Xs/7NmcmQ07EBRDInifUL1KX/Swt1jcku0fe
         1/Xjs2qtPVcegN2D7zVDzx9bqASx9I9nJPbvX2Z3d+MTm/CH9Wj9mBdVH3StYw+hjv6r
         1ZEneS7YIwaIWQomnAhGPs0JAKWXZouMTJbHr1OsmD0EDtNHqU757wWXrn299ay3Zr7t
         B5iA==
X-Gm-Message-State: AOAM5301Glmp6kObLVBLkoP1zXWtVt166djFPZg4DTwWEmFWxi6JXRRX
        Z9hfbleIc43NEHIJ2RksrQ0=
X-Google-Smtp-Source: ABdhPJx/pKjS0xi7O6wrmjndLG6KB6gN3ng4uJvbEmaNeF0yT0vzhR3Jq/02aeW8FV84CjQOxBTGHw==
X-Received: by 2002:a05:600c:2292:: with SMTP id 18mr6757781wmf.6.1638881079503;
        Tue, 07 Dec 2021 04:44:39 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id a9sm15021982wrt.66.2021.12.07.04.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 04:44:39 -0800 (PST)
Date:   Tue, 7 Dec 2021 12:44:37 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        "Jason A . Donenfeld " <Jason@zx2c4.com>,
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
        x86@kernel.org
Subject: Re: [PATCH 1/5] random: Remove unused irq_flags argument from
 add_interrupt_randomness().
Message-ID: <20211207124437.x7khddnt3bplwv4d@liuwe-devbox-debian-v2>
References: <20211207121737.2347312-1-bigeasy@linutronix.de>
 <20211207121737.2347312-2-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207121737.2347312-2-bigeasy@linutronix.de>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Dec 07, 2021 at 01:17:33PM +0100, Sebastian Andrzej Siewior wrote:
> Since commit
>    ee3e00e9e7101 ("random: use registers from interrupted code for CPU's w/o a cycle counter")
> 
> the irq_flags argument is no longer used.
> 
> Remove unused irq_flags irq_flags.

Two irq_flags here.
[...]
>  	struct fast_pool	*fast_pool = this_cpu_ptr(&irq_randomness);
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 392c1ac4f8193..7ae04ccb10438 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -1381,7 +1381,7 @@ static void vmbus_isr(void)
>  			tasklet_schedule(&hv_cpu->msg_dpc);
>  	}
>  
> -	add_interrupt_randomness(vmbus_interrupt, 0);
> +	add_interrupt_randomness(vmbus_interrupt);
>  }

Acked-by: Wei Liu <wei.liu@kernel.org>

