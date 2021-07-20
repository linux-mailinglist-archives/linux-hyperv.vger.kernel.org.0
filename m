Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 419B83CF3FC
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Jul 2021 07:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237640AbhGTEtd (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 20 Jul 2021 00:49:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:60852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237591AbhGTEtc (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 20 Jul 2021 00:49:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0BC866113A;
        Tue, 20 Jul 2021 05:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626759010;
        bh=PxxMUXlt0OImTQvDBWqMXD7xeBnFTjxInCApPpX5SP8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gYjt9zUGSdKsV4I3e38DzNL99uoMjBnPemVv/XomCNZyHzEMfrmsyP/PQ/oS/+hx+
         PhuOBlERNmsLokoZJOU02GF++QD/wzm+Xj1uwBxrJax9ecsTTq6Jo0BnBVZeSVF27h
         9NJoFE1mpmv5WelED/p+uCCtSErfe6YZ/OjoEMM0=
Date:   Tue, 20 Jul 2021 07:30:07 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     longli@linuxonhyperv.com
Cc:     linux-fs@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        Long Li <longli@microsoft.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andra Paraschiv <andraprs@amazon.com>,
        Siddharth Gupta <sidgup@codeaurora.org>,
        Hannes Reinecke <hare@suse.de>, linux-doc@vger.kernel.org
Subject: Re: [Patch v4 2/3] Drivers: hv: add Azure Blob driver
Message-ID: <YPZfX9RE4h8kAIv0@kroah.com>
References: <1626751866-15765-1-git-send-email-longli@linuxonhyperv.com>
 <1626751866-15765-3-git-send-email-longli@linuxonhyperv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1626751866-15765-3-git-send-email-longli@linuxonhyperv.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Jul 19, 2021 at 08:31:05PM -0700, longli@linuxonhyperv.com wrote:
> From: Long Li <longli@microsoft.com>
> 
> Azure Blob provides scalable, secure and shared storage services for Azure.
> 
> This driver adds support for accelerated access to Azure Blob storage. As an
> alternative to REST APIs, it provides a fast data path that uses host native
> network stack and direct data link for storage server access.
> 
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: "K. Y. Srinivasan" <kys@microsoft.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Stephen Hemminger <sthemmin@microsoft.com>
> Cc: Wei Liu <wei.liu@kernel.org>
> Cc: Dexuan Cui <decui@microsoft.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Maximilian Luz <luzmaximilian@gmail.com>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Ben Widawsky <ben.widawsky@intel.com>
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Cc: Andra Paraschiv <andraprs@amazon.com>
> Cc: Siddharth Gupta <sidgup@codeaurora.org>
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: linux-doc@vger.kernel.org
> Signed-off-by: Long Li <longli@microsoft.com>
> ---
>  .../userspace-api/ioctl/ioctl-number.rst      |   2 +
>  drivers/hv/Kconfig                            |  11 +
>  drivers/hv/Makefile                           |   1 +
>  drivers/hv/channel_mgmt.c                     |   7 +
>  drivers/hv/hv_azure_blob.c                    | 628 ++++++++++++++++++
>  include/linux/hyperv.h                        |   9 +
>  include/uapi/misc/hv_azure_blob.h             |  34 +
>  7 files changed, 692 insertions(+)
>  create mode 100644 drivers/hv/hv_azure_blob.c
>  create mode 100644 include/uapi/misc/hv_azure_blob.h
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/SubmittingPatches for what needs to be done
  here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
