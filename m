Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC5A3530FA
	for <lists+linux-hyperv@lfdr.de>; Sat,  3 Apr 2021 00:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbhDBWMQ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 2 Apr 2021 18:12:16 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:37638 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbhDBWMP (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 2 Apr 2021 18:12:15 -0400
Received: by mail-wr1-f44.google.com with SMTP id x16so5753114wrn.4;
        Fri, 02 Apr 2021 15:12:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9+8JeSS0odf4uG4Rtk112oLXdTErcuKdR3I5mU+HNh8=;
        b=BUc+DRQRzgFvy1RdyvHf371pqlvWaOiSDCK7ZGYemUZVjyoARtYSIbfrmnlLwzJmVI
         uT0aemKqsnxTnLMlK6nyLY6Bs+zlpN0BGRYPcr+NaH3xrQFw8kheZq13Y6bz9xQ5k7Wh
         21dcV7errZXs6ErJgYg4Wrg3YKRRDkD49tSmip5K3uq0otHcbcBcs3l4botH6TzrSX3d
         BBVwN1LWawrt5whS2GPGasYKQs9IT/SsKCc2MpXzBQcE8zCz17D3yYAS8i7ULHLImanG
         BCwb5JwLCLMv87u5eRYVor0rwepxubuMqCoNSSJ2DXmLDypQaGjAWoz1pwoGQhcFWl3m
         9cuQ==
X-Gm-Message-State: AOAM533GxI1HgkAqS864FvtVCGqT3uFwE17GQyCdaiAWNBKO0NhBpeHR
        bjtu5TGifHjtB4Krg1q5pmfqeYl5LN8=
X-Google-Smtp-Source: ABdhPJwXHb7vxHcYqCtUIx1COO9M/vU5ZRr7Qy8sMoFAocUeSVsPY3eUZa2PNSdimdB9Z7Il8ooPlQ==
X-Received: by 2002:adf:c449:: with SMTP id a9mr5397121wrg.146.1617401531652;
        Fri, 02 Apr 2021 15:12:11 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id u63sm13792011wmg.24.2021.04.02.15.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 15:12:11 -0700 (PDT)
Date:   Fri, 2 Apr 2021 22:12:10 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Qiheng Lin <linqiheng@huawei.com>
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH -next] Drivers: hv: vmbus: Remove unused including
 <linux/version.h>
Message-ID: <20210402221210.subx4dlivfo7ui7q@liuwe-devbox-debian-v2>
References: <20210331060646.2471-1-linqiheng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210331060646.2471-1-linqiheng@huawei.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Mar 31, 2021 at 02:06:46PM +0800, Qiheng Lin wrote:
> Remove including <linux/version.h> that don't need it.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Qiheng Lin <linqiheng@huawei.com>

Commit message adjusted and queued for hyperv-next. Thanks.

Wei.
