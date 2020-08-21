Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3168524D6AA
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Aug 2020 15:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbgHUNzW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-hyperv@lfdr.de>); Fri, 21 Aug 2020 09:55:22 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:34948 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbgHUNzU (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 21 Aug 2020 09:55:20 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id EFF001C0BB3; Fri, 21 Aug 2020 15:55:17 +0200 (CEST)
Date:   Fri, 21 Aug 2020 15:53:40 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Sasha Levin <sashal@kernel.org>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, gregkh@linuxfoundation.org,
        iourit@microsoft.com, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 1/4] drivers: hv: dxgkrnl: core code
Message-ID: <20200821135340.GA4067@bug>
References: <20200814123856.3880009-1-sashal@kernel.org>
 <20200814123856.3880009-2-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200814123856.3880009-2-sashal@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri 2020-08-14 08:38:53, Sasha Levin wrote:
> Add support for a Hyper-V based vGPU implementation that exposes the
> DirectX API to Linux userspace.

NAK.

Kernel APIs should be documented. ... in tree and with suitable license.
	
> +int dxgadapter_init(struct dxgadapter *adapter, struct hv_device *hdev)
> +{
> +	int ret = 0;
> +	char s[80];
> +
> +	UNUSED(s);

What is going on here?

> +{
> +	struct dxgprocess_adapter *adapter_info = dxgmem_alloc(process,
> +							       DXGMEM_PROCESS_ADAPTER,
> +							       sizeof
> +							       (*adapter_info));

We normally use kernel functions in kernel code.

> +	dxgmutex_unlock(&device->adapter_info->device_list_mutex);

And you should not have private locking primitives, either.

> +bool dxghwqueue_acquire_reference(struct dxghwqueue *hwqueue)
> +{
> +	return refcount_inc_not_zero(&hwqueue->refcount);
> +}

Midlayers are evil.

Best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
