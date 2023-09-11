Return-Path: <linux-hyperv+bounces-22-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4D079A541
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 Sep 2023 10:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AFCD1C20905
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 Sep 2023 08:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068AB3C27;
	Mon, 11 Sep 2023 08:01:12 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E145A259B
	for <linux-hyperv@vger.kernel.org>; Mon, 11 Sep 2023 08:01:11 +0000 (UTC)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EFAECA
	for <linux-hyperv@vger.kernel.org>; Mon, 11 Sep 2023 01:01:02 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-986d8332f50so544744166b.0
        for <linux-hyperv@vger.kernel.org>; Mon, 11 Sep 2023 01:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec; t=1694419261; x=1695024061; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o63kaDsYGhtkR3Unx63xkSmEyv+kX4frhCjmTrl0ffw=;
        b=nKwqa8yxk4Pc/7x9OcsvdJhYFdsasqGkYC2fe+I/5maEbB/c8uztMYtwahxir0x8A5
         oD+7e2CUv4WRAU34caKGQwbeyPpkom6J76es0Rl8otatxH09KEpe8uLWwFHUoIRTjnxO
         Bla+/GhDBi2KzNkpdbhhzoOAAfbLqmct7PUlyijztXH356xMfrvFwnMgd9kHlNjXf0LJ
         eEDH5qlQsTRrkREEP/gwbA7Ziy8x7BcEkaeUK9jKTkEDJF2aHVUG+wRHnN3lOq2EjeGR
         kBzewoKZVVbW2ZZH0l3VwcU3+766GrQD2myX+UxMfSbzu8BajufG/0oEdYU71Y1hKpZ4
         Pb3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694419261; x=1695024061;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o63kaDsYGhtkR3Unx63xkSmEyv+kX4frhCjmTrl0ffw=;
        b=eQNCtM1PI0rkQD3L/bXLOoMamhYuee4RuftlezqMluIvZ4yYV8G5SwABKUPy+cgCBs
         ubioIeacd8RVkmjKfc9nbxBRRfFcUeZir/VvtMXmDRQ3gmXm1oZYRHZ7EjADc+wPvwOP
         el+bfMg56QpRKmbMCmwnpsrdcQAopBIn0C5+vuu6o5Fg9AuAcl6VkwU02mHHT7VE3tHG
         pFdOEW2/8bJ8P9w/bkalSSg/Ikb8UyBh88NWeptyAiMalIP4vXzLjND1r+bCC+FjGXOn
         5jBnXl752mVs7TVvh+HIjnlvafR8EEhx1tgNDyFFWTEBlehuzehPJDHj68BN6wWc2mXR
         GuzQ==
X-Gm-Message-State: AOJu0Ywt6Awaxl400xbitiop/OLodU+f2DmDCh9+J0rbyA6CdAoXDcnl
	h4SoWafmQXuaHPBIfPKbpoEu1A==
X-Google-Smtp-Source: AGHT+IFQqqpjFnwX/M/twdOBKrX8oZa/hHf9nnb0uTsD4Fnhmk8SAJ6b8hdSzKx9KZgMoAfZ7OspFQ==
X-Received: by 2002:a17:906:9bc1:b0:9a1:e1cf:6c6c with SMTP id de1-20020a1709069bc100b009a1e1cf6c6cmr7813827ejc.30.1694419260813;
        Mon, 11 Sep 2023 01:01:00 -0700 (PDT)
Received: from ?IPV6:2003:f6:af13:2000:6eb:9718:be72:1555? (p200300f6af13200006eb9718be721555.dip0.t-ipconnect.de. [2003:f6:af13:2000:6eb:9718:be72:1555])
        by smtp.gmail.com with ESMTPSA id ov27-20020a170906fc1b00b00992c92af6f4sm4948364ejb.144.2023.09.11.01.00.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 01:01:00 -0700 (PDT)
Message-ID: <ca1a5950-9092-6caf-471c-ebda623173e5@grsecurity.net>
Date: Mon, 11 Sep 2023 10:00:59 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] x86/hyperv/vtl: Replace real_mode_header only under
 Hyper-V
