Return-Path: <linux-hyperv+bounces-3422-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9DC9E7ED1
	for <lists+linux-hyperv@lfdr.de>; Sat,  7 Dec 2024 08:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E593284F72
	for <lists+linux-hyperv@lfdr.de>; Sat,  7 Dec 2024 07:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A479276034;
	Sat,  7 Dec 2024 07:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LNc4DNUc"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7950B55896;
	Sat,  7 Dec 2024 07:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733558071; cv=none; b=F1aoqCkk7ZIbXAHnLpxrgZpzQanckiae2dBkOAUyU9fq1GQwGpHlMWf2FKoT7CroQkueyF95YR9h9YVwn01gc/9XaAkwMQiE7MiptNZszxEHZwLZrX/FKUK/qEkPJs0Yl20CubHGI+J9UzGbhURko0MqAS9IgPXKjSYlU3BmsT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733558071; c=relaxed/simple;
	bh=wIO5AgXU9C5B6jiEYC0LfC2JDpUHkZyPB/PrrB9bplw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZUzenAPHjVeXHrpriI3YQ0MKE86invmy0p9mkuNZmmFICWf8lVS0dBNC7USzmfjHxM78UsgqlrBveEj6E0yry7e1IBaD0h/fQHHKxQUCRtTb2drHsHBsWw5IwKrleX6Q97ckQ2d5mx1uJtjXpeT9owJ+iUeog4YUtsdhHHYm3Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LNc4DNUc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF8A3C4CECD;
	Sat,  7 Dec 2024 07:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733558071;
	bh=wIO5AgXU9C5B6jiEYC0LfC2JDpUHkZyPB/PrrB9bplw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LNc4DNUcsHdXLulJ6l+Im/HI/gG+a7qUln1tsoFekWjUrpIln+Sln2/X4DQdb+lVH
	 HBwjfxuZ3AroEqdKxftlX/MgK2+4GXfrFufhUzC5IOqOc7ElL4JUKXom41pkBkP33I
	 j+a9uZaTeXGXIg3ZHf/AhVKHy2bLSmT4zddDW/rESF6vd/rX1sWJMrjMjm//IfgXaz
	 pZGBbpynLzbCVsEMDVgcPOaBVWPuMu8gkNl/ahFYgIuc3D4oOVpuS2yLOGMlUgwY8a
	 mhA8uprAc230aAuWmkxvilbXdp52cxJdFLMBUVJX9uFIR11j4Am5ll0jaDSn3wA+sG
	 tB80D2e7iVENg==
Date: Sat, 7 Dec 2024 07:54:29 +0000
From: Wei Liu <wei.liu@kernel.org>
To: mhklinux@outlook.com
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, gregkh@linuxfoundation.org,
	vkuznets@redhat.com, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Drivers: hv: util: Two fixes in util_probe()
Message-ID: <Z1P_NSktVyPyF0Cv@liuwe-devbox-debian-v2>
References: <20241106154247.2271-1-mhklinux@outlook.com>
 <Z1PzH0F-3BAXpuBU@liuwe-devbox-debian-v2>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1PzH0F-3BAXpuBU@liuwe-devbox-debian-v2>

On Sat, Dec 07, 2024 at 07:02:55AM +0000, Wei Liu wrote:
> On Wed, Nov 06, 2024 at 07:42:45AM -0800, mhkelley58@gmail.com wrote:
> > From: Michael Kelley <mhklinux@outlook.com>
> > 
> > Patch 1 fixes util_probe() to not force the error return value to
> > ENODEV when the util_init function fails -- just return the error
> > code from util_init so the real error code is displayed in messages.
> > 
> > Patch 2 fixes a more serious race condition between initialization
> > of the VMBus channel and initial operations of the user space
> > daemons for KVP and VSS. The fix reorders the initialization in
> > util_probe() so the race condition can't happen.
> > 
> > The two fixes are functionally independent, but Patch 2 introduces
> > the util_init_transport function that parallels the existing code
> > for the util_init function. Doing Patch 1 first avoids an
> > inconsistency in the error handling in similar code for these two
> > parts of util_probe().
> > 
> > This series is v2 of a single patch first posted by Dexuan Cui
> > to fix the race condition.[1] I've taken over the patch per
> > discussion with Dexuan.
> > 
> > [1] https://lore.kernel.org/linux-hyperv/20240909164719.41000-1-decui@microsoft.com/
> > 
> > Michael Kelley (2):
> >   Drivers: hv: util: Don't force error code to ENODEV in util_probe()
> >   Drivers: hv: util: Avoid accessing a ringbuffer not initialized yet
> 
> Acked-by: Wei Liu <wei.liu@kernel.org>

Applied to hyperv-fixes, thanks.

