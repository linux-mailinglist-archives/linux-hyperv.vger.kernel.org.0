Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E11871FAE91
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Jun 2020 12:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728332AbgFPKvX (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 16 Jun 2020 06:51:23 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:53412 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728049AbgFPKvX (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 16 Jun 2020 06:51:23 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 81F591C0BD2; Tue, 16 Jun 2020 12:51:21 +0200 (CEST)
Date:   Tue, 16 Jun 2020 12:51:13 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Sasha Levin <sashal@kernel.org>, alexander.deucher@amd.com,
        chris@chris-wilson.co.uk, ville.syrjala@linux.intel.com,
        Hawking.Zhang@amd.com, tvrtko.ursulin@intel.com,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, spronovo@microsoft.com, iourit@microsoft.com,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [RFC PATCH 0/4] DirectX on Linux
Message-ID: <20200616105112.GC1718@bug>
References: <20200519163234.226513-1-sashal@kernel.org>
 <55c57049-1869-7421-aa0f-3ce0b6a133cf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55c57049-1869-7421-aa0f-3ce0b6a133cf@suse.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi!

> > The driver creates the /dev/dxg device, which can be opened by user mode
> > application and handles their ioctls. The IOCTL interface to the driver
> > is defined in dxgkmthk.h (Dxgkrnl Graphics Port Driver ioctl
> > definitions). The interface matches the D3DKMT interface on Windows.
> > Ioctls are implemented in ioctl.c.
> 
> Echoing what others said, you're not making a DRM driver. The driver should live outside 
> of the DRM code.
> 

Actually, this sounds to me like "this should not be merged into linux kernel". I mean,
we already have DRM API on Linux. We don't want another one, do we?

And at the very least... this misses API docs for /dev/dxg. Code can't really 
be reviewed without that.

Best regards,
										Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
