Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3DB977B259
	for <lists+linux-hyperv@lfdr.de>; Mon, 14 Aug 2023 09:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbjHNHZa (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 14 Aug 2023 03:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234052AbjHNHZB (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 14 Aug 2023 03:25:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90BEEE7E
        for <linux-hyperv@vger.kernel.org>; Mon, 14 Aug 2023 00:25:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1163163FC4
        for <linux-hyperv@vger.kernel.org>; Mon, 14 Aug 2023 07:25:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1576C433CB;
        Mon, 14 Aug 2023 07:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691997899;
        bh=qZaYsLNwZL4NTds8mEJjrz9hvBR/6KHFfnEYBdIm6oE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oZY04GnA3unIuc7uqdm5ymGM3i2K0ZQ5mwfmjCLiVmdvlAxYZq+ZPOvYJOpIqO26y
         OUvc1qkDWiOVmokaU7mwbnOBi0me0PKlkj4LQRDbDdHBXbj27cNIA0uJeZMF/9qiD7
         FKC23UV6BSzU/IlSex9DPgA7D4YyWYuhODKW7dgxtzn7+86w6xgsWUBENIiiBnLWUq
         fiAknksBbZkCy7BgO0idKcwL07ORg25H3KcsBrewuxiyHJfpQphA70SDOR+8CoB4zw
         aBnLWTvuxBNBbj9cqmK6wn9phFPuwtAfqCpsiTcsy4tjGj27cBesxAaFtgpPA+FMCa
         sH2hF2sKB2bYQ==
Date:   Mon, 14 Aug 2023 09:24:54 +0200
From:   Simon Horman <horms@kernel.org>
To:     "Guozihua (Scott)" <guozihua@huawei.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, linux-hyperv@vger.kernel.org,
        netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH -next] hv_netvsc: Remove duplicated include
Message-ID: <ZNnWxiOySLDBN5AA@vergenet.net>
References: <20230810115148.21332-1-guozihua@huawei.com>
 <ZNX8CyvnsP0zhmbA@vergenet.net>
 <d7a6c71a-98a6-64cd-8118-2b0f89189177@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7a6c71a-98a6-64cd-8118-2b0f89189177@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Aug 14, 2023 at 09:56:11AM +0800, Guozihua (Scott) wrote:
> On 2023/8/11 17:14, Simon Horman wrote:
> > On Thu, Aug 10, 2023 at 07:51:48PM +0800, GUO Zihua wrote:
> >> Remove duplicated include of linux/slab.h.  Resolves checkincludes message.
> >>
> >> Signed-off-by: GUO Zihua <guozihua@huawei.com>
> > 
> > The patch looks fine, but for reference, I do have some feedback
> > from a process point of view. It's probably not necessary to
> > repost because of these. But do keep them in mind if you have
> > to post a v2 for some other reason, and for future patch submissions.
> > 
> > * As a non bugfix for Networking code this should likely be targeted
> >   at the net-next tree - the net tree is used for bug fixes.
> >   And the target tree should be noted in the subject.
> > 
> >   Subject: [PATCH net-next] ...
> > 
> > * Please use the following command to generate the
> >   CC list for Networking patches
> > 
> >   ./scripts/get_maintainer.pl --git-min-percent 2 this.patch

It seems that I made a typo here, it should be:

	./scripts/get_maintainer.pl --git-min-percent 25 this.patch

	n.b: 2 -> 25

> > 
> >   In this case, the following, now CCed, should be included:
> > 
> >   - Jakub Kicinski <kuba@kernel.org>
> >   - Eric Dumazet <edumazet@google.com>
> >   - "David S. Miller" <davem@davemloft.net>
> >   - Paolo Abeni <pabeni@redhat.com>
> > 
> > * Please do read the process guide
> > 
> >   https://kernel.org/doc/html/latest/process/maintainer-netdev.html
> > 
> > The above notwithstanding,
> > 
> > Reviewed-by: Simon Horman <horms@kernel.org>
> 
> Hi Simon,
> 
> Thanks for the info and the review-by! Will keep that in mind.
> 
> -- 
> Best
> GUO Zihua
> 
