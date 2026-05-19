Return-Path: <linux-hyperv+bounces-11030-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UE4nHMiuDGrdkwUAu9opvQ
	(envelope-from <linux-hyperv+bounces-11030-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 May 2026 20:41:12 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B33CE583CB5
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 May 2026 20:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5D6C3021E82
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 May 2026 18:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589A5345CAF;
	Tue, 19 May 2026 18:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="dQ3eFEtw"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19010030.outbound.protection.outlook.com [52.103.23.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73D7314D15;
	Tue, 19 May 2026 18:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.23.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779215609; cv=fail; b=CT8ln3MmJWZPHysw9OQYXG+yzIUxOi70UZPIKu40N2jNsOao9jXE0jYA6DGmBgekw+ORfliD2KfFK6H4g/kiZaxGYxnuDaDOUGlRf18ILOxJ6Rm94+TcMVKiNgcXgM4d2Tc36TgJWhqDR5FL6Vzy5Y8fhGHtWdIXQbwJBHqdvvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779215609; c=relaxed/simple;
	bh=czVE1mqbL4ItIG4aP7iZrgpcFuodN33d2Ujdh3a2PdU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E6wBFjQyh9Y4G1VMji4RlAzOIEQi02tgy6pSkuY/QLVmABBlW5bhXvAysgWXi6oGsD2vkyfNwJWDcEd8ZY9tU1IB35xDahe37iTt38NKz6Hv83zh5r5O1LwEeSDLDV3H4rK55BHCLe+kerhtS1krLX0IMwVhANryhGR4DG4wuaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=dQ3eFEtw; arc=fail smtp.client-ip=52.103.23.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CxL99iIr3zeic4t9wI40wQkabpKOeWN4R73cdr8G3eNOPXiklfDCcTPXawcHGS8sfZoG/acAMNgpu6eamRXVd7mkU5dD9vLUWh4GrHtz3lLU76RB4AAerdastR2eHizrkD8hJJ5t1hQpsSv705E6Tzd8jZDmbKxWQrBMDucqck7MhhhavwdLBQCJH4uHgfvp7Sc37aXAY/4v1EfwntZd8HwUo7qn+PdXG0dHmgbYJlGYCoqfn8vzbhpFIc5w1FRB5pCE5MZ/HPTcfX+CqkYMaUmSq3ICNoD6whmf4GEFgEoHVee+41RgAPOYuODfi6iQ6vYW/CTZ5abnDQwcAicZTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nKuHF4ip8RHjSdkqj/5FB8VjRCOJYFUMvxY31lZT6WM=;
 b=A1NiyLK60yTSAaHnCyP/5o+2A0v/p0AnM9qGGWvE0KlepCz0P+jh0ItxWuRC/wTXMuNLIaEfFa0/lm1eENJyM/vVO3TopNOWAfeHOY98AyRN4bNRm+ZmJAf6UVTfZyu8fsANw3vzP/am5kMlwuMa7zfnU7PiCJryvuVXjZz2DVgOlQU4wNlwTCc9wdONoSp/OTHqpJqp32G4pp9Ge4nFPd0REJxQucpvia6z5lmLaK+DQ5gUZgJGZQTC024QQDW+Igoos94xxhasZjtvy5Qu87I7bP4dTlkxy3AZY5nee5i7KroMDGJClNZBhTCCXEpE6C55RI0+Tsf/y9iD72CL8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nKuHF4ip8RHjSdkqj/5FB8VjRCOJYFUMvxY31lZT6WM=;
 b=dQ3eFEtwh54YOZMm+ForR5wzFMNxhNn6yffQ3Qs1cirJc3PjkB4fSdLVC8UOcBsDD0ulu2sYfgpIQMWFFycbRFjQUcS4wPrU30e66FfiWOgrf4w34vSJAP59rdI7jkLXlte7mKferhvSwv4TmS0keF8FScdxHL8sMPBXei/D/T2Ji9sCp1D+GelNzbbfNhlDY8sTaiPVOmrd178xs8nQH1sc/3NDVURGxJgxvB09En4tvrRFeTCtJjBKao3mufZzO158d0Nt7u1Gszi9plfrZfJpdzQ+oGGep7k5o69HOc/3sRT8FglqtTlLOEC15xaNO0RvQ7eaMDFhxAlLKLlXpg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by IA3PR02MB10626.namprd02.prod.outlook.com (2603:10b6:208:513::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Tue, 19 May
 2026 18:33:23 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%5]) with mapi id 15.21.0025.022; Tue, 19 May 2026
 18:33:22 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Berkant Koc <me@berkoc.com>, Saurabh Sengar <ssengar@linux.microsoft.com>,
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "K. Y.
 Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei
 Liu <wei.liu@kernel.org>, Michael Kelley <mhklinux@outlook.com>, Thomas
 Zimmermann <tzimmermann@suse.de>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
	Deepak Rawat <drawat.floss@gmail.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] drm/hyperv: validate VMBus packet size in receive
 callback
