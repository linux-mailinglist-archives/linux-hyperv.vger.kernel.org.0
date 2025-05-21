Return-Path: <linux-hyperv+bounces-5594-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8FFABEB2E
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 May 2025 07:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CE453AD3E2
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 May 2025 05:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE5522DA17;
	Wed, 21 May 2025 05:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EgLmllFK"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425341A5B85;
	Wed, 21 May 2025 05:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747804697; cv=none; b=PcLhupM+bXFWp+COW4I8ygZiU5AeZCBMgCpp/TZTGSWW4qFubLTs9kh7iqHyksLhdp+656kh/RCpQjLbJHFn4FF5QK0+aQmTVVHLStMUL9v5cYGy6IwK8dBDvBRW5Ct2ZJAqyJaKCnQMhizmIbQfKfAygo/DSLLII9ktB5M3Z+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747804697; c=relaxed/simple;
	bh=u7/3KY1Kz6KkAfhTKudlFFJOir6E8UHZ7GaPRxnGVG0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=STEQVYShTCUat/lFDOWX5pXy0pH7zXc4G/ifE3591082TLvwjZ3rvSo/NFCwDmqqcx/asQAiLuUNLr236/AtPc2iqxgY3bULAvm3FnMOe8H802/TRzdLVXuVGpn8S130QRFkAKaA8rhBketzFLsv0h5wspz5o7OyYqBw8ry9jRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EgLmllFK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85763C4CEE4;
	Wed, 21 May 2025 05:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747804695;
	bh=u7/3KY1Kz6KkAfhTKudlFFJOir6E8UHZ7GaPRxnGVG0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=EgLmllFK8fwvA9p9id9HO7R4iI6aKQsfDw/X/h2+hfPmpkQ4DxvO881/tl+XpcCJC
	 5oQFMAy3BrZh7rbm2O7tXqo70WumhO6wz3lSF/pIcmWHDahcv04G7RVxIAqRu6ZRzy
	 BpDwShIP2aI5p40uo2K/YjKCMk4xjVe051SnhFz58o6blPfFVcx8jNTp8Y9LLln2nO
	 SD/q1UOiIcM8zkEg6kY9MJBgaBL/tbj9Y6SdzEe3Mi8iGLrVxlnVueP7SM/LQXqAsn
	 fw5T9KMJ7HjPfWWxACu/HIAdhc/hnY4EyLwE2uXwdONaICh7Iq84FBAhHkuR7NljEV
	 uupqc0PXuoqjw==
Date: Tue, 20 May 2025 22:18:10 -0700
From: Kees Cook <kees@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, ahmed.zaki@intel.com,
 aleksander.lobakin@intel.com, alex.aring@gmail.com, andrew+netdev@lunn.ch,
 ardb@kernel.org, christophe.leroy@csgroup.eu, cratiu@nvidia.com,
 d.bogdanov@yadro.com, davem@davemloft.net, decui@microsoft.com,
 dianders@chromium.org, ebiggers@google.com, edumazet@google.com,
 fercerpav@gmail.com, gmazyland@gmail.com, grundler@chromium.org,
 haiyangz@microsoft.com, hayeswang@realtek.com, hch@lst.de, horms@kernel.org,
 idosch@nvidia.com, jiri@resnulli.us, jv@jvosburgh.net, kch@nvidia.com,
 kys@microsoft.com, leiyang@redhat.com, linux-hardening@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-wpan@vger.kernel.org, linux@treblig.org,
 martin.petersen@oracle.com, mgurtovoy@nvidia.com,
 michael.christie@oracle.com, mingzhe.zou@easystack.cn,
 miquel.raynal@bootlin.com, mlombard@redhat.com, netdev@vger.kernel.org,
 pabeni@redhat.com, phahn-oss@avm.de, sagi@grimberg.me, sam@mendozajonas.com,
 sdf@fomichev.me, shaw.leon@gmail.com, stefan@datenfreihafen.org,
 target-devel@vger.kernel.org, viro@zeniv.linux.org.uk, wei.liu@kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_0/7=5D_net=3A_Convert_dev=5Fset=5Fm?=
 =?US-ASCII?Q?ac=5Faddress=28=29_to_struct_sockaddr=5Fstorage?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20250520200929.1b9ae5ec@kernel.org>
References: <20250520222452.work.063-kees@kernel.org> <20250521001931.7761-1-kuniyu@amazon.com> <202505201741.AFA146E7F6@keescook> <20250520200929.1b9ae5ec@kernel.org>
Message-ID: <935B5950-190B-47D8-BF45-1CBAE904DB71@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On May 20, 2025 8:09:29 PM PDT, Jakub Kicinski <kuba@kernel=2Eorg> wrote:
>On Tue, 20 May 2025 17:42:32 -0700 Kees Cook wrote:
>> Ah yes, I can include that in the next version if you want? I was tryin=
g
>> to find a stopping point since everything kind of touches everything =
=2E=2E=2E
>
>Looks like the build considers -Wincompatible-pointer-types to always
>imply -Werror or some such? We explicitly disable CONFIG_WERROR in our
>CI, but we still get:
>
>drivers/net/macvlan=2Ec:1302:34: error: incompatible pointer types passin=
g 'struct sockaddr *' to parameter of type 'struct __kernel_sockaddr_storag=
e *' [-Werror,-Wincompatible-pointer-types]
> 1302 |                 dev_set_mac_address(port->dev, &sa, NULL);
>      |                                                ^~~
>
>on this series :(

I'll get this fixed and add dev_set_mac_address_user() for v3=2E=2E=2E


--=20
Kees Cook

