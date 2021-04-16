Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18343361E03
	for <lists+linux-hyperv@lfdr.de>; Fri, 16 Apr 2021 12:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239295AbhDPKhw (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 16 Apr 2021 06:37:52 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:37494 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235292AbhDPKhv (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 16 Apr 2021 06:37:51 -0400
Received: by mail-wr1-f53.google.com with SMTP id j5so25245731wrn.4;
        Fri, 16 Apr 2021 03:37:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P+A7eG2xptzjgbsbSvyXQfGCX8bfwC+5K1b6fy+53iQ=;
        b=Y6garCGQTPPG41ejLOvvlBwxXwJjtNGp9A2eI9LcX8wSDofcSNe88dS6EXSIZaycR7
         dvb/CRIAd6N93BaiaF466cVmaHJFoZNbeAYqYn1puZNLpVdOGeO1G2fH9IyFhSn2j6uv
         6iL2023QT+WQPWn8GpbYwy9ik6Jxse1nZROR16fA4gp71c6TSpLhADVzqVhOvCyb10ML
         3L5nHMVSxROkoW60ditxaPTXiEsKFGCidcedkI+W1mfNqE0Z5ECx8TaNguA+13LX9wCQ
         30mexfAnOHNnaOBowPFn0DRNSBL5diLLwyMBFfbXGSTp6qOZmNyKxpZP+3VOEMCErUP4
         mdlQ==
X-Gm-Message-State: AOAM532cynuRnyR/CmHkilC2DIGBV10WNjTJS4lnVIh17dr8kmjyDuT5
        SjYHo0Wlw6xgbA8rtAwrNEHWXqzKyh4=
X-Google-Smtp-Source: ABdhPJy4e4WGoztuHaP/Faw1E88xX/1PqKXlrwj5+H8nmp+omFyhbTiR7gcOqkpohHVCVXq/eizXtw==
X-Received: by 2002:a5d:6c62:: with SMTP id r2mr3159155wrz.37.1618569445807;
        Fri, 16 Apr 2021 03:37:25 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id g84sm8528560wmf.30.2021.04.16.03.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 03:37:25 -0700 (PDT)
Date:   Fri, 16 Apr 2021 10:37:24 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Andrea Parri <parri.andrea@gmail.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dexuan Cui <decui@microsoft.com>, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] Drivers: hv: vmbus: Use after free in __vmbus_open()
Message-ID: <20210416103724.f3unhyu72pbp2qr3@liuwe-devbox-debian-v2>
References: <YHV3XLCot6xBS44r@mwanda>
 <20210413154221.GA2369@anparri>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210413154221.GA2369@anparri>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Apr 13, 2021 at 05:42:21PM +0200, Andrea Parri wrote:
> On Tue, Apr 13, 2021 at 01:50:04PM +0300, Dan Carpenter wrote:
> > The "open_info" variable is added to the &vmbus_connection.chn_msg_list,
> > but the error handling frees "open_info" without removing it from the
> > list.  This will result in a use after free.  First remove it from the
> > list, and then free it.
> > 
> > Fixes: 6f3d791f3006 ("Drivers: hv: vmbus: Fix rescind handling issues")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> I had this 'queued' in my list,
> 
> Reviewed-by: Andrea Parri <parri.andrea@gmail.com>

Applied. Thanks.
