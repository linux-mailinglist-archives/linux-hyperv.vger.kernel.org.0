Return-Path: <linux-hyperv+bounces-6436-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD553B150F1
	for <lists+linux-hyperv@lfdr.de>; Tue, 29 Jul 2025 18:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9B573A644F
	for <lists+linux-hyperv@lfdr.de>; Tue, 29 Jul 2025 16:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DD9289830;
	Tue, 29 Jul 2025 16:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="fNJ3hYsH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2081.outbound.protection.outlook.com [40.92.20.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1E722127B;
	Tue, 29 Jul 2025 16:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.20.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753805365; cv=fail; b=TJtGqNMik8yzbNjRGCCLB/N5gBdmokbGmQBxrHtCUUrpZBVtAQ7m4zfbhM7NoXtqQXFIb/uGRN89MGBgyO+CiXVcmIeOgC/+jbFVrYUtkzVDNK2FE2i2cu2cdebyrMROtMKX1OsEIA0GRVgdtUPTDuBIjcs9uNrBOesYsopx+Go=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753805365; c=relaxed/simple;
	bh=0YWcgyRYUUksclKv9ZeltfOrycobD0ccS3j07ACYKX4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D0gbJL1B4uVqxD4mFo0k2EJdplNvp7qfQRa9NbFwlIo9YXH/o+ynjN9+j6wa/i5Hkg8z0SQlWkrUYDqjv9rHDn775ItWRqhy5Qb8WHz5jYUtCuhTO1MBtd1KJ+roRVzG6RIPsr7QhbLHJ897kCN496j85cWYYGW6F9Ln8cM2jCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=fNJ3hYsH; arc=fail smtp.client-ip=40.92.20.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NWXadiEBesZflEBYz8fbporH4OMXlYdASl8fz4IXNyd4qcAFWaYrOQBcWWojnjwhKNTEKRQQIfTV8E8Y3BPlht2+LXTnjQ6Ze/bsIPjG6zA/qKjULgZsfuwxUyOvPIbtrbhCp8vgxTZODX1g9tp4zz0DQp4MP1TrrWWhwPH/hm1ejNUyt42zyOVusLqOkR9DTIYIj9UPREjuni/+KTMbcYOO0WMQFIjRViZdCH+qLIWqQ+yVCxaS3t/XDY+1XMoQpg9WKXdIgGzE7p0qf+Q53tOmsfAS176qTqxmr/1K94a7vComcGp2zCoU/bpCg4/e+jAkIS4TAsENZe4ibvPptA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6jGyH5c6VjnaHiZPDTYCc3tuKhwoNWSu7qc7AbHeqGA=;
 b=rmD8c6mavOv53K4bIUkYtUaOWMLUQkrBXxutc+ycQtJWdPzAVtwoLFWZ/C1EhTICSgwBEPV5JtpTSyseROJ9ObwY8lzBVJXNg3bzNiDXMy0QaUOM7VlLuM/4sSFJTCeysxnR3rCJhQV8z/4h8iFYUYbcvr3nxXvm4v1skAUwYDkGZs1jKSqg75In+O2Myp+VUlgMhPtLOHTnFcmi4CuwG3yfZMXRN1wexNzv7MD3fKXZLkSGRK18fbQ8x3DbfeC5I7oo6uVH/mWjp54dOEdnQFKI1TvBl+Hr/lJU9Bq+Y7b72K5Py4I8Tysvjeofnw+kStOsFjR7Pr2P8Sh9LAMnQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6jGyH5c6VjnaHiZPDTYCc3tuKhwoNWSu7qc7AbHeqGA=;
 b=fNJ3hYsHGjCy7To3YZRJOCVhmTtDExpJ18SqpiPnpVEQ5Fd/UYkR3s9FPc6qO0kuOle4qDJhc+KGbWdnt09X1q8/DivjQ5uLCQLJba53+W7kHH5GBu7eCFZWowGAUNv9kkNzj4OLzFqKUrUt3hkD+7FJOMIDv8LlUa9QeZXM8cpw8ngMv0KTa9nCA/ZkS1RQ5uqMw/LUkaqgzSRbaalJ89a+94vm/mj+Bn/bUrXRpJpgvmhvCsTe67/9TewcdUoOIfprtgqmNqrtb4pylVOBhwyeRu44HhJ1URANolyPPQChGVZQSOU+wfKfMBgnohAFM67ze3yUc+7yrbmU4lbEsA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH0PR02MB7606.namprd02.prod.outlook.com (2603:10b6:510:5c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Tue, 29 Jul
 2025 16:09:21 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8989.010; Tue, 29 Jul 2025
 16:09:21 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Naman Jain <namjain@linux.microsoft.com>, "K . Y . Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
CC: Roman Kisel <romank@linux.microsoft.com>, Anirudh Rayabharam
	<anrayabh@linux.microsoft.com>, Saurabh Sengar <ssengar@linux.microsoft.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>, Nuno Das Neves
	<nunodasneves@linux.microsoft.com>, ALOK TIWARI <alok.a.tiwari@oracle.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH v7 1/2] Drivers: hv: Export some symbols for mshv_vtl
