Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A889342B10F
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 Oct 2021 02:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235220AbhJMApO (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 12 Oct 2021 20:45:14 -0400
Received: from mail-lf1-f48.google.com ([209.85.167.48]:35396 "EHLO
        mail-lf1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbhJMApO (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 12 Oct 2021 20:45:14 -0400
Received: by mail-lf1-f48.google.com with SMTP id p16so4167913lfa.2;
        Tue, 12 Oct 2021 17:43:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oOwvM3EKxNEtBFMhhfn75utnR2wRei/SWwuhD1BYw9o=;
        b=Clk/stTufjyHS59b1DNmYydkp89DwLOpNhZ2YlZa6+PcsmhRI7jopq8lVkJEDmmhwJ
         7xa1t1rFEqGZwzjhXFwztxxRlooOK/6FUJuCHx1/gdlCCgY+TMh0lPY99dV8GubMPOO6
         I7DvzN35O4IURb7kJwl7AzSsOxypNGFd1N1ZrLNBllxvNsZ5m8tYYmpZp3ZQTpstEcN7
         MpACXzwx3Ea5q/omu466pZhPNDt1YRvNVs2TzBBEt5f2+nE0X0R89TBa4XlpaSlcg1yj
         afPxtURx2lmFC9mTzFlodt/nmTTAHfSd72/GrLmmfMG46JzYfvV6lTfuRVzB6PLuQMQM
         CF8g==
X-Gm-Message-State: AOAM5330xuaA3+mFOq999JFxAOyyWhOmEWludJCgeXbkcVKMGtLAq9Fb
        Xalw7wVZeI7PVvoJj+jlfQw=
X-Google-Smtp-Source: ABdhPJzWJ5C01RYWvPPFegSq9LNKpJ7YSIi7KrEldjA2ZVgyonPU6nzwAa7GBg+K3yJKlDrpRLdFyg==
X-Received: by 2002:a2e:bd86:: with SMTP id o6mr1258496ljq.221.1634085790886;
        Tue, 12 Oct 2021 17:43:10 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id t24sm44473lfk.100.2021.10.12.17.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 17:43:10 -0700 (PDT)
Date:   Wed, 13 Oct 2021 02:43:08 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Long Li <longli@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/3] PCI: hv: Remove unnecessary integer promotion from
 dev_err()
Message-ID: <YWYrnMwyvY45u4qk@rocinante>
References: <20211008222732.2868493-1-kw@linux.com>
 <20211012184749.GA1775474@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211012184749.GA1775474@bhelgaas>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Bjorn,

> > Internally, printk() et al already correctly handles the standard
> > integer promotions, so there is no need to explicitly "%h" modifier as
> > part of a format string such as "%hx".
> > 
> > Thus, drop the "%h" modifier as it's completely unnecessary (N.B. this
> > wouldn't be true for the sscanf() function family), and match preferred
> > coding style.
> > 
> > Related:
> >   commit cbacb5ab0aa0 ("docs: printk-formats: Stop encouraging use of unnecessary
> >   commit 70eb2275ff8e ("checkpatch: add warning for unnecessary use of %h[xudi] and %hh[xudi]")
> >   https://lore.kernel.org/lkml/CAHk-=wgoxnmsj8GEVFJSvTwdnWm8wVJthefNk2n6+4TC=20e0Q@mail.gmail.com/
> > 
> > No change to functionality intended.
> 
> Applied 1/3 and 3/3 to pci/misc for v5.16, thanks!
> 
> For 2/3, I think we might want to convert the VF ID to be unsigned
> consistently.

Will do!  I am going to send a separate patch for it.

	Krzysztof
