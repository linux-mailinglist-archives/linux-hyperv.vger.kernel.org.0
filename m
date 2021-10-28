Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43FC143E029
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 Oct 2021 13:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbhJ1LpC (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 28 Oct 2021 07:45:02 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47]:38445 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbhJ1LpC (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 28 Oct 2021 07:45:02 -0400
Received: by mail-wm1-f47.google.com with SMTP id a20-20020a1c7f14000000b003231d13ee3cso9066393wmd.3;
        Thu, 28 Oct 2021 04:42:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aHQ+21TCN3tcMXyUYAQ0ctXGyvRyA01J7XaqgVcKLz8=;
        b=exm+zt+dRxcInfXk9ru2AsJplMr8vPqX8EGYgpTIX/IB67ENmzYaIba+Vj8XCIiTak
         6Sup7AcpFvU+7YedD8ecCeZQPcFKFkGa0q4w0U55UoQd8ulTGeHHX0XBk0QpIOVYRLy2
         apRAHjBQmzH91Vsa4H9jal38DnRspgyEnponsi6nMjxuRnSKy5ug+wJv8xgALy//7Ufa
         i/JPc3HokTZV5dzAd2ATlVfPv+hpg3b8Q5mVJ3Evc9Nzih6qU9Fo984xghJELsMtjJKN
         nThtsYCuEQVVn9U1P7MwJdu86s/SXtjSZkPPyMiAmtG/0BhNlTmF83HxzRXDSmKT7vQ5
         Yb4A==
X-Gm-Message-State: AOAM531aY4h70qZVevn3kr05lR3IkdggiPjWc3NwmbCrxQ/oMLlhwxZ7
        qMeNuIRBatA98rySESaTA70=
X-Google-Smtp-Source: ABdhPJyYayA2lHNwl8ku/9Mz9oheUtp8rVP7s8NM9O0H288Q48T7VoUYhXQF2NGaiZgvI+HnvKxtzA==
X-Received: by 2002:a1c:2785:: with SMTP id n127mr3833667wmn.155.1635421354755;
        Thu, 28 Oct 2021 04:42:34 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id p12sm3066706wrr.67.2021.10.28.04.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 04:42:34 -0700 (PDT)
Date:   Thu, 28 Oct 2021 11:42:33 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     cgel.zte@gmail.com
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lv Ruyi <lv.ruyi@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>,
        Tianyu.Lan@microsoft.com
Subject: Re: [PATCH] Drivers: hv : vmbus: Adding NULL pointer check
Message-ID: <20211028114233.nebhfxgait6qy2xa@liuwe-devbox-debian-v2>
References: <20211028104138.14576-1-lv.ruyi@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211028104138.14576-1-lv.ruyi@zte.com.cn>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Oct 28, 2021 at 10:41:38AM +0000, cgel.zte@gmail.com wrote:
> From: Lv Ruyi <lv.ruyi@zte.com.cn>
> 
> This patch fixes the following Coccinelle warning:
> drivers/hv/ring_buffer.c:223: alloc with no test
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
> ---
>  drivers/hv/ring_buffer.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/hv/ring_buffer.c b/drivers/hv/ring_buffer.c
> index 931802ae985c..4ef5c3771079 100644
> --- a/drivers/hv/ring_buffer.c
> +++ b/drivers/hv/ring_buffer.c
> @@ -223,6 +223,8 @@ int hv_ringbuffer_init(struct hv_ring_buffer_info *ring_info,
>  		pages_wraparound = kcalloc(page_cnt * 2 - 1,
>  					   sizeof(struct page *),
>  					   GFP_KERNEL);
> +		if (!pages_wraparound)
> +			return -ENOMEM;
>  

(CC Tianyu)

This hunk appears to have been mistakenly deleted by Tianyu's IVM patch
set.

Thanks for noticing this.

Applied to hyperv-next. No "fixes@ tag needed here.

Wei.

>  		pages_wraparound[0] = pages;
>  		for (i = 0; i < 2 * (page_cnt - 1); i++)
> -- 
> 2.25.1
> 
