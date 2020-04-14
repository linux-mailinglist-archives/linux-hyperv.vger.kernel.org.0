Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71F401A8395
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Apr 2020 17:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440791AbgDNPnC (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 14 Apr 2020 11:43:02 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:32052
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2407442AbgDNPm4 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 14 Apr 2020 11:42:56 -0400
X-IronPort-AV: E=Sophos;i="5.72,382,1580770800"; 
   d="scan'208";a="345880051"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Apr 2020 17:42:50 +0200
Date:   Tue, 14 Apr 2020 17:42:50 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Colin King <colin.king@canonical.com>
cc:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] drivers: hv: remove redundant assignment to pointer
 primary_channel
In-Reply-To: <20200414152343.243166-1-colin.king@canonical.com>
Message-ID: <alpine.DEB.2.21.2004141742360.3023@hadrien>
References: <20200414152343.243166-1-colin.king@canonical.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



On Tue, 14 Apr 2020, Colin King wrote:

> From: Colin Ian King <colin.king@canonical.com>
>
> The pointer primary_channel is being assigned with a value that is never,

never -> never used :)

> The assignment is redundant and can be removed.
>
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/hv/channel_mgmt.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
> index ffd7fffa5f83..f7bbb8dc4b0f 100644
> --- a/drivers/hv/channel_mgmt.c
> +++ b/drivers/hv/channel_mgmt.c
> @@ -425,8 +425,6 @@ void hv_process_channel_removal(struct vmbus_channel *channel)
>
>  	if (channel->primary_channel == NULL) {
>  		list_del(&channel->listentry);
> -
> -		primary_channel = channel;
>  	} else {
>  		primary_channel = channel->primary_channel;
>  		spin_lock_irqsave(&primary_channel->lock, flags);
> --
> 2.25.1
>
>
