Return-Path: <linux-hyperv+bounces-94-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 841FF7A16DE
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 Sep 2023 09:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A22B01C211BF
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 Sep 2023 07:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6C96FAF;
	Fri, 15 Sep 2023 07:06:20 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C8C3201
	for <linux-hyperv@vger.kernel.org>; Fri, 15 Sep 2023 07:06:19 +0000 (UTC)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1425F3
	for <linux-hyperv@vger.kernel.org>; Fri, 15 Sep 2023 00:06:17 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-529fb2c6583so2201887a12.1
        for <linux-hyperv@vger.kernel.org>; Fri, 15 Sep 2023 00:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec; t=1694761576; x=1695366376; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CZe/76vQ5HQXY75ssS2Oaysyi0zH2iJKZW/pjIi7njM=;
        b=K1RIicayhVLoN8PllzdgRDznmRNW4eju+ulyebdlDWDPGQdNOvnKvxEP+i6Ao+5cKA
         DRuCmurY9wbasbYtTZKgdB/gnc03HJIms0htI0HKr3kLqIWwUM6PdDsT3qtZwL3uVH3h
         H7oQC7VCiFZJwlEdaQk65+dQUNHQ5gapJpH1kX8abSl/0FRMhQYWsRP4pIGGbRS8S632
         zlwlHvEckDNh8qobRAnAPl3CTXv6qlcU/icfncaX8pbR8N/EgReYhzSLBkJ36Q3LQ7ff
         PkXZRg56HlmQOzyfGmlaKWXYYxCuzBvHGeLTQWkTpSDy585hC3V0fSmfnaqRHXZAXTrJ
         qMNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694761576; x=1695366376;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CZe/76vQ5HQXY75ssS2Oaysyi0zH2iJKZW/pjIi7njM=;
        b=MryEc/EjcJ3UWYDVN6bq07ISORblvJRjQUkT1OAkK6WPEvatCPMWMRPNc9jvXRHs1V
         q+knxsvREvdvtuVHyfHM/c73Dez6SBEZGoXbVrFJmmj4kInS0YglgY+0mlEJGV5fQfem
         bsLhbnpzMcjML1pAWoZ2U9TZcCa80IVQRkiTSnETLVLgIaTjs8A8JuTLS/xUx6oXAIxC
         QtnGJw/+ks0sou1QjKFteK21sV76vDYXwDgCRfXbJGu9ZTNx7tKPA9aAaha+fF200qhg
         k4YuDBmslJpQHx8q3KHX9+MIG7pKabXj4Yn7h2VE0xm6+7fvDGjgvbh2vnvR+Nb4OGww
         1XtQ==
X-Gm-Message-State: AOJu0YzDAzwZTUdruO5pO09HUeYQTRwFIm23XvURM6Q4v5e70Z7mhx+R
	EtIdCpIApRTXOvmsaE64vvmJrg==
X-Google-Smtp-Source: AGHT+IFjTdhbbRBWkinRu9hafMJAySVNAho/ZxW0RAdT/t/nmM256x/l1JolKpXpxLMQPLQ6qb7EDA==
X-Received: by 2002:a17:906:20cb:b0:9ad:7f13:954d with SMTP id c11-20020a17090620cb00b009ad7f13954dmr550736ejc.31.1694761576254;
        Fri, 15 Sep 2023 00:06:16 -0700 (PDT)
Received: from ?IPV6:2003:f6:af2c:1500:c7bb:d28e:613f:8cb7? (p200300f6af2c1500c7bbd28e613f8cb7.dip0.t-ipconnect.de. [2003:f6:af2c:1500:c7bb:d28e:613f:8cb7])
        by smtp.gmail.com with ESMTPSA id p25-20020a1709060e9900b00992b50fbbe9sm2001336ejf.90.2023.09.15.00.06.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 00:06:15 -0700 (PDT)
Message-ID: <92c52af3-085e-8467-88bf-da4fbc56eeaa@grsecurity.net>
Date: Fri, 15 Sep 2023 09:06:15 +0200
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
From: Mathias Krause <minipli@grsecurity.net>
In-Reply-To: <20230913052714.GA29112@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 13.09.23 07:27, Saurabh Singh Sengar wrote:
> On Mon, Sep 11, 2023 at 10:00:59AM +0200, Mathias Krause wrote:
>> On 08.09.23 17:02, Saurabh Singh Sengar wrote:
>>> On Fri, Sep 08, 2023 at 12:26:10PM +0200, Mathias Krause wrote:
>>>> Booting a CONFIG_HYPERV_VTL_MODE=y enabled kernel on bare metal or a
>>>> non-Hyper-V hypervisor leads to serve memory corruption as
>>>
>>> FWIW, CONFIG_HYPERV_VTL_MODE is not expected to be enabled for non VTL
>>> platforms.
>>
>> Fair enough, but there's really no excuse to randomly crashing the
>> kernel if one forgot to RTFM like I did. The code should (and easily
>> can) handle such situations, especially if it's just a matter of a two
>> line change.
> 
> Thanks, I understand your concern. We don't want people to enable this
> flag by mistake and see unexpected behaviours.

Unexpected behaviour like randomly crashing the kernel? ;)

> To add extra safety for this flag, we can make this flag dependent on
> EXPERT config.

Well, if you want to prevent people from using it, make it depend on
BROKEN, because that's what it is. All the other hypervisor support in
the kernel (Xen, VMware, KVM, ACRN, Jailhouse, even plain Hyper-V) can
perfectly cope with getting booted on a different hypervisor or bare
metal. Why is Hyper-V's VTL mode such a special snow flake that it has
to cause random memory corruption and, in turn, crash the kernel with
spectacular (and undebugable) fireworks if it's not booted under Hyper-V?

Thanks,
Mathias

