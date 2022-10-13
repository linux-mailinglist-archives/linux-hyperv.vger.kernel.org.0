Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA7A5FD3B7
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Oct 2022 06:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbiJMEPW (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 13 Oct 2022 00:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJMEPU (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 13 Oct 2022 00:15:20 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5EFE7A4862;
        Wed, 12 Oct 2022 21:15:15 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1127)
        id 25FD220F0F7B; Wed, 12 Oct 2022 21:15:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 25FD220F0F7B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1665634515;
        bh=lBeQwqjXzN3pnjmug5AoUIgi34hiXvQZyQDaZ+yRCfE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n3ro9LxsrP1+3BsKlkmkvbeQMDu8Fxjlo2bSUWgnW8zm1yIv3zyfjVbFhYLcDdcq+
         PCcBPKr/cQUUCXgSLWeOaX2kU7lVMCp3dDG4tixkKUdt8Y1by3/vVhE5APM194wffH
         RM4gUmPfCUPXArhAMjgZ3tq0tJfMxj0v0NME8DAg=
Date:   Wed, 12 Oct 2022 21:15:15 -0700
From:   Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     ssengar@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        longli@microsoft.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com
Subject: Re: [PATCH] uio_hv_generic: Enable support for slower vmbus device
 channels
Message-ID: <20221013041515.GA12822@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1665575806-27990-1-git-send-email-ssengar@linux.microsoft.com>
 <Y0bipdisMbTNMYOq@kroah.com>
 <Y0bjH+k3G6V45WRT@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0bjH+k3G6V45WRT@kroah.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Oct 12, 2022 at 05:54:07PM +0200, Greg KH wrote:
> On Wed, Oct 12, 2022 at 05:52:05PM +0200, Greg KH wrote:
> > On Wed, Oct 12, 2022 at 04:56:46AM -0700, Saurabh Sengar wrote:
> > > This patch enables support for slower vmbus channels, which consist
> > > of following 3 changes :
> > > 	1. Support for hypercalls
> > > 	2. Module params for recv/send buffer sizes
> > > 	3. Module param for custom ring buffer sizes
> > 
> > Even if this all was ok, you are doing 3 things all in one change,
> > that's not allowed at all, you all know this.
> > 
> > Anyway, no new module parameters, this is not the 1990's, we have much
> > better ways to do this properly (hint, module parameters modify code,
> > you want to modify the options of a specific device.)
> 
> Also, you give no good reason for why this is needed at all, nor how
> anyone would use these options and why they would need to.
> 
> The kernel should "just work" and not require manual intervention by a
> user.  Dynamically fix this based on the device, do NOT force a user to
> have to attempt to "tune" anything, that will never work properly over
> time, AND you are being lazy and forcing each individual user to do the
> work, making more effort needed overall than just doing it properly in
> the kernel.

Let me find a method if we can avoid using module parameters, this may result
in hardcoding values in the vmbus driver code for various devices, giving less
flexibilty to user. Meanwhile I figure out this, we can go ahead with
"support for hypercalls", I will send a new patch for it.

Regards,
Saurabh

> 
> thanks,
> 
> greg k-h
