Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64380742A57
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Jun 2023 18:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbjF2QLd (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 29 Jun 2023 12:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbjF2QLd (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 29 Jun 2023 12:11:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9B89E;
        Thu, 29 Jun 2023 09:11:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B86A86157B;
        Thu, 29 Jun 2023 16:11:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96951C433C0;
        Thu, 29 Jun 2023 16:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688055091;
        bh=poaFO3/bPh14xOgLxoo80j/K9Q/PKlqqhRQVP/H2PzY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qux7W8jRi3usYygYWoKQ80BcrBb8GJWqLvuGuwL8lbBwBavexsXOYZo/YD8NXuGDQ
         d1242atZe6+maXcqWu2UAnmYyd7J7+MA4DN1eT1MDIHRkyEzElW6VSEb3knMaRxKVW
         XEppM1gEwcAG3KvCTuYd1XN0lhyMaDdVi+bDG9Xza9K/Yxe3evXQMuZbe1q8stHxpw
         jFl+XugO0YcGPCK7GH6CqDyUXfsresz9YrZfrbnLfuigc4HXzyiy3N4mFJYza82u5e
         UronuKaEFZqz/r813jLP8q4qjeNA/rQDcvX4hMDW6iDW1hqjlUjnGMF6i94Uc3bgst
         bhOgvbvlqGHhA==
Date:   Thu, 29 Jun 2023 09:11:29 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     longli@linuxonhyperv.com
Cc:     Paolo Abeni <pabeni@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Ajay Sharma <sharmaajay@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, linux-rdma@vger.kernel.org,
        linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Long Li <longli@microsoft.com>,
        stable@vger.kernel.org
Subject: Re: [Patch v3] net: mana: Batch ringing RX queue doorbell on
 receiving packets
Message-ID: <20230629091129.19217388@kernel.org>
In-Reply-To: <36c95dd6babb2202f70594d5dde13493af62dcad.camel@redhat.com>
References: <1687823827-15850-1-git-send-email-longli@linuxonhyperv.com>
        <36c95dd6babb2202f70594d5dde13493af62dcad.camel@redhat.com>
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

On Thu, 29 Jun 2023 10:42:34 +0200 Paolo Abeni wrote:
> > While we are making changes in this code path, change the code for
> > ringing doorbell to set the WQE_COUNT to 0 for Receive Queue. The
> > hardware specification specifies that it should set to 0. Although
> > currently the hardware doesn't enforce the check, in the future releases
> > it may do.

And please split this cleanup into a separate patch, it doesn't sound
like it has to be done as part of the optimization.
