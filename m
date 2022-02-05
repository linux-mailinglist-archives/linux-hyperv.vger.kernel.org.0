Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 624574AA7AF
	for <lists+linux-hyperv@lfdr.de>; Sat,  5 Feb 2022 09:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbiBEIaZ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 5 Feb 2022 03:30:25 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:46234 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379678AbiBEIaZ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 5 Feb 2022 03:30:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0C887B8385B;
        Sat,  5 Feb 2022 08:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF439C340E8;
        Sat,  5 Feb 2022 08:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644049822;
        bh=njfNMQX7oG2Q5aX30H5rXM9VkPs10BGoY5vL9vum3l0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YbQ6C0JT/Sez1OVlLhsU0WGBcRQFM+WtjNEFRvViQabKBFXLC5R9id+yvqee2Tc5O
         wix9LZb1ih+GRWJX+zomMiwADgW1B2E2qkCaAWUC+9kcOX1C1+p6iwrz0iALxml600
         sopbdG5JCGJmlx+l9flewmbQi0LqXl0q+X5Hl51Q=
Date:   Sat, 5 Feb 2022 09:30:13 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Iouri Tarassov <iourit@linux.microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, spronovo@microsoft.com
Subject: Re: [PATCH v2 19/24] drivers: hv: dxgkrnl: Simple IOCTLs
 LX_DXESCAPE, LX_DXMARKDEVICEASERROR, LX_DXQUERYSTATISTICS,
 LX_DXQUERYCLOCKCALIBRATION
Message-ID: <Yf41lZtUntrb8V7Z@kroah.com>
References: <cover.1644025661.git.iourit@linux.microsoft.com>
 <07c352a82707304cc5836313b97dfd97be8c7354.1644025661.git.iourit@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07c352a82707304cc5836313b97dfd97be8c7354.1644025661.git.iourit@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Feb 04, 2022 at 06:34:17PM -0800, Iouri Tarassov wrote:

The subject line does not make sense, it is not a sentence.

>     These IOCTLs are logically simple:

What is "these"?

>     - input data is read
>     - a message is sent to the host
>     - the result is returned to the caller
> 
>     - LX_DXESCAPE (D3DKMTEscape)
>       This IOCTL is used to send/receive private data between user mode
>       driver and kernel mode driver. This is an extension of the WDDM APIs.
> 
>     - LX_DXMARKDEVICEASERROR (D3DKMTMarkDeviceAsError)
>       The IOCTL is used to bring the dxgdevice object to the error state.
>       Subsequent calls to use the device object will fail.
> 
>     - LX_DXQUERYSTATISTICS (D3DKMTQuerystatistics)
>       The IOCTL is used to query various statistics from the compute device
>       on the host.
> 
>     - LX_DXQUERYCLOCKCALIBRATION
>       The IOCTL queries clock from the compute device.

Why is this not broken up into one-patch-per-ioctl like I asked?

{sigh}

I'm not reviewing this anymore, please rework it.

thanks,

greg k-h
