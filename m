Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6600D2AB1B1
	for <lists+linux-hyperv@lfdr.de>; Mon,  9 Nov 2020 08:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbgKIHVa (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 9 Nov 2020 02:21:30 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:51770 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728038AbgKIHVa (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 9 Nov 2020 02:21:30 -0500
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 1D01780538;
        Mon,  9 Nov 2020 08:21:26 +0100 (CET)
Date:   Mon, 9 Nov 2020 08:21:25 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Olaf Hering <olaf@aepfle.de>
Cc:     linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>
Subject: Re: [PATCH v1] video: hyperv_fb: include vmalloc.h
Message-ID: <20201109072125.GB1715181@ravnborg.org>
References: <20201106183941.9751-1-olaf@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106183941.9751-1-olaf@aepfle.de>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VafZwmh9 c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=gAzNO5xu912kzqTqD5cA:9 a=CjuIK1q_8ugA:10
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Olaf.

On Fri, Nov 06, 2020 at 07:39:41PM +0100, Olaf Hering wrote:
> hvfb_getmem uses vzalloc, therefore vmalloc.h should be included.
> 
> Fixes commit d21987d709e807ba7bbf47044deb56a3c02e8be4 ("video: hyperv:
> hyperv_fb: Support deferred IO for Hyper-V frame buffer driver")
> 
> Signed-off-by: Olaf Hering <olaf@aepfle.de>

Thanks.
Applied to drm-misc-fixes - as it smells like a build fix in some
configurations.

	Sam
