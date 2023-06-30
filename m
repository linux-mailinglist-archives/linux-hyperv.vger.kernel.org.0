Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 337497442DA
	for <lists+linux-hyperv@lfdr.de>; Fri, 30 Jun 2023 21:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjF3Tqq (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 30 Jun 2023 15:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjF3Tqp (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 30 Jun 2023 15:46:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC513AAF;
        Fri, 30 Jun 2023 12:46:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2978617F1;
        Fri, 30 Jun 2023 19:46:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86A6BC433C0;
        Fri, 30 Jun 2023 19:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688154403;
        bh=gfQj8jVN5q/PonemZN8J295XoGYEGQSCSEtYdv+9wtY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v8T/Kt9cIGNf6FVPOKdfmrGKexeJcdW/UtZdCGsZQ1rZcXHjyf//G3omtM7GEaKhq
         oEIP5eTSkYK+WmnYc0XSq6QnFFRlsOTVLYzO9psKlNboVoNhgw87ympysb+rP0/ttd
         uKtklTeojsW+U64/v4G5mU1WsOt/sYG18dLnoSIc=
Date:   Fri, 30 Jun 2023 21:46:40 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Long Li <longli@microsoft.com>
Cc:     Paolo Abeni <pabeni@redhat.com>,
        "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Ajay Sharma <sharmaajay@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [Patch v3] net: mana: Batch ringing RX queue doorbell on
 receiving packets
Message-ID: <2023063001-agenda-spent-83c6@gregkh>
References: <1687823827-15850-1-git-send-email-longli@linuxonhyperv.com>
 <36c95dd6babb2202f70594d5dde13493af62dcad.camel@redhat.com>
 <PH7PR21MB3263B266E381BA15DCE45820CE25A@PH7PR21MB3263.namprd21.prod.outlook.com>
 <e5c3e5e5033290c2228bbad0307334a964eb065e.camel@redhat.com>
 <PH7PR21MB326330931CFDDA96E287E470CE2AA@PH7PR21MB3263.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR21MB326330931CFDDA96E287E470CE2AA@PH7PR21MB3263.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Jun 30, 2023 at 05:31:48PM +0000, Long Li wrote:
> > Subject: Re: [Patch v3] net: mana: Batch ringing RX queue doorbell on
> > receiving packets
> > 
> > On Thu, 2023-06-29 at 18:18 +0000, Long Li wrote:
> > > > Subject: Re: [Patch v3] net: mana: Batch ringing RX queue doorbell
> > > > on receiving packets
> > > >
> > > > On Mon, 2023-06-26 at 16:57 -0700, longli@linuxonhyperv.com wrote:
> > > > > From: Long Li <longli@microsoft.com>
> > > > >
> > > > > It's inefficient to ring the doorbell page every time a WQE is
> > > > > posted to the received queue. Excessive MMIO writes result in CPU
> > > > > spending more time waiting on LOCK instructions (atomic
> > > > > operations), resulting in poor scaling performance.
> > > > >
> > > > > Move the code for ringing doorbell page to where after we have
> > > > > posted all WQEs to the receive queue during a callback from
> > > > > napi_poll().
> > > > >
> > > > > With this change, tests showed an improvement from 120G/s to
> > > > > 160G/s on a 200G physical link, with 16 or 32 hardware queues.
> > > > >
> > > > > Tests showed no regression in network latency benchmarks on single
> > > > > connection.
> > > > >
> > > > > While we are making changes in this code path, change the code for
> > > > > ringing doorbell to set the WQE_COUNT to 0 for Receive Queue. The
> > > > > hardware specification specifies that it should set to 0.
> > > > > Although
> > > > > currently the hardware doesn't enforce the check, in the future
> > > > > releases it may do.
> > > > >
> > > > > Cc: stable@vger.kernel.org
> > > > > Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure
> > > > > Network Adapter (MANA)")
> > > >
> > > > Uhmmm... this looks like a performance improvement to me, more
> > > > suitable for the net-next tree ?!? (Note that net-next is closed
> > > > now).
> > >
> > > This issue is a blocker for usage on 200G physical link. I think it
> > > can be categorized as a fix.
> > 
> > Let me ask the question the other way around: is there any specific reason to
> > have this fix into 6.5 and all the way back to 5.13?
> > Especially the latest bit (CC-ing stable) looks at least debatable.
> 
> There are many deployed Linux distributions with MANA driver on kernel 5.15 and kernel 6.1. (those kernels are longterm) They need this fix to achieve the performance target.

Why can't they be upgraded to get that performance target, and all the
other goodness that those kernels have?  We don't normally backport new
features, right?

thanks,

greg k-h
