Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 540414AA7B1
	for <lists+linux-hyperv@lfdr.de>; Sat,  5 Feb 2022 09:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359141AbiBEIan (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 5 Feb 2022 03:30:43 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:51228 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359065AbiBEIam (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 5 Feb 2022 03:30:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 76C0A608D4;
        Sat,  5 Feb 2022 08:30:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17C35C340E8;
        Sat,  5 Feb 2022 08:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644049841;
        bh=O8WKG14Rtbt9qqHojc48mDrU8M3KSdTSC54uJjG9TzM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qkt4/4jXT5zUwOg4M+ozCd9ttM1hTkYtZlfWnbSmtEEhVOJDH1kidhcrtG+C0oJ1J
         xo7kwvlF8mSk9M80BJ8RlicW7IhNeLcQrSDsp6EE5Blcg8CmIDS3zu7AEL2QS9r0t/
         YHeZkiodlyezS540tbrAItiwiUp/KBkgefymWWzM=
Date:   Sat, 5 Feb 2022 09:30:31 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Iouri Tarassov <iourit@linux.microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, spronovo@microsoft.com
Subject: Re: [PATCH v2 12/24] drivers: hv: dxgkrnl: Creation of paging queue
 objects.
Message-ID: <Yf41p8UmOSKQHxyB@kroah.com>
References: <cover.1644025661.git.iourit@linux.microsoft.com>
 <daf8e4ac3ab178ca0593bc0b131dc200906f9261.1644025661.git.iourit@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <daf8e4ac3ab178ca0593bc0b131dc200906f9261.1644025661.git.iourit@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Feb 04, 2022 at 06:34:10PM -0800, Iouri Tarassov wrote:
> LX_DXCREATEPAGINGQUEUE (D3DKMTCreatePagingQueue),
> LX_DXDESTROYPAGINGQUEUE (D3DKMTDestroyPagingQueue)

What does this mean?

confused,

greg k-h
