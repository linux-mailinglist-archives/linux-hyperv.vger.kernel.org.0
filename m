Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BCAB3C89C4
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 Jul 2021 19:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbhGNRaO (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 14 Jul 2021 13:30:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:58404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229600AbhGNRaN (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 14 Jul 2021 13:30:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EC161613BE;
        Wed, 14 Jul 2021 17:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626283641;
        bh=RQHO6DIs5uGncRboQ2yR83gOYkw1pt+W3tetAN9kcsk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mptOodHIDmcFzM2ytGCPwTES7Zq4iBoAk+ky2t0TvVg0itYuM7sJ7hGhPIdrbcMb7
         bpF+3/D1rlZ0wGj02/kVWVEjAJg9R6EnLbnbPm/2YhNjrnLoYMJBQ3iYq5cePlnaBG
         eFNNMMt5WIXBiBg95eK0/d349cYOXl1RYXqOvRcY=
Date:   Wed, 14 Jul 2021 19:27:18 +0200
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
Subject: Re: [Patch v3 2/3] Drivers: hv: add Azure Blob driver
Message-ID: <YO8edjd9/2bDz3sO@kroah.com>
References: <1626230722-1971-1-git-send-email-longli@linuxonhyperv.com>
 <1626230722-1971-3-git-send-email-longli@linuxonhyperv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1626230722-1971-3-git-send-email-longli@linuxonhyperv.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Jul 13, 2021 at 07:45:21PM -0700, longli@linuxonhyperv.com wrote:
> From: Long Li <longli@microsoft.com>
> 
> Azure Blob storage provides scalable and durable data storage for Azure.
> (https://azure.microsoft.com/en-us/services/storage/blobs/)
> 
> This driver adds support for accelerated access to Azure Blob storage. As an
> alternative to REST APIs, it provides a fast data path that uses host native
> network stack and secure direct data link for storage server access.

Where is the userspace code that interacts with this driver through your
custom ioctl interface?

thanks,

greg k-h
