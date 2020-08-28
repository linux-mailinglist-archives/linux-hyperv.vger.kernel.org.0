Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3A3E255467
	for <lists+linux-hyperv@lfdr.de>; Fri, 28 Aug 2020 08:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgH1GRQ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 28 Aug 2020 02:17:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:37954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725849AbgH1GRP (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 28 Aug 2020 02:17:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 764A320707;
        Fri, 28 Aug 2020 06:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598595435;
        bh=VpecTDpZuJpFood9pl3sPXDL65hewM0IOGZZFWCt5pQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B/T+NalL7Tue/pKAq6kwz3chnBuFDvkIt2nXyZgj5CTmszp9OfCnTJ8apR7nsPmLE
         b4ywkgsrU1tkg+FIS5A9U8G0hzQ5KW7mQj8mgfG2C5GzhDeuHSEB1YZhw8adQBOq44
         3xeJqYCuwtiZIn7p4O1rObxWlp7jf3k4f72sQ5KA=
Date:   Fri, 28 Aug 2020 08:17:12 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Iouri Tarassov <iourit@linux.microsoft.com>
Cc:     Pavel Machek <pavel@denx.de>, Sasha Levin <sashal@kernel.org>,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, iourit@microsoft.com,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 1/4] drivers: hv: dxgkrnl: core code
Message-ID: <20200828061712.GD56396@kroah.com>
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
> > > +{
> > > +	struct dxgprocess_adapter *adapter_info = dxgmem_alloc(process,
> > > +							       DXGMEM_PROCESS_ADAPTER,
> > > +							       sizeof
> > > +							       (*adapter_info));
> > 
> > We normally use kernel functions in kernel code.
> Using a custom memory allocation function allows us to track memory
> allocations per DXGPROCESS and catch memory leaks when a DXGPROCESS is
> destroyed or when the driver is unloaded. It also allows to easily change
> the memory allocation implementation if needed.

There is only one "memory allocation implementation" in the kernel,
please use that and not any wrapper functions.  You wouldn't want to see
1000's of different memory allocation functions, each driver having a
unique one, right?

Remember, your code is becoming part of the larger kernel, so follow the
guidelines and rules of it.  There is nothing different from your code
and a serial port driver when it comes to these expectations.

thanks,

greg k-h
