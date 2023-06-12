Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2BD772CC49
	for <lists+linux-hyperv@lfdr.de>; Mon, 12 Jun 2023 19:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232666AbjFLRV3 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 12 Jun 2023 13:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232963AbjFLRV2 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 12 Jun 2023 13:21:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2587DB;
        Mon, 12 Jun 2023 10:21:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D3DC612EA;
        Mon, 12 Jun 2023 17:21:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC14CC433EF;
        Mon, 12 Jun 2023 17:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686590485;
        bh=gAuJ9KU5RmFURvI3QbJHtsovxcdj1K6oUU0iGJV69mM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=c8gKP6QI5EfugRQgVTVDhMd0Rmp342XYgNVNZyqas7fICrM7G6nRrWc/lIFK9WcKZ
         /xNkwtTyXt01CCLhTIxX8PzH9fZF1rqCjmW/2Lp/ZknUeE7agOK4gcyqffLevOkZI5
         bDeXumksNF1xaHJbscoCbzvHLGjWvIkNAacC4Ospg1UwYX28O0dMwIigFG4Q2knUtu
         mNN7wagragjKgu3r1P/GS/s6+G4gDOygw8T6qrwKTKOrUTzGaawBRI58nL7kGc/AdD
         lNVbsgBhQCsofTCaa/YdT6xy+GaJc9i+b0j9dD9HhU16kRymrqggaOR6+GvrxNOavN
         WTF0M/kG7b0pA==
Date:   Mon, 12 Jun 2023 10:21:24 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Wei Hu <weh@microsoft.com>
Cc:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Long Li <longli@microsoft.com>,
        Ajay Sharma <sharmaajay@microsoft.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
        "shradhagupta@linux.microsoft.com" <shradhagupta@linux.microsoft.com>
Subject: Re: [PATCH v2 1/1] RDMA/mana_ib: Add EQ interrupt support to mana
 ib driver.
Message-ID: <20230612102124.6d7c31e1@kernel.org>
In-Reply-To: <SI2P153MB0441DAC4E756A1991A03520FBB54A@SI2P153MB0441.APCP153.PROD.OUTLOOK.COM>
References: <20230606151747.1649305-1-weh@microsoft.com>
        <20230607213903.470f71ae@kernel.org>
        <SI2P153MB0441DAC4E756A1991A03520FBB54A@SI2P153MB0441.APCP153.PROD.OUTLOOK.COM>
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

On Mon, 12 Jun 2023 04:44:44 +0000 Wei Hu wrote:
> If the patch also needs to go through the NETDEV branch, does it mean two subsystems will pull its own part? A few follow-up questions about generating a PR, since I have never done such before.
> 
> 1. Which repo should I clone and create the branch from?

The main tree of Linus Torvalds. Check which tags are present in both
netdev and rdma trees and use the newest common tag between the trees
as a base.

> 2. From the example you provided, I see these people has their own branches on kernel.org, for example something like:
> git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux.git tags/mlx5-updates-2023-06-06. 
> I am not Linux maintainer. I just have repo on Github. How do I
> create or fork on kernel.org? Do I need an account to do so? Or I can
> use my own repo on Github?

GitHub is fine.

> 3.  How to create PR in this case? Should I follow this link:
> https://docs.kernel.org/maintainer/pull-requests.html?

Sort of. But still post the patches, so you'd want to use these
commands somewhere along the way:

git format-patch [...] -o $path --cover-letter
git request-pull [...] >> $path/0000-cover-letter.patch
