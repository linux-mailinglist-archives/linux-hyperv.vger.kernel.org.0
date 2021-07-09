Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACDD3C2A2C
	for <lists+linux-hyperv@lfdr.de>; Fri,  9 Jul 2021 22:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbhGIUNx (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 9 Jul 2021 16:13:53 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47]:39449 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbhGIUNx (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 9 Jul 2021 16:13:53 -0400
Received: by mail-wm1-f47.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso9766952wmh.4;
        Fri, 09 Jul 2021 13:11:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=X5Kq+LYu7shcjvHnUUvfPDCy6+d+q+ktHQddeACxeJY=;
        b=cB9v0+tCbjAry9D7qLZnq3Z8cCIFAyJAz6pJdqT7qa54p0E42Z7WOzf8DHlZIiQNfh
         1QN0ynynhwzkScReyqqRkuykz74uwyYolMK08mj1NF9+vis3DCXB9FSqcxUAFNvpYcTO
         /G/2u2qtZkynPqnNjNTQRgtt70F/3dthUcYQ+XiqB5nw91HtGAMPVScH0EnIOGHXsLT3
         Vs5vIUlZj86NYbTl3gwazxGJ2Ho2I6390MG9OOebM/PXuNgsRx3t14wX4AobJJ3UZp5B
         tF/aQgjbfxFnWwXMIIQgfv8ys6aedSSNaq0xNocLRaE3R/gqz4vDISyfkJXv0C74HHKb
         aPvQ==
X-Gm-Message-State: AOAM530eIW2uMW4D/3PWEDYKADbr9/zHNCVTyEDejFIJjA42Rs37r9Cy
        04Txw03ai2axlKiMq/fVc1FdluwlvU0=
X-Google-Smtp-Source: ABdhPJw/wn/J8DBGkyIr19UCGDIC81xoa3fStxjKPsKCEvKchvST+uJVXawhHHCvajPXeaXEnV/DnA==
X-Received: by 2002:a1c:cc02:: with SMTP id h2mr40744025wmb.39.1625861467372;
        Fri, 09 Jul 2021 13:11:07 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id w22sm13034405wmc.4.2021.07.09.13.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 13:11:06 -0700 (PDT)
Date:   Fri, 9 Jul 2021 20:11:05 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        kumarpraveen@linux.microsoft.com, pasha.tatashin@soleen.com,
        Jonathan Corbet <corbet@lwn.net>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Lillian Grassin-Drake <ligrassi@microsoft.com>,
        Muminul Islam <muislam@microsoft.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [RFC v1 7/8] mshv: implement in-kernel device framework
Message-ID: <20210709201105.qvl7bbal7iugtynd@liuwe-devbox-debian-v2>
References: <20210709114339.3467637-1-wei.liu@kernel.org>
 <20210709114339.3467637-8-wei.liu@kernel.org>
 <YOhIzJVPN9SwoRK0@casper.infradead.org>
 <20210709135013.t5axinjmufotpylf@liuwe-devbox-debian-v2>
 <YOhsIDccgbUCzwqt@casper.infradead.org>
 <20210709162732.hnyzpf3uofzc7xqs@liuwe-devbox-debian-v2>
 <YOh7gO3MIDv5Eo8q@casper.infradead.org>
 <20210709191405.t3vno3zw7kdlo4ps@liuwe-devbox-debian-v2>
 <YOioFOT5WgkUB+dY@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YOioFOT5WgkUB+dY@casper.infradead.org>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Jul 09, 2021 at 08:48:36PM +0100, Matthew Wilcox wrote:
> On Fri, Jul 09, 2021 at 07:14:05PM +0000, Wei Liu wrote:
> > You were not CC'ed on this patch, so presumably you got it via one of
> > the mailing lists. I'm not sure why you only got this one patch. Perhaps
> > if you wait a bit you will get the rest.
> 
> No, I won't.  You only cc'd linux-doc on this one patch and not on any
> of the others.

I see. That's because get_maintainers.pl only detected changes to the
doc in this file.

If you're interested in having a look at the other patches, they can
be fetched via at the following url. 

https://lore.kernel.org/linux-hyperv/20210709114339.3467637-1-wei.liu@kernel.org/

Thanks for your attention.

Wei.
