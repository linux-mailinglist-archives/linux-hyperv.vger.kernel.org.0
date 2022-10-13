Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2B95FD3EE
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Oct 2022 06:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiJMEqn (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 13 Oct 2022 00:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiJMEqm (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 13 Oct 2022 00:46:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F98BF1932;
        Wed, 12 Oct 2022 21:46:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 08B27B81C22;
        Thu, 13 Oct 2022 04:46:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50757C433D7;
        Thu, 13 Oct 2022 04:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1665636398;
        bh=pGayVfPonl3TOVCWnaUNxoqRflw7kK3LilXAze3Di2o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OfWnBTzxrMhAL5pZu1woysiViYJ7xSmiHXD4iRbuQiKNy3CUFbTJZmGyFUHIqG6VT
         dQVNW63Kb54peCNAvKBJM0WJg9VMPDU0vJBfwHHmrzRBjTyhSII/4PHJ43PWISIY89
         vBNSqWYLEc6On1f2uMazCgG/keMiZ/jfC02SEpYk=
Date:   Thu, 13 Oct 2022 06:47:22 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Saurabh Singh Sengar <ssengar@linux.microsoft.com>
Cc:     ssengar@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        longli@microsoft.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com
Subject: Re: [PATCH] uio_hv_generic: Enable support for slower vmbus device
 channels
Message-ID: <Y0eYWpYhqfjvxdBj@kroah.com>
References: <1665575806-27990-1-git-send-email-ssengar@linux.microsoft.com>
 <Y0bipdisMbTNMYOq@kroah.com>
 <Y0bjH+k3G6V45WRT@kroah.com>
 <20221013041515.GA12822@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221013041515.GA12822@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Oct 12, 2022 at 09:15:15PM -0700, Saurabh Singh Sengar wrote:
> On Wed, Oct 12, 2022 at 05:54:07PM +0200, Greg KH wrote:
> > On Wed, Oct 12, 2022 at 05:52:05PM +0200, Greg KH wrote:
> > > On Wed, Oct 12, 2022 at 04:56:46AM -0700, Saurabh Sengar wrote:
> > > > This patch enables support for slower vmbus channels, which consist
> > > > of following 3 changes :
> > > > 	1. Support for hypercalls
> > > > 	2. Module params for recv/send buffer sizes
> > > > 	3. Module param for custom ring buffer sizes
> > > 
> > > Even if this all was ok, you are doing 3 things all in one change,
> > > that's not allowed at all, you all know this.
> > > 
> > > Anyway, no new module parameters, this is not the 1990's, we have much
> > > better ways to do this properly (hint, module parameters modify code,
> > > you want to modify the options of a specific device.)
> > 
> > Also, you give no good reason for why this is needed at all, nor how
> > anyone would use these options and why they would need to.
> > 
> > The kernel should "just work" and not require manual intervention by a
> > user.  Dynamically fix this based on the device, do NOT force a user to
> > have to attempt to "tune" anything, that will never work properly over
> > time, AND you are being lazy and forcing each individual user to do the
> > work, making more effort needed overall than just doing it properly in
> > the kernel.
> 
> Let me find a method if we can avoid using module parameters, this may result
> in hardcoding values in the vmbus driver code for various devices, giving less
> flexibilty to user.

A user should not be using the uio driver for any of that, so I doubt
this is a real issue :)

thanks,

greg k-h
