Return-Path: <linux-hyperv+bounces-7363-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C7EC171C1
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Oct 2025 23:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 421923AF9EB
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Oct 2025 22:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A003354AD9;
	Tue, 28 Oct 2025 22:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eXlfkAn4"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0102EAB83;
	Tue, 28 Oct 2025 22:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761688913; cv=none; b=JOd+T7+y6xIK6HrZ3FF+BBORuFAkU7SCntHTDDyjwuFu24ZjEOM+iEI318JuNs/U+l4GFvGrEP+ctSOCQPPt5186DtacgrNpUXbMs8Gqv16ZDfsYdH46aQV1CDQdXunTuJU79Pamw+yc+TbxwyKb1F0JNKdIP9pHSc7fK5EjMjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761688913; c=relaxed/simple;
	bh=8dcVnJQwd2Q2vL09vQ2gjWRm7ih677qGthho3kpNnno=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mS78x0fw1P9CmRu37aBMwUabzddTcYid1887L43E7LcsZZCuylPwwGhS3sEKKU3blbOqjKvoebjeVlnuKR2mQWR+DkqcdGWud1UFCjAj1rRBjBKYkTpTBQU0nUSS7fKs2mVdi58lMlQyJn6UaTWq6wNlS74Ct0NON6D51BR24SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eXlfkAn4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9062C4CEE7;
	Tue, 28 Oct 2025 22:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761688912;
	bh=8dcVnJQwd2Q2vL09vQ2gjWRm7ih677qGthho3kpNnno=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eXlfkAn4OAiiHxOu01TQtSDmQrnCX/tKPX6Swu5Q7eAucYKlTCJVL4+pOgWVdLkuj
	 M/FNt1bwALA4EjaTEov6iGYMr3nu/GmQIKjNg9BtnQEvPDUNqJoUM41V24juty2KWL
	 k67/tv3RzNmzRjyukO0UpwuxmyIIS1MBkrA0Ic4Plm6aRWVGdvmHEx7kzqk28vhZLg
	 /6EHvKljP1Za9D6hZdVi34faqn1lr9xpV1nxbDoiThi14YHMM6KtJBUuiI4gHtGO5A
	 H/XvmAMSTDlTeGfXTxLwJ8xnrXdjU8VQEk2l1BaEcqGuat09KBFfeUy6wa62uxo8yG
	 jXhkQQUypLTyg==
Date: Tue, 28 Oct 2025 15:01:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Haiyang Zhang
 <haiyangz@linux.microsoft.com>, "linux-hyperv@vger.kernel.org"
 <linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, Paul Rosswurm <paulros@microsoft.com>, Dexuan Cui
 <DECUI@microsoft.com>, KY Srinivasan <kys@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>, "edumazet@google.com"
 <edumazet@google.com>, "davem@davemloft.net" <davem@davemloft.net>, Long Li
 <longli@microsoft.com>, "ssengar@linux.microsoft.com"
 <ssengar@linux.microsoft.com>, "ernis@linux.microsoft.com"
 <ernis@linux.microsoft.com>, "dipayanroy@linux.microsoft.com"
 <dipayanroy@linux.microsoft.com>, Konstantin Taranov
 <kotaranov@microsoft.com>, "horms@kernel.org" <horms@kernel.org>,
 "shradhagupta@linux.microsoft.com" <shradhagupta@linux.microsoft.com>,
 "leon@kernel.org" <leon@kernel.org>, "mlevitsk@redhat.com"
 <mlevitsk@redhat.com>, "yury.norov@gmail.com" <yury.norov@gmail.com>,
 Shiraz Saleem <shirazsaleem@microsoft.com>, "andrew+netdev@lunn.ch"
 <andrew+netdev@lunn.ch>, "linux-rdma@vger.kernel.org"
 <linux-rdma@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [net-next, v3] net: mana: Support HW link state
 events
Message-ID: <20251028150151.3b3b7121@kernel.org>
In-Reply-To: <BY1PR21MB3870D5B860FB1F26932EB73ACAFDA@BY1PR21MB3870.namprd21.prod.outlook.com>
References: <1761270105-27215-1-git-send-email-haiyangz@linux.microsoft.com>
	<76598660-8b8e-4fe6-974b-5f3eb431a1ec@redhat.com>
	<BY1PR21MB3870D5B860FB1F26932EB73ACAFDA@BY1PR21MB3870.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Oct 2025 19:36:02 +0000 Haiyang Zhang wrote:
> > Why is  the above needed? I thought mana_link_state_handle() should kick
> > and set the carrier on as needed???  
> 
> Thanks for the question -- our MANA NIC only sends out the link state down/up 
> messages when need to let the VM rerun DHCP client and change IP address...
> 
> So, I need to add netif_carrier_on(ndev) in the probe(), otherwise the 
> /sys/class/net/ethX/operstate will remain "unknown" until it receives the 
> Link down/up messages which do NOT always happen.

Oh that makes the code make much more sense.
Please add this and more detail into the commit message.

> +			if (!netif_carrier_ok(ndev))
> +				netif_carrier_on(ndev);

Testing carrier_ok() before calling carrier_on/off is entirely
pointless, please see the relevant implementations.

BTW I think the ac->link_event accesses are technically racy,
wrap them in READ_ONCE() / WRITE_ONCE() while you respin.
(Unless mana_hwc_init_event_handler() is somehow under rtnl_lock)
-- 
pw-bot: cr

