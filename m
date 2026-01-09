Return-Path: <linux-hyperv+bounces-8198-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4145D0BC2D
	for <lists+linux-hyperv@lfdr.de>; Fri, 09 Jan 2026 18:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39AF83002D2A
	for <lists+linux-hyperv@lfdr.de>; Fri,  9 Jan 2026 17:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD1927FB12;
	Fri,  9 Jan 2026 17:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ULhyJstk"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azolkn19010037.outbound.protection.outlook.com [52.103.10.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A7121019C;
	Fri,  9 Jan 2026 17:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.10.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767980924; cv=fail; b=WKepKvGe4jkD5I4E4c0N2YemkCDPI1qJL8l35+vb6jejQBl7poVq+uVUnZ0wIOcR+QALAGw7QDDj6JyXGqeD9ccjWy4XUL2kWnxYUfd3/FFWu02mMjBrKdsHMEBtzyYVPtDeEmXI2P2qcKO/C8b9T3Hg7VZnRYkqQl3Oez86xv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767980924; c=relaxed/simple;
	bh=NSyv4AdIRjmxII0012qDb1oxGCya8avfw8uTTyf/h6Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Dtlxr+0hkWDoWicT7d5C8vL/IxC9bbsidL9AwSRcCgpG7DcgdZTMR+s35o187pLXwreoq/G77pS7tfB7hYyO30pid/UgFr7RYiuPktEU7TVuk4cH6GmiR1440RW62HBfxu3ZlysvncCp02Gd/ruOHorNFf5QMF5AC5x4BI3G77U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ULhyJstk; arc=fail smtp.client-ip=52.103.10.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bjs7CqyB7iF09N7Mn2A49mjcGt/csx9DIIgQJWadxoiLdZVabZVMgUr3KG0mRwBvRmcylM8e5ZfNkuqT3HH17b0R+QvQRy3xfMhYsY6jOe+Ecuy5qbXZWRzdbr8RNAekI3LS5WCHhJRRKtOqLzShZqPCaZwK1X97NR8ctJ9vXx+8/hiugn9nNgiMRDfPiq8R1eFjVIJWAvxUE1Sjvs0uPcRgwy2VpU5M+ASV91rbUC0bRnPC/lZJ9Iouii2JnwVXKgQhRlpQoXzD7xJbKg5mhlMvXGsvKu8l4vgpBjBHT72aZGiIlrkW1oogK5phrBvT6kfKOZQuQEpdMJardy2wwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sm/jC7P74gy5GVng5CZmYJ0hYX/O6ln9jpK/HYkMTeo=;
 b=iCzHHw4UNIFkPsuVZpA0f7fsA6cwhse5pz0JkJ73pIC7dzMdnMcsWwandfWaz+Tq2+hj2jkfJClwIsZ/7vCKeBe4jXrfyBbqefF3fYeFjYRDpOuBAYOz2ueANz7DHCmZLSwNSXZM8Am0An5FhNjvJ3vyDSs3X26iK6QI2mZCCKm9FlfPZrUHczW/ncQRozlToxEFIOfnwMI+Py9ZsP85aGtDnk9Tdgr98gM2cZErQ2AdBXSZd82eE5JXzK78k7Xg1NSfvjs0QTcZM6LBSsQ9MnZWSC/UQ3YAHzhcY0vbBsDjy2jOAq04fkC+E6E0pchpK7ESFPTldfAaxj+/aceyIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sm/jC7P74gy5GVng5CZmYJ0hYX/O6ln9jpK/HYkMTeo=;
 b=ULhyJstkM+0F3lgXZJx/55e0EwlH6IrcUPNqMqFa8D+gyKuzuji1O8AJj1MFBD5/yaAkEgP1yE5N1UuneQW+mmLkMn8WsEt1uYHSIL5YDMwbDlcLgDo7m9seCJA+CTZil7xcbIFxTxvHP/NzbYfrJ0AQjVW7OC8YJ99rl/1rRZapDxo0bLIjQUm35d2ACJCnq0sJJ7ALGjl7uIID/jOZBqlVQsMw7xtXLy9cAcv9MdWZW9Oepsq8buvwpAo8GYZPYtvPLwwRzmGVD4k5c2X6aohwuB0f7TB4haXX1qVylQskxhyBPk0eaW7OtTHogSpaMr8Bn5T5nch/4rEN24yAew==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CO6PR02MB7553.namprd02.prod.outlook.com (2603:10b6:303:a6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.4; Fri, 9 Jan
 2026 17:48:38 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9499.004; Fri, 9 Jan 2026
 17:48:38 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: "longli@linux.microsoft.com" <longli@linux.microsoft.com>, "K. Y.
 Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei
 Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, "James E.J.
 Bottomley" <James.Bottomley@HansenPartnership.com>, "Martin K. Petersen"
	<martin.petersen@oracle.com>, James Bottomley <JBottomley@Odin.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Long Li <longli@microsoft.com>, "stable@kernel.org" <stable@kernel.org>
Subject: RE: [PATCH] scsi: storvsc: Process unsupported MODE_SENSE_10
Thread-Topic: [PATCH] scsi: storvsc: Process unsupported MODE_SENSE_10
Thread-Index: AQHcgA/ZdvXNwjcnQUWATOkFvIuG4rVKHsfQ
Date: Fri, 9 Jan 2026 17:48:38 +0000
Message-ID:
 <SN6PR02MB4157232BE7BB9B6B1AA81AEBD482A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <1767815803-3747-1-git-send-email-longli@linux.microsoft.com>
In-Reply-To: <1767815803-3747-1-git-send-email-longli@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CO6PR02MB7553:EE_
x-ms-office365-filtering-correlation-id: a598e32f-e140-4a80-efde-08de4fa751a6
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799015|8062599012|19110799012|13091999003|12121999013|15080799012|461199028|31061999003|41001999006|40105399003|52005399003|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?1Y3Im0Ta+0GJ+p4zBV9nfptEy8Ja1V0MnchUcIsMNl+UzJSWmMiICei09t+w?=
 =?us-ascii?Q?ZYlBAMsGTlY11G9CYRjERZ/vfZRuwufBbOlaX4O/jSvk6dJX0oUyKPCRn3X2?=
 =?us-ascii?Q?xQiZMT5wPslXKd01ilU26wwFuwfZXX4Gj6611oxHphW/a+28iNN+WE5VL/rW?=
 =?us-ascii?Q?np4VcwCEVyJV8+MN9TiG8UJwBy7LHDawYFwJNeIW/nqZOjhF5GKj+gw3DtSp?=
 =?us-ascii?Q?XDKDPj+lwd9JXrFrPqHCemythBxn+vnFo8VXqWpi8VuVQY2gjUpfzaiiG5j8?=
 =?us-ascii?Q?NHvp+ZRmHLKEuleQi5O/UyoR5xbYN5V+pIu46u/NfiIB3IfMndizkqPtye0+?=
 =?us-ascii?Q?C9vfQvED5GgSokoVNZ2PPv1ZLaVHcP6KMZU6mH28Qd62O/b5VR06RlD99wLD?=
 =?us-ascii?Q?pUP7We1lc0FuzqSCDQr3BG2q1t7Byd45LPAmhwRam2+ebURRjG3DsX4SELGu?=
 =?us-ascii?Q?tR86tepMMPX2Mv1CT0Y27sTLYXY6Ba+2JYa/hXNEiZ9MIFGJkn+jHmyBmr+g?=
 =?us-ascii?Q?tsCSu2lWPQ8hmau0naTjMmU/3CDCKerOg8ibA522if1GLtaDwszXQ34O9nyI?=
 =?us-ascii?Q?9mupdMoSQu95QyBqroUxK9OGRABzZK8YAStFmte4r45uGHQJVCxDwNtoOF46?=
 =?us-ascii?Q?1BHqnbtfpF+IXNPbBcT0T5fy76pjZYDatIjswh12IWOEQqjisslAuREGeOKZ?=
 =?us-ascii?Q?QkX2A/yE53yMeoY6cSUkIO0RXqi3dunuCRb2AAYtG++hpg+auTWZaWD4hkYA?=
 =?us-ascii?Q?YyxqIIIboSnK5V8XjMCh9ejM4sbCKJ4p3ViJ6fmCe9hsqKFvT5Rrdi3AtHw8?=
 =?us-ascii?Q?YEkycUTLZ/dplquDGfttFkmDN7srpwy0zA3RevakbNHHRJkFty09LuQWUitR?=
 =?us-ascii?Q?7+fp39Wu+juWd/MMPH6PDT2loo/XLYgaueerh9DOpiu4ivm9JqEdjDE13Fwx?=
 =?us-ascii?Q?mUdw+559qcVGZ0VAWmVbLE5VoBLUE9z7t5DE8pwrW50CAFC3uyL/JiwJX/PM?=
 =?us-ascii?Q?Z0SckXNg2SJO2Af0JccyERqLo0WHWZjHbk3jlkZ9vH8AaedefcMiGzsiTcJy?=
 =?us-ascii?Q?uhvjTzIkUUw1IgDv08bcvorlgU3EFZUAC1r3jaMfySomDZaguihAIQKiyv78?=
 =?us-ascii?Q?/CzZ6vloIE5SHIanI+329qE4m6mfqesM+nWdTKXpRBpd5QJGodXawBHl4qMN?=
 =?us-ascii?Q?Z2wivb3CGJQLEkQ+0sYsdgN1O8S/LSqV5aDksgYImMrmnCMRqxGlzMvCL2bs?=
 =?us-ascii?Q?876F80I1uflf1ApMOfOb32ZII1BPu39CfZDjY+ujOw=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?vahQmim+R/6nvj0tZOPwWcotzMYWZ0FC6AM+fu2HvnBEOE2tDwYSG1tJAN4G?=
 =?us-ascii?Q?6AajbQdIYsl0b1vMUbD2zXmKnnUzmJ1c0wNBDfTB5I4RqPGTZzfQESNSoDbk?=
 =?us-ascii?Q?oWvXIRfTnZaAdJa/0EGb0qV5j4hpkoJqrbOZu0BcPC4qMG1IZr+taUK5r5Ih?=
 =?us-ascii?Q?aSyCPGI0hq5yh23t6FGE0QcqHvRq+5Oi0Tzhq91Uo9lv5MY/+lu0M14C6RD8?=
 =?us-ascii?Q?3rmEe9EEKXw/N+IBVzVgAgZLulMOvsaAqX17G9DZ74UbLrGlQHr8Ql052IcE?=
 =?us-ascii?Q?hQuXHfKZHxRRsLtJ3TF1jVumabj6rBaQAR8nGwnW7LIKT5WYlBMaiaVP02t4?=
 =?us-ascii?Q?fz8dAwrq2gkpX3Vc6UfPtOyC4dMggElncaeXx5QCIAXSfsleujAgcIHN55fv?=
 =?us-ascii?Q?C5bydPoqNa7afR3PIua27m5STV4XxQMP7mZYjneLZ502vbRBSJLQcg7t21M0?=
 =?us-ascii?Q?GzW5fz26/Dtx+4LJKszc+zZ3khZXWPrzR3VYDHBY0dK5hs5SGtqdriaJHzFF?=
 =?us-ascii?Q?qG0DTbJV3GGZxbF4BezKRAIZ1Gqd7j4uBGFoXvcavETeqiCnJG9LBYd8P4w1?=
 =?us-ascii?Q?JQpyZKqnC8RVNc9q0+jfyfDSn9fZqYbRcK/wBhdMRfBjLWHda3Ovyb1HUDAG?=
 =?us-ascii?Q?ZDN5uIECkGd8r/zpS8zkT+5AdD8Vp9zg1yzbQGeu7xZinGfLboPM3CFc7EFK?=
 =?us-ascii?Q?IR7HUL9D88k9IArghbIxQuoX3jrkGlaf4DrE7tr4YACD+Kfr/vVGARgevBoS?=
 =?us-ascii?Q?1fAZxztE417CwWYKH53I4Q7qdiJsONdJc9cDkBP3vamM1+twvSxNF9mZb4Hm?=
 =?us-ascii?Q?PCnexPmubDMpAOUIWk5fAZF8ugC9bvn04BfvBf761bPpbJS8520/lddcTu0Q?=
 =?us-ascii?Q?vFmsdXA+RN7vJvIFqxG0G4ahE5r7dgn4qjgQZaDFUKpfd6uRX6qFVNDjymPx?=
 =?us-ascii?Q?+zYdPTJBhXGGJ82DDrzqLr77/qSXqLCli5CJxKZxYniGVAtAoog4XFvFA05d?=
 =?us-ascii?Q?VP8hOY+XZe91d1yxg2RU4CsZ3jnrAd5JKTeqrATKHOutyHI5l2r2N93G0BGG?=
 =?us-ascii?Q?I7KZ2h+IO+gpj3yTHlUOiZkLYMHJt8D4vh0C32tvCvZpUXRL9Tns+jqbd3eO?=
 =?us-ascii?Q?1ECmLAEnG99h8DNzLAMfj5b3Ht5enKvB5ZSV/5AvbA+PoIAc7yW/0xnf4Orl?=
 =?us-ascii?Q?j0AyVsXolsyTR1sI6j03uhQ1ecBlcDzjsDPWn042YEGuBxdoTvZ/ZF2TvYn5?=
 =?us-ascii?Q?D8Dcetkx0zJLnY1LxN66a2mS4GXROl0xv0oei4YzzehgEJEdD9bSOE8+MT5Q?=
 =?us-ascii?Q?Ibo+uOmo4vT0wbRdEK/I0gZKh6T7+cEUysGW1HF1RRCj0U3bbnPSL1q037Gd?=
 =?us-ascii?Q?uTCn4Kk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: a598e32f-e140-4a80-efde-08de4fa751a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2026 17:48:38.1102
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7553

From: longli@linux.microsoft.com <longli@linux.microsoft.com> Sent: Wednesd=
ay, January 7, 2026 11:57 AM
>=20
> The Hyper-V host does not support MODE_SENSE_10 and MODE_SENSE.
> The driver handles MODE_SENSE as unsupported command, but not for
> MODE_SENSE_10. Add MODE_SENSE_10 to the same handling logic and
> return correct code to SCSI layer.
>=20
> Fixes: 89ae7d709357 ("Staging: hv: storvsc: Move the storage driver out o=
f the staging area")
> Cc: stable@kernel.org
> Signed-off-by: Long Li <longli@microsoft.com>
> ---
>  drivers/scsi/storvsc_drv.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
> index 6e4112143c76..9b15784e2d64 100644
> --- a/drivers/scsi/storvsc_drv.c
> +++ b/drivers/scsi/storvsc_drv.c
> @@ -1154,6 +1154,7 @@ static void storvsc_on_io_completion(struct storvsc=
_device
> *stor_device,
>=20
>  	if ((stor_pkt->vm_srb.cdb[0] =3D=3D INQUIRY) ||
>  	   (stor_pkt->vm_srb.cdb[0] =3D=3D MODE_SENSE) ||
> +	   (stor_pkt->vm_srb.cdb[0] =3D=3D MODE_SENSE_10) ||
>  	   (stor_pkt->vm_srb.cdb[0] =3D=3D MAINTENANCE_IN &&
>  	   hv_dev_is_fc(device))) {
>  		vstor_packet->vm_srb.scsi_status =3D 0;

There's a code comment above this "if" statement that describes the situati=
on.
The comment specifically lists INQUIRY, MODE_SENSE, and MAINTENANCE_IN. For
consistency, it should be updated to include MODE_SENSE_10.

With the comment updated,

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

