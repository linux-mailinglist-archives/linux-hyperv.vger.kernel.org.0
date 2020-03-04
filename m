Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06328179748
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Mar 2020 18:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729471AbgCDRzO (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 4 Mar 2020 12:55:14 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40109 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728926AbgCDRzO (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 4 Mar 2020 12:55:14 -0500
Received: by mail-wm1-f65.google.com with SMTP id e26so2807046wme.5;
        Wed, 04 Mar 2020 09:55:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IXbD/GgJVPZ9WOOjQZpIDfTuKHqUvdwDS5tyVn1vzKs=;
        b=dZW/rNEE4siDef5TElhDwRimjVffVGL/eOVlNvygHaKe9GqFlWeXkbCIMvCK3PCaQr
         +RmoAAoMydHmWeDXg35PHKU5FbUnpljLq1iE0S6P3N+yWp0lnYrWw9mM+SnXNNRe6gfl
         FCISM22tFhE/KC2LjQT1WI5MOSuS/dm54S55YvmE6jjfqLTzfQkQj4HU3RqC89TQ0er3
         vHYmm64WT8Cjzc3sObAijW4zuScMmaN0Un+Xf4bDjhVTrTrQZxw0gShFf7AOdFTbSzIh
         oQh3CDKvJCCHSdDEDAUQy+O1WfhJkcVL4oKUE5zZH9jfj5pnWVxthweTDqrqiVXx9gCf
         R/Nw==
X-Gm-Message-State: ANhLgQ1DQXr77lGXKu7uGgOwWlInL18ONrS+2rC6uNFh/sD90rRrTFXN
        GSrpkcotjqAyyhjW1LcUqugC1Bqu
X-Google-Smtp-Source: ADFU+vs9Ns5cKiBuxZvEKxGfUWqB4Wx333NSJ3TdOFT09JNhgx8N5gGqFg8moiDT+XIM3+5kO/phPg==
X-Received: by 2002:a7b:c019:: with SMTP id c25mr4825181wmb.126.1583344512200;
        Wed, 04 Mar 2020 09:55:12 -0800 (PST)
Received: from debian (41.142.6.51.dyn.plus.net. [51.6.142.41])
        by smtp.gmail.com with ESMTPSA id o8sm5015597wmh.15.2020.03.04.09.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 09:55:11 -0800 (PST)
Date:   Wed, 4 Mar 2020 17:55:09 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Dexuan Cui <decui@microsoft.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH] PCI: hv: Replace zero-length array with flexible-array
 member
Message-ID: <20200304175509.dwhn63omfzewaukv@debian>
References: <20200213005048.GA9662@embeddedor.com>
 <HK0P153MB0148FB68FCBAE908CA5991C3BF1A0@HK0P153MB0148.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <HK0P153MB0148FB68FCBAE908CA5991C3BF1A0@HK0P153MB0148.APCP153.PROD.OUTLOOK.COM>
User-Agent: NeoMutt/20180716
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Feb 13, 2020 at 03:43:40AM +0000, Dexuan Cui wrote:
> > From: linux-hyperv-owner@vger.kernel.org
> > <linux-hyperv-owner@vger.kernel.org> On Behalf Of Gustavo A. R. Silva
> > Sent: Wednesday, February 12, 2020 4:51 PM
> >  ...
> > The current codebase makes use of the zero-length array language
> > extension to the C90 standard, but the preferred mechanism to declare
> > variable-length types such as these ones is a flexible array member[1][2],
> > introduced in C99:
> > 
> > struct foo {
> >         int stuff;
> >         struct boo array[];
> > };
> > 
> > By making use of the mechanism above, we will get a compiler warning
> > in case the flexible array does not occur last in the structure, which
> > will help us prevent some kind of undefined behavior bugs from being
> > inadvertently introduced[3] to the codebase from now on.
> > 
> > Also, notice that, dynamic memory allocations won't be affected by
> > this change:
> > 
> > "Flexible array members have incomplete type, and so the sizeof operator
> > may not be applied. As a quirk of the original implementation of
> > zero-length arrays, sizeof evaluates to zero."[1]
> > 
> > This issue was found with the help of Coccinelle.
> 
> Looks good to me. Thanks, Gustavo!
>  
> Reviewed-by: Dexuan Cui <decui@microsoft.com>
> 

Lorenzo, will you be picking up this patch? It seems to me you've been
handling patches to pci-hyperv.c. This patch is not yet in pci/hv branch
in your repository.

Let me know what you think.

Wei.
