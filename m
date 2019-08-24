Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E55D79BF13
	for <lists+linux-hyperv@lfdr.de>; Sat, 24 Aug 2019 19:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbfHXRwe (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 24 Aug 2019 13:52:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:42652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726604AbfHXRwe (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 24 Aug 2019 13:52:34 -0400
Received: from localhost (unknown [8.46.76.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56F5521897;
        Sat, 24 Aug 2019 17:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566669153;
        bh=jmskMfB4yzTBf2+Y4zUZ6yeUmQsGwe+hg5CDSAQN+LE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jAaT1G/zNh3OYFNVAhBehLPWz+nztu1bAIKuSHCZNWrlKXCinGXamSGDCsCI7GCYu
         /pazqhAzeuWcYjeEpKTc5aryfOVn8lg0iSp5KUm/bPU8avwyuvdacJbnmok+Azm0V7
         xXmjaBM3HEAqe3uTpYcZkhdJJa4IV7SN+GIisqW8=
Date:   Sat, 24 Aug 2019 11:12:18 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     lantianyu1986@gmail.com, Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, daniel.lezcano@linaro.org,
        michael.h.kelley@microsoft.com
Subject: Re: [PATCH] x86/Hyper-V: Fix build error with CONFIG_HYPERV_TSCPAGE=N
Message-ID: <20190824151218.GM1581@sasha-vm>
References: <20190822053852.239309-1-Tianyu.Lan@microsoft.com>
 <87zhk1pp9p.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <87zhk1pp9p.fsf@vitty.brq.redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Aug 22, 2019 at 10:39:46AM +0200, Vitaly Kuznetsov wrote:
>lantianyu1986@gmail.com writes:
>
>> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
>>
>> Both Hyper-V tsc page and Hyper-V tsc MSR code use variable
>> hv_sched_clock_offset for their sched clock callback and so
>> define the variable regardless of CONFIG_HYPERV_TSCPAGE setting.
>
>CONFIG_HYPERV_TSCPAGE is gone after my "x86/hyper-v: enable TSC page
>clocksource on 32bit" patch. Do we still have an issue to fix?

Yes. Let's get it fixed on older kernels (as such we need to tag this
one for stable). The 32bit TSC patch won't come in before 5.4 anyway.

Vitaly, does can you ack this patch? It might require you to re-spin
your patch.

--
Thanks,
Sasha
