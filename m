Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9924676939
	for <lists+linux-hyperv@lfdr.de>; Sat, 21 Jan 2023 21:29:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjAUU3G (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 21 Jan 2023 15:29:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjAUU3F (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 21 Jan 2023 15:29:05 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801D725295
        for <linux-hyperv@vger.kernel.org>; Sat, 21 Jan 2023 12:29:04 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id d2so7577638wrp.8
        for <linux-hyperv@vger.kernel.org>; Sat, 21 Jan 2023 12:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rXSfSoA8G8fh3ZYndfS49CGjjHb1kadUkMCLnVlHiAw=;
        b=BTYRh803+TdBAlKTGNO8XogbyXQyH1nKKXPHvfBBzs8HXPIEktk2MgfHI63agXEwta
         fNlKZ4mfwJFwaHFv+foB6WKQsvCI6T30Oap/lj6xIAsPSEyvRVZ/0c+58werKzGOTxUs
         qU+OGOhjpJvK7vb7B5zmSXklvpx02+wOk1VjVv+9RxtVrvPPirIgIF+7OyiD0lWBdw73
         MogHja8t6mVK+PYHp4NDIXCdDUliSAwPFaqLbTeZ4CJYTitl4utfYrWtnW7kRxH1koPC
         ZoPD+nwuKBXtRp0ViP2TLbjEVF4pTpwZgAU/klrGwdEJtXnjSwKk4hwYF/n1s2EztjtF
         7JJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rXSfSoA8G8fh3ZYndfS49CGjjHb1kadUkMCLnVlHiAw=;
        b=vZNnDmEAmGHRQtrlrbXXlADUBB/Z+m+w8LeQSkTG9Q2dqotNPf0S7Zz+9F0yRAabqC
         dhW2EUj8GtHuvCGltkmCsG4L9i8CyZCVqSRR25V0Y1WO38VyV+Tcg+lVhyKWpgjp1SYL
         rg3MsvlXgzx7NYDVR54/DUAHGlqW5j8KBxroAvcIgYPKa4QIQ8EJZ+BkrAOar7Hn2pVa
         oYCVhBBL5WzLRJsh5J+ly8kJPQoBtZ66jeW8OC9gIyrvZQehQqhcdlxPuiFibsWYp55O
         +Yvhb70lJaSvMVOqqDZslUakMsQ+HR5KNWYzAxdv4uTV04H5DDOVbcp5+ZwTYE36SCWN
         yMPA==
X-Gm-Message-State: AFqh2kq1YIVfu0FrIIA/O3/N6ZJFSUK3t43WmAp2NnBErnU7BqnnnQbC
        +qktjqiYNGneV6aYmoHs338kvQ==
X-Google-Smtp-Source: AMrXdXsQ2CZZFGP2KzAtNcrni43m6UgClqCgNPANr0RuaeemKwlLfQDKUdVF8jflDNpRzU44fYAZoQ==
X-Received: by 2002:adf:f0c1:0:b0:2bc:67d:c018 with SMTP id x1-20020adff0c1000000b002bc067dc018mr17857786wro.48.1674332943079;
        Sat, 21 Jan 2023 12:29:03 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id b16-20020adff910000000b002bdf8dd6a8bsm16829383wrr.80.2023.01.21.12.29.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Jan 2023 12:29:02 -0800 (PST)
Message-ID: <b6fc94c1-5211-d5d6-d62e-91e17ae3ee80@linaro.org>
Date:   Sat, 21 Jan 2023 21:28:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 4/4] dt-bindings: hv: Add dt-bindings for VMBus
Content-Language: en-US
To:     Saurabh Singh Sengar <ssengar@linux.microsoft.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, daniel.lezcano@linaro.org, tglx@linutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, mikelley@microsoft.com,
        ssengar@microsoft.com
References: <1673887688-19151-1-git-send-email-ssengar@linux.microsoft.com>
 <1673887688-19151-5-git-send-email-ssengar@linux.microsoft.com>
 <31d78b4c-1416-d8cb-a187-bf924168ee1e@linaro.org>
 <20230117151325.GA9806@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <23a7ae1d-cd49-8c78-5284-4134755ea19a@linaro.org>
 <20230117155258.GA14857@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <f6b80686-d8bc-9c7b-205c-635d4e681f50@linaro.org>
 <20230120125143.GA20797@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230120125143.GA20797@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 20/01/2023 13:51, Saurabh Singh Sengar wrote:
> On Fri, Jan 20, 2023 at 12:43:40PM +0100, Krzysztof Kozlowski wrote:
>> On 17/01/2023 16:52, Saurabh Singh Sengar wrote:
>>> On Tue, Jan 17, 2023 at 04:41:22PM +0100, Krzysztof Kozlowski wrote:
>>>> On 17/01/2023 16:13, Saurabh Singh Sengar wrote:
>>>>> On Mon, Jan 16, 2023 at 07:55:13PM +0100, Krzysztof Kozlowski wrote:
>>>>>> On 16/01/2023 17:48, Saurabh Sengar wrote:
>>>>>>> Add dt-bindings for Hyper-V VMBus
>>>>>>>
>>>>>>> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
>>>>>>> ---
>>>>>>>  .../devicetree/bindings/hv/msft,vmbus.yaml         | 34 ++++++++++++++++++++++
>>>>>>
>>>>>> Also, there is no "hv" hardware, so that's not correct location. If your
>>>>>> bindings describe firmware, this should go to firmware. Otherwise, this
>>>>>> does not look like suitable for DT. We do not describe software stuff in DT.
>>>>>
>>>>> VMBus is a virtual device this is simmilar to virtio. I can rename this folder to vmbus.
>>>>>
>>>>
>>>> Then virtio directory. The directories are per subsystems (hardware
>>>> classes).
>>>
>>> Apologies if I was not clear, I meant to say this is a device conceptually
>>> similar to virtio. But this driver has nothing to do with virtio, we should
>>
>> Bindings are for hardware, not drivers, so if the device serves the same
>> purpose, it's driver differences do not matter.
>>
>>> be creating a new folder for it OR I am fine moving it under bus if that's
>>> okay.
>>
>> Since you do not have children here, it's not really a bus to fit under
>> bus directory...
>>
>> Probably this should go together with virtio bindings to dedicated
>> hypervisor interfaces directory. We do not create directories for
>> specific solutions (implementations) with only one or few bindings.
>> Directories are for entire classes.
> 
> I am OK to keep it anywhere, but I believe virtio is not its correct place. I am also
> concern how will the virtio maintainers will perceive it. Ideally we should be renaming
> virtio to virtualization OR hypervisor OR something more generic where both virtio and
> VMBus can co-exist. Please let me know if renaming virtio is acceptable.

Yes, that's what I was thinking about. I think all of these should be in
one place, but named differently (with updates to MAINTAINERS place).

Best regards,
Krzysztof

