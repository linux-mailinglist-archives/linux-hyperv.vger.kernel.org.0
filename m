Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1A71D7264
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Oct 2019 11:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfJOJjN (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 15 Oct 2019 05:39:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:33418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbfJOJjN (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 15 Oct 2019 05:39:13 -0400
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FA2721927;
        Tue, 15 Oct 2019 09:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571132352;
        bh=DB8hF9mrIlctxtCr1I2Tw2azLiFwJDjpe2ZayJysOdo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UZEyVDHVYglO8OnckdBRF5pL9SfDRyCftG2g8kENvBr1hAlvhpPmfJgzzaY3G94Ni
         sach113/P/YHhuPGD1kIcoO4hYqcR5XVhNVJEv9wbK9qHgRiz82Ibo+HQ6w7EfgcJp
         m/np8cyrF5RXtuKCCzeIfJga43GOqZ7ErsPMVJlc=
Received: by mail-qk1-f178.google.com with SMTP id 201so18518392qkd.13;
        Tue, 15 Oct 2019 02:39:12 -0700 (PDT)
X-Gm-Message-State: APjAAAWOtpKccO9hRsD34pROzsb0DQ0KXdN2t9+LovCeurioOuS/0Hco
        PyKFBi3ehzaNUMaHQrXi3mNOo77vvjfey8p+N8Q=
X-Google-Smtp-Source: APXvYqxYc6LknamR40pBBc+NUAOHgrsC3bhItRdZqSEDCvTmVjPE4WqfL9qK1qYkf399pDI7D5L1DbT//hWEkCvNajA=
X-Received: by 2002:a37:715:: with SMTP id 21mr31540556qkh.148.1571132351050;
 Tue, 15 Oct 2019 02:39:11 -0700 (PDT)
MIME-Version: 1.0
References: <20191015092937.11244-1-parri.andrea@gmail.com>
In-Reply-To: <20191015092937.11244-1-parri.andrea@gmail.com>
From:   Wei Liu <wei.liu@kernel.org>
Date:   Tue, 15 Oct 2019 10:39:00 +0100
X-Gmail-Original-Message-ID: <CAHd7Wqxn3sQQWkzOBrJ1KYm8eUpwa_9dcSYRDfPGAMWm=qvbag@mail.gmail.com>
Message-ID: <CAHd7Wqxn3sQQWkzOBrJ1KYm8eUpwa_9dcSYRDfPGAMWm=qvbag@mail.gmail.com>
Subject: Re: [PATCH] x86/hyperv: Set pv_info.name to "Hyper-V"
To:     Andrea Parri <parri.andrea@gmail.com>
Cc:     Linux Kernel List <linux-kernel@vger.kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        x86@kernel.org, "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Dexuan Cui <decui@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, 15 Oct 2019 at 10:30, Andrea Parri <parri.andrea@gmail.com> wrote:
>
> Michael reported that the x86/hyperv initialization code printed the
> following dmesg when running in a VM on Hyper-V:
>
>   [    0.000738] Booting paravirtualized kernel on bare hardware
>
> Let the x86/hyperv initialization code set pv_info.name to "Hyper-V";
> with this addition, the dmesg read:
>
>   [    0.000138] Booting paravirtualized kernel on Hyper-V
>
> Reported-by: Michael Kelley <mikelley@microsoft.com>
> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
> ---
>  arch/x86/kernel/cpu/mshyperv.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> index 105844d542e5..c7d1801fa88b 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -154,6 +154,8 @@ static uint32_t  __init ms_hyperv_platform(void)

This function is for platform detection only.

>         if (!boot_cpu_has(X86_FEATURE_HYPERVISOR))
>                 return 0;
>
> +       pv_info.name = "Hyper-V";
> +

At this point we're not sure if Linux is really running on Hyper-V yet.

Setting pv_info.name should be moved to the init_platform hook, i.e.
ms_hyperv_init_platform.

Wei.

>         cpuid(HYPERV_CPUID_VENDOR_AND_MAX_FUNCTIONS,
>               &eax, &hyp_signature[0], &hyp_signature[1], &hyp_signature[2]);
>
> --
> 2.17.1
>
