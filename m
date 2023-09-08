Return-Path: <linux-hyperv+bounces-20-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7120C79896C
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 Sep 2023 17:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9E9E281D21
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 Sep 2023 15:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800346ABB;
	Fri,  8 Sep 2023 15:02:26 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFED6AA2
	for <linux-hyperv@vger.kernel.org>; Fri,  8 Sep 2023 15:02:26 +0000 (UTC)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id F0EF61BF9;
	Fri,  8 Sep 2023 08:02:24 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id 6EFBB212B5DB; Fri,  8 Sep 2023 08:02:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6EFBB212B5DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1694185344;
	bh=fkBgC4K+PqEBZmAXZvNvZfd0P/rD4V69d6ky2EyNgfE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GxJaAYz2iR09RZAQRVt7POgYzx7rn5QyVz6C2ONeI0aCkOyacNca1MzvnaYdsXwVT
	 NSccPdMnMZwLUUO7vlNZdoxjbed9iNv1RxV70TujXMhGI7j78ZDSjn32jJdv8hsBxw
	 vac8J1K/+wx37/4PudAfhi4Ms8rUfBqlpaA/1mi0=
Date: Fri, 8 Sep 2023 08:02:24 -0700
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Mathias Krause <minipli@grsecurity.net>
Cc: linux-hyperv@vger.kernel.org, "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: [PATCH] x86/hyperv/vtl: Replace real_mode_header only under
 Hyper-V
Message-ID: <20230908150224.GA3196@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20230908102610.1039767-1-minipli@grsecurity.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908102610.1039767-1-minipli@grsecurity.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 08, 2023 at 12:26:10PM +0200, Mathias Krause wrote:
> Booting a CONFIG_HYPERV_VTL_MODE=y enabled kernel on bare metal or a
> non-Hyper-V hypervisor leads to serve memory corruption as

FWIW, CONFIG_HYPERV_VTL_MODE is not expected to be enabled for non VTL
platforms. Referring Kconfig documentation:
"A kernel built with this option must run at VTL2, and will not run as
a normal guest."

- Saurabh

> hv_vtl_early_init() will run even though hv_vtl_init_platform() did not.
> This skips no-oping the 'realmode_reserve' and 'realmode_init' platform
> hooks, making init_real_mode() -> setup_real_mode() try to copy
> 'real_mode_blob' over 'real_mode_header' which we set to the stub
> 'hv_vtl_real_mode_header'. However, as 'real_mode_blob' isn't just a
> 'struct real_mode_header' -- it's the complete code! -- copying it over
> 'hv_vtl_real_mode_header' will corrupt quite some memory following it.
> 
> The real cause for this erroneous behaviour is that hv_vtl_early_init()
> blindly assumes the kernel is running on Hyper-V, which it may not.
> 
> Fix this by making sure the code only replaces the real mode header with
> the stub one iff the kernel is running under Hyper-V.
> 
> Fixes: 3be1bc2fe9d2 ("x86/hyperv: VTL support for Hyper-V")
> Cc: Saurabh Sengar <ssengar@linux.microsoft.com>
> Cc: stable@kernel.org
> Signed-off-by: Mathias Krause <minipli@grsecurity.net>
> ---
>  arch/x86/hyperv/hv_vtl.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
> index 57df7821d66c..54c06f4b8b4c 100644
> --- a/arch/x86/hyperv/hv_vtl.c
> +++ b/arch/x86/hyperv/hv_vtl.c
> @@ -12,6 +12,7 @@
>  #include <asm/desc.h>
>  #include <asm/i8259.h>
>  #include <asm/mshyperv.h>
> +#include <asm/hypervisor.h>
>  #include <asm/realmode.h>
>  
>  extern struct boot_params boot_params;
> @@ -214,6 +215,9 @@ static int hv_vtl_wakeup_secondary_cpu(int apicid, unsigned long start_eip)
>  
>  static int __init hv_vtl_early_init(void)
>  {
> +	if (!hypervisor_is_type(X86_HYPER_MS_HYPERV))
> +		return 0;
> +
>  	/*
>  	 * `boot_cpu_has` returns the runtime feature support,
>  	 * and here is the earliest it can be used.
> -- 
> 2.30.2
> 

