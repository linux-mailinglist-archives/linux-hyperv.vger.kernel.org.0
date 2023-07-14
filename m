Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73BA2753EE3
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Jul 2023 17:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236312AbjGNPb7 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 14 Jul 2023 11:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236338AbjGNPb6 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 14 Jul 2023 11:31:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE304B4;
        Fri, 14 Jul 2023 08:31:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 69FF261D53;
        Fri, 14 Jul 2023 15:31:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3456C433C8;
        Fri, 14 Jul 2023 15:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689348715;
        bh=BZibhodv9mYmaldbAkgC6exLTG1CjJoX1GGScEeSuPM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=N91TO1CpOC+GYb1J5AVvBZ4SEETH5c6ITsflBdSVxRrRgN5royAaRkjJFJ5WLvSR1
         yWkBe6A+zdU1O3I48jNA8lyBing3UjX98V0DzZ5yUTFFIG1mopqeLRPTOOY0j5VhC3
         rJJb/aS9XZ0LIMEsqnRWLhpEDD1PVYaPyvhWjrjCvcGryh4gH0RpdCef8J37/LMH+h
         3jl4CdBClXEDmz8YEujAVdU3GmjOC+3rmFUCZq8iscRzaJC/gC9rUHkA/OPc7zln29
         1lH472s0k0wXWEXKI4+wsqrwihiStNk5DrLK6ChTZUkDI2AI2NXBFC3YL3YFeXIn6K
         IN+0RQXfsh6+g==
Date:   Fri, 14 Jul 2023 08:31:52 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Jesper Dangaard Brouer <jbrouer@redhat.com>
Cc:     Haiyang Zhang <haiyangz@microsoft.com>, brouer@redhat.com,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Paul Rosswurm <paulros@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        Long Li <longli@microsoft.com>,
        "ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        Ajay Sharma <sharmaajay@microsoft.com>,
        "hawk@kernel.org" <hawk@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "shradhagupta@linux.microsoft.com" <shradhagupta@linux.microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH net-next] net: mana: Add page pool for RX buffers
Message-ID: <20230714083152.3f64d38a@kernel.org>
In-Reply-To: <3b043a95-a4bc-bbaf-c8e0-240e8ddea62f@redhat.com>
References: <1689259687-5231-1-git-send-email-haiyangz@microsoft.com>
        <20230713205326.5f960907@kernel.org>
        <85bfa818-6856-e3ea-ef4d-16646c57d1cc@redhat.com>
        <PH7PR21MB31166EF9DB2F453999D2E92ECA34A@PH7PR21MB3116.namprd21.prod.outlook.com>
        <3b043a95-a4bc-bbaf-c8e0-240e8ddea62f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, 14 Jul 2023 15:13:15 +0200 Jesper Dangaard Brouer wrote:
> > Thank Jakub and Jesper for the reviews.
> > I'm aware of the page_pool.rst doc, and actually tried it before this
> > patch, but I got lower perf. If I understand correctly, we should call
> > page_pool_release_page() before passing the SKB to napi_gro_receive().
> > 
> > I found the page_pool_dev_alloc_pages() goes through the slow path,
> > because the page_pool_release_page() let the page leave the pool.
> > 
> > Do we have to call page_pool_release_page() before passing the SKB
> > to napi_gro_receive()? Any better way to recycle the pages from the
> > upper layer of non-XDP case?
> >   
> 
> Today SKB "upper layers" can recycle page_pool backed packet data/page.
> 
> Just use skb_mark_for_recycle(skb), then you don't need 
> page_pool_release_page().
> 
> I guess, we should update the documentation, mentioning this.

Ah, I should probably send in the few cleanups form the huge page
series. It looks like all users of page_pool_release_page() can
be converted to skb recycling, so we should hide it and remove 
from docs?
