Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C94325542D
	for <lists+linux-hyperv@lfdr.de>; Fri, 28 Aug 2020 08:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbgH1GBc (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 28 Aug 2020 02:01:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:54226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725849AbgH1GBb (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 28 Aug 2020 02:01:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C44220791;
        Fri, 28 Aug 2020 06:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598594491;
        bh=BUfH8WfAunZhF8fDtPUaM+v2rLlSiXdp/dFdKzj/AuE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lzwddw+QutyLPhpntRMPv0eTIEG3GvvQomBWL+4KVVVkJatqq3srm5gw3MpqJMDWt
         AZ9AssC4WQqVePCrOZ//hxANF6oGy0bAYqZubQyUMvSOMcA0XKuFsLm+VJbmb3Af4w
         HNiN6edWKP91sRb1YaAJIn5y8UoylQQFJrXLC21E=
Date:   Fri, 28 Aug 2020 08:01:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Iouri Tarassov <iourit@linux.microsoft.com>
Cc:     Sasha Levin <sashal@kernel.org>, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org,
        iourit@microsoft.com, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 1/4] drivers: hv: dxgkrnl: core code
Message-ID: <20200828060127.GA56396@kroah.com>
References: <20200814123856.3880009-1-sashal@kernel.org>
 <20200814123856.3880009-2-sashal@kernel.org>
 <20200814125528.GA56456@kroah.com>
 <58011269-e910-b3e4-2a3c-552b08c90574@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58011269-e910-b3e4-2a3c-552b08c90574@linux.microsoft.com>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Aug 27, 2020 at 04:29:59PM -0700, Iouri Tarassov wrote:
> On 8/14/2020 5:55 AM, Greg KH wrote:
> > On Fri, Aug 14, 2020 at 08:38:53AM -0400, Sasha Levin wrote:
> > > Add support for a Hyper-V based vGPU implementation that exposes the
> > > DirectX API to Linux userspace.
> > > > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > 
> > Better, but what is this mess:
> > 
> > > +#define ISERROR(ret)					(ret < 0)
> 
> The VM bus messages return the NTSTATUS error code from the host. NTSTATUS
> is integer and the positive values indicate success.
> The success error code needs to be returned by IOCTLs to the DxCore
> applications. The ISERROR() macro is used in places where the NTSTATUS
> success code could be returned from a function. "if (ret)" cannot be used. I
> will add a comment to the macro in the next patch.

No, please just "open code" this, there is no need for a macro that is
actually more characters than the original test.

> > > +#define DXGKDEBUG 1
> > > +/* #define USEPRINTK 1 */
> > > +
> > > +#ifndef DXGKDEBUG
> > > +#define TRACE_DEBUG(...)
> > > +#define TRACE_DEFINE(...)
> > > +#define TRACE_FUNC_ENTER(...)
> > > +#define TRACE_FUNC_EXIT(...)
> > 
> > No, please do not to custom "trace" printk messages, that is what ftrace
> > is for, no individual driver should ever need to do that.
> > 
> > Just use the normal dev_*() calls for error messages and the like, do
> > not try to come up with a custom tracing framework for one tiny
> > individual driver.  If every driver in kernel did that, we would have a
> > nightmare...
> I understand the concern. This will be fixed later when we learn and pick
> the final tracing technology for the driver.

When is "later"?  We don't want to review something that you do not
think is ready to be merged, do it now so we don't trip over things that
you know you want to fix up.

> The current implementation
> allows the hardware vendors to quickly identify issues without learning
> about ftrace. They just need to enable the WSL debug console and mount
> debugfs.

Hardware vendors who know Linux already know about ftrace, don't make
people have to read up and learn about custom ways to debug
just-your-tiny-individual-driver.  Instead follow the customs and ways
the _WHOLE_ kernel works, that is just polite, don't you think?

thanks,

greg k-h
