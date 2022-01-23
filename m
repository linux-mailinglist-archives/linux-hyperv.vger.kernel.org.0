Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E32AA4975D1
	for <lists+linux-hyperv@lfdr.de>; Sun, 23 Jan 2022 22:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240234AbiAWVzk (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 23 Jan 2022 16:55:40 -0500
Received: from mail-wr1-f52.google.com ([209.85.221.52]:44591 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234697AbiAWVzj (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 23 Jan 2022 16:55:39 -0500
Received: by mail-wr1-f52.google.com with SMTP id k18so10155232wrg.11;
        Sun, 23 Jan 2022 13:55:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FtCZGMVCEzvzcuj9uIT9ybSsEia//PiD1l8+cmaI4f4=;
        b=cEk+i0WGCyRUjUvmjZxs5orB5/WGe+Rvu8BC7M2hwO728lNOnpuCzT3O2aGotrKhVo
         33xT/aDgBRoBp80lWfE9WmNHC0CmbRtmAGa3cS4M/x3whKj3TxjpmF3VMsMsQ9lwm1aX
         QV3dXMt85KwnoH9s91Obr/G4OrjZsM/FXTluyhbNSyPGRzqPgBPydeIkrSewYdZ+bCuO
         V90SI10+jsRTO8OCCq0TWC8obSytM9j0VH6fO/GedD/RA2Nb5U0HszzPkWNlh7OhgYen
         Do4F2k/p+XSBSH/kwlj8kjp5Q0Aa8nwjoTRn61Zb95raTuKWPGwaw8K8wFmyAmXflcAH
         SjqA==
X-Gm-Message-State: AOAM530tFzS7iN1kFCEJtLN7PQu90i0i0FjvsazKo5I33HzCucQXK/gQ
        mnYhf/gFHMAXig+k9mPwK8hxj34X7N0=
X-Google-Smtp-Source: ABdhPJyxn5VXglHfrRkeM0Qt816asL38uYi6WsiHvqw5MUJumobgjb9yK1GNHIeJ6QM5lhD34k+2Fw==
X-Received: by 2002:adf:e0c6:: with SMTP id m6mr12016980wri.525.1642974938554;
        Sun, 23 Jan 2022 13:55:38 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id h127sm19625046wmh.27.2022.01.23.13.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 13:55:38 -0800 (PST)
Date:   Sun, 23 Jan 2022 21:55:36 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Yanming Liu <yanminglr@gmail.com>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        Andres Beltran <lkmlabelt@gmail.com>,
        Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH] Drivers: hv: balloon: account for vmbus packet header in
 max_pkt_size
Message-ID: <20220123215536.vsbv7n36govrzqbd@liuwe-devbox-debian-v2>
References: <20220119202052.3006981-1-yanminglr@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220119202052.3006981-1-yanminglr@gmail.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Jan 20, 2022 at 04:20:52AM +0800, Yanming Liu wrote:
> Commit adae1e931acd ("Drivers: hv: vmbus: Copy packets sent by Hyper-V
> out of the ring buffer") introduced a notion of maximum packet size in
> vmbus channel and used that size to initialize a buffer holding all
> incoming packet along with their vmbus packet header. hv_balloon uses
> the default maximum packet size VMBUS_DEFAULT_MAX_PKT_SIZE which matches
> its maximum message size, however vmbus_open expects this size to also
> include vmbus packet header. This leads to 4096 bytes
> dm_unballoon_request messages being truncated to 4080 bytes. When the
> driver tries to read next packet it starts from a wrong read_index,
> receives garbage and prints a lot of "Unhandled message: type:
> <garbage>" in dmesg.
> 
> Allocate the buffer with HV_HYP_PAGE_SIZE more bytes to make room for
> the header.
> 
> Fixes: adae1e931acd ("Drivers: hv: vmbus: Copy packets sent by Hyper-V out of the ring buffer")
> Suggested-by: Michael Kelley (LINUX) <mikelley@microsoft.com>
> Suggested-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> Signed-off-by: Yanming Liu <yanminglr@gmail.com>

Applied to hyperv-fixes. Thanks.
