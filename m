Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9039DBF3F8
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Sep 2019 15:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbfIZNXp (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 26 Sep 2019 09:23:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:45262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726152AbfIZNXp (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 26 Sep 2019 09:23:45 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE9DB217F4;
        Thu, 26 Sep 2019 13:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569504224;
        bh=B0CrnmzE6behyZVfrZbqSSHUmGDDItcrR1NCMuG0aTk=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=pPxNSfgRq4cr7iKEtKePqc3Gs62H2JOmr1WdAAVmvmaSiJzJ6vT2H36qQohyHcCfk
         moyauJ4aRBZpQrMlWqksJAB7/njQTb9XwxuGYZIQxQ1o8c9Nb/fW3tu2wa13fDek5n
         yD7j2tIc8b0LhLa7mqW4Z8lBXMWIBChJvavfc2Iw=
Date:   Thu, 26 Sep 2019 15:23:18 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Dexuan Cui <decui@microsoft.com>
cc:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Subject: RE: [PATCH] HID: hyperv: Add the support of hibernation
In-Reply-To: <nycvar.YFH.7.76.1909261521410.24354@cbobk.fhfr.pm>
Message-ID: <nycvar.YFH.7.76.1909261522380.24354@cbobk.fhfr.pm>
References: <1568244952-66716-1-git-send-email-decui@microsoft.com> <PU1P153MB01695CEE01D65E8CD5CFA4E9BF870@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM> <nycvar.YFH.7.76.1909261521410.24354@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, 26 Sep 2019, Jiri Kosina wrote:

> > > We need mousevsc_pm_notify() to make sure the pm_wakeup_hard_event() 
> > > call does not prevent the system from entering hibernation: the 
> > > hibernation is a relatively long process, which can be aborted by the 
> > > call pm_wakeup_hard_event(), which is invoked upon mouse events.
> > > 
> > > Signed-off-by: Dexuan Cui <decui@microsoft.com>
> > > ---
> > > 
> > > This patch is basically a pure Hyper-V specific change and it has a
> > > build dependency on the commit 271b2224d42f ("Drivers: hv: vmbus:
> > > Implement
> > > suspend/resume for VSC drivers for hibernation"), which is on Sasha Levin's
> > > Hyper-V tree's hyperv-next branch [ ... snipped ...]
> > > 
> > > I request this patch should go through Sasha's tree rather than the
> > > input subsystem's tree.
> > > 
> > > Hi Jiri, Benjamin, can you please Ack?
> > 
> > Hi Jiri, Benjamin,
> > Can you please take a look at the patch?
> 
> Hi Dexuan,
> 
> I am planning to process it once 5.4 merge window is over and thus hid.git 
> is open again for 5.5 material.

Ah, now I see you asked for this go through hyperv tree. For that, feel 
free to add

	Acked-by: Jiri Kosina <jkosina@suse.cz>

Thanks,

-- 
Jiri Kosina
SUSE Labs

