Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 925E64AA7A4
	for <lists+linux-hyperv@lfdr.de>; Sat,  5 Feb 2022 09:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235206AbiBEIYV (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 5 Feb 2022 03:24:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242364AbiBEIYS (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 5 Feb 2022 03:24:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72FEBC061346;
        Sat,  5 Feb 2022 00:24:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0F71CB83971;
        Sat,  5 Feb 2022 08:24:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32475C340E8;
        Sat,  5 Feb 2022 08:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644049451;
        bh=D2eOrJGsH5tAWuKjVJk1cyr3QE9TV+RAkP+9Ap0LVWo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DCvsEC4mEpUxmiAqiDUpU1QaJCEG/A8u9fWMf76Biww8Hv9N2kIQQEz/NhfnHrdgW
         Fa9piGyqUYSLbJ77/MdwHToC0mO3Seh6+dHk7kX6kSgqQ3kAsLOG7/UUMexejb83Pn
         xVdTHnh6wxK4Iig6LDtKiD+QTOAnAaQ3nLdJ3Tlw=
Date:   Sat, 5 Feb 2022 09:24:01 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Iouri Tarassov <iourit@linux.microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, spronovo@microsoft.com
Subject: Re: [PATCH v2 01/24] drivers: hv: dxgkrnl: Driver initialization and
 creation of dxgadapter
Message-ID: <Yf40IQrZR1m5mGVl@kroah.com>
References: <cover.1644025661.git.iourit@linux.microsoft.com>
 <98fe53740526526c4df85a3a3d2e13e88c95f229.1644025661.git.iourit@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98fe53740526526c4df85a3a3d2e13e88c95f229.1644025661.git.iourit@linux.microsoft.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Feb 04, 2022 at 06:33:59PM -0800, Iouri Tarassov wrote:
> This is the first commit for adding support for a Hyper-V based
> vGPU implementation that exposes the DirectX API to Linux userspace.

"This is the first commit" doesn't need to be in the changelog, right?
Please read the documentation for how to write a changelog text, and
look at all of the thousands of examples on the mailing list of others.

Also, it would help if this patch would build :(

