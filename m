Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2779D3B71F5
	for <lists+linux-hyperv@lfdr.de>; Tue, 29 Jun 2021 14:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233626AbhF2MVT (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 29 Jun 2021 08:21:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:38618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233610AbhF2MVS (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 29 Jun 2021 08:21:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B791761D86;
        Tue, 29 Jun 2021 12:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624969130;
        bh=872Gg2Zmdh+gmSqjKfRbCr6B39qxF+MacSlFiVQN7QM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mvZ3PKvTp3ZR39pA3R9bsxYXDyZQDIdyCdoYveKxHv+8EyGtOU58Y7LFaH9R+IE/e
         OCOVrYHB9FEAvP5nupqEcNnzH/NujBMrObXyNNditVBpvBHGqeJbEIwsWPS4MjW3Gp
         qCtKGjDkf08JCvP8ngyowvxL/GE3abgJ4fgrwQ/4=
Date:   Tue, 29 Jun 2021 14:18:48 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     longli@linuxonhyperv.com, linux-kernel@vger.kernel.org,
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
        Hannes Reinecke <hare@suse.de>, linux-doc@vger.kernel.org
Subject: Re: [Patch v2 2/3] Drivers: hv: add Azure Blob driver
Message-ID: <YNsPqJNb1lAafi7U@kroah.com>
References: <1624689020-9589-1-git-send-email-longli@linuxonhyperv.com>
 <1624689020-9589-3-git-send-email-longli@linuxonhyperv.com>
 <YNq8p1320VkH2T/c@kroah.com>
 <0391b223-5f8e-42c0-35f2-a7ec337c55ac@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0391b223-5f8e-42c0-35f2-a7ec337c55ac@metux.net>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Jun 29, 2021 at 12:41:49PM +0200, Enrico Weigelt, metux IT consult wrote:
> On 29.06.21 08:24, Greg Kroah-Hartman wrote:
> 
> Hi folks,
> 
> > Again, no.
> > 
> > Just use dev_dbg(), dev_warn(), and dev_err() and there is no need for
> > anything "special".  This is just one tiny driver, do not rewrite logic
> > like this for no reason.
> 
> Maybe worth mentioning that we have the pr_fmt macro that can be
> defined if some wants to do things like adding some prefix.

No, no driver should mess with that, just use dev_*() calls instead
please.

greg k-h
