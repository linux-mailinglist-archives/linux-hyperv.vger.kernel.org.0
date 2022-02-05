Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 511324AA7A9
	for <lists+linux-hyperv@lfdr.de>; Sat,  5 Feb 2022 09:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348756AbiBEI00 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 5 Feb 2022 03:26:26 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:49040 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238695AbiBEI0V (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 5 Feb 2022 03:26:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 826F1615F2;
        Sat,  5 Feb 2022 08:26:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ECEFC340E8;
        Sat,  5 Feb 2022 08:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644049581;
        bh=Dqhqq/MFZHKCdo49s88mJzq7BeoUMhaAFf+aqJiwsSU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B3k7ewQ8k1Z6nip513wjWhiyptLRIz+JEo3uHwckacsbZT8hBfXtr/alFHplwxPMb
         r7K7d79f7+bpbPyO4znov/54hp4CQbWusQwcz8KahwNHNU4HDc1M2agmd/2lMnB8zt
         4Q0euQu42/PvpSVzYXl25JgP5ZDgeBku/VW58xgY=
Date:   Sat, 5 Feb 2022 09:26:12 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Iouri Tarassov <iourit@linux.microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, spronovo@microsoft.com
Subject: Re: [PATCH v2 01/24] drivers: hv: dxgkrnl: Driver initialization and
 creation of dxgadapter
Message-ID: <Yf40pK55Zx+r7maX@kroah.com>
References: <cover.1644025661.git.iourit@linux.microsoft.com>
 <98fe53740526526c4df85a3a3d2e13e88c95f229.1644025661.git.iourit@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98fe53740526526c4df85a3a3d2e13e88c95f229.1644025661.git.iourit@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Feb 04, 2022 at 06:33:59PM -0800, Iouri Tarassov wrote:
> +Hyper-V vGPU DRIVER

This should be all caps.

