Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 155B93E0EE4
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Aug 2021 09:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235289AbhHEHIv (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 5 Aug 2021 03:08:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:49396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234841AbhHEHIu (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 5 Aug 2021 03:08:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 63F3560ED6;
        Thu,  5 Aug 2021 07:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628147316;
        bh=oh5CRxj5An6fM9CFsXRfU9AaBeUc2oXsAVcypDyyw2k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jeN+XB0sLH5fUjr4AhJ8K5rnlqXZHbHV1tH3RlLEXIv8foK3nci3ENmXFtG9zUiOi
         Y8NXW8GI3nQqiE/JhWxgp0NqquxBxuPINQsbnwrHxVwKDXletFtnzKD2te7U3qqCAb
         lmH1SzHIjTw6mEVdncnJ2oE5+6GzaiYf3giJ93kM=
Date:   Thu, 5 Aug 2021 09:08:33 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     longli@linuxonhyperv.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, Long Li <longli@microsoft.com>,
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
        Hannes Reinecke <hare@suse.de>
Subject: Re: [Patch v5 0/3] Introduce a driver to support host accelerated
 access to Microsoft Azure Blob for Azure VM
Message-ID: <YQuOca6cmsY/CIiW@kroah.com>
References: <1628146812-29798-1-git-send-email-longli@linuxonhyperv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1628146812-29798-1-git-send-email-longli@linuxonhyperv.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Aug 05, 2021 at 12:00:09AM -0700, longli@linuxonhyperv.com wrote:
> v5:
> Added problem statement and test numbers to patch 0

patch 0 does not show up in the changelog, please put that in the patch
that adds the driver, otherwise we will never see that information in
the future.

thanks,

greg k-h
