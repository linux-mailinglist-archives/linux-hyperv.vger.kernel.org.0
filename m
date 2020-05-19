Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA361D9DB2
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 May 2020 19:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729132AbgESRTJ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 19 May 2020 13:19:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:44726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729001AbgESRTI (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 19 May 2020 13:19:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA80B20709;
        Tue, 19 May 2020 17:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589908748;
        bh=XTf3GXvvKPis3qS60syTZxccwFz7ZD9sbAXlJXifamY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=chicMmrTiHVMnEkCiI/ijQjxwAyxygx1vrTAchl8JGL98z30Y6KgeXCPEr17gcM1A
         9A4Qt1W2gZTbAgbRLtlDdrZtL6HsbsnoJ+uVUQmcG6rf7elaJ5smVFOwjQudXNDecd
         iG80B2sOSKcYwgBCE8R9y6ZInrU7uBSuZTNRGhLM=
Date:   Tue, 19 May 2020 19:19:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     alexander.deucher@amd.com, chris@chris-wilson.co.uk,
        ville.syrjala@linux.intel.com, Hawking.Zhang@amd.com,
        tvrtko.ursulin@intel.com, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org,
        spronovo@microsoft.com, iourit@microsoft.com,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [RFC PATCH 1/4] gpu: dxgkrnl: core code
Message-ID: <20200519171906.GA1101627@kroah.com>
References: <20200519163234.226513-1-sashal@kernel.org>
 <20200519163234.226513-2-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519163234.226513-2-sashal@kernel.org>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, May 19, 2020 at 12:32:31PM -0400, Sasha Levin wrote:
> +/*
> + * Dxgkrnl Graphics Port Driver ioctl definitions
> + *
> + */
> +
> +#define LX_IOCTL_DIR_WRITE 0x1
> +#define LX_IOCTL_DIR_READ  0x2
> +
> +#define LX_IOCTL_DIR(_ioctl)	(((_ioctl) >> 30) & 0x3)
> +#define LX_IOCTL_SIZE(_ioctl)	(((_ioctl) >> 16) & 0x3FFF)
> +#define LX_IOCTL_TYPE(_ioctl)	(((_ioctl) >> 8) & 0xFF)
> +#define LX_IOCTL_CODE(_ioctl)	(((_ioctl) >> 0) & 0xFF)

Why create new ioctl macros, can't the "normal" kernel macros work
properly?

> +#define LX_IOCTL(_dir, _size, _type, _code) (	\
> +	(((uint)(_dir) & 0x3) << 30) |		\
> +	(((uint)(_size) & 0x3FFF) << 16) |	\
> +	(((uint)(_type) & 0xFF) << 8) |		\
> +	(((uint)(_code) & 0xFF) << 0))
> +
> +#define LX_IO(_type, _code) LX_IOCTL(0, 0, (_type), (_code))
> +#define LX_IOR(_type, _code, _size)	\
> +	LX_IOCTL(LX_IOCTL_DIR_READ, (_size), (_type), (_code))
> +#define LX_IOW(_type, _code, _size)	\
> +	LX_IOCTL(LX_IOCTL_DIR_WRITE, (_size), (_type), (_code))
> +#define LX_IOWR(_type, _code, _size)	\
> +	LX_IOCTL(LX_IOCTL_DIR_WRITE |	\
> +	LX_IOCTL_DIR_READ, (_size), (_type), (_code))
> +
> +#define LX_DXOPENADAPTERFROMLUID	\
> +	LX_IOWR(0x47, 0x01, sizeof(struct d3dkmt_openadapterfromluid))

<snip>

These structures do not seem to be all using the correct types for a
"real" ioctl in the kernel, so you will have to fix them all up before
this will work properly.

> +void ioctl_desc_init(void);

Very odd global name you are using here :)

Anyway, neat stuff, glad to see it posted, great work!

greg k-h
