Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE262688FCF
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Feb 2023 07:48:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232618AbjBCGrA (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 3 Feb 2023 01:47:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232628AbjBCGqf (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 3 Feb 2023 01:46:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CFDF911B2;
        Thu,  2 Feb 2023 22:44:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2036561DB8;
        Fri,  3 Feb 2023 06:44:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6065C433EF;
        Fri,  3 Feb 2023 06:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675406697;
        bh=2pGlnT6XlzVCoevMd8v4vmCtZoD6Rwmp0FtTTto9gCk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kHT1242WEaBssun+/SgQ8xHgj0KQMRn7F7cG+FHgnk8cKszqEtxH9Jb9WpGtNnnql
         ZczWQ4NFLzLnseSPjkf+8O9h+nRyPs9eef1gH44U+Y0Xl7CheaXiU/01agdMuFbdhb
         O1nQUDifl/9LYrV5P65cJTLh/UfgxY7znDn+4RdY=
Date:   Fri, 3 Feb 2023 07:44:54 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] HV: hv_balloon: fix memory leak with using
 debugfs_lookup()
Message-ID: <Y9ytZo23CTV6AsCS@kroah.com>
References: <20230202140918.2289522-1-gregkh@linuxfoundation.org>
 <BYAPR21MB168826E0AF83D40DE0C704F9D7D79@BYAPR21MB1688.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR21MB168826E0AF83D40DE0C704F9D7D79@BYAPR21MB1688.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Feb 03, 2023 at 03:56:06AM +0000, Michael Kelley (LINUX) wrote:
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org> Sent: Thursday, February 2, 2023 6:09 AM
> 
> > 
> > When calling debugfs_lookup() the result must have dput() called on it,
> > otherwise the memory will leak over time.  To make things simpler, just
> > call debugfs_lookup_and_remove() instead which handles all of the logic
> > at once.
> > 
> > Cc: "K. Y. Srinivasan" <kys@microsoft.com>
> > Cc: Haiyang Zhang <haiyangz@microsoft.com>
> > Cc: Wei Liu <wei.liu@kernel.org>
> > Cc: Dexuan Cui <decui@microsoft.com>
> > Cc: linux-hyperv@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Add a Fixes: tag?  This hv_balloon debugfs code was added in v6.0,
> And I see that debugfs_lookup_and_remove() was also added in v6.0.
> 
> Fixes: d180e0a1be6c ("Drivers: hv: Create debugfs file with hyper-v balloon usage information")

Will do, thanks.

greg k-h
