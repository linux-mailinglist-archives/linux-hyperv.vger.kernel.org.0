Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F292C25D0D4
	for <lists+linux-hyperv@lfdr.de>; Fri,  4 Sep 2020 07:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725892AbgIDFSK (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 4 Sep 2020 01:18:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:53368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725812AbgIDFSJ (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 4 Sep 2020 01:18:09 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A540A206F2;
        Fri,  4 Sep 2020 05:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599196689;
        bh=8WMM6ebQyBfAmzNXp8LFPgkcHhEeM2jeF3KXNZePTII=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a6tlkrcv5egcCzWCQdxwiBbij1LxIf70Ln1u5wpQJWPFstF1nDB4Rf57PGeJlrcrJ
         haWTxIQtnIK6XP75na0gLy/2hAwiIKZ25k4906FIhaCher+UnvHjYzRhCQAvPRmrGr
         yA0Mewhi8N9BMt5zfUrZU2kZeGra+1NzgZt8/D58=
Date:   Fri, 4 Sep 2020 07:18:30 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Iouri Tarassov <iourit@linux.microsoft.com>
Cc:     Pavel Machek <pavel@denx.de>, Sasha Levin <sashal@kernel.org>,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, iourit@microsoft.com,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        spronovo@microsoft.com
Subject: Re: [PATCH 1/4] drivers: hv: dxgkrnl: core code
Message-ID: <20200904051830.GA2231475@kroah.com>
References: <20200814123856.3880009-1-sashal@kernel.org>
 <20200814123856.3880009-2-sashal@kernel.org>
 <20200821135340.GA4067@bug>
 <054abab3-748e-c56b-526a-1b1734a9eaf7@linux.microsoft.com>
 <20200828061840.GE56396@kroah.com>
 <f68415b4-f76d-680a-cc4f-2647fe54e538@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f68415b4-f76d-680a-cc4f-2647fe54e538@linux.microsoft.com>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Sep 03, 2020 at 02:39:05PM -0700, Iouri Tarassov wrote:
> Hi Greg,
> 
> On 8/27/2020 11:18 PM, Greg KH wrote:
> > On Thu, Aug 27, 2020 at 05:25:23PM -0700, Iouri Tarassov wrote:
> > > > > +bool dxghwqueue_acquire_reference(struct dxghwqueue *hwqueue)
> > > > > +{
> > > > > +	return refcount_inc_not_zero(&hwqueue->refcount);
> > > > > +}
> > > > > > Midlayers are evil.
> > > I strongly agree in general, but think that in our case the layers are very
> > > small. It allows to quickly find all places where a reference/dereference on
> > > an object is done and addition of debug tracing to catch errors.
> > 
> > Again, no, please remove all layers like this.  They just make it
> > impossible for others to review and understand the code over time.
> > 
> > Also, in this specific case, it would have allowed me to easily realize
> > that you are doing this type of call incorrectly and should be using a
> > different data structure :)
> 
> Are you suggesting that the current code is incorrect? Could you comment
> what changes need to be done?

You should be using the built-in reference counting object (a kref) and
not trying to roll your own as you did here.  That way we "know" you got
the logic right and do not have to audit your codebase to prove that
your hand-made one is correct.

thanks,

greg k-h
