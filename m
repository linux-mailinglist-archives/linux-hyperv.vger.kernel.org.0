Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 402F725546A
	for <lists+linux-hyperv@lfdr.de>; Fri, 28 Aug 2020 08:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbgH1GSo (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 28 Aug 2020 02:18:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:38472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725849AbgH1GSn (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 28 Aug 2020 02:18:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 782C420707;
        Fri, 28 Aug 2020 06:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598595523;
        bh=RhUMnQR/kXBEykVPYYpsrcg0sCqPxQDS5P3aA5+w4dA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mOTc4jKc2rGw70rZ9w3sChP8+ed0thcpJYqNvXD5tzDP+L/iIyjqKSjnpFni128ij
         dy/ahZvwCiIK/CcZtNXV7jmHheLQldRLZ1FGJO+JSoECxvuJpyOCQsDE4jApddfsSd
         2t5bjj+Zl/q714R9+nOnDpq4g+yB5P291IoiP6lU=
Date:   Fri, 28 Aug 2020 08:18:40 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Iouri Tarassov <iourit@linux.microsoft.com>
Cc:     Pavel Machek <pavel@denx.de>, Sasha Levin <sashal@kernel.org>,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, iourit@microsoft.com,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 1/4] drivers: hv: dxgkrnl: core code
Message-ID: <20200828061840.GE56396@kroah.com>
References: <20200814123856.3880009-1-sashal@kernel.org>
 <20200814123856.3880009-2-sashal@kernel.org>
 <20200821135340.GA4067@bug>
 <054abab3-748e-c56b-526a-1b1734a9eaf7@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <054abab3-748e-c56b-526a-1b1734a9eaf7@linux.microsoft.com>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Aug 27, 2020 at 05:25:23PM -0700, Iouri Tarassov wrote:
> > > +bool dxghwqueue_acquire_reference(struct dxghwqueue *hwqueue)
> > > +{
> > > +	return refcount_inc_not_zero(&hwqueue->refcount);
> > > +}
> > 
> > Midlayers are evil.
> I strongly agree in general, but think that in our case the layers are very
> small. It allows to quickly find all places where a reference/dereference on
> an object is done and addition of debug tracing to catch errors.

Again, no, please remove all layers like this.  They just make it
impossible for others to review and understand the code over time.

Also, in this specific case, it would have allowed me to easily realize
that you are doing this type of call incorrectly and should be using a
different data structure :)

thanks,

greg k-h
