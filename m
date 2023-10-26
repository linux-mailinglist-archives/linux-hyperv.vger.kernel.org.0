Return-Path: <linux-hyperv+bounces-604-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2273B7D87E2
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Oct 2023 19:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF3D2281F26
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Oct 2023 17:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F2138FB2;
	Thu, 26 Oct 2023 17:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE472E3E9;
	Thu, 26 Oct 2023 17:57:56 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C2DAC;
	Thu, 26 Oct 2023 10:57:55 -0700 (PDT)
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 79A04160B8F;
	Thu, 26 Oct 2023 17:57:50 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf03.hostedemail.com (Postfix) with ESMTPA id 6BAAF6000B;
	Thu, 26 Oct 2023 17:57:39 +0000 (UTC)
Message-ID: <eb9c31b2121a164a88bdd8cac663f6880cd52a93.camel@perches.com>
Subject: Re: [PATCH 0/3] ethtool: Add ethtool_puts()
From: Joe Perches <joe@perches.com>
To: Kees Cook <keescook@chromium.org>
Cc: Justin Stitt <justinstitt@google.com>, "David S. Miller"
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
 <lukas.bulwahn@gmail.com>,  linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>, Nathan
 Chancellor <nathan@kernel.org>,  intel-wired-lan@lists.osuosl.org,
 oss-drivers@corigine.com,  linux-hyperv@vger.kernel.org
Date: Thu, 26 Oct 2023 10:57:38 -0700
In-Reply-To: <202310261049.92A3FB31@keescook>
References: <20231025-ethtool_puts_impl-v1-0-6a53a93d3b72@google.com>
	 <202310260845.B2AEF3166@keescook>
	 <39ca00132597c0cc4aac4ea11ab4b571f3981bcb.camel@perches.com>
	 <202310261049.92A3FB31@keescook>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Stat-Signature: hudth4n5i9tsh6noik99p4dqoecq4yae
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 6BAAF6000B
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/FhF5iyLmTVijiQINcZ0DKfw8kt4QZXAA=
X-HE-Tag: 1698343059-8063
X-HE-Meta: U2FsdGVkX18EvEmoxNdb8hk6+O6ituHbXxaJFt94yuI4o75cydbMBKO9R15wtEF6VkcdjuFdT9yaMhXRm3vYaUDQE0fY4PwycxT9WeFqvMNRLqEIHiYE+D7Xg4oAc80cClcOXyOn1zfquNjuxwquDIEP8tJmMNk6z3BfC3ZuK2ggJziXypVPsEUK9Keu4FQ3ncfCo+W3BOl6Fmr3KUjH1uOPVXyJ4NSisvMVQpPwtWe6RV1E6cbgFDGHwkHsXtaww+tTwpwABR38XLVHFAAk31CQ+RyAx3SylbbeObJ26LbpA+oEHLjf/YBdaYbPa+iv

On Thu, 2023-10-26 at 10:49 -0700, Kees Cook wrote:
> On Thu, Oct 26, 2023 at 09:33:17AM -0700, Joe Perches wrote:
> > On Thu, 2023-10-26 at 08:47 -0700, Kees Cook wrote:
> > > On Wed, Oct 25, 2023 at 11:40:31PM +0000, Justin Stitt wrote:
> > > > @replace_2_args@
> > > > identifier BUF;
> > > > expression VAR;
> > > > @@
> > > >=20
> > > > -       ethtool_sprintf
> > > > +       ethtool_puts
> > > >         (&BUF, VAR)
> > >=20
> > > I think cocci will do a better job at line folding if we adjust this
> > > rule like I had to adjust the next rule: completely remove and re-add
> > > the arguments:
> > >=20
> > > -       ethtool_sprintf(&BUF, VAR)
> > > +       ethtool_puts(&BUF, VAR)
> > >=20
> > > Then I think the handful of weird line wraps in the treewide patch wi=
ll
> > > go away.
> > >=20
> >=20
> > Perhaps this, but i believe spatch needs
> > 	 --max-width=3D80
> > to fill all 80 columns
>=20
> Ah, yeah. Default is 78. Current coding style max is 100... I'll adjust
> my local wrappers.

Coding style max is still 80 with exceptions allowed to 100
not a generic use of 100.



