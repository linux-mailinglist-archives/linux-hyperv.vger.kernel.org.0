Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF4422B0414
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Nov 2020 12:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbgKLLlf (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 12 Nov 2020 06:41:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728031AbgKLLk5 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 12 Nov 2020 06:40:57 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEDBBC0617A6
        for <linux-hyperv@vger.kernel.org>; Thu, 12 Nov 2020 03:40:56 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id b6so5663251wrt.4
        for <linux-hyperv@vger.kernel.org>; Thu, 12 Nov 2020 03:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hiH9YFvFj7u18VTdjYlvXbTm7Y6vPC/QKgUkjRYPlj0=;
        b=G3iMxfPdcSlq2kqWuNRyA9VaTuD6kH1gafYeQTw0/GJmXm8nu84CdTkmgl+t+wc3r5
         Y94u72Lu4HTssWwQaKnT4PeHhaqIYZd6M7NGNGIcRhtirha3BVAw72dMUXPamn8zgP+N
         lK6H1l6W0CdQBcxBobq9M1tB9Ds3P85FcNyrYybJqJxy5cy4PZd/42FrTFRFr26/aAA8
         rAbWOAPdrk3IHvuvHxsvd3KxHYXbpwdcDIniGACLpY2hF+SKY2oH+alvlBwfNjaPuomu
         3ZxDQo9Q9TK+GLus5qpsK9JB3jsGtQWiH3UV9bkTlxIEtDDv1vJ8HHiVTmA08ZY871sc
         Js0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hiH9YFvFj7u18VTdjYlvXbTm7Y6vPC/QKgUkjRYPlj0=;
        b=q3UyjlpCdaaMH1L6eEOYmNl1a1ijNR1ZROWXUFInPQq5NZz4Z2jDkatwALizyw7O01
         FH7h2ofOcorRLRyWv2nVdv1SfRO9rWSp6ZA7ra94/jZ/L1QB3emIYCipOToR+jaeVMMs
         ZeJ1PYcFCIDS7Qu1tL2kfjclRu/2wCW2b72Q4llZms32PWYBz3EUKBMxDvaxYwhxyFrQ
         /EOBl470iyc8jWafZ8HQDNOuLHhe+g2rIDVKZZxWqwBoGCrSdgVaXzQRMARlc3jwExt9
         41+12Q+hJI+7bG+NnH6wNr1aoxgPyKSjkqSpYvXEhJU82Np3ZTZkA2RXzZTCqQsqf2yi
         6sHw==
X-Gm-Message-State: AOAM532O39D9ADrYx30bEE5l4KIpIDeOrJaNrxvQa3OyCtp73QIo3D0Y
        SOKTPvKhE+BbMs9iXy3y/VoVhQ==
X-Google-Smtp-Source: ABdhPJyYnJvDHJTFtxxktHznzaXTPpIA0hl6/kGsg1GUlsBx6odch4HOXNEy7ilq+yAmu9wUWTR5lg==
X-Received: by 2002:a5d:474f:: with SMTP id o15mr33909986wrs.377.1605181255351;
        Thu, 12 Nov 2020 03:40:55 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:6971:b700:3764:fa96? ([2a01:e34:ed2f:f020:6971:b700:3764:fa96])
        by smtp.googlemail.com with ESMTPSA id z3sm5815106wrw.87.2020.11.12.03.40.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2020 03:40:54 -0800 (PST)
Subject: Re: [PATCH v2 05/17] clocksource/hyperv: use MSR-based access if
 running as root
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20201105165814.29233-1-wei.liu@kernel.org>
 <20201105165814.29233-6-wei.liu@kernel.org>
 <3527e98a-faab-2360-f521-aa04bbe92edf@linaro.org>
 <20201112112437.lt3g5bhpjym3evu5@liuwe-devbox-debian-v2>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <2c5101fb-f3de-7b0c-ee76-e5a0e6b32098@linaro.org>
Date:   Thu, 12 Nov 2020 12:40:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201112112437.lt3g5bhpjym3evu5@liuwe-devbox-debian-v2>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 12/11/2020 12:24, Wei Liu wrote:
> On Thu, Nov 12, 2020 at 10:56:17AM +0100, Daniel Lezcano wrote:
>> On 05/11/2020 17:58, Wei Liu wrote:
>>> Signed-off-by: Wei Liu <wei.liu@kernel.org>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

>>> ---
>>
>> I would like to apply this patch but the changelog is too short (one line).
>>
>> Please add a small paragraph (no need to resend just answer here, I will
>> amend the log myself.
> 
> Please don't apply this to your tree. It is dependent on a previous
> patch. I expect this series to go through the hyperv tree.
> 
> I will add in this small paragraph in a later version:
> 
>     When Linux runs as the root partition, the setup required for TSC page
>     is different. Luckily Linux also has access to the MSR based
>     clocksource. We can just disable the TSC page clocksource if Linux is
>     the root partition.
> 
> If you're happy with the description, I would love to have an ack from
> you. I will funnel the patch via the hyperv tree.
> 
> Wei.
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
