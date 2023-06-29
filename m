Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F025742B0A
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Jun 2023 19:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbjF2RGp (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 29 Jun 2023 13:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbjF2RGn (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 29 Jun 2023 13:06:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B7C3586;
        Thu, 29 Jun 2023 10:06:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C476615AF;
        Thu, 29 Jun 2023 17:06:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70C2AC433C0;
        Thu, 29 Jun 2023 17:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688058401;
        bh=snyLsXHVhbxKXmXIpWLRNYYMnAJeU7sVB5JSeB+DrS0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eU9MBbQ6pFaX4UtoGXg8D3oGSWg/xo6SYHzJH+Ucnv2yJQW19cnnrN/ZbvJ23CKeJ
         8R5P855h/17RbJnwyLFiHE84xkxCooGl6r7OGHwm8TMdFoA0CaYbXKZG7BG7fUM/AV
         gZgXoih6qQlA9se4M1PAnjlrBF/Kd5OfF8oROf1UKSUL7+DvZYk/jtc7QXRhhCKY2Y
         vw3kq9wL2j2bXI/BJmHkkZxcNFEirC0uvJRzS02ZZqjI093R17cy3NczCK+eNAlXXV
         5EX5THE32sAIH4ufXljJBCGP/NafhCxV9f4B9zCcCH4GrqrB4oM+t2SA2wxQS6KOs2
         T9QcHXxtP/8Bw==
Date:   Thu, 29 Jun 2023 10:06:39 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Haiyang Zhang <haiyangz@microsoft.com>
Cc:     Paolo Abeni <pabeni@redhat.com>,
        "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Ajay Sharma <sharmaajay@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Long Li <longli@microsoft.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [Patch v3] net: mana: Batch ringing RX queue doorbell on
 receiving packets
Message-ID: <20230629100639.140925ab@kernel.org>
In-Reply-To: <PH7PR21MB3116276E09BFD0950FB0FB49CA25A@PH7PR21MB3116.namprd21.prod.outlook.com>
References: <1687823827-15850-1-git-send-email-longli@linuxonhyperv.com>
        <36c95dd6babb2202f70594d5dde13493af62dcad.camel@redhat.com>
        <PH7PR21MB3116276E09BFD0950FB0FB49CA25A@PH7PR21MB3116.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, 29 Jun 2023 16:53:42 +0000 Haiyang Zhang wrote:
> This web page shows the net-next is "open":
> http://vger.kernel.org/~davem/net-next.html
> 
> Is this still the right place to check net-next status?

We're working on fixing it. Unfortunately it's a private page and most
of the netdev maintainers don't have access to changing it :(
