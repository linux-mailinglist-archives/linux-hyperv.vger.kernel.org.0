Return-Path: <linux-hyperv+bounces-980-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5160D7F0156
	for <lists+linux-hyperv@lfdr.de>; Sat, 18 Nov 2023 18:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 814661C2040B
	for <lists+linux-hyperv@lfdr.de>; Sat, 18 Nov 2023 17:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC2F12E40;
	Sat, 18 Nov 2023 17:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dByqGueY"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A00179A2;
	Sat, 18 Nov 2023 17:38:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74C23C433C7;
	Sat, 18 Nov 2023 17:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700329131;
	bh=losrmXlk+odVwrmRe07GJMSdH6r8vdY76JOEkrAnT8w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dByqGueYLz6b8vlOUGniQt46dHd66x1kFnRLjJoHw1Hsw7ap5Hv0cLdxFq2R12Pt9
	 0v7hy1j2j7i5h3ntlKizusHrv8ilYQyGMH547b5A7PBANk1xTOtFDL+SFPjAWHkkpi
	 hzW/90cbNGqQMOO8zfnR1jjFhklycNUr3v0E/WD+majI3yk4fwhdTk3Ak6fZl3yv/R
	 fUz03ZUmfzLnot7uFZmXs1e+4JeMfjzJ059NIBzIGi1rUYm28QWJBmDPdu3DucQxnz
	 qXGmyxbYnDamT/VZzFGsyCupkhj6eL/Oncyv+CVaUvB1ga36HmLi8frpE19ZsTdErw
	 dYjKI4+y3XU+w==
Date: Sat, 18 Nov 2023 09:38:49 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Long Li <longli@microsoft.com>, "longli@linuxonhyperv.com"
 <longli@linuxonhyperv.com>, KY Srinivasan <kys@microsoft.com>, Haiyang
 Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
 <decui@microsoft.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v4] hv_netvsc: Mark VF as slave before exposing
 it to user-mode
Message-ID: <20231118093849.14e36043@kernel.org>
In-Reply-To: <20231115081406.1bd9a4ed@hermes.local>
References: <1699484212-24079-1-git-send-email-longli@linuxonhyperv.com>
	<20231108181318.5360af18@kernel.org>
	<PH7PR21MB3263EBCF9600EEBD6D962B6ECEAEA@PH7PR21MB3263.namprd21.prod.outlook.com>
	<20231110120513.45ed505c@kernel.org>
	<20231115081406.1bd9a4ed@hermes.local>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 Nov 2023 08:14:06 -0800 Stephen Hemminger wrote:
> Jakub is right that in an ideal world, this could all be managed by
> userspace. But the management of network devices in Linux is a
> dumpster fire! Every distro invents there own solution, last time
> I counted there were six different tools claiming to be the
> "one network device manager to rule them all". And that doesn't
> include all the custom scripts and vendor appliances.

To be clear, I thought Long Li was saying that the goal is work around
cases where VF is probed before netvsc. That seems like something that
can be prevented by the hypervisor.

