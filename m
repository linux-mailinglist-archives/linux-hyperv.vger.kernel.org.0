Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A18A48D309
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Jan 2022 08:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232133AbiAMHlx (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 13 Jan 2022 02:41:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbiAMHlx (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 13 Jan 2022 02:41:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AFDFC06173F;
        Wed, 12 Jan 2022 23:41:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 714D561B7D;
        Thu, 13 Jan 2022 07:41:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EC49C36AE3;
        Thu, 13 Jan 2022 07:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1642059711;
        bh=+NMceGwl6EGTtzmN0RRnhn1/mfgf7g//LZJPhc4V0PY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fqfusI0lB4h4Wb3tQELe8BOzYPUdtadkUOJLUZvy5vMNES4dDYR1qXZDwL05mNnRY
         bExXyl9VTSGvQDFjF6pG+HkHs0lPmJgKGutuIdFy8j4/L19J0F72qpTKAasOktxecR
         CA33GpNweSrCnNiIO8HYKLjwE9Dm3MnscOfwKAwM=
Date:   Thu, 13 Jan 2022 08:41:49 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Iouri Tarassov <iourit@linux.microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, spronovo@microsoft.com
Subject: Re: [PATCH v1 9/9] drivers: hv: dxgkrnl: Implement DXGSYNCFILE
Message-ID: <Yd/Xvd147eh+OWlQ@kroah.com>
References: <cover.1641937419.git.iourit@linux.microsoft.com>
 <e04c8e820bc166d9d4fe8e388aace731bb3255b0.1641937420.git.iourit@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e04c8e820bc166d9d4fe8e388aace731bb3255b0.1641937420.git.iourit@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Jan 12, 2022 at 11:55:14AM -0800, Iouri Tarassov wrote:
> Implement the LX_DXCREATESYNCFILE IOCTL (D3DKMTCreateSyncFile).

Your subject line does not describe what this is doing at all, as we
have no clue what DXGSYNCFILE is.

thanks,

greg k-h
