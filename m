Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76F583E1B5D
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Aug 2021 20:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241270AbhHESd3 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 5 Aug 2021 14:33:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:60848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241267AbhHESd2 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 5 Aug 2021 14:33:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AB26C6024A;
        Thu,  5 Aug 2021 18:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628188394;
        bh=Vnb2zcxGZEUexMV2u0dJ0rRLWcI7bnDKV6XRlcLWR9E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z9W8hNUJp8lnnAeyXwWTxCG0RWta6sug3LqEdz4dRsTtNv0EeSU1/6+VnMPPeXL2y
         S2GQ2LUVFzDK7K438MVEn29b3QIv1ifxoyj/ElMfsJQtRUn1Eyx5WDS16zbNFCcWgB
         cjHOTTbrpjFv5tfPA2gPMmfZFXucQ0GHgF6fTxjk=
Date:   Thu, 5 Aug 2021 20:33:11 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Long Li <longli@microsoft.com>
Cc:     "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andra Paraschiv <andraprs@amazon.com>,
        Siddharth Gupta <sidgup@codeaurora.org>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [Patch v5 0/3] Introduce a driver to support host accelerated
 access to Microsoft Azure Blob for Azure VM
Message-ID: <YQwu5z3fx0xhqz3W@kroah.com>
References: <1628146812-29798-1-git-send-email-longli@linuxonhyperv.com>
 <YQuOca6cmsY/CIiW@kroah.com>
 <BY5PR21MB1506213A9BBC8285C01D1EB3CEF29@BY5PR21MB1506.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY5PR21MB1506213A9BBC8285C01D1EB3CEF29@BY5PR21MB1506.namprd21.prod.outlook.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Aug 05, 2021 at 06:27:59PM +0000, Long Li wrote:
> > Subject: Re: [Patch v5 0/3] Introduce a driver to support host accelerated
> > access to Microsoft Azure Blob for Azure VM
> > 
> > On Thu, Aug 05, 2021 at 12:00:09AM -0700, longli@linuxonhyperv.com wrote:
> > > v5:
> > > Added problem statement and test numbers to patch 0
> > 
> > patch 0 does not show up in the changelog, please put that in the patch that
> > adds the driver, otherwise we will never see that information in the future.
> > 
> > thanks,
> > 
> > greg k-h
> 
> I will fix this.  Do you want me to send the v6, or re-spin v5?

If you fix a v5, that turns into v6, right?


