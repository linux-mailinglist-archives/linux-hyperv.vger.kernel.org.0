Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A494701E6
	for <lists+linux-hyperv@lfdr.de>; Mon, 22 Jul 2019 16:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730678AbfGVOIO (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 22 Jul 2019 10:08:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:48364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730647AbfGVOIN (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 22 Jul 2019 10:08:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CB1121911;
        Mon, 22 Jul 2019 14:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563804493;
        bh=LG1lu2Lupaaa2u676U69LswNVhExYLZ8UnOzH7BLwYs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=knbrqspLy5/ip47SnYFMM7RfeRsyA71k6l+729sHoiWRRtfrQjTqz6/IfbjRb8nW/
         3Y5HByy/vDXGEnRqdTdKRP2RuoI58xTVb6L/hnWQCGR5e2vdDYSmEv1MwPUJIEfhhd
         cbdnDw1RrPnYATsU7h7dggmKd0Gc/7708zbTV9sY=
Date:   Mon, 22 Jul 2019 16:08:09 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nishad Kamdar <nishadkamdar@gmail.com>
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>, Joe Perches <joe@perches.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hv: Use the correct style for SPDX License Identifier
Message-ID: <20190722140809.GA29862@kroah.com>
References: <20190722133112.GA7990@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722133112.GA7990@nishad>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Jul 22, 2019 at 07:01:17PM +0530, Nishad Kamdar wrote:
> This patch corrects the SPDX License Identifier style
> in the trace header file related to Microsoft Hyper-V
> client drivers.
> For C header files Documentation/process/license-rules.rst
> mandates C-like comments (opposed to C source files where
> C++ style should be used)
> 
> Changes made by using a script provided by Joe Perches here:
> https://lkml.org/lkml/2019/2/7/46
> 
> Suggested-by: Joe Perches <joe@perches.com>
> Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
