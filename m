Return-Path: <linux-hyperv+bounces-7645-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 230BFC65ED5
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Nov 2025 20:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 8DE86293EE
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Nov 2025 19:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2C5337BAC;
	Mon, 17 Nov 2025 19:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ehuo/z5Q"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10251E9B1A;
	Mon, 17 Nov 2025 19:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763407109; cv=none; b=KnEDgPRX9tIX1NE5oNj4NYzg1n0IpRtiTGkikF95pBRYBxEEn7m5SASauNnRshXDhD+Eeb/rKsfAaeqarMTpJLxbOix7A3rqwImLFc+7/1z3ucaMU2+ZY3Z9HDvPiLaBeE0uNV4S3YjsIrrTvaVpvQUigUb06W5Ic1ZSLKmxgzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763407109; c=relaxed/simple;
	bh=5dBKsasnWB7y7G4tagibRl/eAqR29KMAuOUwo6yffbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OB3YkbsV5o6BenUqTCZZb9YLmLqkbPCkR+8WuU7ru6fIUWDsMRF5IP7KBbd+LJkzCIbpY/HDv71bHgso4W9sJgqPIA6/b6Lf47vQNwJnmejD3azeLUPzMDbCyv1CzM/+jJ+5z6I2sgCmrbPx2c6umiGtofrFbNJbTey37EgLeFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ehuo/z5Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAE9FC2BCB8;
	Mon, 17 Nov 2025 19:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763407109;
	bh=5dBKsasnWB7y7G4tagibRl/eAqR29KMAuOUwo6yffbA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ehuo/z5QWdC4IUNh6frKNmS6fjxJ0rxaRdXQ+TO7vEDByKHHTZghMR1ql9bwepVqS
	 QpuFy8HNGtVJSSTtZfDV1fZs6FoYyvpw6ZI9gT2emUadb8eY65lA3L6RXqlybxFOmM
	 tCA5Ous6NDvsNPoYVPEJmAV1nHVv2cCYFKbpFYFYFEbKiMd13dqflSuZnKfcDRl3+q
	 7PzvYY2erhgrv51+6CB0bgMG6iPq3tonGF3M16ItNW9tRwNbZo1NIYfKTjfNaCJ6GL
	 yoxNpzQvhzsyk/7XcTk79JOpOgdxKy6drqM7E5udXvy9xBYKygW8LeHCOMPCxk0kLQ
	 1Ktfa6RSpHkQA==
Date: Mon, 17 Nov 2025 19:18:27 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: Anirudh Rayabharam <anirudh@anirudhrb.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Drivers: hv: ioctl for self targeted passthrough
 hvcalls
Message-ID: <20251117191827.GC2380208@liuwe-devbox-debian-v2.local>
References: <20251117095207.113502-1-anirudh@anirudhrb.com>
 <36ac7105-3aa7-4e53-b87d-b99438f65295@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36ac7105-3aa7-4e53-b87d-b99438f65295@linux.microsoft.com>

On Mon, Nov 17, 2025 at 10:16:12AM -0800, Nuno Das Neves wrote:
> On 11/17/2025 1:52 AM, Anirudh Rayabharam wrote:
> > From: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
> > 
> > Allow MSHV_ROOT_HVCALL IOCTL on the /dev/mshv fd. This IOCTL would
> > execute a passthrough hypercall targeting the root/parent partition
> > i.e. HV_PARTITION_ID_SELF.
> > 
> 
> I think it's worth taking a moment to check and perhaps explain in
> the commit message/a comment any security implications of the VMM
> process being able to call these hypercalls on the root/parent
> partition.
> 
> One implication would be: can the VMM process influence other
> processes in the root partition via these hypercalls,
> e.g. HVCALL_SET_VP_REGISTERS? I would think that the hypervisor
> itself disallows this but we should check. We can ask the
> hypervisor team what they think, and check the hypervisor code.
> 
> Specifically we should check on any hypercall that could possibly
> influence partition state, i.e.:
> HVCALL_SET_PARTITION_PROPERTY
> HVCALL_SET_VP_REGISTERS
> HVCALL_INSTALL_INTERCEPT
> HVCALL_CLEAR_VIRTUAL_INTERRUPT
> HVCALL_REGISTER_INTERCEPT_RESULT
> HVCALL_ASSERT_VIRTUAL_INTERRUPT
> HVCALL_SIGNAL_EVENT_DIRECT
> HVCALL_POST_MESSAGE_DIRECT
> 
> If it turns out there is something risky we are enabling here, we can
> introduce a new array of hypercalls to restrict which ones can be
> called on HV_PARTITION_ID_SELF.
> 

This is a good point. Please check with the hypervisor team.

Wei

