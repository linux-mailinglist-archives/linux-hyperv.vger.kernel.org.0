Return-Path: <linux-hyperv+bounces-588-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2455A7D7907
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Oct 2023 01:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B534EB211AF
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Oct 2023 23:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA0A381B2;
	Wed, 25 Oct 2023 23:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197BE381AE;
	Wed, 25 Oct 2023 23:59:34 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ADBD189;
	Wed, 25 Oct 2023 16:59:32 -0700 (PDT)
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 1F6B1C0B3C;
	Wed, 25 Oct 2023 23:51:48 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf02.hostedemail.com (Postfix) with ESMTPA id 449128000E;
	Wed, 25 Oct 2023 23:51:37 +0000 (UTC)
Message-ID: <10a072f549e187bc2fdc735c0161c09c90fc1392.camel@perches.com>
Subject: Re: [PATCH 2/3] treewide: Convert some ethtool_sprintf() to
 ethtool_puts()
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
Date: Wed, 25 Oct 2023 16:51:36 -0700
In-Reply-To: <20231025-ethtool_puts_impl-v1-2-6a53a93d3b72@google.com>
References: <20231025-ethtool_puts_impl-v1-0-6a53a93d3b72@google.com>
	 <20231025-ethtool_puts_impl-v1-2-6a53a93d3b72@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Stat-Signature: 5zoexpcbspxzknxxpim471w8h6ypycid
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 449128000E
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+N9jPJtzOomgZCQ3uE45mqLpiTL9MLOGI=
X-HE-Tag: 1698277897-822398
X-HE-Meta: U2FsdGVkX1/piP9epU3PVb8AwxfPnu298LT8+2Ear/QjzRdkg6TlU4ZFVqJStDqO3n+3XE7b+rXjNdVvUiGSpVDrBgNJwbvjRqVhbJYzw3bBx3/mHpMMWU2QA6eLuXuJG9IesNuAClmh2oGyXSTOr5SuM/vS8dt120/ZwdRa0ftJlSyabPiL2I71rQT5u8Z6hamposOtxW8UWys/hMh2ropByFvBIg65AsshQHUvJDmlsWp9lU1T5sJTLuf08ixeHbrY1HQRccfAMy3fhqmlo/ZjQQIgre7Fj+1RAgShAxn1lnKnuxLHp6zSrJJsQib8

On Wed, 2023-10-25 at 23:40 +0000, Justin Stitt wrote:
> This patch converts some basic cases of ethtool_sprintf() to
> ethtool_puts().
>=20
> The conversions are used in cases where ethtool_sprintf() was being used
> with just two arguments:
> >       ethtool_sprintf(&data, buffer[i].name);

OK.

> or when it's used with format string: "%s"
> >       ethtool_sprintf(&data, "%s", buffer[i].name);
> > which both now become:
> >       ethtool_puts(&data, buffer[i].name);

Why do you want this conversion?
Is it not possible for .name to contain a formatting field?


