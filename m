Return-Path: <linux-hyperv+bounces-6739-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC2AB44A41
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Sep 2025 01:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2D56166743
	for <lists+linux-hyperv@lfdr.de>; Thu,  4 Sep 2025 23:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A8A2EE272;
	Thu,  4 Sep 2025 23:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jXMDOONL"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B0D2EC0A3;
	Thu,  4 Sep 2025 23:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757027481; cv=none; b=kRfzv3m1Yaw9qwhqdSiH+ObpqKkRTIbdiCVPFQjiyw0qeKLoicNIoyBfgzmuU/9qrNxShQ9uJHA0KZQbd838aEhWZQGJdvZTgfKvOp3YK0UuHerldAaPIPbH8FdqVXYOqvWYeKR2jf7y2xT6UkB/mykodod686DpyIo+TTB8fyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757027481; c=relaxed/simple;
	bh=Oq0+ozKp6mMfClI+DclioC9F8J+WvSAYCAf0Xk9pN1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u0KbMx/95LEzMyKch38CGRfHysEcc3tSd4ethtAQW0vqXtxjaUE+D6RKPT1KLbnZybOQ3Hv5I4HOTwFlTXX/2Jy289rLK/7P0owBNTidxg7lr4A80LVE9eJtwOT59lUDwXUjMd9xm80z5V3bgiDY/1qLNWyRC2IHTsOTv4sdLy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jXMDOONL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C018C4CEF0;
	Thu,  4 Sep 2025 23:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757027480;
	bh=Oq0+ozKp6mMfClI+DclioC9F8J+WvSAYCAf0Xk9pN1o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jXMDOONLgTSJ2LlhM+7Zt0AR8fP+1eis0bUW1/vqYFN11TyqxodlHXqSJEKzaJiYk
	 xKeZ9J4nbkae/JFaDqP7KWPCQgY0D7OvtPLagX4G1dnP6uIXcjEb7wY9JZkOfrDj0B
	 eFCq60yJBJBV7aAIvggYa9G0O0B5kjqfGRuqt4EItXpKOr78XgSqz3wOWhlUpC6MJX
	 RxmisFc30hLSQ6pkjgC5e7NrE6thIFCwtgNsnn6wiirzfCCJ56OmvrqqBwejQ3IlkV
	 s2uYyw4RyfkvxfAHTqtZoAMLXP16kmMAuA6GPGnLE4gPGU2imnhksqScpw/fo7x3q1
	 eDZxyFpxIcTew==
Date: Thu, 4 Sep 2025 23:11:19 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Tianyu Lan <ltykernel@gmail.com>
Cc: mhklinux@outlook.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, kys@microsoft.com,
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	gustavoars@kernel.org
Subject: Re: [PATCH 1/1] Drivers: hv: Simplify data structures for VMBus
 channel close message
Message-ID: <aLocl7JnI2AZb43E@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
References: <20250831160406.958974-1-mhklinux@outlook.com>
 <CAMvTesBGma=mXDvY=3aqp0k3A3LQt1y7gnMLrD4CqJ1WW1dPSA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMvTesBGma=mXDvY=3aqp0k3A3LQt1y7gnMLrD4CqJ1WW1dPSA@mail.gmail.com>

On Mon, Sep 01, 2025 at 01:56:17AM +0800, Tianyu Lan wrote:
> On Mon, Sep 1, 2025 at 12:06 AM <mhkelley58@gmail.com> wrote:
> >
> > From: Michael Kelley <mhklinux@outlook.com>
> >
> > struct vmbus_close_msg is used for sending the VMBus channel close
> > message. It contains a struct vmbus_channel_msginfo, which has a
> > flex array member at the end. The latter's presence in the middle
> > of struct vmbus_close_msg causes warnings when built with
> > -Wflex-array-member-not-at-end.
> >
> > But the struct vmbus_channel_msginfo is unused because the Hyper-V host
> > does not send a response to the channel close message. So remove the
> > struct vmbus_channel_msginfo. Then, since the only remaining field is
> > struct vmbus_channel_close_channel, also remove the containing struct
> > vmbus_close_msg and directly use struct vmbus_channel_close_channel.
> > Besides eliminating unnecessary complexity, these changes resolve the
> > -Wflex-array-member-not-at-end warnings.
> >
> > Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> > ---
> 
> Reviewed-by: Tianyu Lan <tiala@microsoft.com>

Applied. Thanks.

