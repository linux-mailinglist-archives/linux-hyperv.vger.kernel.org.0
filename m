Return-Path: <linux-hyperv+bounces-3776-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35440A2004F
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Jan 2025 23:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C7C51886C35
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Jan 2025 22:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE501D932F;
	Mon, 27 Jan 2025 22:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="mlcPXlZG"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CY4PR05CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19010010.outbound.protection.outlook.com [52.103.7.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109F21B4F0C;
	Mon, 27 Jan 2025 22:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.7.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738016067; cv=fail; b=RDaDzQlsxBh2t7zgPRvZ1czm1ve4QtORy1yQsyOMtec5oV0uU6EipL+ksM2YHQ+QXtAi4ZF0e1hijtME31qXbXNttJjNemtfMVg58p6RQ46miECZxdQ9tm135pkIoqLjuKRwU2GKQCWFIrintTXvlK+flTT3pFi3FklmwZxxCM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738016067; c=relaxed/simple;
	bh=ngVGgmPXHYXWQetri1ktX6v2o1OkUIYDwTOf0HCR07U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GyGBq94ZUxG22yPiSvHEgcsgh0OL3vLpJBqo0tpcMFivfRJ0NivrKVNO3Itg37c63EjWMfUHy0eSoMXLOOi7WDcMG72fk6zLVEQx3Arv1M40bkSgVyDORdxI8CNF4R6jswnWdNqFP4lVk1gpfNXnmt+U4nqalxK+wQLCMkGscdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=mlcPXlZG; arc=fail smtp.client-ip=52.103.7.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v+vYlNX3wANASaApMfWZB79XyuMmrkv1VHR2dY4evU00JepvCCkWjoytN5qy7ye1Sn5s6tf6xe/fDUCX7KKa5QndolrSpSQrcRzxC+x9BmLSjzgIDsgF0Jc8LRcbwdOoUkO0x8v1Sj4dOuWmIUZNQd4cLc1Yx8cUx5ekf+/biFrK7G6O5J4W5jVRsALwQ8yqELT6D58CBF2jXpAI2YeqFetsNzinO2B9VJBN4YjD/eqRjXAUeJIFx/YHcADyHJ25BdC5Af/KMe6bCJftx89l0GE7z1zqLSjU0sLvvN4JnWO4lNknN7t1HwQ5eCblXIaCfQTy4k+NzcZuHDXl1EKVBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eXZ0jHYlzApcym9+yJO4INKcAX/es79VVseya0ZaspM=;
 b=ZMt//pS+2Gx8UlQI1R36SAlVs8ZappxMLKixqLdMBUMcBZnmYeHmCqKSHaDcr1DU8IwrMyhc3m6Td4ysoo2pArn1IkOSOafcHvAw6K6YStJ/nUq2PHz+gzWeKdng3UGtNcbNTJEqPdH6eoaxIa3cdxrZlJg2plwhIYtoKrL51vzoc19klOEjKX5SGwVcYDspBdGyGfJUHn2P7odnhHEqQmL4ei+LNB+sbLbUwdSIOOPtAq2nuULTNH9G+TLpaAGPAySUkAwAjRZZGVV4xK6w0A28w6WcKlKrMyUhRbvfMynl6HRtLDzDPH9iSChtpZdiBSY/RUnwgRPVxk4T6SffsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eXZ0jHYlzApcym9+yJO4INKcAX/es79VVseya0ZaspM=;
 b=mlcPXlZG7NsnEdJdKGMH4/Ox5ZE1R4awEhTsYQlLE3tm+KUCsfiqENZncjNTaIFpMQ1nWcpKGBmOffFzKbXgslNP1nRq3Ouj4alkUVRY2i7ALD+v8JX483RA/er6urgk+qO//L8e5EOBrBgQmj7rtTiVYcHKb5rQvk/aeNc7sAHQlIEcd4k/zJSBSXmDg2OXXx208CspoCsSRqz4YPVM7CRiUQizFRxqw6mt/McJvpB+mPtN2HhXAz4HHOGgOG8k+9zHLYnUsZ67/pMnAE3ZfPMOgLlsyz8eT10jHcYKN7D7NeGBvHURnChe7bqv7BMZ0qXI87i/tuxF70d8Z/xBsw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SJ0PR02MB8845.namprd02.prod.outlook.com (2603:10b6:a03:3d9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.20; Mon, 27 Jan
 2025 22:14:21 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8377.009; Mon, 27 Jan 2025
 22:14:21 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, Wei Liu
	<wei.liu@kernel.org>, "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, Dexuan Cui <decui@microsoft.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] drivers/hv: select PCI_HYPERV if PCI is enabled
Thread-Topic: [PATCH] drivers/hv: select PCI_HYPERV if PCI is enabled
Thread-Index: AQHbcOa55nOVe7vfNES2bvVQptEMerMrFbtwgAARUQCAAAWOcA==
Date: Mon, 27 Jan 2025 22:14:21 +0000
Message-ID:
 <SN6PR02MB4157562E31E7782596C2C73AD4EC2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250127180947.123174-1-hamzamahfooz@linux.microsoft.com>
 <SN6PR02MB4157BAAEB938E7E4E849DC7CD4EC2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <Z5f94J7rzSC-TyIB@hm-sls2>
In-Reply-To: <Z5f94J7rzSC-TyIB@hm-sls2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SJ0PR02MB8845:EE_
x-ms-office365-filtering-correlation-id: 79b57ee3-1042-4715-1b23-08dd3f1ff344
x-ms-exchange-slblob-mailprops:
 laRBL560oLQowKaVx7aWRf9b2EXVRKJlN8iMoWVlkulfjx0NI8pmv3m9owWISrUMS1F3uUecTRm6A0SRErVcQDD9U39oM7B5AJiJlBCLFnddzyjTGw35/IqvFQRZfKpdCiGd+tkdUHsfewSLoMIxQhJ2pTMr8Y1wUerFuz4dMzJSxv5oCrfyPF5AXJ4z2PRiJPrJ4/+pBDEgqcXOhDSAR83Dmn37pfVWaKTmxrI2k5TJgvdqaAQGSE7M/IE54lh06gjAjki914vM3bHj3M63esehHjKFFck1XjjMJSTV7tmWYcS5+l+c9R5RzY65wKQir/AKlnCpMnQ3fISuJLMv+3kXsxv07WKd9DXdw85dbuKAtZM+l3v9ShF9gE2rYJQg8de4MlhIy+TYoTaS3qyGyQ/FoIIoqg/McpWflltsJoi7TOoaaWtmxk9g6CxoKMQuqM8a7uJHdfpROyYk7r5a3qgsBelNm4ugdvGx8iCWxinxGjGhLJU0yM0t/v0tUswQZSEX82O5f2Jvu1ZIMN8Jz6ILz/1YdDC7oStUdiKYWja238igi0kEt3fXYCNdncVJ7EZ7Q8MYQhzYDvJGuWcvIUXxF2WXpyas0W+4980zUT2a03NDJ+rNomLbzz5DqC44W7oPJ9m6QPyJTLEI5KwIdX3TexIrBV1bTKyNHlQtUpTnZhXSiU3qxP+ezPuVCp9Ke+53wjxjHjJQWPog9UCxfb3eUrNC7fnoD/2gg7BFuB9VbFZSVBmK0BCiAbCDs7kycqW0S3sPzjWYw7vxXacq/AK5bfr7AZrm
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599003|8060799006|19110799003|15080799006|461199028|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?98ASBoBD1eFqM1XhOdMqEgPbXyVFM7g9ZXEiHBrjkZw7XiqN7rYx99UbkY82?=
 =?us-ascii?Q?7A+5fMHaU3VzGTzhKbpBqyvzFYeXPCXDryOaCsC/wHzC2dBRjUSORCrgy7nB?=
 =?us-ascii?Q?quWWI0TffDRcTSZ1i2U4OvCjk3pQlnlaZkl/5Wn/SQhGuawxkd5layl/jm3R?=
 =?us-ascii?Q?9cHqEIdHYmRKwodAL401EbB0Ue04cpUrQJBbugDY6O/h+NSrRoed0d6rs8Rf?=
 =?us-ascii?Q?JtGEyPBvcRltgCN44L0pC+sM1jNssH+/90Nlhks4UCArGz01X21IrRPu1u+Q?=
 =?us-ascii?Q?RKqr43c+yWp/ZkMt/4jIZVItHkZ2xN27xD93j3MHND+q4qkWx7zkDOHs0o0Q?=
 =?us-ascii?Q?OQoG4OMU2ZynbKjj5pyWx0Qj/la/pPX59ip0H3GJb5jYClRzBmLfFtzzvY4g?=
 =?us-ascii?Q?tnTC6iqA8hdK2muGc1UUNDrK81TPBTyj+aWVla85TmL5tJHz2zsuz7NNHuzo?=
 =?us-ascii?Q?wvVvqcT3ZkBQxH+je4k1o8rsXbmaEawTOCitKb3iBpTo9S6gFPU3rkXp/bgT?=
 =?us-ascii?Q?T2XCbiJBZcYlrs5a5Pdu3Xu/XzafonkXmeHDBLR6k4gzaG2iquTXs7ZFEyhH?=
 =?us-ascii?Q?SgvXAvKqbfBZlVsQcufXav5Silr2PwXaOTB+QGPkEtJapeOxe5CQB8mxaCz0?=
 =?us-ascii?Q?sTi9JChCfNuCtxhNTVtbEun4dBNbsS53u1L35v3PPoGzjsS5qqhBkCaUi5ID?=
 =?us-ascii?Q?Kl8tG1JWWPZrxRmrijLhOSsIZ+NNsBN9IILwNlZS16DZY5BWCxwJ7mDqoxyh?=
 =?us-ascii?Q?mDTM8HvMvOSnSkeJCvwaZwTGhGUNNXRN8vavQfoQn73Z2epgowwCL8rkOtNj?=
 =?us-ascii?Q?iiY33YqydbLrA7fqj4EUQodsTq9AlvpFlS8I2ScPin7DQJPpPV57EleAJBSX?=
 =?us-ascii?Q?N8oU9QqlyCUH+TYMkS/MZqnl9QrMN0gbl3sKAawjXeafKaSa0uUvWKGyzDtO?=
 =?us-ascii?Q?6AbFzgLhVhkoyhqwCDrfNnot6TwfGp9eiuPZr1YpjtJQBOD8PZ5D5xcC8E52?=
 =?us-ascii?Q?pW+WlPp3YuKuHaPvgk+8s+HQR+KEWefPSgg872f0y85K/yM=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?EXPDvpjBKBi0kGg9R1xkt3sRRHSPkq6wJDVzFTdbFOe++4TTdfTtPXp1kpqI?=
 =?us-ascii?Q?j/ex9GRdwlebP3r6iOGMFc8+91GrKiJl4onzX/WV7hKku2ZvzHRdF1KLt6JR?=
 =?us-ascii?Q?nJLfVPjsme1BVfzftgQREW6+I0vq9ElKfOByo7wTXG5cW3SCr7UZeW2OuXK+?=
 =?us-ascii?Q?+asLE3I9oDif7FRPxCaKA+lRJgUXCUlsdzLXwwJ4Yb7jXHiNj+oCcZnQnO/6?=
 =?us-ascii?Q?PPgt7m+r3se/cPPIgbwLG1v4MmLiIswR7OEsfQLvA+PtaXDmTtI1hzaRh2TB?=
 =?us-ascii?Q?GF1MIzObce+qPyWpz8pQXlAPBK/L6J80mPr3UruDSlVpnKxdjEksCUAXlmfu?=
 =?us-ascii?Q?6e0CscofoCjM/FKbvSdKYjl1Nj4TW0RyziHnh8XcKXgh0Nf4s98xmmXvleA1?=
 =?us-ascii?Q?U2dU77MVb7W9oqOi1fv24XSlXoOLU+2kpQhqqXld2I3rINzvBk+0TnYXpMoc?=
 =?us-ascii?Q?wTzyfxc7MqxtIL5/BBuzqInNuSPkMcFrR/sy9EYuIUUyjz++O+SUA4ivYOvf?=
 =?us-ascii?Q?fsoW73u1yHC8v0lwADk9WJQhvFZMPyIoa176YBXXbPqzvRRpw1R3p4RStP8D?=
 =?us-ascii?Q?BLHVstLIOQMAFoBYGiiZL4aRhgVyU4twGY/HXTjVmxWF7g73lYb4cmz/EaGg?=
 =?us-ascii?Q?0xBPiA4GtYBNN0N+Jfp4meJ0N+vW8VcKrWndMz+luwsSc89anvShw+vNy5RD?=
 =?us-ascii?Q?8N2srE5ZiB+/0LmxM8tYqk7dn7kqEvHBff42Q9k4sTaVJ8D5EPHtZdCI6U1w?=
 =?us-ascii?Q?WmZo2Ao7TCTI1Y2dnwyQCgLCbKcfeQBEvp6vpZjQtyaKpzCJUUDS8aWRVWgd?=
 =?us-ascii?Q?+JiX3EOEmPtrwLzgYCTzTL8lyyorucDgWaVGX76UTRt/QnUm5+e1FBXggKF+?=
 =?us-ascii?Q?t3gpzPI0CmVnKQXhrr4eJCKRvs3MIlef1AnC4MFBJ6sA9QdvOGCAx/e0ARDj?=
 =?us-ascii?Q?O33Rc6aAivPZZiZvyh5os4lcpSYdL6jESxsY5sX7pwn6OguWDLTyLZmOVfro?=
 =?us-ascii?Q?ty1yILNwBU5/s4sOdKB8h37cTpSd90ChEL0dLZe+u1d+IjiFeZL9kVqZ/1NP?=
 =?us-ascii?Q?IrSAJZNRvB4LcX7PWffmPqz92hVCwTcr6Mz0lCguvUea9g3dsh1YMYTxL3cH?=
 =?us-ascii?Q?7iiHrp64hM3VIIDZM0SWevo8fs6oqUG/crwqPIXfAeTiY6TE0XOPikXwHEUs?=
 =?us-ascii?Q?lhOAfOo+QeXI4fzIFduW7E0sqYBYKGb2PCR7t5Wm0reD/oP39f/rwcWRavY?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 79b57ee3-1042-4715-1b23-08dd3f1ff344
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2025 22:14:21.3948
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8845

From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com> Sent: Monday, Januar=
y 27, 2025 1:43 PM
>=20
> On Mon, Jan 27, 2025 at 09:02:22PM +0000, Michael Kelley wrote:
> > From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com> Sent: Monday, Ja=
nuary 27, 2025 10:10 AM
> > >
> > > We should select PCI_HYPERV here, otherwise it's possible for devices=
 to
> > > not show up as expected, at least not in an orderly manner.
> >
> > The commit message needs more precision:  What does "not show up"
> > mean, and what does "not in an orderly manner" mean?  And "it's possibl=
e"
> > is vague -- can you be more specific about the conditions?  Also, avoid
> > the use of personal pronouns like "we".
> >
> > But the commit message notwithstanding, I don't think this is change
> > that should be made. CONFIG_PCI_HYPERV refers to the VMBus device
> > driver for handling vPCI (a.k.a PCI pass-thru) devices. It's perfectly
> > possible and normal for a VM on Hyper-V to not have any such devices,
> > in which case the driver isn't needed and should not be forced to be
> > included. (See Documentation/virt/hyperv/vpci.rst for more on vPCI
> > devices.)
>=20
> Ya, we ran into an issue where CONFIG_NVME_CORE=3Dy and
> CONFIG_PCI_HYPERV=3Dm caused the passed-through SSDs not to show up (i.e.
> they aren't visible to userspace). I guess it's cause PCI_HYPERV has
> to load in before the nvme stuff for that workload. So, I thought it was
> reasonable to select PCI_HYPERV here to prevent someone else from
> shooting themselves in the foot. Though, I guess it really it on the
> distro guys to get that right.
>=20

Hmmm. By itself, the combination of CONFIG_NVME_CORE=3Dy and
CONFIG_PCI_HYPERV=3Dm should not cause a problem for an NVMe
data disk. If you are seeing a problem with that combo for
NVMe data disks, then maybe something else is going wrong.

However, things are trickier if the NVMe disk is the boot disk with
the OS. In that case, that CONFIG_* combination is still OK, but the
Hyper-V PCI driver module *must* be included in the initramfs
image so that they can be loaded and used when finding and mounting
the root file system. Same thing is true for Hyper-V storvsc when
the boot disk is a SCSI disk -- the storvsc driver and generic SCSI
stack must either be built-in, or the modules included in the initramfs.

The need to have NVME_CORE and the Hyper-V PCI driver available
to mount an NVMe root disk is another case where different distros
have taken different approaches. Some make them built-in to the
kernel image so they don't have to worry about the initramfs, while
other distros make them modules and include them initramfs.

Michael

