Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C56F343F6C
	for <lists+linux-hyperv@lfdr.de>; Mon, 22 Mar 2021 12:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbhCVLQe (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 22 Mar 2021 07:16:34 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:38892 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbhCVLQ0 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 22 Mar 2021 07:16:26 -0400
Received: by mail-wr1-f53.google.com with SMTP id z2so16246210wrl.5;
        Mon, 22 Mar 2021 04:16:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UkbQHhRFu3VCem8wMbYGSCHnBOT7NZBm3cb0xTaOfF0=;
        b=jFOahz2DY2y/DDIDWItBo+DTjtqHrA85pvlDoNSUxXQQUN9I4SZyEpKgriuxYWLYIX
         F/du/WtoC2LPJHYyO+Zav7UmNdaDkENo3OwSIMn8jZHYXLCYBkpPNj9hfabZRseTlkti
         8NboPo0Ynb/4fXE7J1isTzGUeyd77+hyVh5Ift+JO89Dw4IniGaUo10zMHgABYf67PQ9
         iOou6GlnllcoiNrfWOz/t3HKSz7Dd5aS9aMnPfVuS7pZxRnhidbi0HbJOmoy1E+VUak5
         aHJ6gyEEeBM8ZRqGXe+uPUQ/L3fU5ya/hFFQUxUm9Ve1WNhMjHW8AMXowZB/g6uTBoUb
         CBWg==
X-Gm-Message-State: AOAM531MMJ6ssQDETU4G4cgHSAovNeq54W9dX4pdbuRbmaFIf/A9Ewn3
        JDWResRjtBB8owjETURXdHnHGka4/zU=
X-Google-Smtp-Source: ABdhPJxONToZF/zYJgJuQYMDI6ZY4mH5zGY9bhnz1Ws/t2BZvxSpu6NNWHPzKlavMQhoByPSHAGsAw==
X-Received: by 2002:a05:6000:1563:: with SMTP id 3mr17541609wrz.211.1616411783637;
        Mon, 22 Mar 2021 04:16:23 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id o15sm13518844wra.93.2021.03.22.04.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 04:16:23 -0700 (PDT)
Date:   Mon, 22 Mar 2021 11:16:21 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     Sunil Muthuswamy <sunilmut@microsoft.com>,
        Matheus Castello <matheus@castello.eng.br>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <liuwe@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, vkuznets <vkuznets@redhat.com>,
        KY Srinivasan <kys@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] x86/Hyper-V: Support for free page reporting
Message-ID: <20210322111621.kdjsaxxioxo6k7dl@liuwe-devbox-debian-v2>
References: <SN4PR2101MB088069A91BC5DB6B16C8950BC0699@SN4PR2101MB0880.namprd21.prod.outlook.com>
 <MWHPR21MB1593BF61E959AC8F056CDFF5D7689@MWHPR21MB1593.namprd21.prod.outlook.com>
 <SN4PR2101MB088036B8892891C5408067BEC0689@SN4PR2101MB0880.namprd21.prod.outlook.com>
 <MWHPR21MB15932DFEE4F0756419D58525D7689@MWHPR21MB1593.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR21MB15932DFEE4F0756419D58525D7689@MWHPR21MB1593.namprd21.prod.outlook.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Mar 19, 2021 at 09:30:50PM +0000, Michael Kelley wrote:
> From: Sunil Muthuswamy <sunilmut@microsoft.com>  Sent: Friday, March 19, 2021 2:21 PM
> > 
> > > What's the strategy for this flag in the unlikely event that the hypercall fails?
> > > It doesn't seem right to have hv_query_ext_cap() fail, but leave the
> > > static flag set to true.  Just move that line down to after the status check
> > > has succeeded?
> > 
> > That call should not fail in any normal circumstances. The current idea was to
> > avoid repeating the same call on persistent failure. 
> 
> OK, I can see that as a valid strategy.  And the assumption is that a failed
> hypercall would leave hv_extended_cap unmodified and hence all zeros.
> 
> I'm OK with this approach if you want to keep it.  But perhaps add a short
> comment about the intent so it doesn't look like a bug. :-)
> 

Sunil, if you can send an updated version of your patch by either
providing a comment or moving the code around, I can queue it up for
hyperv-next.

I think adding a comment is perhaps the easier thing to do.

Wei.
