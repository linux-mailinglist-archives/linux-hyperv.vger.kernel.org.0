Return-Path: <linux-hyperv+bounces-1634-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FA386E90D
	for <lists+linux-hyperv@lfdr.de>; Fri,  1 Mar 2024 20:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5480F1C25825
	for <lists+linux-hyperv@lfdr.de>; Fri,  1 Mar 2024 19:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED423E481;
	Fri,  1 Mar 2024 19:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="m0XUM4cL"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2055.outbound.protection.outlook.com [40.92.22.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D853B194;
	Fri,  1 Mar 2024 19:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.22.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709319662; cv=fail; b=i/6rv6eYvWZXuCiBJ4VCW6TWPcFkm9t1CZym87RD2oio7VZUZ9I/v7HsFdP/QaTV5K3jryUzUoaHkslKH7fE7Ec/8DJS3hoxTwLvmyIukJUN1J+94b6TX39S/pHXcWiqffjshtgxl6bO1y3Wyr9c8LxOwfdiMEpSuV8gm2mBbcE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709319662; c=relaxed/simple;
	bh=YtsDBCYdz44kPDLCKromIZgjdfD0AV/XpV1cwNQGc5o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dvD9bYNDAkkVs9UANj71h/jRNv2e4tsX+h6NGlkKCzHgyHwN7PhRSRHglyR27JlOtGURw4cIrBiK86r7mG2kW0uxZwacrcrBcJ0A0y6cWU3kFVLnXCl76dDfbql/kNaKvwKQ2M0t7hPSWKD0XsWedwPMxkiC01OKe40YEFamGQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=m0XUM4cL; arc=fail smtp.client-ip=40.92.22.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XKNUQmQMmClFeg0G7dVJbWgoGA6w9/ntwM82ig+z5MYSj2HxGqYlg4NsSe7eRQQg7qgvyHupIDBgtP50sI25uR99a82QbFokY5yR2/YwnmkhmQWzb6Y/ZBpxznNY9AsPZN4EK/sKF4CI14b+zqqAi8UoHV0cqSJKzGsS9tzIr4tTaD9U36iktZKee/yY6fUPKAjHT75e0C/IO9lv7ih4CdVZLkbRYUpx8ONtbslJ6q+GLKYH/WCtbZFNTOZI7ps33YhgEEWHWY6UOghHE4AhTg1+FfRTUhKPAylhm/dsYbk9uL6TAFK3Cpvk2uWZ5ZqWldO6DYOHHvkqV3Ouy8RrMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fj1VzpWGQFB7TIeH2p8daxLOBVSLar/lPEAPIkd86s0=;
 b=Iyr7vHik+NUeyWmaUbtTUWInEHgDw0OWw90mjF7zpqz52JZrYaYFfYXwNHiVenuajC+26CfDk1dtAwgRSepdeMULQlycqc9ySYHE8x3Ub/xErNTFKEatFX00732Djxc1FEcMPaY4mQiWaOKzKjIatVo7qXa86/OeIVnLA3DgDqvqoztjqZ81QKvTTFAzML30LU5GjGJM6Ot07D8g2o9nS4SIPkYbSPj8L2Rkm14dQ3KgWCnpRtOYCTL2rqey3EinH7/7EPnI+ArU1nqLVaHfEYSifBFDQPmDkAN29iqjHx5rZ0Fm6bm0mTbT78+NmoVRBLXIKRsWCIn1aSTAqohcZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fj1VzpWGQFB7TIeH2p8daxLOBVSLar/lPEAPIkd86s0=;
 b=m0XUM4cLknWqTgJ3jj52PZ+tI/c40sTX0tcPXQw47GGxDh8Ma6FcP5OI8zIzyPgSd+kWubBJvMSoIg4afOElQ7+SOdKYEB7wUguekuvYDrClbrbqrV8xvUHibSSdvCtfZoumJrMXlliAFwcR3punttGpyLehP3v3RxG+23Cq0piUAIZfWPm5+V5YfiJzGaDGgy5dHfAu/ChO4WtpzihUfa8B+bZ0OKUKXb2ttJCp+SgXnrjasog0Vn6BNoQz9bhGDrMzDl+B8L2j9R1rlIVIfyKAe7U1cvv5nTgpstQeSkzEbR2Ff9VSWH5Lk0EFmkzmFrskqs9C6HL32jxDLNJ+wQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CY5PR02MB8941.namprd02.prod.outlook.com (2603:10b6:930:3a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.34; Fri, 1 Mar
 2024 19:00:56 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd%5]) with mapi id 15.20.7339.031; Fri, 1 Mar 2024
 19:00:56 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Rick Edgecombe <rick.p.edgecombe@intel.com>, "kys@microsoft.com"
	<kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "decui@microsoft.com"
	<decui@microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "elena.reshetova@intel.com"
	<elena.reshetova@intel.com>
