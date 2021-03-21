Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 747883435CB
	for <lists+linux-hyperv@lfdr.de>; Mon, 22 Mar 2021 00:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbhCUXo2 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 21 Mar 2021 19:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbhCUXn5 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 21 Mar 2021 19:43:57 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF91C061574;
        Sun, 21 Mar 2021 16:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Message-ID:From:To:Subject:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:
        Date:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=QpCOh3ZZKVIt/5fIr+fZr6XwGE/vaUvRE5REQJBty5o=; b=k3HnraaSUAbIVn159/79AGK5Yn
        T4lWiMl53fV3g174B5WcDTShiclB+6FTr7onPtDtU8FwUn6AbV/iIvthJ79ahDIHIMgjbqAS97SDk
        d7FI08JDQ+H3DoL2uaGvJ67pPw1Wr26nZuPKRFKE+rRhdLrQYqSg480+dD4Imexkc51MYNh8mFkdt
        FuSfVY0PKe320vuIW//zukwXT0QdV/JyLEqXfNLyMB8x+M0ul9wmow3Oqh0hLUmYO5QTizis85qSc
        DSTUHWwRrzMal4eANNlWJiMkNN9iKFuwUSUe5Lxx3iLslllktHI4SnP2L30Q/LTqc6+ENlhiBnOuw
        FPzk2OEA==;
Received: from [2601:1c0:6280:3f0:490f:cdb5:d6c9:8d7b]
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lO7hm-00AYRr-A8; Sun, 21 Mar 2021 23:42:03 +0000
Date:   Sun, 21 Mar 2021 16:41:53 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <20210321233108.3885240-1-unixbhaskar@gmail.com>
References: <20210321233108.3885240-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] hyperv: Few mundane typo fixes
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <97467DD8-0B7A-4555-8334-4C3470909A2B@infradead.org>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On March 21, 2021 4:31:08 PM PDT, Bhaskar Chowdhury <unixbhaskar@gmail=2Eco=
m> wrote:
>
>s/sructure/structure/
>s/extention/extension/
>s/offerred/offered/
>s/adversley/adversely/
>
>Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail=2Ecom>

Acked-by: Randy Dunlap <rdunlap@infradead=2Eorg>

>---
> include/linux/hyperv=2Eh | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
>
>diff --git a/include/linux/hyperv=2Eh b/include/linux/hyperv=2Eh
>index f1d74dcf0353=2E=2E2c18c8e768ef 100644
>--- a/include/linux/hyperv=2Eh
>+++ b/include/linux/hyperv=2Eh
>@@ -284,7 +284,7 @@ struct vmbus_channel_offer {
>
> 		/*
> 		 * Pipes:
>-		 * The following sructure is an integrated pipe protocol, which
>+		 * The following structure is an integrated pipe protocol, which
> 		 * is implemented on top of standard user-defined data=2E Pipe
> 		 * clients have MAX_PIPE_USER_DEFINED_BYTES left for their own
> 		 * use=2E
>@@ -883,11 +883,11 @@ struct vmbus_channel {
> 	 * Support for sub-channels=2E For high performance devices,
> 	 * it will be useful to have multiple sub-channels to support
> 	 * a scalable communication infrastructure with the host=2E
>-	 * The support for sub-channels is implemented as an extention
>+	 * The support for sub-channels is implemented as an extension
> 	 * to the current infrastructure=2E
> 	 * The initial offer is considered the primary channel and this
> 	 * offer message will indicate if the host supports sub-channels=2E
>-	 * The guest is free to ask for sub-channels to be offerred and can
>+	 * The guest is free to ask for sub-channels to be offered and can
> 	 * open these sub-channels as a normal "primary" channel=2E However,
> 	 * all sub-channels will have the same type and instance guids as the
> 	 * primary channel=2E Requests sent on a given channel will result in a
>@@ -951,7 +951,7 @@ struct vmbus_channel {
> 	 * Clearly, these optimizations improve throughput at the expense of
> 	 * latency=2E Furthermore, since the channel is shared for both
> 	 * control and data messages, control messages currently suffer
>-	 * unnecessary latency adversley impacting performance and boot
>+	 * unnecessary latency adversely impacting performance and boot
> 	 * time=2E To fix this issue, permit tagging the channel as being
> 	 * in "low latency" mode=2E In this mode, we will bypass the monitor
> 	 * mechanism=2E
>--
>2=2E31=2E0


--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
