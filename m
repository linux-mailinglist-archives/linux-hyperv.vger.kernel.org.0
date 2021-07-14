Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 189A63C89B4
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 Jul 2021 19:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239092AbhGNR2B (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 14 Jul 2021 13:28:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:57738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238965AbhGNR2B (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 14 Jul 2021 13:28:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 35887613BE;
        Wed, 14 Jul 2021 17:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626283508;
        bh=YBUexU/Ep0eKywTvM8VxRKUrG3cHCn5z4fR1WY9PWqM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BDPVKAxRLveTcv3zywzD93nr2gRlVIwU/Wr6cJDEza54bTHXuYqrpnfD44TWuHeDA
         LFfTS09Zxo3Aey86LAUOMtloDXAw0W1fZ12ziOv/O5zVC+hmUpjfMC3r2+0cdHzdhG
         c/qZUT7Jh7zU2V3ytw5qigWdKERtsb8kQpmzdD6E=
Date:   Wed, 14 Jul 2021 19:25:06 +0200
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
Message-ID: <YO8d8vn7z6VWqliB@kroah.com>
References: <1626230722-1971-1-git-send-email-longli@linuxonhyperv.com>
 <1626230722-1971-3-git-send-email-longli@linuxonhyperv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1626230722-1971-3-git-send-email-longli@linuxonhyperv.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

One final thing:

On Tue, Jul 13, 2021 at 07:45:21PM -0700, longli@linuxonhyperv.com wrote:
> +#define az_blob_dbg(fmt, args...) dev_dbg(&az_blob_dev.device->device, fmt, ##args)
> +#define az_blob_info(fmt, args...) dev_info(&az_blob_dev.device->device, fmt, ##args)
> +#define az_blob_warn(fmt, args...) dev_warn(&az_blob_dev.device->device, fmt, ##args)
> +#define az_blob_err(fmt, args...) dev_err(&az_blob_dev.device->device, fmt, ##args)

This tiny driver does not deserve a different loging scheme from all of
the rest of the kernel.  Just use the dev_* calls directly please, no
need to try to roll your own.  Especially for a 600 line file.

And remove your calls to az_blob_info() that are just debugging stuff,
when the driver is working properly, it is quiet.

thanks,

greg k-h