Subject: RE: [RFC RFT PATCH 2/4] hv: Track decrypted status in vmbus_gpadl
Thread-Topic: [RFC RFT PATCH 2/4] hv: Track decrypted status in vmbus_gpadl
Thread-Index: AQHaZTRZwlB7r62I/064k+0xwPOwcLEjPmsg
Date: Fri, 1 Mar 2024 19:00:56 +0000
Message-ID:
 <SN6PR02MB4157DDD1AFA071CEA8B5187CD45E2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240222021006.2279329-1-rick.p.edgecombe@intel.com>
 <20240222021006.2279329-3-rick.p.edgecombe@intel.com>
In-Reply-To: <20240222021006.2279329-3-rick.p.edgecombe@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [irDVm9rC9ej1yzPm5HRXvVXVGrNJI7p+]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CY5PR02MB8941:EE_
x-ms-office365-filtering-correlation-id: ed590b93-a7c0-4797-c76f-08dc3a21ecd0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ZydtEUEWEaBoiZCNC/GxkI59dtdQ1Xd96/eKf0QV3D7u2JBmwwPoAjgPNnoA0plgNOeelMgoBL+1LiG7ysJe/CqhwZndiPgQY64e8IRMVFIUBHC5Wy9Uy7yj9r6sg76+03TvJQNZQr7ZvLAEVcJW0A9W+DcxpcyhuGHH/nj4dAVyGbgptiyMIEQiYowHg+2Y3Iz2UUBAJOWB03SpcndBlHxlHxpMoGhr2TAMN8kRHi3zddxL17REfiIw3nHvHSJLpCkqVKsxdORIgGzWq8p0iRh3j4UXhys2vMu5Chw4yEuxUYCwQDJq01ihuSTRNmiF43zUucALkw0JaVBwaoSzTstGTHukda1aszvMy1BqwF724nLrpnXzKq6Iv3Nyudl/B9Q1JVDBtkHdHwe/At3sNbDjhrUxqywNhViJ4CsiHthQwlc/WRk8ppsX54tKnqncEz3UQ+pvGNR7iAKOPaglspScmfbL2pDXdGhhcVnCSZBY+/xs6FzrEZ8/s4njsutozR0JsE+NcVv792IlCB0EnBSyfT5EjkexcTicHvF6JNlFWPQYQg4ociMRvwM8O6rF
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?F8I+50s62m4KLy8StmFJnf7nuj3mJudv5uh+YglFuzbbD1jvG+ol1EEZT6Ms?=
 =?us-ascii?Q?xxvCupYUvfC6I34huxMdnPNUvEUAWHSvpyq8xdjuSS6MCw61w4U8NCYTCUZN?=
 =?us-ascii?Q?/FAp5iiLYBzCqFOdDd92bFNcjRTTYIXvEA9OHf0UXpb7mH57jVwQTU7HH8mx?=
 =?us-ascii?Q?n7EKeMAIniYIFXTsWp4TBKLfMtWYQx4jwPnF2MkvvaGtHhvml4Zzq6vqB+r4?=
 =?us-ascii?Q?mihO3tiIU2neFzLS2E3yDsy5amlG9j3m5SHUZV2raYmxONsyJBal/kKuVDd6?=
 =?us-ascii?Q?v2dUIM+1l69vnjqF3yUM00jpUOZBFk/xc3Uau6GY7fstmd0qALqozXmTdamy?=
 =?us-ascii?Q?s5Ki/kxEcm1CiOxAhX75fPx0U2BVSyCmGCSfPfoOutCC0cRltyOEChgEAS/v?=
 =?us-ascii?Q?qY6mbDuMyX+Kjrdmm6OfvB+V7BtKUXKVd4HFukhbaxnm0p22bpTeYtDDbN5Q?=
 =?us-ascii?Q?TyZV3PoIGLkdSLhq8UwW366V0d6jghUMpGf1wlEpDsr1mwn7fuz6H6sdGCfF?=
 =?us-ascii?Q?dPeovR39pgUTM/7pOxuPWotsZZQ8wz7COtdbesqqJmkpJLSSTpLG4lqIC1p5?=
 =?us-ascii?Q?0Ntpdow+ZISi8iNhcQzpqtIOBOP2JJoG0kLPhGZyNOSik2EEDlc4s/fAl75V?=
 =?us-ascii?Q?cSizSR81O0yZtrz07JPYsQsB1lQy7YceTu7Md9IgzdOnMDg5gqPilewaS9w1?=
 =?us-ascii?Q?szjE8Sxae9YSMbCJRGF4s9eSB02kbS1BS6VQg6iBeEpE3U1fOIpygOWFdKi3?=
 =?us-ascii?Q?n5ZBGLYBt8H5/zKIi1NjccRjnX7Jv8QY82uJXhLYcwGsoBDMjUOTWsqZxWiY?=
 =?us-ascii?Q?Au7wL8QkoQRQEXC8mvFp0akJkxZQopVV0LDDihZ9F7+6BJzTkw5xT3f/SKqf?=
 =?us-ascii?Q?afpakPtf4953Np+XtyhCmFfpJizArMDVBRf/rj2C/hDDOm6D8NvL7jnpjuKY?=
 =?us-ascii?Q?xJrVyWw3rbW/8d3dBcpmhhOFjo6QlIGWy0Y9qwWEVKJcxi4JnXmCsiaAcxxl?=
 =?us-ascii?Q?cgTzfo2mz+Ny8G0o8zrfvInc3aVJa88+Hptf0/ltbsnP06aY7/j3qV0Eioiv?=
 =?us-ascii?Q?lffbTfldR0aZNbQi/shq5Wl+gf7KbF00kEHInQbvPravkM+sd9hqqwopdMk/?=
 =?us-ascii?Q?LYOvmE7IMjA5cKU6+7KhvHelQB61c1mAKW5Bw+50KyzOw7ZubCTYQeUvmvaP?=
 =?us-ascii?Q?asCUuIVfeF0e7KpSmsv1IEn12Na0v9Cl+sGjKA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ed590b93-a7c0-4797-c76f-08dc3a21ecd0
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2024 19:00:56.0826
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR02MB8941

