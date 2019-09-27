Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34A54C04CB
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Sep 2019 14:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbfI0MFP (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 27 Sep 2019 08:05:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:59988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726087AbfI0MFP (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 27 Sep 2019 08:05:15 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2946B217D7;
        Fri, 27 Sep 2019 12:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569585914;
        bh=W3Fut34UYd87648+dZlDGceVMqrfwS5SkthrB6eivls=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ov8RUuH/Vluia5z9gTayuY3fyS6jNImzZIAwMUryKnJXG9Lz+T6yOD54+T8IViSYH
         ws3GBi0RdsNwQHXG8jHxP0g6HRX8a0Ng5XvGjjHRQflxFecx/K2v+5LpzwWkajR52v
         +NW866OC9BVmZ6l3ic09nwkjI57H/1UtS4EdqK10=
Date:   Fri, 27 Sep 2019 08:05:13 -0400
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
Message-ID: <20190927120513.GM8171@sasha-vm>
References: <1568244952-66716-1-git-send-email-decui@microsoft.com>
 <PU1P153MB01695CEE01D65E8CD5CFA4E9BF870@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <nycvar.YFH.7.76.1909261521410.24354@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.1909261522380.24354@cbobk.fhfr.pm>
 <PU1P153MB016973F30CC1A52E46D15230BF810@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <PU1P153MB016973F30CC1A52E46D15230BF810@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Sep 27, 2019 at 05:42:31AM +0000, Dexuan Cui wrote:
>> From: Jiri Kosina <jikos@kernel.org>
>> Sent: Thursday, September 26, 2019 6:23 AM
>> To: Dexuan Cui <decui@microsoft.com>
>>
>> On Thu, 26 Sep 2019, Jiri Kosina wrote:
>>
>> > > > This patch is basically a pure Hyper-V specific change and it has a
>> > > > build dependency on the commit 271b2224d42f ("Drivers: hv: vmbus:
>> > > > Implement
>> > > > suspend/resume for VSC drivers for hibernation"), which is on Sasha
>> Levin's
>> > > > Hyper-V tree's hyperv-next branch [ ... snipped ...]
>> > > >
>> > > > I request this patch should go through Sasha's tree rather than the
>> > > > input subsystem's tree.
>> > > >
>> > > > Hi Jiri, Benjamin, can you please Ack?
>> > >
>> > > Hi Jiri, Benjamin,
>> > > Can you please take a look at the patch?
>> >
>> > Hi Dexuan,
>> >
>> > I am planning to process it once 5.4 merge window is over and thus hid.git
>> > is open again for 5.5 material.
>>
>> Ah, now I see you asked for this go through hyperv tree. For that, feel
>> free to add
>> 	Acked-by: Jiri Kosina <jkosina@suse.cz>
>> Jiri Kosina
>
>Thanks for the Ack, Jiri!
>
>I have a bunch of patches, including this one, to support Linux VM's hibernation
>when the VM runs on Hyper-V. I just feel it would be better for all of them to
>go through the Hyper-V tree. :-)

Thank Dexuan, Jiri,

Dexuan, I've been silently ignoring your patches for the past few weeks
for the same reason as Jiri has mentioned. I'll pick them all up once
the 5.4 merge window closes in a few days.

--
Thanks,
Sasha
