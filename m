Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6D0B735C8D
	for <lists+linux-hyperv@lfdr.de>; Mon, 19 Jun 2023 18:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjFSQ6j (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 19 Jun 2023 12:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbjFSQ62 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 19 Jun 2023 12:58:28 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6193A106
        for <linux-hyperv@vger.kernel.org>; Mon, 19 Jun 2023 09:58:27 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f9b627c1b8so1230475e9.1
        for <linux-hyperv@vger.kernel.org>; Mon, 19 Jun 2023 09:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687193906; x=1689785906;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cSjLhKAkEVmr9MYwtf9eP9pfk3HW3uaYe68MnVI4gb4=;
        b=JlVoWKoejeYGVw9gW2I/yNfs7ivLHcr1xRX/Kt9aY+bNwIYXp2NvRfeCZHk+T69Xux
         VizWnR2LcZ3KuXcodUg3gLKcfu8BL0M3D1nWycrXYlyzMwkn69cL5OxaHIDnbsFTtY2n
         BHz9GBSZ2mPvHFQCavT77ItUUyjF+RrquclO4Lx3lmmbYQxwGJ+SqmxCdgE2+Tweej4E
         chy5R2GV5JpIAaUz/bl3nf2SsHV2/w7d3uUzR248KV+FHYj3EEUyu91Cnj7Xn72ETw2E
         E5fgy16kn6ppIe+1J9ceVMUUQudx3B3igm5sTtnCpY1Jpm68LHzCFoZLjcRLhf7kOs3x
         5Lxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687193906; x=1689785906;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cSjLhKAkEVmr9MYwtf9eP9pfk3HW3uaYe68MnVI4gb4=;
        b=VXRlNk1tuuDpG2Hmcd6s2bFQc/3NfEtHQjdoKXbuqfv16bpZg5rsuhpTn9WO1Jwn0B
         U0HaHeTTRhvu9ehyysLJoBMpZQXyeJO4MXjNLrFKAALHpfXspdj0STYA/GgITg7iZ+6g
         ehfx/z+UVseUNWlGaYPMUUkVQ0amd+dpZEexhlWWkMhH0sp0Swd6Qz4pny0YbuiJFaz5
         nRpnHXh62//0WbGWoCMml6ERHlLaupRucGsHs7xQNIPEWmJaoRnhXnXJwlKtS4SgA9Ql
         Vm/soHwk4UqM4GUn6MfYxybSXQJjDUyNdvcEQXEDP/QAWzV+bEz9W7ADP5RgwWNn0yBY
         e51w==
X-Gm-Message-State: AC+VfDzXSKte1OczVVPDoTXRp3hvkCik36njLli8B0zWIR+NipHyyLjO
        HCOT/ELemGovmb28SXVBOsxPJg==
X-Google-Smtp-Source: ACHHUZ7LG1qZO6pyGSLX05cmV1ONaJCA3BVDnjiEngtgcdfzljIp98Kn6HsVCboJAURsVKJ3A49TRw==
X-Received: by 2002:a05:600c:b4e:b0:3f7:fcca:5e32 with SMTP id k14-20020a05600c0b4e00b003f7fcca5e32mr9158353wmr.17.1687193905807;
        Mon, 19 Jun 2023 09:58:25 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:13d0:1b6c:ce40:5429? ([2a05:6e02:1041:c10:13d0:1b6c:ce40:5429])
        by smtp.googlemail.com with ESMTPSA id x23-20020a1c7c17000000b003f72468833esm211361wmc.26.2023.06.19.09.58.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 09:58:25 -0700 (PDT)
Message-ID: <07c5efe5-4eb0-121f-7b50-8f3fba68beab@linaro.org>
Date:   Mon, 19 Jun 2023 18:58:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/1] clocksource: hyper-v: Rework clocksource and sched
 clock setup
Content-Language: en-US
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
References: <1686325621-16382-1-git-send-email-mikelley@microsoft.com>
 <fdc643c4-6298-d337-1d8d-3f28f6c1acfc@linaro.org>
 <BYAPR21MB1688E1163BB36DF03CC8E00BD75FA@BYAPR21MB1688.namprd21.prod.outlook.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <BYAPR21MB1688E1163BB36DF03CC8E00BD75FA@BYAPR21MB1688.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 19/06/2023 18:44, Michael Kelley (LINUX) wrote:
> From: Daniel Lezcano <daniel.lezcano@linaro.org> Sent: Monday, June 19, 2023 9:16 AM
>>
>> On 09/06/2023 17:47, Michael Kelley wrote:
>>> Current code assigns either the Hyper-V TSC page or MSR-based ref counter
>>> as the sched clock. This may be sub-optimal in two cases. First, if there
>>> is hardware support to ensure consistent TSC frequency across live
>>> migrations and Hyper-V is using that support, the raw TSC is a faster
>>> source of time than the Hyper-V TSC page.  Second, the MSR-based ref
>>> counter is relatively slow because reads require a trap to the hypervisor.
>>> As such, it should never be used as the sched clock. The native sched
>>> clock based on the raw TSC or jiffies is much better.
>>>
>>> Rework the sched clock setup so it is set to the TSC page only if
>>> Hyper-V indicates that the TSC may have inconsistent frequency across
>>> live migrations. Also, remove the code that sets the sched clock to
>>> the MSR-based ref counter. In the cases where it is not set, the sched
>>> clock will then be the native sched clock.
>>>
>>> As part of the rework, always enable both the TSC page clocksource and
>>> the MSR-based ref counter clocksource. Set the ratings so the TSC page
>>> clocksource is preferred. While the MSR-based ref counter clocksource
>>> is unlikely to ever be the default, having it available for manual
>>> selection is convenient for development purposes.
>>>
>>> Signed-off-by: Michael Kelley <mikelley@microsoft.com>
>>
>> The patch does not apply, does it depend on another patch?
> 
> It should apply to linux-next.  It depends on two previous patches from
> Peter Zijlstra in the sched/core branch of tip.  See:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=sched/core&id=9397fa2ea3e7634f61da1ab76b9eb88ba04dfdfc
> 
> and
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=sched/core&id=e39acc37db34f6688e2c16e958fb1d662c422c81

Yeah, but the branch is tip/timers/core

Could you respin against it ?

Thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

