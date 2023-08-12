Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF58779F89
	for <lists+linux-hyperv@lfdr.de>; Sat, 12 Aug 2023 13:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236881AbjHLLOv (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 12 Aug 2023 07:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232348AbjHLLOu (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 12 Aug 2023 07:14:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ABDAE6D;
        Sat, 12 Aug 2023 04:14:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B9EF63A4F;
        Sat, 12 Aug 2023 11:14:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59C38C433C8;
        Sat, 12 Aug 2023 11:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691838892;
        bh=7GDrR1FqegNUd0g/0siRXkqYOeSyc6sLb8b1vYPySX0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xb//RtODcAcy06ZdqIGrDH3Zsg8znpRaELxUacxrr5hPyxbj4SWFJVtujvDy20XI5
         0Bp+c5fXch2kOle31wUUHLpsa+RdBemVv2wfhke+FRX0xfOr24UDffhkIwcXySJ5ar
         5PRx6k/oVs0hVnPlZ2KkxYTajGwFY2UgBJzdzV2w=
Date:   Sat, 12 Aug 2023 13:14:50 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Saurabh Sengar <ssengar@linux.microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, mikelley@microsoft.com, corbet@lwn.net,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 0/3] UIO driver for low speed Hyper-V devices
Message-ID: <2023081215-canine-fragile-0a69@gregkh>
References: <1691132996-11706-1-git-send-email-ssengar@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1691132996-11706-1-git-send-email-ssengar@linux.microsoft.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Aug 04, 2023 at 12:09:53AM -0700, Saurabh Sengar wrote:
> Hyper-V is adding multiple low speed "speciality" synthetic devices.
> Instead of writing a new kernel-level VMBus driver for each device,
> make the devices accessible to user space through a UIO-based
> hv_vmbus_client driver. Each device can then be supported by a user
> space driver. This approach optimizes the development process and
> provides flexibility to user space applications to control the key
> interactions with the VMBus ring buffer.

Why is it faster to write userspace drivers here?  Where are those new
drivers, and why can't they be proper kernel drivers?  Are all hyper-v
drivers going to move to userspace now?

> The new synthetic devices are low speed devices that don't support
> VMBus monitor bits, and so they must use vmbus_setevent() to notify
> the host of ring buffer updates. The new driver provides this
> functionality along with a configurable ring buffer size.
> 
> Moreover, this series of patches incorporates an update to the fcopy
> application, enabling it to seamlessly utilize the new interface. The
> older fcopy driver and application will be phased out gradually.
> Development of other similar userspace drivers is still underway.
> 
> Moreover, this patch series adds a new implementation of the fcopy
> application that uses the new UIO driver. The older fcopy driver and
> application will be phased out gradually. Development of other similar
> userspace drivers is still underway.

You are adding a new user api with the "ring buffer" size api, which is
odd for normal UIO drivers as that's not something that UIO was designed
for.

Why not just make you own generic type uiofs type kernel api if you
really want to do all of this type of thing in userspace instead of in
the kernel?

And finally, if this is going to replace the fcopy driver, then it
should be part of this series as well, removing it to show that you
really mean it when you say it will be deleted, otherwise we all know
that will never happen.

thanks,

greg k-h
