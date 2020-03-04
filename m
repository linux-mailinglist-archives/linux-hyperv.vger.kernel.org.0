Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC13D179798
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Mar 2020 19:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388195AbgCDSKW (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 4 Mar 2020 13:10:22 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33527 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388189AbgCDSKW (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 4 Mar 2020 13:10:22 -0500
Received: by mail-wm1-f65.google.com with SMTP id a25so5285872wmm.0;
        Wed, 04 Mar 2020 10:10:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6K5mSx3hLH2eC6TJDpwRSBd6DNa0fXfEXM9YJbhKTUo=;
        b=X/blQgC7janOQG/uErT1N7XiZKBg6Xy1ve+jBJwpYUjlyKMs9GvWC+KJEfUZ7NezSz
         BsLAtkRSDgNKrjZJ7C06qL2IEXqsuZt7/j+AUmCMo2b23j65c/O9zztUjMm6ucfrHAJc
         FQ5Nprvk211O8Fg7CjADu9+RHBsf125RuRD6lU/PO8OHIUUGzD2PmlHPglV+paYnQTo8
         BA58lHlZDhkvb0Z6Wlhh3Qs23+7kbSzABxwcwDZq3LkCvoLsjTEVEOxFHmem3cffj9/C
         GJ5X4QO1cD5jT76F8pknl8CTKL+YJEQn65raHOV3mQXYjCtYAzUKooERz3S7G0xM29PW
         z0LQ==
X-Gm-Message-State: ANhLgQ1aUHQiOtqbmZ20K+tJNxlBB0Y/oNWQA3PqWfDHyL58bvtOYw2m
        OA20a/56bYFb1SLFk1w1qAY=
X-Google-Smtp-Source: ADFU+vv8F7j77Sv2x6A2y7G2otTcm4JBrH0lQ9MmEphsTYfNiML6p42pZ9rYylq3kZ7sK2hY/cJjww==
X-Received: by 2002:a1c:750e:: with SMTP id o14mr4618729wmc.156.1583345420226;
        Wed, 04 Mar 2020 10:10:20 -0800 (PST)
Received: from debian (41.142.6.51.dyn.plus.net. [51.6.142.41])
        by smtp.gmail.com with ESMTPSA id z12sm3468853wrl.48.2020.03.04.10.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 10:10:19 -0800 (PST)
Date:   Wed, 4 Mar 2020 18:10:17 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: hv: Replace zero-length array with flexible-array
 member
Message-ID: <20200304181017.epqvhmtegefb4eba@debian>
References: <20200213005048.GA9662@embeddedor.com>
 <HK0P153MB0148FB68FCBAE908CA5991C3BF1A0@HK0P153MB0148.APCP153.PROD.OUTLOOK.COM>
 <20200304175509.dwhn63omfzewaukv@debian>
 <20200304180635.GA21844@e121166-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304180635.GA21844@e121166-lin.cambridge.arm.com>
User-Agent: NeoMutt/20180716
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Mar 04, 2020 at 06:06:35PM +0000, Lorenzo Pieralisi wrote:
> On Wed, Mar 04, 2020 at 05:55:09PM +0000, Wei Liu wrote:
> > On Thu, Feb 13, 2020 at 03:43:40AM +0000, Dexuan Cui wrote:
> > > > From: linux-hyperv-owner@vger.kernel.org
> > > > <linux-hyperv-owner@vger.kernel.org> On Behalf Of Gustavo A. R. Silva
> > > > Sent: Wednesday, February 12, 2020 4:51 PM
> > > >  ...
> > > > The current codebase makes use of the zero-length array language
> > > > extension to the C90 standard, but the preferred mechanism to declare
> > > > variable-length types such as these ones is a flexible array member[1][2],
> > > > introduced in C99:
> > > > 
> > > > struct foo {
> > > >         int stuff;
> > > >         struct boo array[];
> > > > };
> > > > 
> > > > By making use of the mechanism above, we will get a compiler warning
> > > > in case the flexible array does not occur last in the structure, which
> > > > will help us prevent some kind of undefined behavior bugs from being
> > > > inadvertently introduced[3] to the codebase from now on.
> > > > 
> > > > Also, notice that, dynamic memory allocations won't be affected by
> > > > this change:
> > > > 
> > > > "Flexible array members have incomplete type, and so the sizeof operator
> > > > may not be applied. As a quirk of the original implementation of
> > > > zero-length arrays, sizeof evaluates to zero."[1]
> > > > 
> > > > This issue was found with the help of Coccinelle.
> > > 
> > > Looks good to me. Thanks, Gustavo!
> > >  
> > > Reviewed-by: Dexuan Cui <decui@microsoft.com>
> > > 
> > 
> > Lorenzo, will you be picking up this patch? It seems to me you've been
> > handling patches to pci-hyperv.c. This patch is not yet in pci/hv branch
> > in your repository.
> > 
> > Let me know what you think.
> 
> I shall pick it up, I checked patchwork and it was erroneously
> assigned to Bjorn, that's why I have not taken it yet.
> 
> Fixed now, apologies, I will merge it shortly.

Thanks for picking it up.

Wei.

> 
> Lorenzo
