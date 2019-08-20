Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E770796464
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Aug 2019 17:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730178AbfHTP3R (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 20 Aug 2019 11:29:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:33652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727006AbfHTP3Q (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 20 Aug 2019 11:29:16 -0400
Received: from localhost (mobile-107-77-164-38.mobile.att.net [107.77.164.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E74C6206BB;
        Tue, 20 Aug 2019 15:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566314956;
        bh=ZrF9TUCnLV2W4EyJhMQkx9AglXnpvTw/gLkflBdNy/E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rPXezODrzMCa0ELtLvFg+/8kuvfVewd9CKnmLWsyvP9KCvkKNEKm8E0UmY5PlWyjR
         vcw2TDeAIzRGoogNDjkfcyPuZiCYttlYf12ze1vbgZ7nlokyTNcEpUMzgVjwdCT0hs
         C2DxoyW6pyDRSJZIx+75oATfpwgFFQ+T6q9qTtsE=
Date:   Tue, 20 Aug 2019 11:29:15 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
Cc:     Dexuan Cui <decui@microsoft.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Input: hyperv-keyboard: Use in-place iterator API in the
 channel callback
Message-ID: <20190820152915.GM30205@sasha-vm>
References: <1566270066-27546-1-git-send-email-decui@microsoft.com>
 <20190820031805.GO121898@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190820031805.GO121898@dtor-ws>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Aug 19, 2019 at 08:18:05PM -0700, dmitry.torokhov@gmail.com wrote:
>On Tue, Aug 20, 2019 at 03:01:23AM +0000, Dexuan Cui wrote:
>> Simplify the ring buffer handling with the in-place API.
>>
>> Also avoid the dynamic allocation and the memory leak in the channel
>> callback function.
>>
>> Signed-off-by: Dexuan Cui <decui@microsoft.com>
>> ---
>>
>> Hi Dmitry, can this patch go through Sasha's hyperv tree:
>> https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git
>>
>> This is a purely Hyper-V specific change.
>
>Sure, no problem.
>
>Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Queued up for hyperv-fixes, thank you.

--
Thanks,
Sasha
