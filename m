Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C540726D05
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 Jun 2023 22:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234196AbjFGUic (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 7 Jun 2023 16:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234260AbjFGUi1 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 7 Jun 2023 16:38:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8008F26BB;
        Wed,  7 Jun 2023 13:38:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 60C0B645B9;
        Wed,  7 Jun 2023 20:38:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C530DC4339C;
        Wed,  7 Jun 2023 20:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686170287;
        bh=rPUHEPERLm0DXG4pXZwSjeSGww4CDsRDvqeL184e0ZI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RwPiP0ZqgMhbmO69KJMWKgjyDmw2DU+Uq2Q+wsJ6Ykw6Iz9jKpPLGiP3PtocJpEzk
         2CVKCmg4yT/KV6j4mPpeqQ23pJX4t5g0IkDUFpHdc4i1cV1pmGSKQFB66jnXtL8JKO
         OM7gV87EK/USNmftlnhvilSKzUYjImtHxRXUeqLzMxa8R9GJKTCtJLRqF7Y7bC8zBh
         DyA12yt13ok4+AX2LQ1uRQPbTTBv7DlsQvU6ValAs4WzvW2hZ9ttvURzadLgLxRv4S
         S+MHRjWomI2NgIqke51H4XpJUh8it8RmcI3ild6mST+lr74KeC0Sj6RMUc7L8985s2
         CJyy9k+p5Ymbw==
Date:   Wed, 7 Jun 2023 13:38:05 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Haiyang Zhang <haiyangz@microsoft.com>
Cc:     linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
        decui@microsoft.com, kys@microsoft.com, paulros@microsoft.com,
        olaf@aepfle.de, vkuznets@redhat.com, davem@davemloft.net,
        wei.liu@kernel.org, edumazet@google.com, pabeni@redhat.com,
        leon@kernel.org, longli@microsoft.com, ssengar@linux.microsoft.com,
        linux-rdma@vger.kernel.org, daniel@iogearbox.net,
        john.fastabend@gmail.com, bpf@vger.kernel.org, ast@kernel.org,
        sharmaajay@microsoft.com, hawk@kernel.org, tglx@linutronix.de,
        shradhagupta@linux.microsoft.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next,V2] net: mana: Add support for vlan tagging
Message-ID: <20230607133805.58161672@kernel.org>
In-Reply-To: <1686170042-10610-1-git-send-email-haiyangz@microsoft.com>
References: <1686170042-10610-1-git-send-email-haiyangz@microsoft.com>
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

On Wed,  7 Jun 2023 13:34:02 -0700 Haiyang Zhang wrote:
> To support vlan, use MANA_LONG_PKT_FMT if vlan tag is present in TX
> skb. Then extract the vlan tag from the skb struct, and save it to
> tx_oob for the NIC to transmit. For vlan tags on the payload, they
> are accepted by the NIC too.
> 
> For RX, extract the vlan tag from CQE and put it into skb.
> 
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
> V2:
> Removed the code that extracts inband tag, because our NIC accepts
> inband tags too.

Please don't rush multiple versions, if your previous version is buggy
you have to reply to it saying so and then wait before posting v2.

Reviewing something just to find there is a v2 already posting is one
of the more annoying experiences for maintainers and reviewers.

Quoting documentation:

  Resending after review
  ~~~~~~~~~~~~~~~~~~~~~~
  
  Allow at least 24 hours to pass between postings. This will ensure reviewers
  from all geographical locations have a chance to chime in. Do not wait
  too long (weeks) between postings either as it will make it harder for reviewers
  to recall all the context.
  
  Make sure you address all the feedback in your new posting. Do not post a new
  version of the code if the discussion about the previous version is still
  ongoing, unless directly instructed by a reviewer.
  
See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#resending-after-review
