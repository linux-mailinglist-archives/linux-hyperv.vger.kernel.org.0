Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6762A20C1
	for <lists+linux-hyperv@lfdr.de>; Sun,  1 Nov 2020 19:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbgKASTl (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 1 Nov 2020 13:19:41 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41759 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbgKASTl (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 1 Nov 2020 13:19:41 -0500
Received: by mail-wr1-f68.google.com with SMTP id s9so12004181wro.8
        for <linux-hyperv@vger.kernel.org>; Sun, 01 Nov 2020 10:19:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kqeKZc9YhvQhPgkIKRPGX1ZSHU2pR7Pe6QYenXPMwOs=;
        b=LGcvdVNktjcP+Wt8WgNWIto05UTnWDNKVT7ZjRubrRVNfsNEqokkhwkjVHHPipV6EQ
         pXTn3f8cCHxGgo1tuS9MbMLJGZrRJXG/088SpIQ8czO37/zrWEiml0/OKIpvqpFjDrsJ
         Rrv/Vs30Y9O1dMUH7Rd6Q5Xqt/VuEOU6b6ofseXBIMsTqRSz69/h86Ksuqv2nCAvR31Y
         sPr4Qm6mG1Pmc13NThuzpc++lpqQKZpmwUR3Wgka/VwCFKZru5hJkS27qkbjo/Gt0f0s
         0uAM5Qe8PbJuZEhJuwO8g18n8xciFOzmlpICmwlwGWvDGs0ybFvimo5lg1HOC8WIU8q+
         wLeQ==
X-Gm-Message-State: AOAM532saze3LCzT0iTL0uz9kb/IAvtnSkjVclMm+G77/BjajW1j/WbZ
        8QgEyNKio5GVu3CZrB0PgOw=
X-Google-Smtp-Source: ABdhPJzsvg2zJI4/OdwLHHu4ppQkis+cygLjk/by2x1sY2kpP0QpPnRf1b9DBra4Vv0ivEnHMEr4kQ==
X-Received: by 2002:adf:a195:: with SMTP id u21mr8541796wru.132.1604254779715;
        Sun, 01 Nov 2020 10:19:39 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id x21sm20973272wmi.3.2020.11.01.10.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2020 10:19:39 -0800 (PST)
Date:   Sun, 1 Nov 2020 18:19:37 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Michael Kelley <mikelley@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Subject: Re: ** POTENTIAL FRAUD ALERT - RED HAT ** RE: Field names inside
 ms_hyperv_info
Message-ID: <20201101181937.332bmmqnwlju5my4@liuwe-devbox-debian-v2>
References: <20201028150323.tz5wamibt42dgx7f@liuwe-devbox-debian-v2>
 <87lffnzqhp.fsf@vitty.brq.redhat.com>
 <MW2PR2101MB10520A20D4ADB1CE6B6AD559D7150@MW2PR2101MB1052.namprd21.prod.outlook.com>
 <87imarzllm.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87imarzllm.fsf@vitty.brq.redhat.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Oct 30, 2020 at 06:09:57PM +0100, Vitaly Kuznetsov wrote:
[...]
> > We don't have a TLFS for ARM64 (should be coming soon).  Might
> > be worth seeing what naming, if any, will be used there.
> 
> In that case we should probably wait untill the naming there is clear as
> I'm afraid we'll be renaming again.
> 

Sure. I'm fine with this too.

Wei.

> -- 
> Vitaly
> 
