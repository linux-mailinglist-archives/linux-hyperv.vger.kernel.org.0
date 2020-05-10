Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC05A1CCB0B
	for <lists+linux-hyperv@lfdr.de>; Sun, 10 May 2020 14:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbgEJM2m (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 10 May 2020 08:28:42 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38956 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726863AbgEJM2m (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 10 May 2020 08:28:42 -0400
Received: by mail-wr1-f65.google.com with SMTP id l18so7319327wrn.6;
        Sun, 10 May 2020 05:28:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VJbyXfWi9FQgLlFDAkij90Rn6aY2QPKr+8He+pNm/PA=;
        b=sOhtbf6jF+Zi9T2X0Ts/fcce1n4TKdZBbNPgYOTSs3LXoprsJVQFC16eOquT4WWRVi
         cHukm7FSIDBjw/soNcTIXLvy6xzKpgfQWrdrQZVUQHDpJHK3uqKiPa0hGj6VindaLW04
         bZ2uznS83DMGKCzgG97dKurAYsas11ww6uI62BelwARHOLANmbtjXkSOrOxOV95O2D+7
         UWsWVmJ5H2AD/W5ZuIaA0J4+wJ8UxHaadxwMNYIWKhC0y99lisRNZdvD0JAFb2EyTNK3
         iYLhdyW+OMx7m+1DaJyJjTN5iaE9TYF5BV2YVKiwIzzhaztAbubmcopCcNxRYDAPO9os
         vMpQ==
X-Gm-Message-State: AGi0Pua/SXdH1g81dtAML+BTo8fa5qipi9DscPTUxjHlH91ez1zxawEY
        ZKOs2MyTnrAwWg0LG7CCV3s=
X-Google-Smtp-Source: APiQypI9xbd5NEcCh/UKN3POjsbnNaU8r9yavybe7c7ELy6umyyduVpl7a5AHBlA/8w8W266NKKrgw==
X-Received: by 2002:a5d:51cb:: with SMTP id n11mr12993864wrv.236.1589113718953;
        Sun, 10 May 2020 05:28:38 -0700 (PDT)
Received: from debian (44.142.6.51.dyn.plus.net. [51.6.142.44])
        by smtp.gmail.com with ESMTPSA id q74sm15257882wme.14.2020.05.10.05.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2020 05:28:38 -0700 (PDT)
Date:   Sun, 10 May 2020 13:28:36 +0100
From:   Wei Liu <wei.liu@kernel.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vmbus: Replace zero-length array with flexible-array
Message-ID: <20200510122836.7mvrfhdshrfzqyth@debian>
References: <20200507185323.GA14416@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507185323.GA14416@embeddedor>
User-Agent: NeoMutt/20180716
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, May 07, 2020 at 01:53:23PM -0500, Gustavo A. R. Silva wrote:
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
> sizeof(flexible-array-member) triggers a warning because flexible array
> members have incomplete type[1]. There are some instances of code in
> which the sizeof operator is being incorrectly/erroneously applied to
> zero-length arrays and the result is zero. Such instances may be hiding
> some bugs. So, this work (flexible-array member conversions) will also
> help to get completely rid of those sorts of issues.
> 
> This issue was found with the help of Coccinelle.
> 
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Applied to hyperv-next.

Thanks.