Content-Language: en-US, de-DE
To: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, linux-kernel@vger.kernel.org,
 stable@kernel.org
References: <20230908102610.1039767-1-minipli@grsecurity.net>
 <20230908150224.GA3196@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
From: Mathias Krause <minipli@grsecurity.net>
In-Reply-To: <20230908150224.GA3196@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 08.09.23 17:02, Saurabh Singh Sengar wrote:
> On Fri, Sep 08, 2023 at 12:26:10PM +0200, Mathias Krause wrote:
>> Booting a CONFIG_HYPERV_VTL_MODE=y enabled kernel on bare metal or a
>> non-Hyper-V hypervisor leads to serve memory corruption as
> 
> FWIW, CONFIG_HYPERV_VTL_MODE is not expected to be enabled for non VTL
> platforms.

Fair enough, but there's really no excuse to randomly crashing the
kernel if one forgot to RTFM like I did. The code should (and easily
can) handle such situations, especially if it's just a matter of a two
line change.

> Referring Kconfig documentation:
> "A kernel built with this option must run at VTL2, and will not run as
> a normal guest."

So, maybe, the 'return 0' below should be a 'panic("Need to run on
Hyper-V!")' instead?

But then, looking at the code, most of the VTL specifics only run when
the Hyper-V hypervisor was actually detected during early boot. It's
just hv_vtl_early_init() that runs unconditionally and spoils the game.

Is there really a *hard* requirement / reason for having VTL support
disabled when not running under Hyper-V? At least I can't find any from
the code side. It'll all be fine with the below patch, also enabling
running the same kernel on multiple platforms -- bare metal, KVM, Hyper-V,..

Thanks,
Mathias

> 
> - Saurabh
> 
>> hv_vtl_early_init() will run even though hv_vtl_init_platform() did not.
>> This skips no-oping the 'realmode_reserve' and 'realmode_init' platform
>> hooks, making init_real_mode() -> setup_real_mode() try to copy
>> 'real_mode_blob' over 'real_mode_header' which we set to the stub
>> 'hv_vtl_real_mode_header'. However, as 'real_mode_blob' isn't just a
>> 'struct real_mode_header' -- it's the complete code! -- copying it over
>> 'hv_vtl_real_mode_header' will corrupt quite some memory following it.
>>
>> The real cause for this erroneous behaviour is that hv_vtl_early_init()
>> blindly assumes the kernel is running on Hyper-V, which it may not.
>>
>> Fix this by making sure the code only replaces the real mode header with
>> the stub one iff the kernel is running under Hyper-V.
>>
>> Fixes: 3be1bc2fe9d2 ("x86/hyperv: VTL support for Hyper-V")
>> Cc: Saurabh Sengar <ssengar@linux.microsoft.com>
>> Cc: stable@kernel.org
>> Signed-off-by: Mathias Krause <minipli@grsecurity.net>
>> ---
>>  arch/x86/hyperv/hv_vtl.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
>> index 57df7821d66c..54c06f4b8b4c 100644
>> --- a/arch/x86/hyperv/hv_vtl.c
>> +++ b/arch/x86/hyperv/hv_vtl.c
>> @@ -12,6 +12,7 @@
>>  #include <asm/desc.h>
>>  #include <asm/i8259.h>
>>  #include <asm/mshyperv.h>
>> +#include <asm/hypervisor.h>
>>  #include <asm/realmode.h>
>>  
>>  extern struct boot_params boot_params;
>> @@ -214,6 +215,9 @@ static int hv_vtl_wakeup_secondary_cpu(int apicid, unsigned long start_eip)
>>  
>>  static int __init hv_vtl_early_init(void)
>>  {
>> +	if (!hypervisor_is_type(X86_HYPER_MS_HYPERV))
>> +		return 0;
>> +
>>  	/*
>>  	 * `boot_cpu_has` returns the runtime feature support,
>>  	 * and here is the earliest it can be used.
>> -- 
>> 2.30.2
>>

