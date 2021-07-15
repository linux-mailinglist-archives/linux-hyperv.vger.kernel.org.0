Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFBD3C9A6D
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 Jul 2021 10:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbhGOIX7 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 15 Jul 2021 04:23:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:44170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231991AbhGOIX7 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 15 Jul 2021 04:23:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4B7F761183;
        Thu, 15 Jul 2021 08:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626337265;
        bh=/W+ULFbU/BGI8YXIYShenS1pmj1qoEaLlFWsmFLl7Bw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZZyI55QaKobP2Xyj54SFFbu1ZordCei/pAfFDfdV9DFAg72303w4mnR1RSwNlV4/B
         kRNVEx1xnA8lMBAm06hJUjAAZr8EYGYKw9Q/SvSLjX0F+1iBCMpJfaI3ZL/WBFLfK4
         LRB1Myd7JB25qoaC79Elc+njHBkF7XRRSpfNR8no=
Date:   Thu, 15 Jul 2021 10:21:02 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     longli@linuxonhyperv.com
Cc:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        Long Li <longli@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
Subject: Re: [Patch v3 3/3] Drivers: hv: Add to maintainer for Azure Blob
 driver
Message-ID: <YO/v7mGn8ZWiqd7g@kroah.com>
References: <1626230722-1971-1-git-send-email-longli@linuxonhyperv.com>
 <1626230722-1971-4-git-send-email-longli@linuxonhyperv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1626230722-1971-4-git-send-email-longli@linuxonhyperv.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Jul 13, 2021 at 07:45:22PM -0700, longli@linuxonhyperv.com wrote:
> From: Long Li <longli@microsoft.com>
> 
> Add longli@microsoft.com to maintainer list for Azure Blob driver.
> 
> Cc: K. Y. Srinivasan <kys@microsoft.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Stephen Hemminger <sthemmin@microsoft.com>
> Cc: Wei Liu <wei.liu@kernel.org>
> Cc: Dexuan Cui <decui@microsoft.com>
> Signed-off-by: Long Li <longli@microsoft.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9487061..b547eb9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8440,6 +8440,7 @@ M:	Haiyang Zhang <haiyangz@microsoft.com>
>  M:	Stephen Hemminger <sthemmin@microsoft.com>
>  M:	Wei Liu <wei.liu@kernel.org>
>  M:	Dexuan Cui <decui@microsoft.com>
> +M:	Long Li <longli@microsoft.com>

You just added yourself to the maintainer of _all_ of the hyperv
drivers, was that intentional?

thanks,

greg k-h
