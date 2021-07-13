Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 891003C7382
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 Jul 2021 17:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237121AbhGMPuQ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 13 Jul 2021 11:50:16 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:35399 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237061AbhGMPuQ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 13 Jul 2021 11:50:16 -0400
Received: by mail-wr1-f53.google.com with SMTP id m2so20060808wrq.2;
        Tue, 13 Jul 2021 08:47:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jG0GlQf65FSs7wAywgVrWxVXba4Vuqs6QN9P6/U3ebY=;
        b=TKpVO3WlHW+sBQ0RzmrgQXNHtpukbnSt8NLaeWtv1jBLp08jI4YxujYSPKqyc1iQBI
         4g5/25Ptc8GLkVKpartSUdYPLop8mGpoX7te8Tnvw2jPPLrcsmlWbpXZ5cqTIzj0Prpe
         t9c1aQP1AHJ+Y9Z2rQW0ovaQYrPD1s71SQSBhp5JQiAPRtaQAQeGxr0k6PZC8fMsU1b3
         Pj1NgKLK5PbRGYODCoqpeXwlEb10RNxyLTAuGCpJv62vG1RpSrmkxT4JDjAw78oN475C
         NN8b2DfCbxcTi7dBKf4sqdt1kqmHfn5xUtZyx+X++V+yKMgsxF+/gIsEOFEsaH3/ZkUn
         a1RQ==
X-Gm-Message-State: AOAM530xOmIKX2S33BX0EMJJ5LEAOwHGwNmSCfK9EqBkxJivEOS/GzeF
        jgYJ3DYk5CbV1cgm70/PTvU=
X-Google-Smtp-Source: ABdhPJwnXEwLHQqAh7h+z2eHbDH/aW2z/lyoAggOo061dYdClwuDp9v6dAUr+4x/fzhdO8By/lLM5A==
X-Received: by 2002:adf:b318:: with SMTP id j24mr6755990wrd.361.1626191244601;
        Tue, 13 Jul 2021 08:47:24 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id a9sm17581521wrv.37.2021.07.13.08.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 08:47:24 -0700 (PDT)
Date:   Tue, 13 Jul 2021 15:47:22 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Ani Sinha <ani@anisinha.ca>,
        Michael Kelley <mikelley@microsoft.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Wei Liu <wei.liu@kernel.org>, linux-kernel@vger.kernel.org,
        anirban.sinha@nokia.com, mikelley@microsoft.com,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-hyperv@vger.kernel.org
Subject: Re: [PATCH] Hyper-V: fix for unwanted manipulation of sched_clock
 when TSC marked unstable
Message-ID: <20210713154722.pqsofao7xp4ihg44@liuwe-devbox-debian-v2>
References: <20210713030522.1714803-1-ani@anisinha.ca>
 <20210713130446.gt7k3cwlmhsxtltw@liuwe-devbox-debian-v2>
 <20210713131756.GD4170@worktop.programming.kicks-ass.net>
 <alpine.DEB.2.22.394.2107132051590.2135909@anisinha-lenovo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2107132051590.2135909@anisinha-lenovo>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Jul 13, 2021 at 09:01:06PM +0530, Ani Sinha wrote:
> 
> 
> On Tue, 13 Jul 2021, Peter Zijlstra wrote:
> 
> > On Tue, Jul 13, 2021 at 01:04:46PM +0000, Wei Liu wrote:
> > > On Tue, Jul 13, 2021 at 08:35:21AM +0530, Ani Sinha wrote:
> > > > Marking TSC as unstable has a side effect of marking sched_clock as
> > > > unstable when TSC is still being used as the sched_clock. This is not
> > > > desirable. Hyper-V ultimately uses a paravirtualized clock source that
> > > > provides a stable scheduler clock even on systems without TscInvariant
> > > > CPU capability. Hence, mark_tsc_unstable() call should be called _after_
> > > > scheduler clock has been changed to the paravirtualized clocksource. This
> > > > will prevent any unwanted manipulation of the sched_clock. Only TSC will
> > > > be correctly marked as unstable.
> > >
> > > Correct me if I'm wrong, what you're trying to address is that
> > > sched_clock remains marked as unstable even after Linux has switched to
> > > a stable clock source.
> > >
> > > I think a better approach will be to mark the sched_clock as stable when
> > > we switch to the paravirtualized clock source.
> >
> > No.. unstable->stable transitions are unsound. You get to switch to your
> > paravirt clock earlier.
> >
> 
> I believe manipulating sched_clock was never the intention of the original
> author who added the code to mark tsc as unstable on hyper-V:
> 
> commit 88c9281a9fba67636ab26c1fd6afbc78a632374f
> Author: Vitaly Kuznetsov <vkuznets@redhat.com>
> Date:   Wed Aug 19 09:54:24 2015 -0700
> 
>     x86/hyperv: Mark the Hyper-V TSC as unstable
> 
> 
> The original author simply wanted to mark TSC as unstable on hyper-V
> systems because of reasons the above commit log will describe. Sched clock
> manipulation happened accidentally because from where the
> mark_tsc_unstable() was being called. This patch simply fixes this.
> 
> Michael Kelly from Microsoft has tested this patch already.

OK. In light of Peter's comment and this one, I'm fine with this patch.

Michael, can you give an ack or review here?

Thanks,
Wei.

> 
> --Ani
> 
