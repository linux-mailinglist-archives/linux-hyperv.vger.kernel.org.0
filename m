Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9197B5BA
	for <lists+linux-hyperv@lfdr.de>; Wed, 31 Jul 2019 00:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbfG3Wbz (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 30 Jul 2019 18:31:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:57282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727512AbfG3Wbz (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 30 Jul 2019 18:31:55 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45282206E0;
        Tue, 30 Jul 2019 22:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564525914;
        bh=bhYUGbSkY3Uo3tTdsGT0lHKsZ9LoYbOAtkZDResN6Q8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AvJ07IND6QhnbzeKIvDtiVfLTCvEH1PJncUEkT4tduuF3whzeXyJE9EL3dbSvA2mR
         sTPT96y2ClhIdwR/tfKmXNqbKje5WChKeNa/JrzBcQuOGfnHzkmzRmvHTYMHbnoJdm
         UuRnyi/NO75ll3g9of5v5lOyK8W+5ub3tRFanzYM=
Date:   Tue, 30 Jul 2019 18:31:53 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Nishad Kamdar <nishadkamdar@gmail.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Joe Perches <joe@perches.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hv: Use the correct style for SPDX License Identifier
Message-ID: <20190730223153.GJ29162@sasha-vm>
References: <20190722133112.GA7990@nishad>
 <20190722140809.GA29862@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190722140809.GA29862@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Jul 22, 2019 at 04:08:09PM +0200, Greg Kroah-Hartman wrote:
>On Mon, Jul 22, 2019 at 07:01:17PM +0530, Nishad Kamdar wrote:
>> This patch corrects the SPDX License Identifier style
>> in the trace header file related to Microsoft Hyper-V
>> client drivers.
>> For C header files Documentation/process/license-rules.rst
>> mandates C-like comments (opposed to C source files where
>> C++ style should be used)
>>
>> Changes made by using a script provided by Joe Perches here:
>> https://lkml.org/lkml/2019/2/7/46
>>
>> Suggested-by: Joe Perches <joe@perches.com>
>> Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
>
>Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Queued up for hyperv-fixes, thanks!

--
Thanks,
Sasha
