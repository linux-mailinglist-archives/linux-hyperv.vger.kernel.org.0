Return-Path: <linux-hyperv+bounces-602-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E7E67D8792
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Oct 2023 19:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29841281FC1
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Oct 2023 17:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E4338F9B;
	Thu, 26 Oct 2023 17:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8B61BDC7;
	Thu, 26 Oct 2023 17:30:28 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23925B9;
	Thu, 26 Oct 2023 10:30:26 -0700 (PDT)
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 1775780BF4;
	Thu, 26 Oct 2023 17:30:21 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf07.hostedemail.com (Postfix) with ESMTPA id D70822002C;
	Thu, 26 Oct 2023 17:30:09 +0000 (UTC)
Message-ID: <7eec92d9e72d28e7b5202f41b02a383eb28ddd26.camel@perches.com>
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
Date: Thu, 26 Oct 2023 10:30:08 -0700
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
X-Rspamd-Queue-Id: D70822002C
X-Rspamd-Server: rspamout02
X-Stat-Signature: gjwxid9tcn9tzi1nmcpi4hsmszny7q6k
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+EI9TAgP8y8yYHcBc5iItVgLH9GhH6Qh8=
X-HE-Tag: 1698341409-723574
X-HE-Meta: U2FsdGVkX18C6ufE/QssxWAA52g0kzXgdZJqwTBNOwFNEA1mGXzSgLWrdDtJfFtYvR9vYZrerqOWMEcF3r4AsUcZeyzJYE1vyu0mO5pnfPGhcKIJlPngze7YtCQC93ao9Ul+7IgR2g8cFoFVOEel2H8MBoPmvse5vEFG5iXnHNez6fBmMPrKhvTsCwfZmHT0TUa+OeBfONQdiUG2AjKOZBTD2+mZnQazSe0jyd2GjoF2cTSx3nGhMhrOVIjP1h1HOwA7PbqgXKe1fj+gEvsvZe+MMHOiZmH7OTlkcMCNubwSzg55E5kA+5xCLr+pJUR3FHRZombKDZ5Q8vAyzi/OB5BS3LNhadq6

On Wed, 2023-10-25 at 23:40 +0000, Justin Stitt wrote:
> Add some warnings for using ethtool_sprintf() where a simple
> ethtool_puts() would suffice.

Hi again Justin.

After I read patch 1/3 I don't object at all.

spatch/cocci will always be a better option than checkpatch
for conversions like this because it's a proper grammar parser
and checkpatch is a stupid little perl script.

If you resubmit this please:


> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -7020,6 +7020,19 @@ sub process {
>  			     "Prefer strscpy, strscpy_pad, or __nonstring over strncpy - see:=
 https://github.com/KSPP/linux/issues/90\n" . $herecurr);
>  		}
> =20
> +# ethtool_sprintf uses that should likely be ethtool_puts
> +		if (   $line =3D~ /\bethtool_sprintf\s*\(\s*$FuncArg\s*,\s*$FuncArg\s*=
\)/   ) {
> +			WARN("ETHTOOL_SPRINTF",
> +			     "Prefer ethtool_puts over ethtool_sprintf with only two argument=
s" . $herecurr);
> +		}
> +
> +		# use $rawline because $line loses %s via sanitization and thus we can=
't match against it.
> +		if (   $rawline =3D~ /\bethtool_sprintf\s*\(\s*$FuncArg\s*,\s*\"\%s\"\=
s*,\s*$FuncArg\s*\)/   ) {
> +			WARN("ETHTOOL_SPRINTF2",
> +			     "Prefer ethtool_puts over ethtool_sprintf with standalone \"%s\"=
 specifier" . $herecurr);
> +		}

o remove the whitespace before and after the parentheses
o use the same type "ETHTOOL_SPRINTF" or maybe "PREFER_ETHTOOL_PUTS"
  for both warnings.
o Add a newline on the message output
o Add a --fix option

Something like:
---
 scripts/checkpatch.pl | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 25fdb7fda1128..6924731110d87 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -7011,6 +7011,25 @@ sub process {
 			     "Prefer strscpy, strscpy_pad, or __nonstring over strncpy - see: h=
ttps://github.com/KSPP/linux/issues/90\n" . $herecurr);
 		}
=20
+# ethtool_sprintf uses that should likely be ethtool_puts
+		if ($line =3D~ /\bethtool_sprintf\s*\(\s*$FuncArg\s*,\s*$FuncArg\s*\)/) =
{
+			if (WARN("PREFER_ETHTOOL_PUTS",
+				 "Prefer ethtool_puts over ethtool_sprintf with only two arguments\n" =
. $herecurr) &&
+			    $fix) {
+				$fixed[$fixlinenr] =3D~ s/\bethtool_sprintf\s*\(\s*($FuncArg)\s*,\s*($=
FuncArg)/ethtool_puts($1, $7)/;
+			}
+		}
+
+		# use $rawline because $line loses %s via sanitization and thus we can't=
 match against it.
+		if ($rawline =3D~ /\bethtool_sprintf\s*\(\s*$FuncArg\s*,\s*\"\%s\"\s*,\s=
*$FuncArg\s*\)/) {
+			if (WARN("PREFER_ETHTOOL_PUTS",
+				 "Prefer ethtool_puts over ethtool_sprintf with standalone \"%s\" spec=
ifier\n" . $herecurr) &&
+			    $fix) {
+				$fixed[$fixlinenr] =3D~ s/\bethtool_sprintf\s*\(\s*($FuncArg)\s*,\s*"\=
%s"\s*,\s*($FuncArg)/ethtool_puts($1, $7)/;
+			}
+		}
+
+
 # typecasts on min/max could be min_t/max_t
 		if ($perl_version_ok &&
 		    defined $stat &&




