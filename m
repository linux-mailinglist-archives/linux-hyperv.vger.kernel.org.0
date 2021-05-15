Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F80C3819B0
	for <lists+linux-hyperv@lfdr.de>; Sat, 15 May 2021 17:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbhEOPv4 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 15 May 2021 11:51:56 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:43718 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbhEOPvz (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 15 May 2021 11:51:55 -0400
Received: by mail-wr1-f52.google.com with SMTP id s8so2032581wrw.10;
        Sat, 15 May 2021 08:50:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ziuBJAu+Mb9fTP75gEpK2txrCbMrczSXcZOBd9igvIg=;
        b=s/owaGyZe/LHhW5UBTxALRDbHrGdO7BA0Y/G0lHFrc6E+nQ8OmyU9Wdq3OKPN8YMoU
         nADTf1SOu6lNJBXY6LauQJx4vhmAsLCCFTcOYHA6yAezW+bE8dU+Wwmuk43GoeJMK4VB
         WeXdfc8KS3LYT/QW1VpgV5W/1KT0gvojARyGnvO+uqz4RkG2n5YH0vQE4lP3Pajo6CnK
         zD/IqNH9COsUYIXQC5fIaBqucowh9hUJxArMrg7QX8oofkBaIKO+TCDjXvumy0L/i1O7
         tIlaIpl6nw3LwVmVo+B/fdcmVHXcQeFU3QjAiIeCoe3dVUvzSc0LcLylBJo9D/BzallJ
         qiBQ==
X-Gm-Message-State: AOAM53090O8uqY9umKOkc/k6LBx2pV2sOay+vmZOIkt4elTsl9GPHe3w
        OCqQZ9cnI6BhRXUBmuLxIVE=
X-Google-Smtp-Source: ABdhPJyylBUNnud2xcsQl9NBEBXIiMQhfDzN5PtD/YgJAvxcAGoLWuqIPWu3i9RhLQb9MKLq+h2RQg==
X-Received: by 2002:a5d:4561:: with SMTP id a1mr15912532wrc.55.1621093841125;
        Sat, 15 May 2021 08:50:41 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id k9sm7447863wmk.5.2021.05.15.08.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 May 2021 08:50:40 -0700 (PDT)
Date:   Sat, 15 May 2021 15:50:39 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, lkmlabelt@gmail.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] hv_utils: Fix passing zero to 'PTR_ERR' warning
Message-ID: <20210515155039.pf3q2vpxhov5afdp@liuwe-devbox-debian-v2>
References: <20210514070116.16800-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210514070116.16800-1-yuehaibing@huawei.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, May 14, 2021 at 03:01:16PM +0800, YueHaibing wrote:
> Sparse warn this:
> 
> drivers/hv/hv_util.c:753 hv_timesync_init() warn:
>  passing zero to 'PTR_ERR'
> 
> Use PTR_ERR_OR_ZERO instead of PTR_ERR to fix this.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied to hyperv-next. Thanks.
