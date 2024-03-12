Return-Path: <linux-hyperv+bounces-1738-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A853879D21
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 Mar 2024 21:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2013A283266
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 Mar 2024 20:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1713142645;
	Tue, 12 Mar 2024 20:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="G2I+TGxT"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11021006.outbound.protection.outlook.com [40.93.193.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BFB382;
	Tue, 12 Mar 2024 20:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.193.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710277194; cv=fail; b=I0Ny1S6ZwlzSN1mbMD95y7BubhO2h+z9absg9L0+vh4NP3PwAULsS3PT9vdV0eMdT4Y4FzRutQ829gBSFq9m2KazOQ2cwsBnI01eALnDYABrSWfb/C0tYpKvW5lBbEE9utQCMn3iPXzxQG/3moPI1IaO+YC+HeZOyjE++PA4NP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710277194; c=relaxed/simple;
	bh=ZZf5HzpR2QX6OSr2GsuN+WSHyeXJBkrnB5u8CDZtIz8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pLeACHwyMvMliLhQv6RzEHeYAWrr/CASXDUQ35v7yYKvc/sd2X6cUWXVGs2kMHpoqDG4jel4Cr6Q/UMA8dCxXgUL8NEUSSvuyO3xs2FGsFM75POeJqNtXNlevlayWuZzlx35meTClYiJFuFb87b7u/EXQsHKJjcXlPYUBI6B8lY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=G2I+TGxT; arc=fail smtp.client-ip=40.93.193.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B3wj+WPf/upRbo0gRWvLeFbhsJPpRAq/ObRPZF/l89EVIJOz2U/GXMdcCPFCdECS+X6M/UmN1WwuidsvK648yEXwkYLPaGIWmLzGfy94qSnbq/ZXBfsem0M1zcm6rtPjas1N4jWpe9kg/9pfbHx0jFvH1PsxdJxOY/GQ6OprgVXn5Gn/wy5+2jA8R7meYeCalG8yfE690Q/sjA0PCo0B73vFLKq0TB++5gYKUAdgiTYoTfF5+MTOPZNxYfT2gkbH8VRbuw4pG4OLz7ENtw2ZXdYuqsCJ0a3hO7ObtqgYUOcv0wiYo5MK0NIWtyfxl+o+o7MmCyevR94RDTmQziS76Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j0oqXTdcVxFes8pKvFPIQYY18crYERC4zWbc+d+EAcU=;
 b=SV10kqnbDxaOQDs+Zs9cuGIt09kmgByjVh30XU+StS2cBNILCzUPwsG/OsoTiMCIuHkwD25NqXYCNBznPlg9p5oroXNXpfFWJnZSr2uDdkURyfzC0RjgyLz/7nx7YBWNhFIWgGXF59Dh5sdavh+A6nU6fBT2iq3rlkTASh4q1bMr9Aq6nkrGbkeTDO52LeL0gdiAN5BHqRp0BiAMhsmkIGDXMHusfLXDn6eA1sQIoPzgxHYox/FTvyx7Pqlx2LkHXBG7lf5QWY7FOGCca0dmZGoufbcfZ0CHKrkNxmOvi7gxjyM18rzU72jcbyxbTJp7ORhSsuAmqy3l9EHf5I9PMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j0oqXTdcVxFes8pKvFPIQYY18crYERC4zWbc+d+EAcU=;
 b=G2I+TGxTdqiqziDSEbDml4snCgd6jANSptM81agLV75PWUsJfnyPmcamAqNy7ON6aGzUDpnQlUiQar03EZLtRRN/qMwfDYWLQOO12sDzmohRBLFlJ7XGjjue/xVWSvL5Hq1NmBGgT9yeqRGjRrm/3qV3DJQJSPzD7+OYKJJpOlk=
Received: from SJ1PR21MB3457.namprd21.prod.outlook.com (2603:10b6:a03:453::5)
 by PH7PR21MB3236.namprd21.prod.outlook.com (2603:10b6:510:1d8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.13; Tue, 12 Mar
 2024 20:59:50 +0000
Received: from SJ1PR21MB3457.namprd21.prod.outlook.com
 ([fe80::70f:687e:92e6:45b7]) by SJ1PR21MB3457.namprd21.prod.outlook.com
 ([fe80::70f:687e:92e6:45b7%4]) with mapi id 15.20.7409.004; Tue, 12 Mar 2024
 20:59:50 +0000
From: Long Li <longli@microsoft.com>
To: Saurabh Sengar <ssengar@linux.microsoft.com>, KY Srinivasan
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Saurabh Singh Sengar <ssengar@microsoft.com>
Subject: RE: [PATCH 3/6] uio_hv_generic: Enable interrupt for low speed VMBus
 devices
Thread-Topic: [PATCH 3/6] uio_hv_generic: Enable interrupt for low speed VMBus
 devices
Thread-Index: AQHaYcvJgcNPZXWcHEu1pfrlhbcG+rE0vKpw
Date: Tue, 12 Mar 2024 20:59:49 +0000
Message-ID:
 <SJ1PR21MB34572B6E99C28D63F0ACD2D3CE2B2@SJ1PR21MB3457.namprd21.prod.outlook.com>
References: <1708193020-14740-1-git-send-email-ssengar@linux.microsoft.com>
 <1708193020-14740-4-git-send-email-ssengar@linux.microsoft.com>
In-Reply-To: <1708193020-14740-4-git-send-email-ssengar@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR21MB3457:EE_|PH7PR21MB3236:EE_
x-ms-office365-filtering-correlation-id: ce39e220-c7ef-4abc-a3e0-08dc42d75b76
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 e6q+N5D2mw25S1vccTH9XzOzyjOO0bFpRWjS901GrdkKCtWFXooZ+pGDTPHdNO8ogQhWFWBzSi97lZ32V+S3Q31FU2KASJlVJcN3g0T8/LJOiZU4qRe/f4zBXOecJnY9P+LRzm3vplo6OVX7ib4eHZ8mocZhg4C9npjtL3/d2H3hoNsZixYpBFz6xMsrECnyXFwqB9PFrrgES3fRmOxMQ0sylYoqYFP4HObD9hPSjUBHrXuwblXnPQ1mG6aXB5C65RMEhbtqQjdgMMn0zxEfgqmW+i6vyzaOqZh02fz0ViyuKEKkk/wjexosXCWXRYhdwkOm3Wk5fwEnyko+13LZCbf+e4zonbPOJGxJtXaHFrLHnU+gLD/x+R123jkk0MWFvT4CK3Na0Fs3nteO5Mmta3/deqS51+L7yk4lHiKC2xH4mFIhlUmfbmJ3NqmO1bYnanHfjaZA2tutdOdUH9aEs2tWvxzFUluq/CR4RBBgATVAaZYwTGDUovh1uX4rvSNKr1Y+vQUyAxUjVeeCt8cMYEquufuNj0PIMErsrn7hVHflbHEv5OVg+A/kCPX65j9UCXyYiXkLbajgg77/6D3Uu8VPhPBEWQlzYVX/sB++d1siwt4ML9E9ONy+3TEXTgEjncIEWiVZTnBjtuUnYC5nzsvGrWq4A6hIT20x4ZuGRoazJF2SVmcYxSR6014EfrKdLiBeDkrSAKnio8y4crRqsTwxjz0NdbpbiUZew8JSC5o=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR21MB3457.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?nHpWSOQClnWIzM27uQGsfi7VhFH8Y/DyYjOPB70G/ly07PrdR9yy9F3kcxfD?=
 =?us-ascii?Q?ZVWxbjjcfjPBnHok/tSxbxDar3Zd1E1xgXrh4+dw0GUhhaKJ5fjMfbvrXzWU?=
 =?us-ascii?Q?/nWjNLVvyMwgSC5dWmYKLdOKqRZshwZTEbE857AEYp+dnp4to2/8N+ZEDnGR?=
 =?us-ascii?Q?RgWjMdk4qt6TBqq4lukqZBddVY9XI+F95LqX8IQcIPwhHUchQYYIfk3EUcaF?=
 =?us-ascii?Q?Kio4oWX/4fmnws6NEF6wGFcjjPrlNXD1EIXv5ErZIPpuCCYhiacmJBiHRWTV?=
 =?us-ascii?Q?HHZx/G3DTruC2f8/TiLiErY/FKYTaZCZaOGzrQ2lT3ugM60NUVpmwT1I0oqh?=
 =?us-ascii?Q?rizmf4oBg7lFBA2xgsN5vVwZ19OkG3ytw+nWcVQYGINiSfoKCuRdrd9f9BzR?=
 =?us-ascii?Q?2S430+AwdnshBaJaqkdMyJVsYu12DZs5pu8y/xZ71pcQ/Vu2FDi4izUv9rkF?=
 =?us-ascii?Q?AIja273H45RctJwPkancephZqcQAncIqPofygrg4Y+JdPAslRStRdskptt8d?=
 =?us-ascii?Q?1i3dSWchgbnAd8veyuLNm0urCQDH3qFZHwC8inrFFOBSfrF17ci2eOFGGZfH?=
 =?us-ascii?Q?5wSL8a6KkVKY9ipeqN8FYfsqbBtqhEB2yAFYLg0Bh/TMAHWaBEuSdRPo+o06?=
 =?us-ascii?Q?gFyM8bzwIggALZ84dH4cGWyxCee6Vx/fS48kRYUWbqwkKRKfawaG8BGMmNlf?=
 =?us-ascii?Q?F2gEFqXW2eWAmTDbuL7qMfDP1vgw/tbIfvckSTfbWSHh2pDZ48OhkyIOumDZ?=
 =?us-ascii?Q?39gmfbyFFar2Cty8+PhzNB9x4ZcWGDA+C3ikANMmKfjZdKbM3qbRh9JDierH?=
 =?us-ascii?Q?diu9t1mBcEUN+xq6GDHCHrHJd55gmD/L2+VK3N1Uya1LKHvpg6vlUxzKyv1S?=
 =?us-ascii?Q?bqlwbAh+mZ7vVsYruaTBNEtz3Fgvtt8lLF1AAvAenVZFQ9ZLTr8wbryj9aib?=
 =?us-ascii?Q?Fix4cX8uRWuv1mCfbheJlu4Lql2gaYT/PNWs8Avjeii05iCkpS64fL6u4759?=
 =?us-ascii?Q?NZTkQW9oc4GGqT42bjZdEwld35EimKxBL44kepYhZdC/q2sdqfc78uSVEM+S?=
 =?us-ascii?Q?pNNRR55U1SvIYFuHUSCJvSySsOXXykp0o4jTHAVFxb5eWjFfYhFhaS/vjLjQ?=
 =?us-ascii?Q?by3y/pCM9lZ8e1P+d7hNcLzDckRTVDoSFqtoGAFUgd9/iP2ANC4riDJqg8zL?=
 =?us-ascii?Q?G7vkWwR8msxHENMelYpMzeR6YuOghqKzBc+7DWuLTZQmtlaM5XhaIdAboXnQ?=
 =?us-ascii?Q?UsIoIBZhLbN0R8+7JZg41GF9xHOr9dEQXAoejgo6PNJ/K2ZYugs4Bc8CCRqf?=
 =?us-ascii?Q?xXgqfNxSjjdBl+6NMt6KJLkWwYK0Q4T59U2bb3czayrWlJI5973RqS5ilhl2?=
 =?us-ascii?Q?unNLVg5tBg95xkyN1Q3vOkEpWGc5WmzgTOfhxXGftSFafwK0mpm+vMgB4OFN?=
 =?us-ascii?Q?cJH1ZcAkQYKTkGJ6Zwcgl8LzY/7aOnqQl3akksMSaECE9HqUU+Ilyq2jpPjJ?=
 =?us-ascii?Q?euiqOkqU6Nu/HMAsCQmQWasR36Xn8E9G9aUpRX33vVP/ZwHENhAbfN4G9Ugk?=
 =?us-ascii?Q?ZFllgfVLqtRh9d66Dl0L65m2hEdOsazR6Lzpul8o?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR21MB3457.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce39e220-c7ef-4abc-a3e0-08dc42d75b76
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2024 20:59:49.9059
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4RVQnpi+0bPw8TR2lpKfUa6BeXeZY/TetSs6fGEwzP/PEn3B+Mzct8/JI9KFAPpo7DREU/GUfGM9YQmrSAgjiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR21MB3236

> Subject: [PATCH 3/6] uio_hv_generic: Enable interrupt for low speed VMBus
> devices
>=20
> Hyper-V is adding some "specialty" synthetic devices. Instead of writing =
new
> kernel-level VMBus drivers for these devices, the devices will be present=
ed to
> user space via this existing Hyper-V generic UIO driver, so that a user s=
pace driver
> can handle the device. Since these new synthetic devices are low speed de=
vices,
> they don't support monitor bits and we must use vmbus_setevent() to enabl=
e
> interrupts from the host.
>=20
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>

Reviewed-by: Long Li <longli@microsoft.com>

> ---
>  drivers/uio/uio_hv_generic.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c =
index
> 4bda6b52e49e..289611c7dfd7 100644
> --- a/drivers/uio/uio_hv_generic.c
> +++ b/drivers/uio/uio_hv_generic.c
> @@ -84,6 +84,9 @@ hv_uio_irqcontrol(struct uio_info *info, s32 irq_state)
>  	dev->channel->inbound.ring_buffer->interrupt_mask =3D !irq_state;
>  	virt_mb();
>=20
> +	if (!dev->channel->offermsg.monitor_allocated && irq_state)
> +		vmbus_setevent(dev->channel);
> +
>  	return 0;
>  }
>=20
> @@ -240,12 +243,6 @@ hv_uio_probe(struct hv_device *dev,
>  	int ret;
>  	size_t ring_size =3D hv_dev_ring_size(channel);
>=20
> -	/* Communicating with host has to be via shared memory not hypercall
> */
> -	if (!channel->offermsg.monitor_allocated) {
> -		dev_err(&dev->device, "vmbus channel requires hypercall\n");
> -		return -ENOTSUPP;
> -	}
> -
>  	if (!ring_size)
>  		ring_size =3D HV_RING_SIZE * PAGE_SIZE;
>=20
> --
> 2.34.1
>=20


