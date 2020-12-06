Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD2CB2D067D
	for <lists+linux-hyperv@lfdr.de>; Sun,  6 Dec 2020 19:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbgLFSVX (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 6 Dec 2020 13:21:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgLFSVX (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 6 Dec 2020 13:21:23 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEBA6C0613D1;
        Sun,  6 Dec 2020 10:20:42 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id c198so9675951wmd.0;
        Sun, 06 Dec 2020 10:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IBlcf7ksAuEvCZLcbkUIbzhFbCOYIpwbh1pRZSUCoh8=;
        b=CcQXNj1wsGNheX+8oj+t/QWoZ/AuEQVIzeh8fal/2XbOaP/cXtrWyZ44uOgkd+/J6M
         gf1UyIRJLPXax2V62Qz9zcfaSTSmJ6lojyCAjN8EF3q1o8dax769eMwMcjSDBs2BOBAQ
         YJEr3lQBSuXZznBZ7hik1M8i/+1YIF1hwLB6azAppGHP0boatQ9RqLa7YiAl+p584kGN
         eWt2FS47kLC3t+0gLXnil+Y3PM49XK1pSE6FBl35nXrYiMyGvA6iJMW7RUEi/uKdW+mM
         L0QgFtBZS7YGhMeA2XL+/N9avd0XezpTJLKhiRixIbRJ71ol7I6x4RtO0il7CFjRJG6u
         U5MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IBlcf7ksAuEvCZLcbkUIbzhFbCOYIpwbh1pRZSUCoh8=;
        b=EatOL2ZbKTQZpYy/LVV+VJ8PpKOzZS8fu+8x++Bq8cGUGYrmpE4341Tw7Lq1V4NzPO
         YVrG2fxBWKMwTVhktXr2hC700BmkQuio0mglWtj1yZkE85MeOWwAv8xdvi2l28NysOSl
         J1+6nEBHGOnG+Oz8Dt5PIMCA9z8vcyWFsmFDuwdWrdiNnl3r+BFAvJYaDD+HeR8xsQF8
         9bRT6gwMQV37VRFGWFDN8cTaRSDSYe7OktS/2PKElMmYJ7rKIV753YSQaR7SKOLrq5Fg
         X/iwXDcKfMiZyM3XFifOhxD091XxarQQdDzyX8bjDWfKgfMyTg+DlRG/aU3hvkFwj8Lc
         316A==
X-Gm-Message-State: AOAM530Xht/PZk3kBilVnvseL9Fko9GS403hZCCxcCz2CsRnilRO11Ku
        ZZs57Q/uVFI5BCQno9l0Q1XEWKj9mcBqsQ==
X-Google-Smtp-Source: ABdhPJxpNxmkFxPV6UQxlH7Yhs0kXZrOeoAiv8LD6C6kaXJHvAVt+4NS8fEvfDLeoqivW4AgQ9+RXw==
X-Received: by 2002:a7b:c8da:: with SMTP id f26mr15235508wml.155.1607278841449;
        Sun, 06 Dec 2020 10:20:41 -0800 (PST)
Received: from andrea (host-95-239-64-30.retail.telecomitalia.it. [95.239.64.30])
        by smtp.gmail.com with ESMTPSA id b200sm11369891wmb.10.2020.12.06.10.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Dec 2020 10:20:41 -0800 (PST)
Date:   Sun, 6 Dec 2020 19:20:38 +0100
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Juan Vazquez <juvazq@microsoft.com>,
        Saruhan Karademir <skarade@microsoft.com>
Subject: Re: [PATCH 3/6] Drivers: hv: vmbus: Avoid double fetch of
 payload_size in vmbus_on_msg_dpc()
Message-ID: <20201206182038.GC3256@andrea>
References: <20201118143649.108465-1-parri.andrea@gmail.com>
 <20201118143649.108465-4-parri.andrea@gmail.com>
 <MW2PR2101MB1052C82219AB1CEDA949B4EAD7CF1@MW2PR2101MB1052.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW2PR2101MB1052C82219AB1CEDA949B4EAD7CF1@MW2PR2101MB1052.namprd21.prod.outlook.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sun, Dec 06, 2020 at 05:14:18PM +0000, Michael Kelley wrote:
> From: Andrea Parri (Microsoft) <parri.andrea@gmail.com> Sent: Wednesday, November 18, 2020 6:37 AM
> > 
> > vmbus_on_msg_dpc() double fetches from payload_size.  The double fetch
> > can lead to a buffer overflow when (mem)copying the hv_message object.
> > Avoid the double fetch by saving the value of payload_size into a local
> > variable.
> 
> Similar comment here about providing some brief context in the commit
> message on the problem that we are guarding against by removing the
> double fetch.

Will expand.


> 
> I could see combining this patch with the previous one since the
> motivation and pattern of the changes are exactly the same, just for
> two different fields.

Will consider this suggestion for v3.  Please see v2 for a related
discussion.

  Andrea
