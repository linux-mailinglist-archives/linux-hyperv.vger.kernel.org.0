Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5443642C67
	for <lists+linux-hyperv@lfdr.de>; Mon,  5 Dec 2022 17:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbiLEQA5 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 5 Dec 2022 11:00:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbiLEQA5 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 5 Dec 2022 11:00:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8921AF1E;
        Mon,  5 Dec 2022 08:00:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 08740611C5;
        Mon,  5 Dec 2022 16:00:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D945AC433B5;
        Mon,  5 Dec 2022 16:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1670256055;
        bh=trNrKrfKjsfA/iJHoM4RlcQMgCcsX15/LCiL4T/xuJ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EXkPiPH9jpu2QDhpC1k592OE6zoYsvZ6Cm6TtkRBZj9flj8DPe/+/ck94MscE/Hy+
         PVn+ynbqHg6LhzriIAOKH+7f1fPldEuUHPztcK+v0tQmwdicxIaCw7If8OtrPmpjh+
         OYAzWhpAg9ucHwpcZ/6qG8GRvR0WojmPy76I8FYg=
Date:   Mon, 5 Dec 2022 17:00:52 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dawei Li <set_pte_at@outlook.com>
Cc:     johannes@sipsolutions.net, robert.jarzmik@free.fr, jgross@suse.com,
        sstabellini@kernel.org, oleksandr_tyshchenko@epam.com,
        roger.pau@citrix.com, srinivas.kandagatla@linaro.org,
        bgoswami@quicinc.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        xen-devel@lists.xenproject.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] Make remove() of any bus based driver void returned
Message-ID: <Y44VtN/rmjIU6sDC@kroah.com>
References: <TYCP286MB23234ABCCF40E3FC42FD09A4CA189@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYCP286MB23234ABCCF40E3FC42FD09A4CA189@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Dec 05, 2022 at 11:36:38PM +0800, Dawei Li wrote:
> For bus-based driver, device removal is implemented as:
> device_remove() => bus->remove() => driver->remove()
> 
> Driver core needs no feedback from bus driver about the result of
> remove callback. In which case, commit fc7a6209d571 ("bus: Make
> remove callback return void") forces bus_type::remove be void-returned.
> 
> Now we have the situation that both 1st & 2nd part of calling chain
> are void returned, so it does not make much sense for the last one
> (driver->remove) to return non-void to its caller.
> 
> So the basic idea behind this patchset is making remove() callback of
> any bus-based driver to be void returned.
> 
> This patchset includes changes for drivers below:
> 1. hyperv
> 2. macio
> 3. apr
> 4. xen
> 5. ac87
> 6. soundbus

Then that should be 6 different patchsets going to 6 different
subsystems.  No need to make this seems like a unified set of patches at
all.

> Q: Why not platform drivers?
> A: Too many of them.(maybe 4K+)

That will have to be done eventually, right?

thanks,

greg k-h
