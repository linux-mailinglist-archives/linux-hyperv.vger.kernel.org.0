Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C42D30DCFC
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Feb 2021 15:38:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232621AbhBCOir (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 3 Feb 2021 09:38:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232475AbhBCOht (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 3 Feb 2021 09:37:49 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D681C0613ED
        for <linux-hyperv@vger.kernel.org>; Wed,  3 Feb 2021 06:37:09 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id g10so24601204wrx.1
        for <linux-hyperv@vger.kernel.org>; Wed, 03 Feb 2021 06:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=W9o4SlQMY45XTTQ+rehlT9Bq2FFJYeLKrQoKvMrDhRM=;
        b=JkHOLPjsBRJ7MEO+P/LaWuiuauNXCE4nP8pFwaJoeFr1XGWF0h0KeYpSkKM9dBT2QL
         wLGiA2FsWZyTxNOMSqpdgw+RyeHmaRSEaOY26ehwkx+CTZoz3QQffntlLM9QYVY2IC5B
         Cp6ey+FflriO0RlCzNPgdCulD5mV658Q1LCX6JKySsQDHcrLax9jO+2h+zaLA0RlcUu2
         XRRfDU0i5uIdTEhDlRxIRvc2K990wrkeEo07nkmOv7LBjQPAXdN2dMj6EoYEzioIIRox
         cKcbgfRN8K4GCitle9VEuvuIzAjaG+laNgz/L/uwoltZBR7xf72dNYc0RbcLHIZd4yHr
         q5gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=W9o4SlQMY45XTTQ+rehlT9Bq2FFJYeLKrQoKvMrDhRM=;
        b=qVJvNQKCGrYojv52E0xNQGWlS1aPWExWMJlMLHw9c9whmVz6/OkjulzlCMKpBuVGb3
         H8C0POfkGHiz6KOM0ngwKVsIVsyLhKYmdzL4A+ZkkhEuroHt7BLFYbnKMX0oY9O100e8
         822H0AsQKgwSXjeDFqPSgKQPdVH6y94T6Kvh7ClNDv38XMFOlr0tp/vRZzfMUpRCExyF
         gwPWUia7APxLBtI9b7PT68tnFk5w02TlaO8tdoRLsxw4RtZUvG9HnI1oQ5ONhHQXmHQl
         XpTCCeOGX3j/U7DW4yr0YZ1tTgQEg0VXo1gZlZbefrcZXvIIkcxMCZlBoQ8d0Vxw7XDA
         jjMw==
X-Gm-Message-State: AOAM533hx2Sl3rv3gujYcLFn/J9YuQ9DjTZf+bd7vlzZek16yzC5aH6j
        0OY6/E0WuTw61L19NsJZ+Ho=
X-Google-Smtp-Source: ABdhPJyLb5Xu6GiAR46AJOZCyseluVHXy+GNUfXLVyPj/GF/B/kF3CgakhwB0Vo8KCyIgZAsyL6M1w==
X-Received: by 2002:a5d:47a8:: with SMTP id 8mr3791017wrb.180.1612363027681;
        Wed, 03 Feb 2021 06:37:07 -0800 (PST)
Received: from anparri (host-95-238-70-33.retail.telecomitalia.it. [95.238.70.33])
        by smtp.gmail.com with ESMTPSA id h1sm3984219wrr.73.2021.02.03.06.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 06:37:07 -0800 (PST)
Date:   Wed, 3 Feb 2021 15:37:00 +0100
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-hyperv@vger.kernel.org
Subject: Re: [bug report] hv_netvsc: Copy packets sent by Hyper-V out of the
 receive buffer
Message-ID: <20210203143700.GA559623@anparri>
References: <YBp2oVIdMe+G/liJ@mwanda>
 <20210203104544.GA558156@anparri>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203104544.GA558156@anparri>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Feb 03, 2021 at 11:45:44AM +0100, Andrea Parri wrote:
> Hi Dan,
> 
> On Wed, Feb 03, 2021 at 01:10:41PM +0300, Dan Carpenter wrote:
> > Hello Andrea Parri (Microsoft),
> > 
> > This is a semi-automatic email about new static checker warnings.
> > 
> > The patch 0ba35fe91ce3: "hv_netvsc: Copy packets sent by Hyper-V out
> > of the receive buffer" from Jan 26, 2021, leads to the following
> > Smatch complaint:
> > 
> >     drivers/net/hyperv/rndis_filter.c:468 rsc_add_data()
> >     error: we previously assumed 'csum_info' could be null (see line 460)
> > 
> > drivers/net/hyperv/rndis_filter.c
> >    459			}
> >    460			if (csum_info != NULL) {
> >                             ^^^^^^^^^^^^^^^^^
> > "csum_info" can be NULL.
> > 
> >    461				memcpy(&nvchan->rsc.csum_info, csum_info, sizeof(*csum_info));
> >    462				nvchan->rsc.ppi_flags |= NVSC_RSC_CSUM_INFO;
> >    463			} else {
> >    464				nvchan->rsc.ppi_flags &= ~NVSC_RSC_CSUM_INFO;
> >    465			}
> >    466			nvchan->rsc.pktlen = len;
> >    467			if (hash_info != NULL) {
> >    468				nvchan->rsc.csum_info = *csum_info;
> >                                                         ^^^^^^^^^^^
> > Unchecked dereference.  Plus this has "csum_info" on both sides of the
> > assignment so maybe it is a copy and paste error?  This is equivalent to
> > the "memcpy(&nvchan->rsc.csum_info, csum_info, sizeof(*csum_info));"
> > in the ealier if statement but stated as an assignment instead of a
> > memcpy().
> 
> Right, I did realize about the error and I'm about to send a fix for it.

For reference,

  https://lkml.kernel.org/r/20210203113513.558864-3-parri.andrea@gmail.com/

  Andrea
