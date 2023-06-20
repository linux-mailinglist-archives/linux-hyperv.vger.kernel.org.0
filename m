Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99E99736400
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Jun 2023 09:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjFTHHJ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 20 Jun 2023 03:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjFTHHH (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 20 Jun 2023 03:07:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256D510F9;
        Tue, 20 Jun 2023 00:07:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AEEA761028;
        Tue, 20 Jun 2023 07:07:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAD73C433C0;
        Tue, 20 Jun 2023 07:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687244822;
        bh=GR6mhcNPQGfkgf7foRclZExHB5KiyAu6DP74hdSupHI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YYHRqV7NGao0+/4qGNuIYHGB7c2vQTiWCmItJ4yhidm8FjqgK5mH0b1OpmvjwZHA1
         pAlF3lBlSnWan838AKvkOAAqtL8/0MkeQhKPQZNpcxgm0nVgUd6n70zqNd4p8bEx1v
         rFikaycLUbi9MorxHDXIMgYoe1l2ruTkLLUfR4/I=
Date:   Tue, 20 Jun 2023 09:06:57 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Saurabh Singh Sengar <ssengar@microsoft.com>
Cc:     Saurabh Sengar <ssengar@linux.microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH v2 1/5] uio: Add hv_vmbus_client driver
Message-ID: <2023062007-coral-nicotine-856c@gregkh>
References: <1686766512-2589-1-git-send-email-ssengar@linux.microsoft.com>
 <1686766512-2589-2-git-send-email-ssengar@linux.microsoft.com>
 <2023061419-probe-velocity-b276@gregkh>
 <PUZP153MB07490FDBBB8CC3099CFF126BBE5CA@PUZP153MB0749.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PUZP153MB07490FDBBB8CC3099CFF126BBE5CA@PUZP153MB0749.APCP153.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Jun 20, 2023 at 05:19:14AM +0000, Saurabh Singh Sengar wrote:
> > And you are defining a "global" variable that can be modified by an individual
> > sysfs file for ANY device bound to this driver, messing with the other device's
> > ring buffer size, right?  This needs to be per-device, or explain in huge detail
> > here why not.
> 
> The global variable is expected to be set by userspace per device before opening, the
> particular uio device. For a particular Hyper-v device this value be same, and once
> device is open the ring buffer is allocated and there won't be any impact afterwards
> changing it. I can elaborate more of this in sysfs documentation.

That's totally confusing, please make this per-device properly, as you
will find out when you try to document it, what you are describing is
unlike any other per-device interface we have.

greg k-h
