Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DCF69C7F7
	for <lists+linux-hyperv@lfdr.de>; Mon, 26 Aug 2019 05:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbfHZDcL (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 25 Aug 2019 23:32:11 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38687 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbfHZDcL (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 25 Aug 2019 23:32:11 -0400
Received: by mail-pf1-f195.google.com with SMTP id o70so10839013pfg.5;
        Sun, 25 Aug 2019 20:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xa8DntdIz8LC3JJ+BkOhzuHnHyOIlOhfoPe7xm4aRe8=;
        b=Z86t4++BSalOqOkY1hNY6bqmn3pi1wX0qJpSQJ5P8UgHb4p6HaTS92KVyQDbzMfhli
         AqMPL/1kdWc5CsCqKYh5/2la+lmyj/OQPky92nTLklx+4MJOBpzA8fNMvu+YQz9RGKC7
         0anuCt1VKhdryArNdNz6RO3p2OL3AkJ5UI+AjMc9tqGA+3TXXn9qSrZ0tZ2CqUmbCnRq
         CaAYKvSB5WPnNEA1mv+WsfzuzIXKayLupi6dgRb/UPMFmSlsTkeeyeAwnAOwZehPJGMA
         NbXDEdDmFEjNdpesFNef+QUgNYPJR+FLRb89SZ42iDx91llreqxWbI8LdOFYCjReGdPu
         n0yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xa8DntdIz8LC3JJ+BkOhzuHnHyOIlOhfoPe7xm4aRe8=;
        b=HUkBsVswtPrYuxgvz03L9pJ24ZbGEiIzqAV5QTPT7vzpW6WUdbO9fUyMwJSMwK6IY3
         vpuwOmGLnBjus1WHceT0+LoFfnc9F5JIh37NgF6ymreSmWCbnDgjQLOU4/lnHz0MnGZx
         gTGyXZH0vRV8NKJ/qFhAelwI/anN5cjDMmy22DxZGbMlEGp1klDPO/cmQIDHEj1Oa3Y8
         mcJzHrSBufncNZuy+L/gIo3MhEJbXxwNTcJTkSVEQWR7zfH8zNADeggiYTj2G+OZC6O1
         vD56/CJuxluwicgaNzaG4TxA/llUC3xuRHKgQCZ2BCsquCLW9i8zZ36nNH2YQ8OrpFuQ
         s9yw==
X-Gm-Message-State: APjAAAXDr1tsfmbk4EMKPDqAHOYvm0rY8TohvF5IofmJLbK4mZ3DBU8O
        7jqsl2TrcLT4N7XsgARy2OmHLo98MoC5vtcB5Pk=
X-Google-Smtp-Source: APXvYqzN3pdcoH83pjRw1/MJddGwkq8XkYEuuFhC6p38MxZs9rCZOLSKFmzpC+SAwhimHbuc5zhdxSTpdKrls0zCmpM=
X-Received: by 2002:a65:5043:: with SMTP id k3mr1282285pgo.406.1566790330845;
 Sun, 25 Aug 2019 20:32:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190822053852.239309-1-Tianyu.Lan@microsoft.com>
 <87zhk1pp9p.fsf@vitty.brq.redhat.com> <20190824151218.GM1581@sasha-vm>
In-Reply-To: <20190824151218.GM1581@sasha-vm>
From:   Tianyu Lan <lantianyu1986@gmail.com>
Date:   Mon, 26 Aug 2019 11:31:59 +0800
Message-ID: <CAOLK0pyk0z2DodvdP46XD7GrDUHmiRBehs8FT2u7iWes-bLtuA@mail.gmail.com>
Subject: Re: [PATCH] x86/Hyper-V: Fix build error with CONFIG_HYPERV_TSCPAGE=N
To:     Sasha Levin <sashal@kernel.org>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org,
        "linux-kernel@vger kernel org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        michael.h.kelley@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sun, Aug 25, 2019 at 1:52 AM Sasha Levin <sashal@kernel.org> wrote:
>
> On Thu, Aug 22, 2019 at 10:39:46AM +0200, Vitaly Kuznetsov wrote:
> >lantianyu1986@gmail.com writes:
> >
> >> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
> >>
> >> Both Hyper-V tsc page and Hyper-V tsc MSR code use variable
> >> hv_sched_clock_offset for their sched clock callback and so
> >> define the variable regardless of CONFIG_HYPERV_TSCPAGE setting.
> >
> >CONFIG_HYPERV_TSCPAGE is gone after my "x86/hyper-v: enable TSC page
> >clocksource on 32bit" patch. Do we still have an issue to fix?
>
> Yes. Let's get it fixed on older kernels (as such we need to tag this
> one for stable). The 32bit TSC patch won't come in before 5.4 anyway.
>
> Vitaly, does can you ack this patch? It might require you to re-spin
> your patch.
>
Hi Sasha:
               Thomas has foled this fix into original patch.
https://lkml.org/lkml/2019/8/23/600
--
Best regards
Tianyu Lan
