Return-Path: <linux-hyperv+bounces-5588-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ADBAABE89C
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 May 2025 02:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 752C77A83E5
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 May 2025 00:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A94C3BBF0;
	Wed, 21 May 2025 00:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PAT9lG8L"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DB1632;
	Wed, 21 May 2025 00:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747788155; cv=none; b=nkzbjS7asdV3fEQLSo0+qKadqni+aUpCaT+P4fyiL7FWDYI8R+ALSi1ko3DOLfEQuuLwGa1ih15N8vOAtvn6nfqLDQBBoFxnrpvuASxc7cmf3kaK0+uMZaTAjFnqN/uDk4HRw9WvrnMQ5JA9qkPAicRp0VeiCSqcqsAFxd+ZkIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747788155; c=relaxed/simple;
	bh=/RrFroAnx4HggKLHMMSIYYEaz83wGtiW3hYlxlEWXWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IQ+4SNgTSnMiaSHkde1LcF91PROcidadIZ06+uIzWi01eyUV+MIOf08cPXcBzKBf9l5ejsO45OIxZCexysVILy1ej8SXP+Q5puQfdBaaLW2os3InAStgSfEQoqO0N5sULf+sQVk5eL2na96Ra5D6KfEchE8hfWPbLXv/hrBq188=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PAT9lG8L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49812C4CEEA;
	Wed, 21 May 2025 00:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747788155;
	bh=/RrFroAnx4HggKLHMMSIYYEaz83wGtiW3hYlxlEWXWY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PAT9lG8LPkxAwkRVnnhNYAd60AAeYfGIAO9KTdifgfX1guOO6r/bZruvcFf+ZgGeK
	 e06AbBhuFWam87cQ3brvBfJnjJ4FY7zJmv4K2XAuwaA/yFYmzhhj6r0NDIpmZvFU+y
	 wpRvnlt6ifBX1N2Mx7kcy4ma021PfVMTh5iOMpOtm4AhHfRogi3QGhnOBCbZ36pgqI
	 xPS0M84CixKHPB+rQn/Kjn0RuyrcD3sXwAluk3g7XEoMyD2IaQIzCuqS8NIiNA6jYc
	 r5xaeYB4j4q0Lbx3epkEl6n0pdfwMZTK8h15UIC+s8VYG5jf0b1LSwWnolulVZ2TGo
	 jdvs6R+aniuSg==
Date: Tue, 20 May 2025 17:42:32 -0700
From: Kees Cook <kees@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: ahmed.zaki@intel.com, aleksander.lobakin@intel.com,
	alex.aring@gmail.com, andrew+netdev@lunn.ch, ardb@kernel.org,
	christophe.leroy@csgroup.eu, cratiu@nvidia.com,
	d.bogdanov@yadro.com, davem@davemloft.net, decui@microsoft.com,
	dianders@chromium.org, ebiggers@google.com, edumazet@google.com,
	fercerpav@gmail.com, gmazyland@gmail.com, grundler@chromium.org,
	haiyangz@microsoft.com, hayeswang@realtek.com, hch@lst.de,
	horms@kernel.org, idosch@nvidia.com, jiri@resnulli.us,
	jv@jvosburgh.net, kch@nvidia.com, kuba@kernel.org,
	kys@microsoft.com, leiyang@redhat.com,
	linux-hardening@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-wpan@vger.kernel.org, linux@treblig.org,
	martin.petersen@oracle.com, mgurtovoy@nvidia.com,
	michael.christie@oracle.com, mingzhe.zou@easystack.cn,
	miquel.raynal@bootlin.com, mlombard@redhat.com,
	netdev@vger.kernel.org, pabeni@redhat.com, phahn-oss@avm.de,
	sagi@grimberg.me, sam@mendozajonas.com, sdf@fomichev.me,
	shaw.leon@gmail.com, stefan@datenfreihafen.org,
	target-devel@vger.kernel.org, viro@zeniv.linux.org.uk,
	wei.liu@kernel.org
Subject: Re: [PATCH 0/7] net: Convert dev_set_mac_address() to struct
 sockaddr_storage
Message-ID: <202505201741.AFA146E7F6@keescook>
References: <20250520222452.work.063-kees@kernel.org>
 <20250521001931.7761-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250521001931.7761-1-kuniyu@amazon.com>

On Tue, May 20, 2025 at 05:19:20PM -0700, Kuniyuki Iwashima wrote:
> From: Kees Cook <kees@kernel.org>
> Date: Tue, 20 May 2025 15:30:59 -0700
> > Hi,
> > 
> > As part of the effort to allow the compiler to reason about object sizes,
> > we need to deal with the problematic variably sized struct sockaddr,
> > which has no internal runtime size tracking. In much of the network
> > stack the use of struct sockaddr_storage has been adopted. Continue the
> > transition toward this for more of the internal APIs. Specifically:
> > 
> > - inet_addr_is_any()
> > - netif_set_mac_address()
> > - dev_set_mac_address()
> > 
> > Only 3 callers of dev_set_mac_address() needed adjustment; all others
> > were already using struct sockaddr_storage internally.
> 
> I guess dev_set_mac_address_user() was missed on the way ?
> 
> For example, tap_ioctl() still uses sockaddr and calls
> dev_set_mac_address_user(), which cast it to _storage.

Ah yes, I can include that in the next version if you want? I was trying
to find a stopping point since everything kind of touches everything ...
:P

-- 
Kees Cook

