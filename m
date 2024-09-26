Return-Path: <linux-hyperv+bounces-3071-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38732986B7A
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Sep 2024 05:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA4C7B217AD
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Sep 2024 03:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C12D176AA0;
	Thu, 26 Sep 2024 03:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="KSDhygar"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FFE917ADFF;
	Thu, 26 Sep 2024 03:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727322310; cv=none; b=uFUUOEndy4AMjcTURc1RVPvjkMvQoW4XiqE0s5tOQSCL2PIjpLbmpY7ZDHcVmEkR73+qLbb4RQh+USV5A1wh9cgOo94m/22COSwxhwTqE247zv6wu9vqUP5kKpPDFaigCFfuYxZJicHfmDQBiB5O4zNefXLGCP5Y7JMByv2jVOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727322310; c=relaxed/simple;
	bh=qji11PFodQTOGl0U/FI207nQGwy3hvtRdkGk+gDTKWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hg27w3fA8o+ykyLBdrxmdn3c8SqIIjuCew+FvBABNzwhyk0bTrUX0YnzAaWwUKEMj15X1oI4KGATeyZEJ4cgocYELV8N6EakUUbLuMYsm4H25vibbAHdufvXjM9zsmG/CL4uEz5GV/PQDpS3VA1YXJxBnS75g1a0WNpatT5Mu5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=KSDhygar; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 29D0B20C6B0A; Wed, 25 Sep 2024 20:45:08 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 29D0B20C6B0A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1727322308;
	bh=DN5YSrMcwxqMpqpqgpFbw4VHtXj52g4zYkkDf2IuhRc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KSDhygarWPIt79snSww0jYF6WyHhTZpwoa3xCQ0EbmZ9LhBJ8MqixPMjphmP8ziE8
	 7ekGubcopsjiyS9MDB3iRWpwKMeM2GrdFJ51NqO0waRt33DAOZ7lFfur3jL0grqm85
	 9eTFo3go+j2oZcGVnf4yjMehKGXaruJbhl5BDQak=
Date: Wed, 25 Sep 2024 20:45:08 -0700
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, jikos@kernel.org, bentiss@kernel.org,
	dmitry.torokhov@gmail.com, linux-hyperv@vger.kernel.org,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	ernis@microsoft.com, rafael@kernel.org, pavel@ucw.cz,
	lenb@kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 0/3] Disable Suspend-to-Idle in Hyper-V and Fix
 Hibernation Interruptions
Message-ID: <20240926034508.GA25516@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1726176470-13133-1-git-send-email-ernis@linux.microsoft.com>
 <ZvIxVn1NKWuJ4u2k@csail.mit.edu>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZvIxVn1NKWuJ4u2k@csail.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Tue, Sep 24, 2024 at 03:26:14AM +0000, Srivatsa S. Bhat wrote:
> Hi Vennela,
> 
> [+linux-pm, Rafael, Pavel, Len]
> 
> Let's CC the linux-pm mailing list for discussions related to power
> management features (such as suspend/resume and hibernation).
> 
> On Thu, Sep 12, 2024 at 02:27:47PM -0700, Erni Sri Satya Vennela wrote:
> > It has been reported that Hyper-V VM users can unintentionally abort
> > hibernation by mouse or keyboard movements. To address this issue,
> > we have decided to remove the wakeup events for the Hyper-V keyboard
> > and mouse driver.
> 
> >From the description of the problem, it doesn't occur to me that this
> is specific to Hyper-V. I was wondering if VMs on other hypervisor
> platforms wouldn't face the same issue? I'd like to recommend
> exploring how this problem has been solved for other platforms, so
> that we can reuse the same approach here. (If it turns out that
> removing keyboard and mouse wakeup events is the way to go, then
> great; otherwise, we can learn and apply the recommended solution).
> 
This is how the keyboard and mouse devices can be disabled manually and
is the proper way to address this issue.
>echo disabled > /sys/bus/vmbus/drivers/hid_hyperv/$HV_MOUSE/power/wakeup
>echo disabled > 
>/sys/bus/vmbus/drivers/hyperv_keyboard/$HV_KEYBOARD/power/wakeup
>systemctl hibernate
But based on customer feedback we are totally eliminating them as wakeup
events.

Initially, they were registered as wakeup events to wakeup from
Suspend-to-Idle state. Since there is no real user of this operation,
we are disabling them to ensure they do not interfere with hibernation
process.
> > However, this change introduces another problem: 
> > Suspend-to-Idle brings the system down with no method to wake it back up.
> > 
> > Given that there are no real users of Suspend-to-Idle in Hyper-V,
> > we have decided to disable this feature for VMBus. This results in:
> > 
> > $echo freeze > /sys/power/state
> > > bash: echo: write error: Operation not supported
> > 
> > The keyboard and mouse were previously registered as wakeup sources to
> > interrupt the freeze operation in a VM. Since the freeze operation itself
> > is no longer supported, we are disabling them as wakeup events.
> > 
> > This patchset ensures that the system remains stable and prevents
> > unintended interruptions during hibernation.
> > 
> > Erni Sri Satya Vennela (3):
> >   Drivers: hv: vmbus: Disable Suspend-to-Idle for VMBus
> >   Revert "Input: hyperv-keyboard - register as a wakeup source"
> >   Revert "HID: hyperv: register as a wakeup source"
> > 
> >  drivers/hid/hid-hyperv.c              |  6 ------
> >  drivers/hv/vmbus_drv.c                | 15 ++++++++++++++-
> >  drivers/input/serio/hyperv-keyboard.c | 12 ------------
> >  3 files changed, 14 insertions(+), 19 deletions(-)
> > 
> > -- 
> > 2.34.1
> > 
> > 
> 
> Regards,
> Srivatsa
> Microsoft Linux Systems Group