Thread-Topic: [PATCH v2 2/2] drm/hyperv: validate VMBus packet size in receive
 callback
Thread-Index: AQIUBwkfFERYES9mX2x90t/+K692oQIfeugFAhcXqVoCpbX6hLVwf9cw
Date: Tue, 19 May 2026 18:33:22 +0000
Message-ID:
 <SN6PR02MB415761EE7992EAFA14F2201BD4002@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260517-drm-hyperv-cover@berkoc.com>
 <20260517-drm-hyperv-patch2@berkoc.com>
 <20260517-drm-hyperv-cover-v2@berkoc.com>
 <20260517-drm-hyperv-patch2-v2@berkoc.com>
In-Reply-To: <20260517-drm-hyperv-patch2-v2@berkoc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|IA3PR02MB10626:EE_
x-ms-office365-filtering-correlation-id: f696a60a-6c8b-4cc2-ea88-08deb5d51b8f
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|31061999003|51005399006|37011999003|55001999006|19101099003|12121999013|19110799012|8062599012|8060799015|15080799012|13091999003|40105399003|3412199025|440099028|102099032|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?aKfOYCFT610DXS9TrOY+oo3qRQbIhWvzW5wq2JndZ/9I2pLfGCIxr1XLjPf1?=
 =?us-ascii?Q?fj0ivQTdXhYpZ+5JqidluPOlkzIx1e53b/YhAog/tDGkb0UJ2Gvc3KMdTmeh?=
 =?us-ascii?Q?Aisd2nQ8ULwkS4BqVdrb/nzGV1mxIKU7vS3Ys1JayXhpQpmP3XC1CR089dxu?=
 =?us-ascii?Q?EdYhD+xA44SgqGFE+k4OhoFbImHKRhrC/CWT0MR+avfXQEi/zveOhapazs6f?=
 =?us-ascii?Q?c5mWmsA8w+aqAXHkO5CHYV5ECWM+AuicyyNWcHrD6P/KbuAhLuo3qWNSPPOk?=
 =?us-ascii?Q?Opj4DtehsWEh0BON05R7boEcWhdQqerhHdx53nx100mlu0fvSoGAsDZJAWR/?=
 =?us-ascii?Q?NicaVhyZqToKIzZ40/VpmlXxwDTey+LpmgL9AVSckWkK/7pZi/+mnHq8knYK?=
 =?us-ascii?Q?mjhl07EgDshZmQXVgYUz4gDyVQHA3U1uD0xb+de9Am8U/ttFQtdkInFhkTd5?=
 =?us-ascii?Q?ghyYZXqtmHZGc+dUKgzIBB3aB7t3pFuts73++2urTKKIbyGt3dDut9dSpy/Y?=
 =?us-ascii?Q?FR0OA1omAFycPU1aycFgHKxxT//oUGBiP6hi8aYGFT5l2DmgdrEsn/gvrH10?=
 =?us-ascii?Q?q6LHUMtFo0SRGboBQU0X/0TJKgigfAQ7/lYLd1T+lgiTLJCuc2vwB9GRHIdS?=
 =?us-ascii?Q?qD/v4kA32k85BAvuWjxS4sQjZzriNE5yLYgR2b6F7/yPZ7U6y3eEVaxMhYr4?=
 =?us-ascii?Q?MPg64K9iWT/yjdGizUUX93WD15vZIM/wS3M/vuX1hVEjiYhF5IDoEGfd6xy0?=
 =?us-ascii?Q?kBZDwK8BCHh5j8berG0FGUcxUUkGT6gJWIiMq5hQgO3nuxxDcUzvckKLa1Vo?=
 =?us-ascii?Q?MggLce6ng57SVkLvSTZ9XwEwXsf+hkWHLqO34cHs19d8lJKzvyT2CwH0Mipt?=
 =?us-ascii?Q?cQ7ej5aqeiFwmsM31tEsWVn4VuEoTDy4DCRIAnBhMFVKpaL5YDBH2mjQqNXa?=
 =?us-ascii?Q?4BFJXCgp6NKFZEUFXwE0xu6odJ0g4FQquAZLmW6cSfBs0Aw/f22THmccXrfm?=
 =?us-ascii?Q?8PdF9Hv+RIU6Tn1UUm9l9JqbmjpJlmfpgYH6eJZm66zs40+9rt36Fj9ZjGNz?=
 =?us-ascii?Q?AAg7RhKLc7YkErmbkS5y10oiZMcjn9il/vD8HPP3Ms160CnK/2KNnyUNafCy?=
 =?us-ascii?Q?V4BvwT4rP8Ml?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?bvfQ6xjloi+xGAEUyqVdRqyhR/W6+DDQOyx7Be6nA/xMjhE71t8ZH7twcZli?=
 =?us-ascii?Q?n4XzZB9HJIuENT3SPNEYGC3a77NzCxWz0s/7aLfc1TzjVsEaqDPWStneaqZm?=
 =?us-ascii?Q?xwqj8Am7mK55kGZls/aRPE8uPFtbA4U5jG21/Nf4wU9G5zwYKzmQAd8ZQog9?=
 =?us-ascii?Q?qcRMksylQ2UWsDTcsw1gHujW5dxImntPHJBf2i5o0ndr4NZLXLtoutCohVt9?=
 =?us-ascii?Q?cbzx8VhNGUZWLJLaT3swU4Sc5XRli0vZWImQAqPWus4k4zYcyKDLVRjhtwfe?=
 =?us-ascii?Q?nV4sI9JAZfIdM6QHlLtFL6H2EuAFRS9sgk+MobtYGymzAKgGBB1WSaMFoROE?=
 =?us-ascii?Q?rt7Ig1rVumKmlwPrZaqxG5H4tHEmW86pnTUh0Vz+Age7djnW8xVtTHHmfBxF?=
 =?us-ascii?Q?LLFwJaLo7wwvadCxWiSR5mbli8jBqNS88vgRIw1Ep5dxfLI8HdvZGlM86eay?=
 =?us-ascii?Q?ulGillT7OICetYJPk2Jbovs7SeD2uqnzhbN7pxyPK8YTMInEBswhBbl+1xx+?=
 =?us-ascii?Q?bWjh95s++LSfEeisMcq0Rp4nPn/DExtV4suqIpMGi1ZviS92FPSd9GHiiLzj?=
 =?us-ascii?Q?QtI+uq0VXFKmEyYwqX2P4wZd3KIYQx2ULdWrKaH46rnSVMNewxphZeYxUukp?=
 =?us-ascii?Q?lFKAVcsNqokc2v7UlgQEkl1FxYtjBhb4EmL0YwedvahflMF8mQURsH2KZbRh?=
 =?us-ascii?Q?MZLKk6MJQ5fQTBPfBUPkSy9AkfAfYDuhuwjcPYhLef2vTPEQXXE5jXC64kzx?=
 =?us-ascii?Q?9LfJNUVvIW5tJQJnjputbMoy7J7ZXOyfUV6a3bZyEzWAAvvsdO1SFMDeuP2L?=
 =?us-ascii?Q?np7lhz5u+/Fjfo+bTxEzAv49Txz0+oeREEHGyl5OcIy4zwsS3beceKIFq5b1?=
 =?us-ascii?Q?7lFoI9OxAwuK1LAwUkYtp89cXAcyJGnNAWVO+N3n7cppJuibXOMGwQEyS9/i?=
 =?us-ascii?Q?nh2a53ufJcc3gUo9IQzbyLDpXyQiJi2mnQSxFUssspbEU+TYGl/RGqkWDIg0?=
 =?us-ascii?Q?PXwEMGHugk/+/r+h5tlOkLs8+0Lv6DctJykr/xq5AK9o6TkhrW/MVdSRPtQ7?=
 =?us-ascii?Q?TD2gMBFhHLx2QRv0Fy256l4wYVms5bhZ/Pb/oSkm8/eepchS07fpZKB7JfA3?=
 =?us-ascii?Q?z4P5/h5m8ZXQizSI94N1x5NpgNBZ6dy8UoObHSgRBPL7OQvn54VDE7quj3r3?=
 =?us-ascii?Q?TjXMRwjKGY3I750Pgv9akTXvD7TAEraszvbnZHxR8k+UyYrwhAmdfdju4dEO?=
 =?us-ascii?Q?fEo4pPeHju4WmqvBqlfhf67fw9joghleB008D31UPQtfhW2Fq4ycSvlC9BLL?=
 =?us-ascii?Q?SFn5C+1+l2s4zLwjMXeEhNnobZVExzas+9IUnHxpogj8r31s5lPaCAeojqwG?=
 =?us-ascii?Q?qDuN25k=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f696a60a-6c8b-4cc2-ea88-08deb5d51b8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2026 18:33:22.7919
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR02MB10626
X-Spamd-Result: default: False [5.34 / 15.00];
	SEM_URIBL_FRESH15(3.00)[berkoc.com:email];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11030-lists,linux-hyperv=lfdr.de];
	R_DKIM_ALLOW(0.00)[outlook.com:s=selector1];
	GREYLIST(0.00)[pass,body];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,microsoft.com,kernel.org,outlook.com,suse.de,linux.intel.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[outlook.com,none];
	DKIM_TRACE(0.00)[outlook.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	DBL_BLOCKED_OPENRESOLVER(0.00)[SN6PR02MB4157.namprd02.prod.outlook.com:mid,outlook.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,berkoc.com:email]
X-Rspamd-Queue-Id: B33CE583CB5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Berkant Koc <me@berkoc.com> Sent: Sunday, May 17, 2026 7:25 AM
>=20
> hyperv_receive() reads bytes_recvd from vmbus_recvpacket() but does not
> forward that value to hyperv_receive_sub(). The sub-handler reads
> msg->vid_hdr.type and msg->feature_chg.is_dirt_needed without knowing
> how many bytes the host actually wrote, so a short packet leaves the
> parser reading bytes that the host did not write in this packet.

This is a valid concern. Similar patterns have hopefully been fixed in othe=
r
drivers that were hardened for CoCo VMs.

> The unconditional memcpy(hv->init_buf, msg, VMBUS_MAX_PACKET_SIZE) on the
> wait-completion path also copies the full 16 KiB recv_buf regardless
> of bytes_recvd, including any residue from the prior message.

Does copying the full 16 KiB break anything? Or are you flagging as just
wasteful activity? This gets to what I previously mentioned about commit
messages -- explain "why".  Being wasteful is a valid reason, but it can be
helpful to future readers to be explicit about the "why".

>=20
> Pass bytes_recvd into hyperv_receive_sub() and reject any packet shorter
> than the pipe + synthvid header. The dirt-feature branch additionally
> requires the feature_change payload size before reading is_dirt_needed.
> The init_buf copy now uses bytes_recvd as the length argument, which
> keeps it bounded by VMBUS_MAX_PACKET_SIZE through the new upper check.
>=20
> Unchanged from v1.

Version related comments should go below the "---" following the Signed-off
line. They will be visible in the patch emails, but won't get put into the
git log when the patch is finally accepted. The Linux kernel doesn't want
to clutter the git log with intermediate version information that accumulat=
es
as the patch is reviewed and revised.

>=20
> Fixes: 76c56a5affeb ("drm/hyperv: Add DRM driver for hyperv synthetic vid=
eo device")
> Cc: stable@vger.kernel.org # 5.14+
> Signed-off-by: Berkant Koc <me@berkoc.com>
> ---
>  drivers/gpu/drm/hyperv/hyperv_drm_proto.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
> b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
> index 3b5065fe06e4..cdab4895dd40 100644
> --- a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
> +++ b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
> @@ -423,26 +423,35 @@ static int hyperv_get_supported_resolution(struct h=
v_device *hdev)
>  	return 0;
>  }
>=20
> -static void hyperv_receive_sub(struct hv_device *hdev)
> +static void hyperv_receive_sub(struct hv_device *hdev, u32 bytes_recvd)
>  {
>  	struct hyperv_drm_device *hv =3D hv_get_drvdata(hdev);
>  	struct synthvid_msg *msg;
> +	size_t hdr_size;
>=20
>  	if (!hv)
>  		return;
>=20
> +	hdr_size =3D sizeof(struct pipe_msg_hdr) +
> +		   sizeof(struct synthvid_msg_hdr);
> +	if (bytes_recvd < hdr_size || bytes_recvd > VMBUS_MAX_PACKET_SIZE)

The check against VMBUS_MAX_PACKET_SIZE shouldn't be needed.
vmbus_recvpacket() takes VMBUS_MAX_PACKET_SIZE as the max
receive size and won't return a bytes_recvd value that is larger.

> +		return;

In similar cases in other drivers that have been hardened for CoCo VMs, the
code outputs a rate limited error message. That should be done here so the
bad received message isn't just ignored. See hv_kvp_onchannelcallback() for
example.

> +
>  	msg =3D (struct synthvid_msg *)hv->recv_buf;
>=20
>  	/* Complete the wait event */
>  	if (msg->vid_hdr.type =3D=3D SYNTHVID_VERSION_RESPONSE ||
>  	    msg->vid_hdr.type =3D=3D SYNTHVID_RESOLUTION_RESPONSE ||
>  	    msg->vid_hdr.type =3D=3D SYNTHVID_VRAM_LOCATION_ACK) {
> -		memcpy(hv->init_buf, msg, VMBUS_MAX_PACKET_SIZE);
> +		memcpy(hv->init_buf, msg, bytes_recvd);

Additional logic is needed here. Each of the three message types
in the "if" statement has data beyond just the header. Before doing
the memcpy() and complete(), the code should validate that the msg
is big enough to contain that expected data.  I.e., it needs to do the
same as you have done for SYNTHVID_FEATURE_CHANGE.
Otherwise, the code that wakes up from the completion
will think that it has valid data to work with, and it may not.

Of course, the problem already exists in the upstream code. But if you
are going to make changes to fix the problem, the fix should fully
handle situation and not just be a partial fix.

>  		complete(&hv->wait);
>  		return;
>  	}
>=20
>  	if (msg->vid_hdr.type =3D=3D SYNTHVID_FEATURE_CHANGE) {
> +		if (bytes_recvd < hdr_size +
> +		    sizeof(struct synthvid_feature_change))
> +			return;

Same here.  Output a rate limited error message.

>  		hv->dirt_needed =3D msg->feature_chg.is_dirt_needed;
>  		if (hv->dirt_needed)
>  			hyperv_hide_hw_ptr(hv->hdev);
> @@ -469,7 +478,7 @@ static void hyperv_receive(void *ctx)
>  				       &bytes_recvd, &req_id);
>  		if (bytes_recvd > 0 &&
>  		    recv_buf->pipe_hdr.type =3D=3D PIPE_MSG_DATA)
> -			hyperv_receive_sub(hdev);
> +			hyperv_receive_sub(hdev, bytes_recvd);
>  	} while (bytes_recvd > 0 && ret =3D=3D 0);
>  }
>=20
> --
> 2.47.3
>=20

