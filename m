Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33BEF4CBE8F
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Mar 2022 14:11:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233561AbiCCNLq (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 3 Mar 2022 08:11:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233524AbiCCNLp (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 3 Mar 2022 08:11:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD4A186B8E;
        Thu,  3 Mar 2022 05:11:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12BC3619E3;
        Thu,  3 Mar 2022 13:11:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04D2FC004E1;
        Thu,  3 Mar 2022 13:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646313059;
        bh=lSLEDv7+JFAWs47ADuLZDINgHOuHcAxjkGMi/7FoW9o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IwIOgjfNc+Rb9LdB+LeX1yze3Uhisjx9WsyrMMkjLRqMh7zXDz/roADfEgu2PPFgC
         1bP/sPDvevcZuKmdATHx0PK+3T/50HA0fAUFEu5Hl26fxwn0zE8F43r9pMtGss/8dF
         lSDVOObtXIHO2xxAWSezC5rastWk/uQ7v1eHrJp0=
Date:   Thu, 3 Mar 2022 14:10:56 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Iouri Tarassov <iourit@linux.microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, spronovo@microsoft.com,
        spronovo@linux.microsoft.com
Subject: Re: [PATCH v3 02/30] drivers: hv: dxgkrnl: Driver initialization and
 loading
Message-ID: <YiC+YMyEnPDbEepS@kroah.com>
References: <719fe06b7cbe9ac12fa4a729e810e3383ab421c1.1646163378.git.iourit@linux.microsoft.com>
 <739cf89e71ff72436d7ca3f846881dfb45d07a6a.1646163378.git.iourit@linux.microsoft.com>
 <Yh6F9cG6/SV6Fq8Q@kroah.com>
 <6b691648-96ce-f28e-436e-f5eb4137e73b@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b691648-96ce-f28e-436e-f5eb4137e73b@linux.microsoft.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Mar 02, 2022 at 03:27:56PM -0800, Iouri Tarassov wrote:
> 
> On 3/1/2022 12:45 PM, Greg KH wrote:
> > On Tue, Mar 01, 2022 at 11:45:49AM -0800, Iouri Tarassov wrote:
> > > - Create skeleton and add basic functionality for the
> > > hyper-v compute device driver (dxgkrnl).
> > > 
> > > +
> > > +#undef pr_fmt
> > > +#define pr_fmt(fmt)	"dxgk: " fmt
> >
> > Use the dev_*() print functions, you are a driver, and you always have a
> > pointer to a struct device.  There's no need to ever call pr_*().
> >
> 
> There is no struct device during module initialization until the
> /dev/dxg device is created.

Then you should not have anything to print out.

> Is it ok to use pr_* functions in this case?

Nope.

> Should dev_*(NULL,...) be used?

No, not at all, never!

> I see other drivers use the pr_* functions in this case (mips.c as an
> example).

There are lots of bad examples in the kernel tree, let's make your code
a good one.

thanks,

greg k-h
