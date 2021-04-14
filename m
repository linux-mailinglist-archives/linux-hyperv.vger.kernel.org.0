Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4D035F76E
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 Apr 2021 17:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350243AbhDNPQK (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 14 Apr 2021 11:16:10 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]:34725 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350221AbhDNPP5 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 14 Apr 2021 11:15:57 -0400
Received: by mail-wm1-f42.google.com with SMTP id n11-20020a05600c4f8bb029010e5cf86347so2758170wmq.1;
        Wed, 14 Apr 2021 08:15:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mOrRpmbd/M6QwuGhrFGhWB9U/poLWrU93GphgE/wg0g=;
        b=NWehfkUshGpFx7P/x+NjCD1L01BYpct1p3DmbP5Ao9oem/+SW061BzED9r0PkhzazS
         PWzTeugvPC2CKk14EKtH/2xYEurRypAjst8ruhL/mzHKCXa+2+so38d4KCsYH+NNHsWr
         sD12Ygg2rSOQy/PnAamCYzxYp39rJFkxt621z83bNjREdqQ+azC9sPDucUpash8RYtwl
         qIRYZcHD3A3gc69jKyMl4nBR5QZ1r4VLhpKeMXRyNI3wacyL4z2UaCsC+XW4maeyjVyj
         G2IM7AtHLNxfDomQakFfXA67UZpjVSOFMISzEhnMvA1UNSnadJ9HJcNoYc0Nio1Tyo7T
         zKkQ==
X-Gm-Message-State: AOAM533PNXM/FLl/GMPt2XxbbVQphh+4d9qu/Sc2DTz24mpWcury/HnL
        65XcntPlPx1ie4h3PoZ8wFo=
X-Google-Smtp-Source: ABdhPJwYEomqhRoCu6n9VE6NwGrAIFmUCBmoett3v6LGozFsJ0saccLO4s8Pb1t59UPGIigWRUwW+g==
X-Received: by 2002:a1c:1bd0:: with SMTP id b199mr3421824wmb.127.1618413335116;
        Wed, 14 Apr 2021 08:15:35 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id c2sm5457633wmr.22.2021.04.14.08.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 08:15:34 -0700 (PDT)
Date:   Wed, 14 Apr 2021 15:15:33 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Drivers: hv: vmbus: remove unused function
Message-ID: <20210414151533.zx7ciqfechv5xuwb@liuwe-devbox-debian-v2>
References: <1618381282-119135-1-git-send-email-jiapeng.chong@linux.alibaba.com>
 <MWHPR21MB15933A7D469B6FF2E60368A6D74E9@MWHPR21MB1593.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR21MB15933A7D469B6FF2E60368A6D74E9@MWHPR21MB1593.namprd21.prod.outlook.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Apr 14, 2021 at 02:48:17PM +0000, Michael Kelley wrote:
> From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com> Sent: Tuesday, April 13, 2021 11:21 PM
[...]
> This function became unused as of commit 4226ff69a3df 
> ("vmbus: simplify hv_ringbuffer_read") on 7/17/2017.
> 
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>

Applied to hyperv-next. Thanks.

Wei.
