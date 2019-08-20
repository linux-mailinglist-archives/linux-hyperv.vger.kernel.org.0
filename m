Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E17659645A
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Aug 2019 17:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbfHTP24 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 20 Aug 2019 11:28:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:33368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725971AbfHTP24 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 20 Aug 2019 11:28:56 -0400
Received: from localhost (mobile-107-77-164-38.mobile.att.net [107.77.164.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 194D3206BB;
        Tue, 20 Aug 2019 15:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566314935;
        bh=R6uEsvj+Z8DveshyQXaYecmWy9jwfku6o9M4QWO+BNc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a+AWwG7CMJiydUOmA06KOkHBUfFoDK5vuvwvCWVw9Rfyv4RIRw+kzt6fEWe25+bD5
         GmODZUy8zkMZVHldv1Kxczzl/ps/j7Jp6dZoDFkPUb3LThIRDrXR0DxesNNtCuLcZy
         qodIXfCuUJhWIRXo795m1nXA+4GA582lSzZzIONU=
Date:   Tue, 20 Aug 2019 11:28:53 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Drivers: hv: vmbus: Remove the unused "tsc_page" from
 struct hv_context
Message-ID: <20190820152853.GL30205@sasha-vm>
References: <1566270393-28009-1-git-send-email-decui@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1566270393-28009-1-git-send-email-decui@microsoft.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Aug 20, 2019 at 03:06:40AM +0000, Dexuan Cui wrote:
>This field is no longer used after the commit
>63ed4e0c67df ("Drivers: hv: vmbus: Consolidate all Hyper-V specific clocksource code")
>, because it's replaced by the global variable
>"struct ms_hyperv_tsc_page *tsc_pg;" (now, the variable is in
>drivers/clocksource/hyperv_timer.c).
>
>Fixes: 63ed4e0c67df ("Drivers: hv: vmbus: Consolidate all Hyper-V specific clocksource code")
>Signed-off-by: Dexuan Cui <decui@microsoft.com>

Queued up for hyperv-fixes, thank you.

--
Thanks,
Sasha
