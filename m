Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0F004AA51A
	for <lists+linux-hyperv@lfdr.de>; Sat,  5 Feb 2022 01:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348857AbiBEAf4 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 4 Feb 2022 19:35:56 -0500
Received: from linux.microsoft.com ([13.77.154.182]:59586 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238078AbiBEAf4 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 4 Feb 2022 19:35:56 -0500
Received: from [192.168.1.17] (unknown [192.182.151.181])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1F50820B6C61;
        Fri,  4 Feb 2022 16:35:56 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1F50820B6C61
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1644021356;
        bh=Lxh39MUIwPoB4L77nmzR+NxgwzKfDafwt/YKb1Z9Oyk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=IumbASqLXkb8e1ibpmpHYMvxXZidJ5avumnPKdXaqW1EVALP1PWXs640zZhYUu0pe
         Iep8qGZJRpsZ3BxAFIzHRdIXowRYphqso9HBcgnuPiKS4S1Em5gr2KXO1ifjDBl0wO
         ooC33qR8biJi7OiVtyBVNYhh5VHBksZZKQhHimkY=
Message-ID: <deb33dd6-06c8-13c1-8d37-4c4f36248d96@linux.microsoft.com>
Date:   Fri, 4 Feb 2022 16:35:55 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v1 9/9] drivers: hv: dxgkrnl: Implement DXGSYNCFILE
Content-Language: en-US
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, spronovo@microsoft.com,
        gregkh@linuxfoundation.org,
        DRI Development <dri-devel@lists.freedesktop.org>,
        jenatali@microsoft.com
References: <cover.1641937419.git.iourit@linux.microsoft.com>
 <e04c8e820bc166d9d4fe8e388aace731bb3255b0.1641937420.git.iourit@linux.microsoft.com>
 <YeG6+Crv/Bg4h3u1@phenom.ffwll.local>
 <e472cbe8-44ec-110a-1ad7-bc561cd0be88@linux.microsoft.com>
 <CAKMK7uFkVvfXM7QsgSfP4OLk9b_cSwNsi3s3_7EFuL+Pa1s7eQ@mail.gmail.com>
From:   Iouri Tarassov <iourit@linux.microsoft.com>
In-Reply-To: <CAKMK7uFkVvfXM7QsgSfP4OLk9b_cSwNsi3s3_7EFuL+Pa1s7eQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


On 1/17/2022 1:35 AM, Daniel Vetter wrote:
> On Mon, Jan 17, 2022 at 9:34 AM Iouri Tarassov
> <iourit@linux.microsoft.com> wrote:
> >
> >
> btw another idea I had over the w/e: Another option might be to allow
> different backends for sync_file, and then making sure that you cannot
> ever mix dma_fence and hv_dxg_fence type sync_file up (in e.g. the
> merge ioctl).
>
> The issue is that fundamentally dma_fence and memory fences (or umf
> for userspace memory fences as we tend to call them) aren't
> compatible, but some of the interop plans we have is to allow stuffing
> either of them into fence container objects like sync_file. So going
> that route for wddm monitored fence support too could be a really
> future-proof approach, plus it'd allow you to still share the
> sync_file interface code. Not that it's going to be much code sharing,
> since all the implementation code needs to be distinct.
> -Daniel

Thanks Daniel!

I will remove the patch for dxgsyncfile from the next set of upstream 
patches.

It will be added later after a re-design.

Iouri

