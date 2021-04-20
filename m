Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEA3736605A
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Apr 2021 21:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233548AbhDTTlX (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 20 Apr 2021 15:41:23 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49]:43638 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233541AbhDTTlX (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 20 Apr 2021 15:41:23 -0400
Received: by mail-wm1-f49.google.com with SMTP id p10-20020a1c544a0000b02901387e17700fso1742424wmi.2;
        Tue, 20 Apr 2021 12:40:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sMMGdr7JEy8BvSwLQ/yZhzlMoyLP4uO6JbljwCQU/Ko=;
        b=Pcm/ZBmiyLYzF7T3yiuB8ehfgFUIlmg7JZ16tTxx7RRG0HmwnTwSfwPyM+69nsPGl/
         3gG+LoeVN0WKYhFSkIX539H34QFA5122GJB3Y4YN3cRwiAKkqfuyfIQl/bj1lJKfdFwE
         IhThTyN5fT/09muV7ebgm0H6bEYHMdKOSHy8BzFz7vCPCqmXQE6a46htXNqTu/5kFz6y
         JEUuhdoan4FkGGMToo0lK6fXnFlZSnhkO80Fsm7itz3dL9YtIGiYWiLXwAWFhWgxY1KL
         g0JjK80KATEomO0vx7RNDSh9JcxE5PiT3HLXFj1T6VKzDQbmTwDPd02upSCF83y2dQX/
         YPpQ==
X-Gm-Message-State: AOAM533SX8Rj1vYyaZCH+SZqptbZeHkx92deFzFIOongY3FczQ2MZok4
        QWY1VW+pTxYUbZ/NbN7lhdU=
X-Google-Smtp-Source: ABdhPJwciRmccZteNoTyAX/OGxC7Q0+otjZy0r0z0nEF5ncJBvXScb7WzxcbkSbrWKEDMKVpw0v+8A==
X-Received: by 2002:a05:600c:3217:: with SMTP id r23mr6022499wmp.98.1618947651004;
        Tue, 20 Apr 2021 12:40:51 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id u2sm5487183wmm.5.2021.04.20.12.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 12:40:50 -0700 (PDT)
Date:   Tue, 20 Apr 2021 19:40:49 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: Re: [PATCH v2] Drivers: hv: vmbus: Initialize unload_event statically
Message-ID: <20210420194049.vsmax7bseebb324x@liuwe-devbox-debian-v2>
References: <20210420014350.2002-1-parri.andrea@gmail.com>
 <MWHPR21MB15934822FAFFFD4D3FA369BAD7489@MWHPR21MB1593.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR21MB15934822FAFFFD4D3FA369BAD7489@MWHPR21MB1593.namprd21.prod.outlook.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Apr 20, 2021 at 04:50:56AM +0000, Michael Kelley wrote:
> From: Andrea Parri (Microsoft) <parri.andrea@gmail.com> Sent: Monday, April 19, 2021 6:44 PM
> > 
> > If a malicious or compromised Hyper-V sends a spurious message of type
> > CHANNELMSG_UNLOAD_RESPONSE, the function vmbus_unload_response() will
> > call complete() on an uninitialized event, and cause an oops.
> > 
> > Reported-by: Michael Kelley <mikelley@microsoft.com>
> > Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> > ---
> > Changes since v1[1]:
> >   - add inline comment in vmbus_unload_response()
> > 
> > [1] https://lore.kernel.org/linux-hyperv/20210416143932.16512-1-parri.andrea@gmail.com/
> > 
> >  drivers/hv/channel_mgmt.c | 7 ++++++-
> >  drivers/hv/connection.c   | 2 ++
> >  2 files changed, 8 insertions(+), 1 deletion(-)
> > 
> 
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>

Applied to hyperv-next. Thanks.
