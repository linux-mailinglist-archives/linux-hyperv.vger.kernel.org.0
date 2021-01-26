Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84F28304236
	for <lists+linux-hyperv@lfdr.de>; Tue, 26 Jan 2021 16:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406265AbhAZPUq (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 26 Jan 2021 10:20:46 -0500
Received: from mail-wr1-f49.google.com ([209.85.221.49]:42809 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391796AbhAZPUl (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 26 Jan 2021 10:20:41 -0500
Received: by mail-wr1-f49.google.com with SMTP id h9so6634379wrr.9;
        Tue, 26 Jan 2021 07:20:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=460NPPZwyIUmxq4OnFGdo8FcYglMWQ0+AliFnnOiLnM=;
        b=iti1bZz1pOUuri9X1BYmMUlf3aj/FKBo2G1LohP9q3Etw5cQihAsRlFChpPIecVPQ3
         PJIzkoQ9LzXHnwhZOXiknxwBja43wd3TK+84FskTJvewsKqNuEvbnP3tTEdwimQ+lIzo
         jbKW+y3PD2sj/n6w/WigRUgxMf3EzgAPGcwv40tOLsc52MI4U7N8NJEcEQIehlNaXBCn
         ED5yS294B6+HYj1xGJkeQi1lWXA2wZ05eKWV6GJOaSVMd7bEdYHFD4Y88diNCEWpAaRj
         czlN+95J4lJXi5q2e851mD69coD7kOnBcOIbLxrClCHm1ZcqiFqc7GBBzn4ffphG//2P
         dk6g==
X-Gm-Message-State: AOAM53175XcP3lkLmnbq+uIbral2oFwoSPWF94zRfvt29+wEXosExtkg
        loHgNI8pyN8U5mRwY/iOA5E=
X-Google-Smtp-Source: ABdhPJzrWkjBXfd9WHDyZ5AWbLFubFbKr07XM5tjuvAetHbQYWycZU4X02gmBbQwXJsnH6LfA/pBRg==
X-Received: by 2002:adf:d206:: with SMTP id j6mr6474841wrh.427.1611674399762;
        Tue, 26 Jan 2021 07:19:59 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id c20sm3552041wmb.38.2021.01.26.07.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 07:19:59 -0800 (PST)
Date:   Tue, 26 Jan 2021 15:19:58 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v5 05/16] clocksource/hyperv: use MSR-based access if
 running as root
Message-ID: <20210126151958.anyp2ncjykivsfvn@liuwe-devbox-debian-v2>
References: <20210120120058.29138-1-wei.liu@kernel.org>
 <20210120120058.29138-6-wei.liu@kernel.org>
 <CA+CK2bBTjUWEOrFKi4pYpEe355sve6b7AjKGc7cQRRe3c-DTrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bBTjUWEOrFKi4pYpEe355sve6b7AjKGc7cQRRe3c-DTrQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Jan 20, 2021 at 11:13:28AM -0500, Pavel Tatashin wrote:
> On Wed, Jan 20, 2021 at 7:01 AM Wei Liu <wei.liu@kernel.org> wrote:
> >
> > When Linux runs as the root partition, the setup required for TSC page
> > is different.
> 
> Why would we need a TSC page as a clock source for root partition at
> all? I think the above can be removed.
> 

The TSC page is considered superior to MSR-based clock. In the future we
may want to switch back to that TSC page instead.

I think it provides more context than without.

Wei.

>  Luckily Linux also has access to the MSR based
> > clocksource. We can just disable the TSC page clocksource if Linux is
> > the root partition.
> >
