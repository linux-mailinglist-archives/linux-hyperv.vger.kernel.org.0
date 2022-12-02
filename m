Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18D54640D56
	for <lists+linux-hyperv@lfdr.de>; Fri,  2 Dec 2022 19:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiLBSea (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 2 Dec 2022 13:34:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234263AbiLBSe2 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 2 Dec 2022 13:34:28 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86CF8ECE7B
        for <linux-hyperv@vger.kernel.org>; Fri,  2 Dec 2022 10:34:27 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id bx10so9157093wrb.0
        for <linux-hyperv@vger.kernel.org>; Fri, 02 Dec 2022 10:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uM5qYEcEfq1G6+RMFkevC5ozRbBEd4PXgJE50YN+e3U=;
        b=pECRmNhhVnkaSfbU9NbIyzdiBpY7C8V2AqaNNVQz0pKin8L593CkkVqJwiMBK3lCTC
         kP5FTdxKkd+CjXNh/ly765lVFKWjWkV2/cZhYIJMv0924TWeRFwCHVs6ZKp0urt9hblY
         2WSIs4phfaq7dxcRJle2WIJtVZJDSbdpIc2qI6EuDjWWUq3q2a5OsMZDzkxH3dsWtQsa
         6UVM61IS8c++33jWnYcTTfzIhq/54MBZ3WJj2lFieo1js4lXzqJVb84UpurXIE38e6Ha
         EGvOg4SCXTFr+rO8Fvg1cMkRpDh9tlWy5Q3QJKUZZoKdJdeTPV/OSJzqQEFDB4vy1S4C
         3Glw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uM5qYEcEfq1G6+RMFkevC5ozRbBEd4PXgJE50YN+e3U=;
        b=M6TBFMpaRdrDnd5JQugdMNv04uQmApk6IztfEIk8c/wCVjJxvbYlyWuW9qFz6qysQi
         OYR+89yj8BYsBQanz9pttmbSgqLXuAPGPgwW7CTUEmF1OaSrdQoMb5+zw3jNlMEPRWFI
         EDKQiXfhcBz/S+DH+AhlvVOcgsGr0bOnvrvjY36qJ2vCIrSZL8XlizmfNi5xy9NhbOx4
         h7yZtl3CMaNYmgAb1BcqeowQ2kJ0ZI6GniJHsACmlci0NPONaF75zTxAX9xOkl5N4Hqy
         EX7lvknTg9vJbYv0icMd+aQ0mpQwz/yD8FEeabUXOmx1mwHrzxS8rpDO3hOj6a6lfQAi
         TBww==
X-Gm-Message-State: ANoB5pmbrdeGBixF5zudRAflOOCwhCAG3NBZX0wW+MO5cm7JSngWILz2
        jlzfVuguvaF5Bdgn6RMxdWAl1WSVQfF3P3Sh
X-Google-Smtp-Source: AA0mqf7Upzn+p6/WOgfvwmoYsnEfBAatge7V+AbZyi3eW6OWub2CAMkYB5tFbInWebBXNa9iqdlTDw==
X-Received: by 2002:adf:f64b:0:b0:241:cdf2:fe53 with SMTP id x11-20020adff64b000000b00241cdf2fe53mr37809416wrp.85.1670006065989;
        Fri, 02 Dec 2022 10:34:25 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id bg28-20020a05600c3c9c00b003cfa3a12660sm14828113wmb.1.2022.12.02.10.34.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 10:34:25 -0800 (PST)
Message-ID: <689e6879-ad0c-5cab-2c7b-238d61d0a923@linaro.org>
Date:   Fri, 2 Dec 2022 19:34:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] clocksource/drivers/hyperv: use Hyper-V's page size to
 calculate PFN
Content-Language: en-US
To:     Wei Liu <wei.liu@kernel.org>
Cc:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "mail@anirudhrb.com" <mail@anirudhrb.com>,
        "kumarpraveen@linux.microsoft.com" <kumarpraveen@linux.microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20221103152338.2926983-1-anrayabh@linux.microsoft.com>
 <BYAPR21MB1688743DD4507008D33499B0D7389@BYAPR21MB1688.namprd21.prod.outlook.com>
 <Y2PiyAEJZitd3LS8@liuwe-devbox-debian-v2>
 <ab0e318d-0840-a76f-bf34-73db659eef63@linaro.org>
 <Y4pAmUQZuSP9MMiu@liuwe-devbox-debian-v2>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <Y4pAmUQZuSP9MMiu@liuwe-devbox-debian-v2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 02/12/2022 19:14, Wei Liu wrote:
> On Fri, Dec 02, 2022 at 01:33:17PM +0100, Daniel Lezcano wrote:
>>
>> Hi,
>>
>> On 03/11/2022 16:48, Wei Liu wrote:
>>
>> [ ... ]
>>
>>>> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
>>>
>>> Thank you both for the quick turnaround. I will just squash this patch
>>> into the previous one.
>>
>> Can you point to the mailing list the squashed version ?
> 
> The squashed patch is this one:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4ad1aa571214e8d6468a1806794d987b374b5a08

Thanks!

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

