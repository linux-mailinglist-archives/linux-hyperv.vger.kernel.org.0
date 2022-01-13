Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEFD748D321
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Jan 2022 08:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbiAMHqK (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 13 Jan 2022 02:46:10 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:37276 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbiAMHqJ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 13 Jan 2022 02:46:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0011361BF7;
        Thu, 13 Jan 2022 07:46:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E293C36AE3;
        Thu, 13 Jan 2022 07:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1642059968;
        bh=lpGDNOjF9PS4ksE1JbP35kchrQbMp1z3OOJmzOtFQr8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lDQ3A8NfxKXdOOY6FCt963ToivHNmAobE1x5iZgCj0rSy9DKon9Vf2b4HzMt5UcOc
         0N9WnVIHQfQl7Is4MWRWOpOC1eaKV8etTn1AhcNdeRVcHQ4p/db0/7++85D1lvVrNI
         25Mv3QVLfHzHHPhr31A/9ecfRw4mrRgPI74JG164=
Date:   Thu, 13 Jan 2022 08:46:05 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Iouri Tarassov <iourit@linux.microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, spronovo@microsoft.com
Subject: Re: [PATCH v1 1/9] drivers: hv: dxgkrnl: Driver initialization and
 creation of dxgadapter
Message-ID: <Yd/YvU5RQOAvLOhC@kroah.com>
References: <cover.1641937419.git.iourit@linux.microsoft.com>
 <1b26482b50832b95a9d8532c493cee6c97323b87.1641937419.git.iourit@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b26482b50832b95a9d8532c493cee6c97323b87.1641937419.git.iourit@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Jan 12, 2022 at 11:55:06AM -0800, Iouri Tarassov wrote:
> +	dev_dbg(dxgglobaldev, "%s: %x:%x %p %pUb\n",
> +		    __func__, adapter->luid.b, adapter->luid.a, hdev->channel,
> +		    &hdev->channel->offermsg.offer.if_instance);

When I see something like "global device pointer", that is a HUGE red
flag.

No driver should ever have anything that is static to the driver like
this, it should always be per-device.  Please use the correct device
model here, which does not include a global pointer, but rather unique
ones that are given to you by the driver core.  That way you are never
tied to only "one device per system" as that is a constraint that you
will have to fix eventually, might as well do it all correctly the first
time as it is not any extra effort to do so.

thanks,

greg k-h
