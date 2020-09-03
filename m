Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C91625C991
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Sep 2020 21:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729232AbgICTcL (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 3 Sep 2020 15:32:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:43524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729186AbgICTcJ (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 3 Sep 2020 15:32:09 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE58B20722;
        Thu,  3 Sep 2020 19:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599161528;
        bh=urgC3XANEqd0OtMfhUa14aYGKX59FNTKMoZUM/RdZNg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pd+LUsxNe52ZEcOcy7XM6gU3S3XAxJ0TlLFoHQ0qFIYKwrhFw8TCflvu6vlK+jdOm
         NTdmYwWz1LsLcwVkfDh3HkzlOj2sD2FQl2ALBdhXI5LxK1ljMSXNObQXJtC5WA2YGB
         XkFTk2jMTHTAijkpMsc8HjFZs7WXJdQpNr7150T8=
Date:   Thu, 3 Sep 2020 21:32:30 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Iouri Tarassov <iourit@linux.microsoft.com>
Cc:     Sasha Levin <sashal@kernel.org>, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org,
        iourit@microsoft.com, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, spronovo@microsoft.com
Subject: Re: [PATCH 1/4] drivers: hv: dxgkrnl: core code
Message-ID: <20200903193230.GA2044018@kroah.com>
References: <20200814123856.3880009-1-sashal@kernel.org>
 <20200814123856.3880009-2-sashal@kernel.org>
 <20200814130406.GC56456@kroah.com>
 <cfb9eb69-24f9-2a0c-1f1b-9204c6666aa8@linux.microsoft.com>
 <20200828061257.GB56396@kroah.com>
 <d8f6ed37-11dc-1103-8908-ad79482a4694@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d8f6ed37-11dc-1103-8908-ad79482a4694@linux.microsoft.com>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Sep 03, 2020 at 11:55:16AM -0700, Iouri Tarassov wrote:
> Hi Greg,
> 
> I appreciate your comments and working to address them.
> 
> On 8/27/2020 11:12 PM, Greg KH wrote:
> > As for "matching names", why does that matter?  Who sees both names at
> > the same time?
> > 
> > > > > > endian issues?
> > > > > > If not, why are these bit fields?
> > > This matches the definition on the Windows side. Windows only works on
> > > little endian platforms.
> > 
> > But Linux works on both, so you need to properly document/handle this somehow.
> This driver works only in a Linux container in conjunction with the Windows
> host. The structure definitions are  the same on the host and the container.
> The driver will not be enabled or work on platforms, where Windows does not
> run.

That's fine, you can create your structures in a way that works no
matter what endian is in use, in very simple ways.  Don't rely on
bit fields like this in a structure to actually work the way you think
they work (hint, compilers hate them and do horrible things with them
usually...)

So do it that way please, especially for when you are passing things
across the user/kernel boundry.  It's much simpler and easier to do it
right now, than to have to fix it up later.

thanks,

greg k-h
