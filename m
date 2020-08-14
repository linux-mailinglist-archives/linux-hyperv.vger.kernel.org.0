Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92AAB244A04
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Aug 2020 14:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbgHNMzH (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 14 Aug 2020 08:55:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:56062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726313AbgHNMzG (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 14 Aug 2020 08:55:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3C622087D;
        Fri, 14 Aug 2020 12:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597409706;
        bh=gw7rdxx7qRx6ls9E5NgLwr5dfYEgtMjHhpG+X4+ZMNQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zpGs7qmzEQT7OcQlDZTfqYPK9uYlu8FApfGV+1wC6vlVyojHb8266I4ZviTV45lHm
         iL0t6iF0wj1rTjUHdJjixr4lr2HjlVnmgwgyD2CKfRouGiNqcKnEK0WxB59G8SIRkS
         kCYzZRi4NEOOBt6LIYKMXLKTG9FhGGDigCFMZT2o=
Date:   Fri, 14 Aug 2020 14:55:28 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, iourit@microsoft.com,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 1/4] drivers: hv: dxgkrnl: core code
Message-ID: <20200814125528.GA56456@kroah.com>
References: <20200814123856.3880009-1-sashal@kernel.org>
 <20200814123856.3880009-2-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200814123856.3880009-2-sashal@kernel.org>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Aug 14, 2020 at 08:38:53AM -0400, Sasha Levin wrote:
> Add support for a Hyper-V based vGPU implementation that exposes the
> DirectX API to Linux userspace.
> 
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Better, but what is this mess:

> +#define ISERROR(ret)					(ret < 0)

?

> +#define EINTERNALERROR					EINVAL

And that?

> +
> +#define DXGKRNL_ASSERT(exp)
> +#define UNUSED(x) (void)(x)

Ick, no, please.

> +#undef pr_fmt

In a .h file?

> +#define pr_fmt(fmt)	"dxgk:err: " fmt
> +#define pr_fmt1(fmt)	"dxgk: " fmt
> +#define pr_fmt2(fmt)	"dxgk:    " fmt

Why?

> +
> +#define DXGKDEBUG 1
> +/* #define USEPRINTK 1 */
> +
> +#ifndef DXGKDEBUG
> +#define TRACE_DEBUG(...)
> +#define TRACE_DEFINE(...)
> +#define TRACE_FUNC_ENTER(...)
> +#define TRACE_FUNC_EXIT(...)

No, please do not to custom "trace" printk messages, that is what ftrace
is for, no individual driver should ever need to do that.

Just use the normal dev_*() calls for error messages and the like, do
not try to come up with a custom tracing framework for one tiny
individual driver.  If every driver in kernel did that, we would have a
nightmare...

thanks,

greg k-h
