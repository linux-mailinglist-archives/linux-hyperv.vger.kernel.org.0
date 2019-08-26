Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E26F19CA02
	for <lists+linux-hyperv@lfdr.de>; Mon, 26 Aug 2019 09:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729857AbfHZHUi (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 26 Aug 2019 03:20:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33466 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727963AbfHZHUi (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 26 Aug 2019 03:20:38 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A0F53811A9
        for <linux-hyperv@vger.kernel.org>; Mon, 26 Aug 2019 07:20:37 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id s18so9253058wrt.21
        for <linux-hyperv@vger.kernel.org>; Mon, 26 Aug 2019 00:20:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Qr6ks7uI6Ob3HfkdqYZ1mV0jtXig91Oji7qUddOHKkE=;
        b=UUwG2klV1B+zH/KmYuJ27u64dN3y+JxOEtYAMR4EzVQS0QTvXjRsZ533rfXtqYjTem
         aVoEXOCpzUDX0YIedpitfPyPHUWe5ZsYD6zIoEfL81t5RdXCINMlLcfm+3ZIWZPgC/kp
         Mb5MKrxywgs5aTx2fWH9KNABmKXtiRpWqRz31ve/r92WQ/2g8ppD/Hh8UeuJiuPAI3df
         nakno7dRujViD/pBwvniT2gsHnmcJDn0O3tQZenkOEKV5fp1qRo4iKFvujTvVOAQTFab
         mv90qvGD3CK+qBItfFsDH6G6wOG0efUiNLHIDjUxdUYOVZxLag90L2CiV8sGy1TjgvNQ
         z4mQ==
X-Gm-Message-State: APjAAAU08jvUoJVEa/ik40+xq6NczD/MY5XnL4bU0Unisg7oPPpXmha1
        PQik9cJcPHkxxtkB/H82E2Fvp4oUQVxautbOtJpCOfrbQ0MQ67xUEXIxyJrBHLEaHJwpekEc87L
        yAgLNcjQpXr++N3ODklewL3wf
X-Received: by 2002:a5d:53c1:: with SMTP id a1mr20655980wrw.185.1566804036283;
        Mon, 26 Aug 2019 00:20:36 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwt/GrvvkTFE9kWbOoAuRkBgia1BmCyyHEBCO8VYyM5xQx/69FBatjunWTDdFQMflwDVGrC1w==
X-Received: by 2002:a5d:53c1:: with SMTP id a1mr20655953wrw.185.1566804036055;
        Mon, 26 Aug 2019 00:20:36 -0700 (PDT)
Received: from vitty.brq.redhat.com (ip-89-176-161-20.net.upcbroadband.cz. [89.176.161.20])
        by smtp.gmail.com with ESMTPSA id e14sm8994700wma.37.2019.08.26.00.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 00:20:35 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     lantianyu1986@gmail.com, Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        daniel.lezcano@linaro.org, michael.h.kelley@microsoft.com,
        tglx@linutronix.de
Subject: Re: [PATCH] x86/Hyper-V: Fix build error with CONFIG_HYPERV_TSCPAGE=N
In-Reply-To: <20190824151218.GM1581@sasha-vm>
References: <20190822053852.239309-1-Tianyu.Lan@microsoft.com> <87zhk1pp9p.fsf@vitty.brq.redhat.com> <20190824151218.GM1581@sasha-vm>
Date:   Mon, 26 Aug 2019 09:20:36 +0200
Message-ID: <87d0gso0jf.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Sasha Levin <sashal@kernel.org> writes:

> On Thu, Aug 22, 2019 at 10:39:46AM +0200, Vitaly Kuznetsov wrote:
>>lantianyu1986@gmail.com writes:
>>
>>> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
>>>
>>> Both Hyper-V tsc page and Hyper-V tsc MSR code use variable
>>> hv_sched_clock_offset for their sched clock callback and so
>>> define the variable regardless of CONFIG_HYPERV_TSCPAGE setting.
>>
>>CONFIG_HYPERV_TSCPAGE is gone after my "x86/hyper-v: enable TSC page
>>clocksource on 32bit" patch. Do we still have an issue to fix?
>
> Yes. Let's get it fixed on older kernels (as such we need to tag this
> one for stable). The 32bit TSC patch won't come in before 5.4 anyway.
>
> Vitaly, does can you ack this patch? It might require you to re-spin
> your patch.
>

Sure, no problem,

Acked-by: Vitaly Kuznetsov <vkuznets@redhat.com>

I, however, was under the impression the patch fixes the issue with the
newly introduced sched clock:

commit b74e1d61dbc614ff35ef3ad9267c61ed06b09051
Author: Tianyu Lan <Tianyu.Lan@microsoft.com>
Date:   Wed Aug 14 20:32:16 2019 +0800

    clocksource/hyperv: Add Hyper-V specific sched clock function

(and Fixes: tag is missing)

and this is not in mainline as of v5.3-rc6. In tip/timers/core Thomas
already picked my "clocksource/drivers/hyperv: Enable TSC page
clocksource on 32bit" which also resolves the issue.

So my question is - which older/stable kernel do you have in mind?

-- 
Vitaly
