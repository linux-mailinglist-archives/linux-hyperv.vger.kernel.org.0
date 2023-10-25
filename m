Return-Path: <linux-hyperv+bounces-586-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3313C7D78F5
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Oct 2023 01:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 541661C20CD9
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Oct 2023 23:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A59381A8;
	Wed, 25 Oct 2023 23:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2312D33E3;
	Wed, 25 Oct 2023 23:53:15 +0000 (UTC)
X-Greylist: delayed 82 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 25 Oct 2023 16:53:14 PDT
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D497693;
	Wed, 25 Oct 2023 16:53:14 -0700 (PDT)
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 73084140753;
	Wed, 25 Oct 2023 23:53:10 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf06.hostedemail.com (Postfix) with ESMTPA id EB8562000F;
	Wed, 25 Oct 2023 23:52:58 +0000 (UTC)
Message-ID: <c7e45f79e04cf28b69300cc12cf47267fb216955.camel@perches.com>
Subject: Re: [PATCH 3/3] checkpatch: add ethtool_sprintf rules
From: Joe Perches <joe@perches.com>
To: Justin Stitt <justinstitt@google.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shay Agroskin
 <shayagr@amazon.com>, Arthur Kiyanovski <akiyano@amazon.com>, David Arinzon
 <darinzon@amazon.com>, Noam Dagan <ndagan@amazon.com>, Saeed Bishara
 <saeedb@amazon.com>, Rasesh Mody <rmody@marvell.com>, Sudarsana Kalluru
 <skalluru@marvell.com>, GR-Linux-NIC-Dev@marvell.com, Dimitris Michailidis
 <dmichail@fungible.com>, Yisen Zhuang <yisen.zhuang@huawei.com>, Salil
 Mehta <salil.mehta@huawei.com>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>,  Tony Nguyen <anthony.l.nguyen@intel.com>,
 Louis Peens <louis.peens@corigine.com>, Shannon Nelson
 <shannon.nelson@amd.com>, Brett Creeley <brett.creeley@amd.com>, 
 drivers@pensando.io, "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang
 <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
 <decui@microsoft.com>, Ronak Doshi <doshir@vmware.com>, VMware PV-Drivers
 Reviewers <pv-drivers@vmware.com>, Andy Whitcroft <apw@canonical.com>,
 Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn
 <lukas.bulwahn@gmail.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Nick Desaulniers
 <ndesaulniers@google.com>, Nathan Chancellor <nathan@kernel.org>, Kees Cook
 <keescook@chromium.org>, intel-wired-lan@lists.osuosl.org, 
 oss-drivers@corigine.com, linux-hyperv@vger.kernel.org
Date: Wed, 25 Oct 2023 16:52:58 -0700
In-Reply-To: <20231025-ethtool_puts_impl-v1-3-6a53a93d3b72@google.com>
References: <20231025-ethtool_puts_impl-v1-0-6a53a93d3b72@google.com>
	 <20231025-ethtool_puts_impl-v1-3-6a53a93d3b72@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Stat-Signature: ewynon9iqkxk4ba7ojpnwtcnyur8eded
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: EB8562000F
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19HM4U+AZp5TxLK9aKEhza6ficBJMSjAYo=
X-HE-Tag: 1698277978-811897
X-HE-Meta: U2FsdGVkX1+p9+z8yCq32YY8S2DSMu0GtmU5Y2BLTOHLbVa47GMVGnlUfueykHLbFBJzUqiIuNUoLTjPNpuPmPmdObkyQyyYuvVzxDUXUYBXVjgtSZL2VLZt0M+ihq91yI+KJMnhw13lDleMsbRbUz2084V9BtLz3jRVgcLorLaY772BDVcKhBSdvFtDf2GPoSWp62x76n++3gowAjGE0QzGeGP1a3j/o4yx5i3/j7G9kDn6arjCylGwRoNsTERruOxHd2GpijuQvv1XVYKqXSIlXskZ2U42iC6tNJZVsKH071QZzpcUdpEeBh6ZYV0q

On Wed, 2023-10-25 at 23:40 +0000, Justin Stitt wrote:
> Add some warnings for using ethtool_sprintf() where a simple
> ethtool_puts() would suffice.
>=20
> The two cases are:
>=20
> 1) Use ethtool_sprintf() with just two arguments:
> >       ethtool_sprintf(&data, driver[i].name);

OK.

> or
> 2) Use ethtool_sprintf() with a standalone "%s" fmt string:
> >       ethtool_sprintf(&data, "%s", driver[i].name);

I'm rather doubt this is really desired or appropriate.



