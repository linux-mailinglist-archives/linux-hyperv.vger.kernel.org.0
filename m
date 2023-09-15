Return-Path: <linux-hyperv+bounces-97-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 024277A1E18
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 Sep 2023 14:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB92B1C20A61
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 Sep 2023 12:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B031DF43;
	Fri, 15 Sep 2023 12:06:50 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F1DDDB7
	for <linux-hyperv@vger.kernel.org>; Fri, 15 Sep 2023 12:06:48 +0000 (UTC)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3C23C0B
	for <linux-hyperv@vger.kernel.org>; Fri, 15 Sep 2023 05:04:01 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-5007616b756so3289099e87.3
        for <linux-hyperv@vger.kernel.org>; Fri, 15 Sep 2023 05:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec; t=1694779439; x=1695384239; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t93tJk6x9KXevq75/2U+Hu+IOtVV0GhyzBblvFXEk8c=;
        b=uGHhaEgsk2yfVxaaJ4OT3A24PwSRacCcV2ocbO8IbwG+CWPkDcDUy199GyDhKPzys1
         nOCtr+3BIOazEZ70VoJkXSp92DdfUcP/UjGqXoSO9XWtniZh1NQRJXHVS2zSXCQWvKjJ
         NTeSlZJ3ItFiHmxA7A0BtvbahwHipInoE01MeMLB76eJQLMGQl2YAR9islrUGkfxML9v
         tYInjAeOnQNM8twtogSiZIu9Zsv4ldy5VKlAtLh8i85WfCipQ71j4e02TrhIaTBfAikU
         7YrHB4uVURSSUkFI078V/ftcb140hV6T+6tHjebwFpi/bGzbCDTNHxJSJLR/TM+nMW8r
         EGKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694779439; x=1695384239;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t93tJk6x9KXevq75/2U+Hu+IOtVV0GhyzBblvFXEk8c=;
        b=eCjDtjf3Ciy+45PgJT31hFRiUvDlbhzym/5mSWC0VFG4nTtYZqsJ+kQaKeTwqH241R
         XGsil4Q9b471/3QjVE0pkdSXM2FA/BQ5jciMcMAfiExzWvPyIHMpJh62PaLdfUPFCQJu
         I5Q2xy6Z46jQOwTUvVEKQxiwxnSNF0W4/F9xKwAEkimhKC1TYNnjJHiDLNj6KDcljj7+
         PUC+S928/MU2sBTHkW768Gg+RKRTg1sBXYjhT1B+JKtPNKUuKWA6HiqSKQXqbmy5UyV+
         fzkiJxbp62ur6MZ/tRUOCCWK04/7P4/dpRxGlcuMLaWNKjq6zdpYa8h/zJvnlh0wMUC4
         kN4A==
X-Gm-Message-State: AOJu0YzlCr477FApbuUZxag53RfWV2ohTwQZnF9/8O06Za3kc2kjZgnQ
	7DtEyuwtCGIk6qQN2t72unPYTQ==
X-Google-Smtp-Source: AGHT+IGK0BWnkxl2Z+BZ8xlBZpL3aHQZKHfdU5ZcTS3pbZdnjtvlonA5LgSXLrarnHD5eTS/ZjAKKQ==
X-Received: by 2002:a05:6512:3b13:b0:500:cb2b:8678 with SMTP id f19-20020a0565123b1300b00500cb2b8678mr1657469lfv.40.1694779438575;
        Fri, 15 Sep 2023 05:03:58 -0700 (PDT)
Received: from ?IPV6:2003:f6:af2c:1500:c7bb:d28e:613f:8cb7? (p200300f6af2c1500c7bbd28e613f8cb7.dip0.t-ipconnect.de. [2003:f6:af2c:1500:c7bb:d28e:613f:8cb7])
        by smtp.gmail.com with ESMTPSA id ee17-20020a056402291100b005308fa6ef7fsm650619edb.16.2023.09.15.05.03.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 05:03:58 -0700 (PDT)
Message-ID: <40467722-f4ab-19a5-4989-308225b1f9f0@grsecurity.net>
Date: Fri, 15 Sep 2023 14:03:56 +0200
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
 <ca1a5950-9092-6caf-471c-ebda623173e5@grsecurity.net>
 <20230913052714.GA29112@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <92c52af3-085e-8467-88bf-da4fbc56eeaa@grsecurity.net>
 <20230915113258.GA24381@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
From: Mathias Krause <minipli@grsecurity.net>
In-Reply-To: <20230915113258.GA24381@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 15.09.23 13:32, Saurabh Singh Sengar wrote:
> On Fri, Sep 15, 2023 at 09:06:15AM +0200, Mathias Krause wrote:
>> On 13.09.23 07:27, Saurabh Singh Sengar wrote:
>>> On Mon, Sep 11, 2023 at 10:00:59AM +0200, Mathias Krause wrote:
>>>> On 08.09.23 17:02, Saurabh Singh Sengar wrote:
>>>>> On Fri, Sep 08, 2023 at 12:26:10PM +0200, Mathias Krause wrote:
>>>>>> Booting a CONFIG_HYPERV_VTL_MODE=y enabled kernel on bare metal or a
>>>>>> non-Hyper-V hypervisor leads to serve memory corruption as
>>>>>
>>>>> FWIW, CONFIG_HYPERV_VTL_MODE is not expected to be enabled for non VTL
>>>>> platforms.
> 
> <snip>
> 
>>
>> Well, if you want to prevent people from using it, make it depend on
>> BROKEN, because that's what it is. All the other hypervisor support in
>> the kernel (Xen, VMware, KVM, ACRN, Jailhouse, even plain Hyper-V) can
>> perfectly cope with getting booted on a different hypervisor or bare
>> metal. Why is Hyper-V's VTL mode such a special snow flake that it has
>> to cause random memory corruption and, in turn, crash the kernel with
>> spectacular (and undebugable) fireworks if it's not booted under Hyper-V?
> 
> 'BROKEN' is certainly not the right choice here. If it is used on the
> correct platform as it is designed to be nothing is broken.

This "if" is all I'm complaining about. If that assumption gets broken,
for whatever reason (a user wrongly enabling Kconfig options / a distro
trying to build a kernel that can run on many platforms / ...), the
kernel should still behave instead of corrupting memory leading to a
kernel crash -- especially if it's that dumb simple to handle this case
just fine.

So please, can you answer my question above, why VTL is such a special
snow flake that it needs no error handling nor validation of its core
assumptions like all other hypervisor code in the kernel seem to get right?

> 
> The default option for CONFIG_HYPERV_VTL_MODE is set to 'N', there is
> sufficient documentation for it as well. I agree there can be cases where
> people can still end up enabling it, for that EXPERT is a reasonable
> solution.

I don't see why this would solve anything, less so in preventing the
memory corruption angle which can easily be avoided.


Thanks,
Mathias

