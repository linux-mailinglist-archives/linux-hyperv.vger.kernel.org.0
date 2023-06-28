Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC237417BB
	for <lists+linux-hyperv@lfdr.de>; Wed, 28 Jun 2023 20:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbjF1R7l (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 28 Jun 2023 13:59:41 -0400
Received: from mail-pg1-f178.google.com ([209.85.215.178]:57602 "EHLO
        mail-pg1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbjF1R6v (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 28 Jun 2023 13:58:51 -0400
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-55ac628e3cfso2380477a12.3;
        Wed, 28 Jun 2023 10:58:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687975130; x=1690567130;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RW4mwlpWl10TH0psfzQmrQ5XZDVmCuzE7bR+x7bxPNE=;
        b=l5wwZIyk4TS2XMYOjm7/tKmRWUKgHA7WL3mD7V+GfwmU8CD3sxSy6P3a9Pgf4XTiL1
         kbXBXyWg8s7OLFHrcMCmEZblbor5w983KIDEhR2oXYIrvN6EM6rjUe6i1bWy9j/bEEJc
         QAbayg89khKOIFuVgFhiCSs90frJsrE5IG1fo6HfC7gO91r14JoAqKf0YffUbohsLmRk
         B7J2jHjs3KBjZzzBi69GMHfBF08ccdtvXV50XqmDZibjchnXuA4JWNPg3ffMuNr/m15/
         O5N9xap+I9WSsfZX5vVw/9YoV/L+t2EZKWOJhz9py/cI9NnEz0h3ddYM/I9UVFMRl7KW
         27/w==
X-Gm-Message-State: AC+VfDx68mhGMJZOSYe7FlYgyGl9yalgUNEY0tnFdLeIuAwcAqOiC8d7
        KyB2usNAc+Z0kSEAmSu9Mv8=
X-Google-Smtp-Source: ACHHUZ6I6NNMYBTcW1td1WbYA0EwtrILk6+AD9BP3oTE+rYL8C549ffwpRWXcqbzodde5/KRLoAecw==
X-Received: by 2002:a17:90a:d511:b0:263:949:7ab9 with SMTP id t17-20020a17090ad51100b0026309497ab9mr5311816pju.24.1687975130502;
        Wed, 28 Jun 2023 10:58:50 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id s2-20020a17090aba0200b002535a0f2028sm9743975pjr.51.2023.06.28.10.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 10:58:50 -0700 (PDT)
Date:   Wed, 28 Jun 2023 17:58:48 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Saurabh Sengar <ssengar@linux.microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        mikelley@microsoft.com, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, hpa@zytor.com
Subject: Re: [PATCH v3] x86/hyperv: add noop functions to x86_init mpparse
 functions
Message-ID: <ZJx02GzzoQ9E1TH9@liuwe-devbox-debian-v2>
References: <1687537688-5397-1-git-send-email-ssengar@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1687537688-5397-1-git-send-email-ssengar@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Jun 23, 2023 at 09:28:08AM -0700, Saurabh Sengar wrote:
> Hyper-V can run VMs at different privilege "levels" known as Virtual
> Trust Levels (VTL). Sometimes, it chooses to run two different VMs
> at different levels but they share some of their address space. In
> such setups VTL2 (higher level VM) has visibility of all of the
> VTL0 (level 0) memory space.
> 
> When the CONFIG_X86_MPPARSE is enabled for VTL2, the VTL2 kernel
> performs a search within the low memory to locate MP tables. However,
> in systems where VTL0 manages the low memory and may contain valid
> tables, this scanning can result in incorrect MP table information
> being provided to the VTL2 kernel, mistakenly considering VTL0's MP
> table as its own
> 
> Add noop functions to avoid MP parse scan by VTL2.
> 
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>

Hi Dave, are you happy with the commit message?

> ---
> [V3]
>  - modify commit message.
> 
>  arch/x86/hyperv/hv_vtl.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
> index 85d38b9f3586..db5d2ea39fc0 100644
> --- a/arch/x86/hyperv/hv_vtl.c
> +++ b/arch/x86/hyperv/hv_vtl.c
> @@ -25,6 +25,10 @@ void __init hv_vtl_init_platform(void)
>  	x86_init.irqs.pre_vector_init = x86_init_noop;
>  	x86_init.timers.timer_init = x86_init_noop;
>  
> +	/* Avoid searching for BIOS MP tables */
> +	x86_init.mpparse.find_smp_config = x86_init_noop;
> +	x86_init.mpparse.get_smp_config = x86_init_uint_noop;
> +
>  	x86_platform.get_wallclock = get_rtc_noop;
>  	x86_platform.set_wallclock = set_rtc_noop;
>  	x86_platform.get_nmi_reason = hv_get_nmi_reason;
> -- 
> 2.34.1
> 
