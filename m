Return-Path: <linux-hyperv+bounces-10269-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMCREyuI52kU9wEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10269-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Apr 2026 16:22:35 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F51643BF09
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Apr 2026 16:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 701FE3036EDE
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Apr 2026 14:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175213D75D4;
	Tue, 21 Apr 2026 14:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RyE+2kKa"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E804DEED8;
	Tue, 21 Apr 2026 14:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776781122; cv=none; b=WqKTvHMbdl+YmzRPou3y9qXLg8LsfxOTBJbWNfXx6kHDbhCCffUIklh2DQMJjxgISKqD5/cfkLfyl+myzZUAIc4VQhEV5KcGGmo8m1EfehhDssBk2Mk5ZAv3wePgfQol483+ZNp7djJqJ5YcIaTwVrN6bBmmHCmJUeOcC9Y8Ny4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776781122; c=relaxed/simple;
	bh=3Ct/SPVIVJ2+EBRzhARfaZ8x6ntKDyeLe8hrRi9Fxd8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RsX5Mz3dB/Jtb8Lz12DLefWKKR2laFoqtwEwq7W3cD2gEz92CCIZavFrvkm+so37coP1XthxNKSp5i5CWw/eZ8t+TCPb7I4TAuyaZ3AVONKFW5oH7tEm/CzxWXl29IbyjYtJ9Gc1szubOjABGYU0dliZjzgSmYApYm7guokD69c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RyE+2kKa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07BDAC2BCB0;
	Tue, 21 Apr 2026 14:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776781121;
	bh=3Ct/SPVIVJ2+EBRzhARfaZ8x6ntKDyeLe8hrRi9Fxd8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RyE+2kKa3AXBCXD9eLv1BEVn3pPHTE6Bhhn0ZQ8hqgpujDTRUlUF8fDaF8M+bLFu+
	 kbsxmPqMHi2eHDnqFXUJpMV4UE3yJ5Oig9vJcLL4HQAzI8sFzUk4pw3smjkLDLuX1H
	 DLnwOVwny8NmJneBx+LOcTjyklGdHmNHO2se2NWQ0jYtj9f8oO24rjkIbV729U9/m8
	 3LPqdB59mZyhmh0FAS2i16wI/6NDg74tUUEJGd121qxkDnJoAp5hh/TlfUoRglS8yu
	 XN/sYN5ZOuDlCuFyKP9PnHOmiR1oRNR7TQm1Fcvz8rdtAKjUIT92kjHJ2GTRxRQ9QI
	 Ritnpo5/GhytQ==
Date: Tue, 21 Apr 2026 07:18:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Dexuan Cui <DECUI@microsoft.com>, "patchwork-bot+netdevbpf@kernel.org"
 <patchwork-bot+netdevbpf@kernel.org>, KY Srinivasan <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, "wei.liu@kernel.org"
 <wei.liu@kernel.org>, Long Li <longli@microsoft.com>, "davem@davemloft.net"
 <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org"
 <horms@kernel.org>, "niuxuewei.nxw@antgroup.com"
 <niuxuewei.nxw@antgroup.com>, "linux-hyperv@vger.kernel.org"
 <linux-hyperv@vger.kernel.org>, "virtualization@lists.linux.dev"
 <virtualization@lists.linux.dev>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
 <stable@vger.kernel.org>, Ben Hillis <Ben.Hillis@microsoft.com>,
 "levymitchell0@gmail.com" <levymitchell0@gmail.com>
Subject: Re: [EXTERNAL] Re: [PATCH net v2] hv_sock: Report EOF instead of
 -EIO for FIN
Message-ID: <20260421071839.30217a60@kernel.org>
In-Reply-To: <CAGxU2F6DVcLDLg3dT5DsDmsaOuhOcD+4VSG5dqXcFRwsN1NZ+A@mail.gmail.com>
References: <20260416191433.840637-1-decui@microsoft.com>
	<177672238581.1802062.15838493180057695674.git-patchwork-notify@kernel.org>
	<SA1PR21MB69214CABCA0DCD597040F849BF2C2@SA1PR21MB6921.namprd21.prod.outlook.com>
	<CAGxU2F6DVcLDLg3dT5DsDmsaOuhOcD+4VSG5dqXcFRwsN1NZ+A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,davemloft.net,google.com,redhat.com,antgroup.com,vger.kernel.org,lists.linux.dev,gmail.com];
	TAGGED_FROM(0.00)[bounces-10269-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv,netdevbpf];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 9F51643BF09
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 21 Apr 2026 09:28:19 +0200 Stefano Garzarella wrote:
> > I'm sorry -- I just posted v3
> >     https://lore.kernel.org/linux-hyperv/20260421025950.1099495-1-decui@microsoft.com/T/#u
> > and then I realized that the v2 had been merged into the main branch :-(
> >
> > Should I post a new delta patch(with a Fixes tag against the v2) based on the main branch?  
> 
> Ehm, I'm not sure about the process but if it's merged in net tree,
> maybe we need a follow up patch.
> 
> Anyway, let's wait for Jakub's or other net maintainers' suggestions.

Yes, you have to post an incremental fix