From: Rick Edgecombe <rick.p.edgecombe@intel.com> Sent: Wednesday, February=
 21, 2024 6:10 PM
>=20

See comment in Patch 1 about the "Subject" prefix.

> On TDX it is possible for the untrusted host to cause

See comment in Patch 1 about TDX vs. CoCo VM.

> set_memory_encrypted() or set_memory_decrypted() to fail such that an
> error is returned and the resulting memory is shared. Callers need to tak=
e
> care to handle these errors to avoid returning decrypted (shared) memory =
to
> the page allocator, which could lead to functional or security issues.
>=20
> In order to make sure caller's of vmbus_establish_gpadl() and

s/caller's/callers/

> vmbus_teardown_gpadl() don't return decrypted/shared pages to
> allocators, add a field in struct vmbus_gpadl to keep track of the
> decryption status of the buffer's. This will allow the callers to

s/buffer's/buffers/

> know if they should free or leak the pages.
>=20
> Only compile tested.
>=20
> Cc: "K. Y. Srinivasan" <kys@microsoft.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Wei Liu <wei.liu@kernel.org>
> Cc: Dexuan Cui <decui@microsoft.com>
> Cc: linux-hyperv@vger.kernel.org
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> ---
>  drivers/hv/channel.c   | 11 ++++++++---
>  include/linux/hyperv.h |  1 +
>  2 files changed, 9 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
> index 56f7e06c673e..fe5d2f505a39 100644
> --- a/drivers/hv/channel.c
> +++ b/drivers/hv/channel.c
> @@ -478,6 +478,7 @@ static int __vmbus_establish_gpadl(struct
> vmbus_channel *channel,
>  	ret =3D set_memory_decrypted((unsigned long)kbuffer,
>  				   PFN_UP(size));
>  	if (ret) {
> +		gpadl->decrypted =3D false;

There's an earlier error return in this function where
gpadl->decrypted isn't set at all.  I think it works because that
flag is in the channel structure, which is zero'd when allocated,
so the flag defaults to false. But it would probably be better to
explicitly set gpadl->decrypted to false upon entry to the
function so there's no implicit and potentially ambiguous
behavior.

>  		dev_warn(&channel->device_obj->device,
>  			 "Failed to set host visibility for new GPADL %d.\n",
>  			 ret);
> @@ -550,6 +551,7 @@ static int __vmbus_establish_gpadl(struct vmbus_chann=
el *channel,
>  	gpadl->gpadl_handle =3D gpadlmsg->gpadl;
>  	gpadl->buffer =3D kbuffer;
>  	gpadl->size =3D size;
> +	gpadl->decrypted =3D true;

This needs to be done immediately after the call to
set_memory_decrypted() is known to succeed, so that
the "goto cleanup" cases get to the "cleanup:" label
with correct information about the encrypted state
of the memory.

>=20
>=20
>  cleanup:
> @@ -563,9 +565,10 @@ static int __vmbus_establish_gpadl(struct vmbus_chan=
nel *channel,
>=20
>  	kfree(msginfo);
>=20
> -	if (ret)
> -		set_memory_encrypted((unsigned long)kbuffer,
> -				     PFN_UP(size));
> +	if (ret) {
> +		if (set_memory_encrypted((unsigned long)kbuffer, PFN_UP(size)))

Doesn't the above need to be "if (!set_memory_encrypted(...))" ?
Then if set_memory_encrypted() fails, gpadl->decrypted will be "true".

> +			gpadl->decrypted =3D false;
> +	}
>=20
>  	return ret;
>  }
> @@ -886,6 +889,8 @@ int vmbus_teardown_gpadl(struct vmbus_channel
> *channel, struct vmbus_gpadl *gpad
>  	if (ret)
>  		pr_warn("Fail to set mem host visibility in GPADL teardown %d.\n", ret=
);
>=20
> +	gpadl->decrypted =3D ret;
> +
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(vmbus_teardown_gpadl);
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> index 2b00faf98017..5bac136c268c 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -812,6 +812,7 @@ struct vmbus_gpadl {
>  	u32 gpadl_handle;
>  	u32 size;
>  	void *buffer;
> +	bool decrypted;
>  };
>=20
>  struct vmbus_channel {
> --
> 2.34.1