Thread-Topic: [PATCH v7 1/2] Drivers: hv: Export some symbols for mshv_vtl
Thread-Index: AQHcAEe3+OKx7ga0hkKUwbQOt2WbmrRJRWAg
Date: Tue, 29 Jul 2025 16:09:20 +0000
Message-ID:
 <SN6PR02MB4157ABF89421EF7C7BDA6023D425A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250729051436.190703-1-namjain@linux.microsoft.com>
 <20250729051436.190703-2-namjain@linux.microsoft.com>
In-Reply-To: <20250729051436.190703-2-namjain@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH0PR02MB7606:EE_
x-ms-office365-filtering-correlation-id: 8a05093b-ca94-4cca-7e7b-08ddceba4729
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799012|8060799015|8062599012|461199028|15080799012|440099028|40105399003|3412199025|4302099013|10035399007|102099032|1602099012;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?SC287n4+KRTc9di56E99j/TjKsWLqvNOidYiMCyBONhZ23/BwT0+q7iawuHm?=
 =?us-ascii?Q?q7QrkxW+WaH5jrnS4hu/zazHlsS123geb9gzmtqFTvk5KE8/72KBlHbJS0QV?=
 =?us-ascii?Q?pVy4ra1R8ELC3VizazzxbdfFgthSDkD+hrM5SQiRXntkt+cf3vLwi7fltI0T?=
 =?us-ascii?Q?VfV99xnF0HaEwJ/Mk7PxggUS2JFLSrv8MvdfdrgD3ZcBqd4IdWb6tmsazayb?=
 =?us-ascii?Q?s5GrIDci3dVj6ygjacD5JGCDxof/9f1T0Iv0UBMmaN6I0U+3JktosX4auW3J?=
 =?us-ascii?Q?C0FRs2e5Pb3LDBIiGC7SlXL6m3M4ocg7j8h1dTuLv9ehWiXPK6XUGqfPdzfV?=
 =?us-ascii?Q?TAb72TeGP/HkugVYEYIjveNj6auisdnr2cQ43VIIUdGGl4LbMde9fBrQ4AS9?=
 =?us-ascii?Q?Y80hMoFcEx/tLPv4ue5LhdbRpfMm6grZB4ZtGTjGbELFYUQ3L6MFD2jOJ07Y?=
 =?us-ascii?Q?HB1QEu815s92cUlPGq/xiREsQkja4mWuFr4kCE/At/Zm7uYlORvnqDpKZPCR?=
 =?us-ascii?Q?bNm6401aL0iNZEd+XKCp5g+pITGIc/ejs8xVcObrU8yArc0in67xI4H0OlLF?=
 =?us-ascii?Q?aRD5Z3Wznx6Ea2+nh3mspQDkPu3xJfTZiuG9Q25s9P/OkbL9bEZ/nrqI+BaW?=
 =?us-ascii?Q?W+9GXd9Vv+IRPddNUp+9qvW6Qx/Gct3V4AILM8MKm7evT/tPK5lsacDV0E8j?=
 =?us-ascii?Q?DDRSqZkgYRCfAxYNXjfD5Je85oVIeq0jigWOyNzrUDKJMF16gYzmNVFyJN0p?=
 =?us-ascii?Q?1S7/dniUlKKVMtCdqjE4xvopGW859irxMIjr2rz9+ITAEs3wf52QRNWPKeJq?=
 =?us-ascii?Q?yahP5mpVgswVey1DovBvVWpk//5nbQ1zPgv51q8wHMPTLgBy9HB/x+iPkxcp?=
 =?us-ascii?Q?p8TYlB/La0Xahxvt5XMqHXviuZJMj2Z+H0fNjVm7rrMpym2LeV3iqze1IIgz?=
 =?us-ascii?Q?0Jss5I0sf/D7uhwJ5lpmKJyHRAMH79XSpnGQo9GBcXrsyFeYsuwGXjWT2lpH?=
 =?us-ascii?Q?VNNgMLWJpwIpEpNSDcTKOoo5e3mzOJ46L8h0PCZPjlwj8FQBiYhdUNmUHIb2?=
 =?us-ascii?Q?GZULRcW1mfyz2iywXIlIrue250Oeg7UOiya4mu7uDsdDiR5wLkXeUnojouC9?=
 =?us-ascii?Q?Ls7eha3S8y3EsLWDGhwbQuytO9erI25mwfplIYnYR8rcZdayaVm/j+VaqBGR?=
 =?us-ascii?Q?dAnTvycdPJYICJeKbBylTaig1fvuwyvIZKfVWxg5eUymAqc3yBRAubHeTtse?=
 =?us-ascii?Q?3gyPbF26lUNYqyhLvk/0?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?EoiYRaKrv3I2rT+A0mEDFDsiAkldPZZ0Dn8KhSIz7ELOTwsCP2PXGztxoHDi?=
 =?us-ascii?Q?iuthLk+evhmoIgnsOUxx96DFP/xf4P84Q4ASs5IMMOggvtA1QUkl8X0+q0j7?=
 =?us-ascii?Q?mLQXuc5bMTgrTgYijPhp36Nl07l5y8kqrtGdWgiBkb3LmbX8cpfUVgIhdk3/?=
 =?us-ascii?Q?5aKNL7s6EWa2JfhjZs4lB2i2xXBB8+1H0bI+4gtcxQx+AAoeOGvI6fRRWgLF?=
 =?us-ascii?Q?QrVWP14WTQr6Z3KlUsQxMeyNRRcKAGRa/vPf8m86wJkWwJ0xYI0mm/A1JqDq?=
 =?us-ascii?Q?I45o3OYYueNLY7HjhMS8valSqUjlNR2fAdu2AMXvvwfO6SWOgu70TEropuFA?=
 =?us-ascii?Q?UQVP4OiBuZemxQM2tPVUeNZ1KcZAbvZE42QsKMfaZ8AL1XGePHvqpTEzASq7?=
 =?us-ascii?Q?Y1bU33BFBoRGsFnwqXGF1k9LVC6snJiXGBIipTAMyEofd0ysGkbCQIa5bHr3?=
 =?us-ascii?Q?pkDagy48IR9QMCvKearATxJ3DzxJbqPwkCZcHrn+IQ9N8tT9vvgW9rarFLFp?=
 =?us-ascii?Q?JdloExTlgoxZMvT4nxQN2FxxHqQAEJFzSXNZgw39p9skEuQ24+EWsmzK98ZM?=
 =?us-ascii?Q?HLp5ATWYJxG+JXeqPoJjGo85cUGd6xeVgQWUN48QkS9BLZ0ygC5zU8rWXu6U?=
 =?us-ascii?Q?8knoZycVKTtPzFeKaQAcecZVh2s3vvg9f0BNnL+bNt1nZZcYp7PnktCcYn9w?=
 =?us-ascii?Q?dVhmyHhFHcYdQ6LhOjismEAFaIGlnXUioqVig1kj/Ibu6RBmMi2bfj94fQv9?=
 =?us-ascii?Q?0alZZHev1MXLgodNWHvV3Iq5cDPCZlqVQ5kEvcgKw0a54qbRzTg5AAmEHsVn?=
 =?us-ascii?Q?p7+qpfRRFJ+qLf6AT7JY48A+J8didfw/1l/Qxrd+Ni/e0TRoA1jv5UA8Om39?=
 =?us-ascii?Q?edpRLEvScKZ0hRJGwVMqX3xGfmEKpnSUboot4BBFVOHhyvMHURQ1PU7lbhjI?=
 =?us-ascii?Q?NcW+rBZA8Wke94eFQ60l65TfPVS9p5CEwHP9gMNZ36v0AecF/oLJb+Zp36Hb?=
 =?us-ascii?Q?Rqc6elaJwCCyWvWPzCvwU3Zbuw2i/l+rDjTiJjuUs2TPCyBSDi7P82G+RRl7?=
 =?us-ascii?Q?tWjkzsqprQEDBY6ZsljzNDlgYlPEw1kWuYFbmrdcimHPaBae/45G/+h1zDYp?=
 =?us-ascii?Q?1d2wC0E8Z3QghkcDz8Ydm63gHRVMkWQn0PTRrWTWCnrO6wMwv/6uebbucybN?=
 =?us-ascii?Q?3qjnFNP3JFlx/WkTik7bVO/JLtbyDn9RMAbpzd8J0Z40KnMT9ObNsd1SxNw?=
 =?us-ascii?Q?=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a05093b-ca94-4cca-7e7b-08ddceba4729
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2025 16:09:20.9545
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7606

From: Naman Jain <namjain@linux.microsoft.com> Sent: Monday, July 28, 2025 =
10:15 PM
>=20
> MSHV_VTL driver is going to be introduced, which is supposed to
> provide interface for Virtual Machine Monitors (VMMs) to control
> Virtual Trust Level (VTL). Export the symbols needed
> to make it work (vmbus_isr, hv_context and hv_post_message).
>=20
> Co-developed-by: Roman Kisel <romank@linux.microsoft.com>
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> Co-developed-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> Reviewed-by: Roman Kisel <romank@linux.microsoft.com>
> Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202506110544.q0NDMQVc-lkp@i=
ntel.com/
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> ---
>  drivers/hv/hv.c           | 3 +++
>  drivers/hv/hyperv_vmbus.h | 1 +
>  drivers/hv/vmbus_drv.c    | 4 +++-
>  3 files changed, 7 insertions(+), 1 deletion(-)
>=20

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

