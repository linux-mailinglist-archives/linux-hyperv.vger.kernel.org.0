Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 793C0244A09
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Aug 2020 14:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbgHNM5J (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 14 Aug 2020 08:57:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:56748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728224AbgHNM5J (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 14 Aug 2020 08:57:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5ED92087D;
        Fri, 14 Aug 2020 12:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597409827;
        bh=TP+P9nfWKVvkUwmjSCx4BCEcuRAeVQe+bmzohmFGECY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YaQueDJdQ8b8HIFDT4cXha3uhm5ghbDmGc4cJKFJjhIJuQ9r1L97wgehp7V0HIh6o
         AEjrINpDTxiJo/EKDf2yIiOZTh1s1x/VotefABzO4lq3H56zIfyl2bDE+4qMUnvVxv
         nPxlRF9X319+Dc6dSiXXUebrJJWmEtOZ7oUuQSkA=
Date:   Fri, 14 Aug 2020 14:57:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, iourit@microsoft.com,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 1/4] drivers: hv: dxgkrnl: core code
Message-ID: <20200814125729.GB56456@kroah.com>
References: <20200814123856.3880009-1-sashal@kernel.org>
 <20200814123856.3880009-2-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200814123856.3880009-2-sashal@kernel.org>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Aug 14, 2020 at 08:38:53AM -0400, Sasha Levin wrote:
> Add support for a Hyper-V based vGPU implementation that exposes the
> DirectX API to Linux userspace.

Api questions:

> +struct d3dkmthandle {
> +	union {
> +		struct {
> +			u32 instance	:  6;
> +			u32 index	: 24;
> +			u32 unique	: 2;

What is the endian of this?

> +		};
> +		u32 v;
> +	};
> +};
> +
> +extern const struct d3dkmthandle zerohandle;
> +
> +struct ntstatus {
> +	union {
> +		struct {
> +			int code	: 16;
> +			int facility	: 13;
> +			int customer	: 1;
> +			int severity	: 2;

Same here.

Are these things that cross the user/kernel boundry?

And why int on one and u32 on the other?

> +		};
> +		int v;
> +	};
> +};
> +
> +struct winluid {
> +	uint a;
> +	uint b;

And now uint?  Come on, be consistent please :)

thanks,

greg k-h
