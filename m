Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 225792B0701
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Nov 2020 14:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbgKLNu4 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 12 Nov 2020 08:50:56 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50541 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727932AbgKLNuz (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 12 Nov 2020 08:50:55 -0500
Received: by mail-wm1-f66.google.com with SMTP id h2so5367225wmm.0;
        Thu, 12 Nov 2020 05:50:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SYyrpeZ4G3uDz8D/KONLP8yc9fOcKtHvxCb2Yt0usoE=;
        b=d4tncy4rii1qMq9SZsJnw5KymIG05hlpsZdQfN1OXv1hYHFLy/ZXM0JbgrJ+jNxLq7
         dGUarP+63bIVDnK5Rqmy7iS0zpqZ5SKq7qi1ReVjEw0oLEzjJ0+mDfjvsdSx6IVHQP96
         Y5mpi+j/UqxF6RLL3oE1Ad7qa6ASmc+U82bMkSouxXObp3GsLgkmv5u9ZIq8yzBVKmjJ
         sejaCZIPiflccX6KLzRead/QN2BILLmuH7Xnlg3ZGjBwu16JzUHddKgQ+y5UCnCQwOPU
         a9BX1TJuwvqboPCfFvBwLBHbBt67AMazL0vFGr2qfB/NvzM4ygD+ZoXcYzGETMNqJgMh
         8kkg==
X-Gm-Message-State: AOAM531MQeZRlZ9V7497LUSQ0vqiA7F+DuBylunSw151SXaAaU2tiBRq
        cCrQZxvDamoXC5VW/rUNnP/03YOfu8k=
X-Google-Smtp-Source: ABdhPJw6wLodz3K7xFrxGT40hvCTyDJt82PaVwve3iE0kTxqD+EbkxsK6asuyV56GtsVoqssNtYKpg==
X-Received: by 2002:a7b:c1ce:: with SMTP id a14mr9523314wmj.169.1605189053581;
        Thu, 12 Nov 2020 05:50:53 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id b17sm6801177wru.12.2020.11.12.05.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 05:50:52 -0800 (PST)
Date:   Thu, 12 Nov 2020 13:50:51 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 15/17] x86/hyperv: implement an MSI domain for root
 partition
Message-ID: <20201112135051.gzd3pyqz2nyum655@liuwe-devbox-debian-v2>
References: <20201105165814.29233-1-wei.liu@kernel.org>
 <20201105165814.29233-16-wei.liu@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105165814.29233-16-wei.liu@kernel.org>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Nov 05, 2020 at 04:58:12PM +0000, Wei Liu wrote:
> When Linux runs as the root partition on Microsoft Hypervisor, its
> interrupts are remapped.  Linux will need to explicitly map and unmap
> interrupts for hardware.
> 
> Implement an MSI domain to issue the correct hypercalls. And initialize
> this irqdomain as the default MSI irq domain.
> 
> Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> Co-Developed-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
> v2:
> This patch is simplified due to upstream changes.
> ---
>  arch/x86/hyperv/Makefile    |   2 +-
>  arch/x86/hyperv/hv_init.c   |  10 +-
>  arch/x86/hyperv/irqdomain.c | 330 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 340 insertions(+), 2 deletions(-)
>  create mode 100644 arch/x86/hyperv/irqdomain.c
> 
> diff --git a/arch/x86/hyperv/Makefile b/arch/x86/hyperv/Makefile
> index 565358020921..2ebcf3969121 100644
> --- a/arch/x86/hyperv/Makefile
> +++ b/arch/x86/hyperv/Makefile
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  obj-y			:= hv_init.o mmu.o nested.o
> -obj-$(CONFIG_X86_64)	+= hv_apic.o hv_proc.o
> +obj-$(CONFIG_X86_64)	+= hv_apic.o hv_proc.o irqdomain.o

I need to move irqdomain.o to obj-y because 32bit build also needs it in
hv_init.o.

After this change, 32bit build of the kernel builds and works as expected.

Wei.
