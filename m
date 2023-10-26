Return-Path: <linux-hyperv+bounces-593-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD30F7D8494
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Oct 2023 16:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70930281FE6
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Oct 2023 14:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2910A2E64B;
	Thu, 26 Oct 2023 14:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T1+gpBbu"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0579E2E411;
	Thu, 26 Oct 2023 14:24:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 182A7C433C9;
	Thu, 26 Oct 2023 14:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698330265;
	bh=JvktxjVfkL+L338qM5yYJHIrOtY6B+d/w/XgfHIyqJ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=T1+gpBbuxN3eqF4QCYpT83BIEg0rFmZapScZQJ7whB+Hy4Y/GiypWgWapxytG+HJC
	 L7rExCB0EvByr/Vt+KvKSm76qzkqsOkFDfe/wAMJIdo6IL1dtgF+73RmWPjkdgyJ9x
	 VpBFQsqP5eZGpg2gIfQb3IgEFrlXXaIt2mSR29CCMBO2qAOr8IWz0OVqsuOiLiiYNf
	 ngP7MiDMktJlqG64ShxT7abpgW2RH1nBTjet9kL9keKfzE2EQfxKhCHyzSeB87Xo7k
	 7LHSK8Vmz4IyxE7sGkdZx2bmn14F3rM646El/iJmEqiHCVYgP3zttjDHjxIlY/pBcM
	 wkbdWdLe9uXQw==
Date: Thu, 26 Oct 2023 07:24:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Shay Agroskin <shayagr@amazon.com>, Arthur Kiyanovski
 <akiyano@amazon.com>, David Arinzon <darinzon@amazon.com>, Noam Dagan
 <ndagan@amazon.com>, Saeed Bishara <saeedb@amazon.com>, Rasesh Mody
 <rmody@marvell.com>, Sudarsana Kalluru <skalluru@marvell.com>,
 <GR-Linux-NIC-Dev@marvell.com>, Dimitris Michailidis
 <dmichail@fungible.com>, Yisen Zhuang <yisen.zhuang@huawei.com>, Salil
 Mehta <salil.mehta@huawei.com>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>, "Tony Nguyen" <anthony.l.nguyen@intel.com>,
 Louis Peens <louis.peens@corigine.com>, Shannon Nelson
 <shannon.nelson@amd.com>, Brett Creeley <brett.creeley@amd.com>,
 <drivers@pensando.io>, "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang
 Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
 <decui@microsoft.com>, Ronak Doshi <doshir@vmware.com>, VMware PV-Drivers
 Reviewers <pv-drivers@vmware.com>, Andy Whitcroft <apw@canonical.com>, Joe
 Perches <joe@perches.com>, "Dwaipayan Ray" <dwaipayanray1@gmail.com>, Lukas
 Bulwahn <lukas.bulwahn@gmail.com>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>, Nick Desaulniers <ndesaulniers@google.com>,
 Nathan Chancellor <nathan@kernel.org>, Kees Cook <keescook@chromium.org>,
 <intel-wired-lan@lists.osuosl.org>, <oss-drivers@corigine.com>,
 <linux-hyperv@vger.kernel.org>
Subject: Re: [PATCH 2/3] treewide: Convert some ethtool_sprintf() to
 ethtool_puts()
Message-ID: <20231026072423.2ebd4619@kernel.org>
In-Reply-To: <f4b69b9d-2294-e0bf-a12a-9622eb70bd99@intel.com>
References: <20231025-ethtool_puts_impl-v1-0-6a53a93d3b72@google.com>
	<20231025-ethtool_puts_impl-v1-2-6a53a93d3b72@google.com>
	<f4b69b9d-2294-e0bf-a12a-9622eb70bd99@intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Oct 2023 11:23:37 +0200 Przemek Kitszel wrote:
> this would now fit into one line
> (perhaps it's the same in other cases, I just checked this one manually)

I think cocci would fold lines automatically? Could be worth trying
spatch to do the conversion for that reason, if you aren't already.

