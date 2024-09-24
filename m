Return-Path: <linux-hyperv+bounces-3061-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FBA3983B84
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Sep 2024 05:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 013C2B22563
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Sep 2024 03:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1841805A;
	Tue, 24 Sep 2024 03:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=outgoing.csail.mit.edu header.i=@outgoing.csail.mit.edu header.b="O8SwsVsr"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from outgoing2021.csail.mit.edu (outgoing2021.csail.mit.edu [128.30.2.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4AF11CAF;
	Tue, 24 Sep 2024 03:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.30.2.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727148386; cv=none; b=K3idLn5rv/U8Jt8I4oHlcEUcB8wIXejFOgheD5AGXgw6v0/GTs4qKsDkZla1Fx2uGuQy3eUPx1Z0mWcwrkqZ0kYIjxsnVoEqdbBZZqCD8R43rz/9wHljJ4rB+jIrWZ7NKBIKxqbqd1f1jc6Blg4rfNbvddiSTs6MiomkgC4GLOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727148386; c=relaxed/simple;
	bh=5do3pFCGviAlrYmjo+9gOkpJZ/1OrJuYNxeJZe4BR+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ykk3ju/GWP5lDwF3hX31AbBQfdEtz4JSte1RABsJI+pfVghoCm4TMyzQt16NmyugtRm2XFmiwjAHznOJngNv413wGp07fNFWgloaq8rX70KGXOnhw36ycqCk7M+5oijMJKVDq/zqsQvEr73FR/z367wKo+pAJYWhoD3pfLZc5A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu; spf=pass smtp.mailfrom=csail.mit.edu; dkim=pass (2048-bit key) header.d=outgoing.csail.mit.edu header.i=@outgoing.csail.mit.edu header.b=O8SwsVsr; arc=none smtp.client-ip=128.30.2.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csail.mit.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=outgoing.csail.mit.edu; s=test20231205; h=In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=cfKRFOqpf7Zq5W3HSKL69wx5R5uROv9DLNQhkhjGjN4=; t=1727148384; x=1728012384; 
	b=O8SwsVsrrYzHHpqyySGIrKM62ss/557KWQmxJjslzHg/VQfeKwyGfmPVoW9df/G2DJzx+qE5v0I
	MMijl75RAKEhbi3E9CMfD/QINt4vZ01xRlRMDzqp8kOste4gFYFJ7bt0+EP86EfbK+TlTDRn7VWJT
	xUqrpXaDAETU+IGYg8bWVML+BPc5yt+WbiOCSDFQgf7AFPu1QT9mhM5r8+rDl/y7eAJXCm0sXl0hA
	OG4lQETqHGsOfZtOJtgneAesli5sLRBLbSEC8VR8UPmJT47XJ/uI8Qtv+RpTvrCk4D7e3SRsy/a2O
	fUcZtl6hkIGB1vJqKz8qjygYuhRlv/weq0GA==;
Received: from [172.179.10.40] (helo=csail.mit.edu)
	by outgoing2021.csail.mit.edu with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <srivatsa@csail.mit.edu>)
	id 1sswBw-00EsUn-Nv;
	Mon, 23 Sep 2024 23:26:20 -0400
Date: Tue, 24 Sep 2024 03:26:14 +0000
From: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, jikos@kernel.org, bentiss@kernel.org,
	dmitry.torokhov@gmail.com, linux-hyperv@vger.kernel.org,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	ernis@microsoft.com, rafael@kernel.org, pavel@ucw.cz,
	lenb@kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 0/3] Disable Suspend-to-Idle in Hyper-V and Fix
 Hibernation Interruptions
Message-ID: <ZvIxVn1NKWuJ4u2k@csail.mit.edu>
References: <1726176470-13133-1-git-send-email-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1726176470-13133-1-git-send-email-ernis@linux.microsoft.com>

Hi Vennela,

[+linux-pm, Rafael, Pavel, Len]

Let's CC the linux-pm mailing list for discussions related to power
management features (such as suspend/resume and hibernation).

On Thu, Sep 12, 2024 at 02:27:47PM -0700, Erni Sri Satya Vennela wrote:
> It has been reported that Hyper-V VM users can unintentionally abort
> hibernation by mouse or keyboard movements. To address this issue,
> we have decided to remove the wakeup events for the Hyper-V keyboard
> and mouse driver.

From the description of the problem, it doesn't occur to me that this
is specific to Hyper-V. I was wondering if VMs on other hypervisor
platforms wouldn't face the same issue? I'd like to recommend
exploring how this problem has been solved for other platforms, so
that we can reuse the same approach here. (If it turns out that
removing keyboard and mouse wakeup events is the way to go, then
great; otherwise, we can learn and apply the recommended solution).

> However, this change introduces another problem: 
> Suspend-to-Idle brings the system down with no method to wake it back up.
> 
> Given that there are no real users of Suspend-to-Idle in Hyper-V,
> we have decided to disable this feature for VMBus. This results in:
> 
> $echo freeze > /sys/power/state
> > bash: echo: write error: Operation not supported
> 
> The keyboard and mouse were previously registered as wakeup sources to
> interrupt the freeze operation in a VM. Since the freeze operation itself
> is no longer supported, we are disabling them as wakeup events.
> 
> This patchset ensures that the system remains stable and prevents
> unintended interruptions during hibernation.
> 
> Erni Sri Satya Vennela (3):
>   Drivers: hv: vmbus: Disable Suspend-to-Idle for VMBus
>   Revert "Input: hyperv-keyboard - register as a wakeup source"
>   Revert "HID: hyperv: register as a wakeup source"
> 
>  drivers/hid/hid-hyperv.c              |  6 ------
>  drivers/hv/vmbus_drv.c                | 15 ++++++++++++++-
>  drivers/input/serio/hyperv-keyboard.c | 12 ------------
>  3 files changed, 14 insertions(+), 19 deletions(-)
> 
> -- 
> 2.34.1
> 
> 

Regards,
Srivatsa
Microsoft Linux Systems Group

