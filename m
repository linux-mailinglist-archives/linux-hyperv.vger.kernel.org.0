Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AEA84C9740
	for <lists+linux-hyperv@lfdr.de>; Tue,  1 Mar 2022 21:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbiCAUrB (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 1 Mar 2022 15:47:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbiCAUrB (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 1 Mar 2022 15:47:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268C862132;
        Tue,  1 Mar 2022 12:46:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFCE160C08;
        Tue,  1 Mar 2022 20:46:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABF3BC340EE;
        Tue,  1 Mar 2022 20:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646167579;
        bh=+MTLGsDpNqZKSHDLMdqKj66I6CLX7n4xlSHCwNmcmAU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q1xX7O6qCvIskPMNg2LxcYdH939a9GtQQc0WQb6y+7fhp7jhMHiy8BlGEJc2IL0LJ
         06Mp0vMv0euEVsxVpeyoxN+Rhd/o1vMUgj8OalStrKp77pKc2z7MWi8W0lpZqU2yLn
         V1GHzxiUL5Su7C7Gl4bIiEwRihZR29XKizD21qhQ=
Date:   Tue, 1 Mar 2022 21:46:16 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Iouri Tarassov <iourit@linux.microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, spronovo@microsoft.com,
        spronovo@linux.microsoft.com
Subject: Re: [PATCH v3 05/30] drivers: hv: dxgkrnl: Opening of /dev/dxg
 device and dxgprocess creation
Message-ID: <Yh6GGJvjEE0hB9jJ@kroah.com>
References: <719fe06b7cbe9ac12fa4a729e810e3383ab421c1.1646163378.git.iourit@linux.microsoft.com>
 <419b863b2848b9e86382511a2f0f12cf91065578.1646163378.git.iourit@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <419b863b2848b9e86382511a2f0f12cf91065578.1646163378.git.iourit@linux.microsoft.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Mar 01, 2022 at 11:45:52AM -0800, Iouri Tarassov wrote:
> --- a/drivers/hv/dxgkrnl/dxgkrnl.h
> +++ b/drivers/hv/dxgkrnl/dxgkrnl.h
> @@ -27,9 +27,11 @@
>  #include <linux/pci.h>
>  #include <linux/hyperv.h>
>  
> +struct dxgprocess;

No need to pre-define this.

thanks,

greg k-h
