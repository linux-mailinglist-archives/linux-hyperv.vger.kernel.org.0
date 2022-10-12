Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B8F5FC8BC
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Oct 2022 17:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbiJLPx3 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 12 Oct 2022 11:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiJLPx2 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 12 Oct 2022 11:53:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90063F2527;
        Wed, 12 Oct 2022 08:53:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2348AB81A25;
        Wed, 12 Oct 2022 15:53:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5041DC433D6;
        Wed, 12 Oct 2022 15:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1665590003;
        bh=ADrm7lpAE3A8hFQl+aJV649fnURlPGKsL0O1UYzaWwE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R69C1BbRj5Z++1djDywM2gyLLoULoZvjoRiq+Le4Wcs1yqyO2XO8pfjIQPF2RYb4O
         2QYp+JCazbMG55D5mYWe+DoE8oYV2XzYQ7CKd2w3RtY63RKqKnC/tLlwFN33XyvgVQ
         IPrS1xdfy/VZbXfxqhvlCymSBSVbM5jsKYdmB0X4=
Date:   Wed, 12 Oct 2022 17:54:07 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Saurabh Sengar <ssengar@linux.microsoft.com>
Cc:     ssengar@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        longli@microsoft.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com
Subject: Re: [PATCH] uio_hv_generic: Enable support for slower vmbus device
 channels
Message-ID: <Y0bjH+k3G6V45WRT@kroah.com>
References: <1665575806-27990-1-git-send-email-ssengar@linux.microsoft.com>
 <Y0bipdisMbTNMYOq@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0bipdisMbTNMYOq@kroah.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Oct 12, 2022 at 05:52:05PM +0200, Greg KH wrote:
> On Wed, Oct 12, 2022 at 04:56:46AM -0700, Saurabh Sengar wrote:
> > This patch enables support for slower vmbus channels, which consist
> > of following 3 changes :
> > 	1. Support for hypercalls
> > 	2. Module params for recv/send buffer sizes
> > 	3. Module param for custom ring buffer sizes
> 
> Even if this all was ok, you are doing 3 things all in one change,
> that's not allowed at all, you all know this.
> 
> Anyway, no new module parameters, this is not the 1990's, we have much
> better ways to do this properly (hint, module parameters modify code,
> you want to modify the options of a specific device.)

Also, you give no good reason for why this is needed at all, nor how
anyone would use these options and why they would need to.

The kernel should "just work" and not require manual intervention by a
user.  Dynamically fix this based on the device, do NOT force a user to
have to attempt to "tune" anything, that will never work properly over
time, AND you are being lazy and forcing each individual user to do the
work, making more effort needed overall than just doing it properly in
the kernel.

thanks,

greg k-h
