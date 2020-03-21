Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 606B518E2DE
	for <lists+linux-hyperv@lfdr.de>; Sat, 21 Mar 2020 17:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbgCUQ0e (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 21 Mar 2020 12:26:34 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35961 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbgCUQ0e (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 21 Mar 2020 12:26:34 -0400
Received: by mail-wm1-f65.google.com with SMTP id g62so9764732wme.1;
        Sat, 21 Mar 2020 09:26:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GuIqERTR3t0coAsUD7Xv8E642UJWezc6SO06+7Y9t9o=;
        b=kBYU9f2G3g2T05In+0I+Te8Q0+FaYib/Z08p4nUB7pLQD+R+0st1OFUW3ONUq837X0
         +M18jnFYJwAPgS7tz9OReKH8iZQ9D+4zv+a/xZ7DvZZVkdFNZzyVd9o3bAVftqY+Hvvc
         AXjyLVS6zN6E7otr4vMwBe+cyrBRpVckcKcOMA8RZf302ypED0xOCpbzhk/oyOI7rPrX
         A6jX3O5OTvwKCudfiHn0DYJgaMJmBwuuvZ8fn2QEiGvi2/MJPoqkecK+P0jpvJVtACQ+
         9Bcs88zVsSzRfwpdb4OHYLHOGV/H8bFAPvfviRaZnLr+aFRcON4VcA/C6S38UlgosqPL
         hdnw==
X-Gm-Message-State: ANhLgQ1J0i0hqtMvNj//zMRuftg1g9nQ8Jwtu4R4AXCt9H7zys/u7yLy
        +eji8kfv/g/e+AGSfov6c/g=
X-Google-Smtp-Source: ADFU+vs81+eZkmrFoTsfi0dcYyhe3fjahZ2bTDKZ83PS6zZ/DARksABcXdX7c3rjONYB7NFJpllvRQ==
X-Received: by 2002:a1c:5604:: with SMTP id k4mr16262801wmb.57.1584807991960;
        Sat, 21 Mar 2020 09:26:31 -0700 (PDT)
Received: from debian (41.142.6.51.dyn.plus.net. [51.6.142.41])
        by smtp.gmail.com with ESMTPSA id g14sm13584389wme.32.2020.03.21.09.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2020 09:26:31 -0700 (PDT)
Date:   Sat, 21 Mar 2020 16:26:29 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] hv: hyperv_vmbus.h: Replace zero-length array with
 flexible-array member
Message-ID: <20200321162629.xjlpnw2oxx6r4yzg@debian>
References: <20200319213226.GA9536@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200319213226.GA9536@embeddedor.com>
User-Agent: NeoMutt/20180716
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Mar 19, 2020 at 04:32:26PM -0500, Gustavo A. R. Silva wrote:
> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:
> 
> struct foo {
>         int stuff;
>         struct boo array[];
> };
> 
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertently introduced[3] to the codebase from now on.
> 
> Also, notice that, dynamic memory allocations won't be affected by
> this change:
> 
> "Flexible array members have incomplete type, and so the sizeof operator
> may not be applied. As a quirk of the original implementation of
> zero-length arrays, sizeof evaluates to zero."[1]
> 
> This issue was found with the help of Coccinelle.
> 
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Queued, thanks.

Wei.
