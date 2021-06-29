Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAAB93B6E3F
	for <lists+linux-hyperv@lfdr.de>; Tue, 29 Jun 2021 08:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbhF2G2E (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 29 Jun 2021 02:28:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:36360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231881AbhF2G2D (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 29 Jun 2021 02:28:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B865C61DAC;
        Tue, 29 Jun 2021 06:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624947936;
        bh=v5CNiYR427RWJetooOKgP+6bHuWbYp011prcBVR0AFw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z/SmX9dV6XhQZKYSwcOsVFMgcuZLH/UFQyFh+ax4FLThLredBAa2Nu6NiTlxusey6
         ji7YqdagXxrz+6WJCdl8XgSa7WWPz+sbYBeoTGhWp3EW1n4FaYsT1Ps5k7Ujs+gEbS
         3QEcXkmhBGAK8Ty6St8cw6AVL8E26FoeA3vr3ZNM=
Date:   Tue, 29 Jun 2021 08:25:34 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     longli@linuxonhyperv.com
Cc:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
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
Subject: Re: [Patch v2 2/3] Drivers: hv: add Azure Blob driver
Message-ID: <YNq83qS24pO9wVJk@kroah.com>
References: <1624689020-9589-1-git-send-email-longli@linuxonhyperv.com>
 <1624689020-9589-3-git-send-email-longli@linuxonhyperv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1624689020-9589-3-git-send-email-longli@linuxonhyperv.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Jun 25, 2021 at 11:30:19PM -0700, longli@linuxonhyperv.com wrote:
> @@ -0,0 +1,655 @@
> +// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause

If you _REALLY_ want to do this, please document _WHY_ you are doing
this in the changelog comment as dual-licensed Linux kernel code will
just cause you a lot of problems in the long run and we want to be sure
you understand all of the issues here and your managers agree with it.

thanks,

greg k-h
