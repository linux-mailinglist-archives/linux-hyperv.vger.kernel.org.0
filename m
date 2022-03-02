Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4184C9EA4
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Mar 2022 08:53:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239922AbiCBHyG (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Mar 2022 02:54:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233208AbiCBHyE (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Mar 2022 02:54:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4593E2DA91;
        Tue,  1 Mar 2022 23:53:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D4A4160B16;
        Wed,  2 Mar 2022 07:53:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DE13C004E1;
        Wed,  2 Mar 2022 07:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646207601;
        bh=JVHovSPSHmzrBSKXU+wJ0xDWPI/HbFUs+B+kw6xf6nw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wBVZee/M87vYeOpWbXi7DSVcc18hKvXjFM7GrB5sGUjuFAsbANfuQgyNFigpum1vU
         J2HRYPBcS8JDFOy8snCKtx5Kv9xkCtskeApBjz+vo7G20vkVv1j6njYhhuuqk1OqMF
         Sjn1TmAgBJ1zBtAjyA39L18m/bjtwwqn0o5/Ziww=
Date:   Wed, 2 Mar 2022 08:53:15 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Iouri Tarassov <iourit@linux.microsoft.com>, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        spronovo@microsoft.com, spronovo@linux.microsoft.com
Subject: Re: [PATCH v3 02/30] drivers: hv: dxgkrnl: Driver initialization and
 loading
Message-ID: <Yh8ia7nJNN7ISR1l@kroah.com>
References: <719fe06b7cbe9ac12fa4a729e810e3383ab421c1.1646163378.git.iourit@linux.microsoft.com>
 <739cf89e71ff72436d7ca3f846881dfb45d07a6a.1646163378.git.iourit@linux.microsoft.com>
 <Yh6F9cG6/SV6Fq8Q@kroah.com>
 <20220301222321.yradz24nuyhzh7om@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220301222321.yradz24nuyhzh7om@liuwe-devbox-debian-v2>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Mar 01, 2022 at 10:23:21PM +0000, Wei Liu wrote:
> > > +struct dxgglobal *dxgglobal;
> > 
> > No, make this per-device, NEVER have a single device for your driver.
> > The Linux driver model makes it harder to do it this way than to do it
> > correctly.  Do it correctly please and have no global structures like
> > this.
> > 
> 
> This may not be as big an issue as you thought. The device discovery is
> still done via the normal VMBus probing routine. For all intents and
> purposes the dxgglobal structure can be broken down into per device
> fields and a global structure which contains the protocol versioning
> information -- my understanding is there will always be a global
> structure to hold information related to the backend, regardless of how
> many devices there are.

Then that is wrong and needs to be fixed.  Drivers should almost never
have any global data, that is not how Linux drivers work.  What happens
when you get a second device in your system for this?  Major rework
would have to happen and the code will break.  Handle that all now as it
takes less work to make this per-device than it does to have a global
variable.

> I definitely think splitting is doable, but I also understand why Iouri
> does not want to do it _now_ given there is no such a model for multiple
> devices yet, so anything we put into the per-device structure could be
> incomplete and it requires further changing when such a model arrives
> later.
> 
> Iouri, please correct me if I have the wrong mental model here.
> 
> All in all, I hope this is not going to be a deal breaker for the
> acceptance of this driver.

For my reviews, yes it will be.

Again, it should be easier to keep things in a per-device state than
not as the proper lifetime rules and the like are automatically handled
for you.  If you have global data, you have to manage that all on your
own and it is _MUCH_ harder to review that you got it correct.

Please fix, it will make your life easier as well.

thanks,

greg k-h
