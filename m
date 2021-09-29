Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B70EC41C625
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Sep 2021 15:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344360AbhI2N5x (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 29 Sep 2021 09:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244589AbhI2N5t (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 29 Sep 2021 09:57:49 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5152AC061768;
        Wed, 29 Sep 2021 06:56:03 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id bd28so8968561edb.9;
        Wed, 29 Sep 2021 06:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Sxcdm4+gr+uFVFw9+vfSgdTzx/pDv0j7O/Mzf1AStEw=;
        b=FvFox01IyLQ/CP6zWAocb6ZVnsjejgL4SFAuP7CM4+SDbFKJJF9t6Tzg8A3I7FVnF7
         Qb1MlTfkqOAw+JWVTXXGruMbbTZ3o3YYuIFwQ5UdTrh8yRXGBQKP16evuCLti6ibW6+t
         XDuA0evO7X7Eh9VZ6D6oADz41SYEjEtNJtHssROd4ZWYkGqI95Zqb6YrXGe1P26s6PXn
         WH4R1y8MD7Onj2njbhnvstgJbGfEGo5jj0Vt8lw3SHevvgnI/EWf/jmdHULAhXYiE1ad
         CxwUqtjwCaOR+Dk7tFbjP6T9PYeHdUyhhlNsIX3laMQ9tSp8zH8QxeKLeGoKuFmABijF
         XMqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Sxcdm4+gr+uFVFw9+vfSgdTzx/pDv0j7O/Mzf1AStEw=;
        b=DoqDzBzs4CJYtTn2F4IOuXhZDDOLhmIZ+Tt3N+jHt7Z7IGtef37DrR3FN0ZIrJ4HJ+
         OLDaXy2vlLagsQWqI9HReGEPZjwEmOk68HwTVW5LzD+KDyDW1yDOj+RSeJ9N3pWJ+gBg
         p/f3tEkVVWcBGYyHLiSktE0FQpLCH1nVauryyNE26QkhAgNNkdEM3qwJQd2nAinVKR1O
         szWcw1DS//A/iNcpoIW/EChcUoxCdahTsQMikejGoN/WWI0/2mtjBUF7sV/YCfVePt+i
         XNqErfpn/1D+NqO+5JhMB66sjUHxmzYLIKTgt3KXcZjiLEqFFyhX1gETxEyfKoIM83Rc
         YAkA==
X-Gm-Message-State: AOAM53004p0V2/h9trl5G7PJBzlojjHfv3syQ8R/KrHRCVLUZI3AMOVv
        Dx1R78pQ8ZfYSf9Bx/TfHex/ZhmSbk2EMg==
X-Google-Smtp-Source: ABdhPJyHRpbjQJBh+TdNwmm7dPCq8vMsaSopyGbXuk9BvP4vT/SsUAOKXoKX0BMTjADKl88UvVo+Og==
X-Received: by 2002:a17:906:4310:: with SMTP id j16mr13967048ejm.48.1632923756586;
        Wed, 29 Sep 2021 06:55:56 -0700 (PDT)
Received: from anparri (host-79-49-65-228.retail.telecomitalia.it. [79.49.65.228])
        by smtp.gmail.com with ESMTPSA id l10sm1618024edr.14.2021.09.29.06.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 06:55:56 -0700 (PDT)
Date:   Wed, 29 Sep 2021 15:55:48 +0200
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Haiyang Zhang <haiyangz@microsoft.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>
Subject: Re: [RFC PATCH] scsi: storvsc: Fix validation for unsolicited
 incoming packets
Message-ID: <20210929135508.GA3258@anparri>
References: <20210928163732.5908-1-parri.andrea@gmail.com>
 <BN8PR21MB128430486E2F07EA71A7FCBDCAA89@BN8PR21MB1284.namprd21.prod.outlook.com>
 <BN8PR21MB1284DC9279AC61FE0C267C5ACAA99@BN8PR21MB1284.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN8PR21MB1284DC9279AC61FE0C267C5ACAA99@BN8PR21MB1284.namprd21.prod.outlook.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> > The patch looks good. But for readability, I'd suggested put the length
> > checks together like this:
> > 
> > 	u32 minlen = rqst_id ? sizeof(struct vstor_packet) -
> > 		stor_device->vmscsi_size_delta : VSTOR_MIN_UNSOL_PKT_SIZE;
> > 
> > 	if (pktlen < minlen) {
> > 		dev_err(&device->device,
> > 			   "Invalid pkt: id=%llu, len=%u, minlen=%u\n",
> > 			   rqst_id, pktlen, minlen);
> > 		continue;
> > 	}
> > 
> > Thanks.
> > 
> > Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> The tag was meant to be:
> Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>

Thank you, Haiyang.  I'll update as suggested.

  Andrea
