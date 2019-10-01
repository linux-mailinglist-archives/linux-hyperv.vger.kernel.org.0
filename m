Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 651A6C4007
	for <lists+linux-hyperv@lfdr.de>; Tue,  1 Oct 2019 20:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725905AbfJASkZ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 1 Oct 2019 14:40:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:60376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbfJASkZ (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 1 Oct 2019 14:40:25 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEB472133F;
        Tue,  1 Oct 2019 18:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569955225;
        bh=Z4IfwR1ZU5AEcqWAHKoTrywxvUITptIy5CVJe05Wp6k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FAoLSjdOImd8QCvzlGTOvffzRpYS7KLZdQY5YQDAFLBIl2nzJDIwHVx7d1+VYzZb2
         1lh8GPwWzlD7DoXpKTA0FOwZehDfUMy1G2NUNyla+UvV770Mtqm1e3PfM/XT4KlezQ
         RBsvFR/gbUz4swY60V8by29UByJx5d1OCyGCDt2E=
Date:   Tue, 1 Oct 2019 14:40:23 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     Jiri Kosina <jikos@kernel.org>, KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH] HID: hyperv: Add the support of hibernation
Message-ID: <20191001184023.GC8171@sasha-vm>
References: <1568244952-66716-1-git-send-email-decui@microsoft.com>
 <PU1P153MB01695CEE01D65E8CD5CFA4E9BF870@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <nycvar.YFH.7.76.1909261521410.24354@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.1909261522380.24354@cbobk.fhfr.pm>
 <PU1P153MB016973F30CC1A52E46D15230BF810@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20190927120513.GM8171@sasha-vm>
 <PU1P153MB01698048162343130F34DAE0BF830@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <PU1P153MB01698048162343130F34DAE0BF830@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sun, Sep 29, 2019 at 05:44:09PM +0000, Dexuan Cui wrote:
>> From: Sasha Levin <sashal@kernel.org>
>> Dexuan, I've been silently ignoring your patches for the past few weeks
>> for the same reason as Jiri has mentioned. I'll pick them all up once
>> the 5.4 merge window closes in a few days.
>
>Thanks, Sasha!
>
>BTW, I'll post a v2 for this patch, as IMO I may be able to get rid of the
>mousevsc_pm_notify in this patch by disabling the channel callback
>in the suspend function.

Okay, I'm ignoring this patch for now then.

--
Thanks,
Sasha
