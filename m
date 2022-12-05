Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C14642C6D
	for <lists+linux-hyperv@lfdr.de>; Mon,  5 Dec 2022 17:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbiLEQCb (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 5 Dec 2022 11:02:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbiLEQCb (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 5 Dec 2022 11:02:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B431B1C7;
        Mon,  5 Dec 2022 08:02:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85203611CE;
        Mon,  5 Dec 2022 16:02:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59369C433D6;
        Mon,  5 Dec 2022 16:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1670256148;
        bh=fUCRk5umyyi3F3OQ84Ugjf+XIjegvMCAtqFGwoNUqqc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o8sllyzqWv2DzA+KUc9+w2ABl/BVpS0Lah/qIWLxT+W/phFpqpqdbXN1oOWepc2y6
         1CM6I2RlaNDAfcFYCSOSYzTwNVhYoEmdiIQoSi0gEVkPf+sgz5otQ4QNZFNjb4x0YQ
         NNzgKtGndHDakAGEC+w4etUgbRYKrSRN7qSWH+MA=
Date:   Mon, 5 Dec 2022 17:02:26 +0100
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
Subject: Re: [PATCH 4/6] xen: make remove callback of xen driver void returned
Message-ID: <Y44WEkKh9tdNjMlW@kroah.com>
References: <20221205153644.60909-1-set_pte_at@outlook.com>
 <TYCP286MB232333CB411691110A8B9D96CA189@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYCP286MB232333CB411691110A8B9D96CA189@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Dec 05, 2022 at 11:36:42PM +0800, Dawei Li wrote:
> Since commit fc7a6209d571 ("bus: Make remove callback return
> void") forces bus_type::remove be void-returned, it doesn't
> make much sense for any bus based driver implementing remove
> callbalk to return non-void to its caller.

Please wrap changelogs at 72 columns.

And this should go through the maintainers of the Xen bus code, not me,
right?

And why wasn't this attached to the 0/6 email properly?  Did you use
different tools?  If so, our tools can't find the link to keep them in
sync either :(

thanks,

greg k-h
