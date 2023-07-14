Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C303A753033
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Jul 2023 05:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234929AbjGNDxv (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 13 Jul 2023 23:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234952AbjGNDxn (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 13 Jul 2023 23:53:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A14830D7;
        Thu, 13 Jul 2023 20:53:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3686B61BE6;
        Fri, 14 Jul 2023 03:53:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F456C433C8;
        Fri, 14 Jul 2023 03:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689306808;
        bh=+Fwviehmwgt9m79rlkMZy9sX+Vt3vd0g3UBMQgLjJSE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Oe5GldKdTBTA4XQjk58S0OXHh+EuHdGsss8/xGKrhDOPhwAHK1FI0eq0kJnvMlgXJ
         zWMyLRPMe7jckoV247ZCMBDzuM54nqWJZmwREKMYtgM8Ll4b2Q4ADi7FMuy7tGSq43
         TbX4m++CTLhdyMV8oo96GBk00rJqIlohbJy3Yt56nd1V31Yiagil5P/Hs44FhvW3UD
         9Ej+6w1zkIvRVU1K5UcGyqmBQZq/WNnuEijCEVzBcsxRVTMmsu+4MVnw7CF/vRwasH
         lAJHnrJ5DLXVqSwkd5V4xIVztAAKZero3ZhbDh3dkiD+vsYGoNPtLK6PIN4t1rz16e
         aLFT8rQM4LfsQ==
Date:   Thu, 13 Jul 2023 20:53:26 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Haiyang Zhang <haiyangz@microsoft.com>
Cc:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: mana: Add page pool for RX buffers
Message-ID: <20230713205326.5f960907@kernel.org>
In-Reply-To: <1689259687-5231-1-git-send-email-haiyangz@microsoft.com>
References: <1689259687-5231-1-git-send-email-haiyangz@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, 13 Jul 2023 14:48:45 +0000 Haiyang Zhang wrote:
> Add page pool for RX buffers for faster buffer cycle and reduce CPU
> usage.
> 
> Get an extra ref count of a page after allocation, so after upper
> layers put the page, it's still referenced by the pool. We can reuse
> it as RX buffer without alloc a new page.

Please use the real page_pool API from include/net/page_pool.h
We've moved past every driver reinventing the wheel, sorry.
-- 
pw-bot: cr
