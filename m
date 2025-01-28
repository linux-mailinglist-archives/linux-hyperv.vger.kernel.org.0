Return-Path: <linux-hyperv+bounces-3778-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CCCA2038B
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Jan 2025 05:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A42F3A52ED
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Jan 2025 04:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043F329D0C;
	Tue, 28 Jan 2025 04:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ouNK8Utm"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazolkn19011028.outbound.protection.outlook.com [52.103.13.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DDF7485;
	Tue, 28 Jan 2025 04:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.13.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738039536; cv=fail; b=VofvN/MprcHLJ/vcupUrZ95l5BxElYxao8BDhtRBwVQRlx5Y1zYfMGAZXD8yOaa34XlkneO0ImU/E7Tlvg3nqpcjGny6eUZ59+QMoEwwGJnXj5OIkc7BWpvN4aQpHo5Z22Or+ppWw6a5vSb5HbU+OJXxgO/L9cV2DQQGl3aw9kA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738039536; c=relaxed/simple;
	bh=54A3HYXmUZEiPT5HegT73+dhPYH9uAamTO0fd5v32Gc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HPRP6+aBcLB7qNdlej3ATvQL+qTuNfB1+zjaYdDy3AZdlZcgW/8hbXrFIgN3sKuCZsWF61I5R3PNjnPTEgLdfMUU3FOj+mhCOh/uc2Cq1DG4YH3PSP8cAkTR6Y/7eIwCoED4S8yr9j+DcKiIE0u/N8vybGTaPzzl5xSUHqKgBjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ouNK8Utm; arc=fail smtp.client-ip=52.103.13.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sjyZ7uNVPuRwmRkoiyXEXt7oWX+lMmuGIp33c4aXT8y+cHpRLeacffnKJRdw+l9qITLnGn7HjaNCZC7isvZb19821LHr8/eWjsOV0SUVb+KN3D/dvDf9by6C84cvtNSR9eyQpq7y28SSvTI7Exaa26QRD3jzXuk4UT6EZtCKU5GVPP7zie9+wlW3G7aWG18zm4nLLKWZpj47nPpJoHnBHHNFc5i4fAfiX0fN7JqvT2kJhTOR2eKZ/+FfYV6uDb3f43RW5CZFA7bUlurMB2h4AziUnF4PCrWEGWYBwbZSiVnlMiLLSHDpeDrsvZlm6RkzE3wsiCO9PKliaJJfWOIr7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4FdP1uq9kKP6TyTFA3uTMq5H7X6Ui1znSsB0N5r/lXI=;
 b=BiKyYXHww6Mau1ej7xyel9H9dDVr17fIjNe48l0X8yARvqKCFjXo9ccgdIXFS41fZmU2u7pZ7jddeg1b7WBsQnjzELtxzvvb2ahULp/1lBapuvv1UW82E5rXkNwalehZzrwYL1hBmVQD+OnTm8JGWEFjfsPiDf4GLfzHkddDOpAIJshPLtoT4OkJR+DcNzvehRGHc/RLHOCszNoqSgXOtbAS0N9V2xyAnqPwJRUbXv0q52hQUe5oQ83QwT7Jmucyn+8gSbg3nHaRGafBi7zeJrfHeCnXMpUlYbnTq38Z4F9Ii7jNz3HHKwx5qx25rRP1gplA+4ayAUmRrpsE6ZLS7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4FdP1uq9kKP6TyTFA3uTMq5H7X6Ui1znSsB0N5r/lXI=;
 b=ouNK8Utmw4ZDVVzdvu+JSzJ5+LnCwdqfKn966kz5caZbqrYY1T/ekLOUyhlWXEBc8UkdiFIk0h/NPRdrvbxBhpgzwjMGb2It1XW4UEXXj13G2cyIlfmIhVu+VYeQkjo76xKyaT4KNz/ksGzXDbWG4hPYOVb3nSSqWYQ6NgGsLHEk+zxRFbvUoiTmv4BrNfBv8gX9tgV5Ed7QCXWaWAiyHJqNGAHJeN1mwyqSVJTnBy5h31T/1aEygfJsU9AOw1eDh08V0fhYVc+nOL4cgk9rHndwCk0EZmzBnpB87oeOTWBKmsezGj4O/HtV/R7ylJLzbRbusL2xM6ehGxLwFbE2Dw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SJ0PR02MB8579.namprd02.prod.outlook.com (2603:10b6:a03:3f8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.19; Tue, 28 Jan
 2025 04:45:32 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8377.009; Tue, 28 Jan 2025
 04:45:32 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Wei Liu <wei.liu@kernel.org>, Hamza Mahfooz
	<hamzamahfooz@linux.microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "K. Y. Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Dexuan Cui
	<decui@microsoft.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] drivers/hv: select PCI_HYPERV if PCI is enabled
Thread-Topic: [PATCH] drivers/hv: select PCI_HYPERV if PCI is enabled
Thread-Index: AQHbcOa55nOVe7vfNES2bvVQptEMerMrFbtwgAARUQCAAGwrgIAABW5A
Date: Tue, 28 Jan 2025 04:45:32 +0000
Message-ID:
 <SN6PR02MB4157D37501FAC6288334B62ED4EF2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250127180947.123174-1-hamzamahfooz@linux.microsoft.com>
 <SN6PR02MB4157BAAEB938E7E4E849DC7CD4EC2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <Z5f94J7rzSC-TyIB@hm-sls2> <Z5hYnSW-3iKZxn0T@liuwe-devbox-debian-v2>
In-Reply-To: <Z5hYnSW-3iKZxn0T@liuwe-devbox-debian-v2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SJ0PR02MB8579:EE_
x-ms-office365-filtering-correlation-id: 6ac7d1d8-60da-4413-28dd-08dd3f56992b
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799006|461199028|8062599003|15080799006|19110799003|56899033|102099032|440099028|3412199025|12091999003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?fncBghYM+EQwIlUWm6hKDwLNwL8MhV4qfLjiHZH/xkOh5L9weAwXE28xgBD+?=
 =?us-ascii?Q?04Jn1J+uFIYroSam1I472E9qwX4VaU61Wm3aYeg+i4dVZ/lPloRgpc4+uwJQ?=
 =?us-ascii?Q?VBDwIx+D/RlI+Ql/vMgVqxMwupMQyA5G3Gz7A/HHAeBO2rpacXexpgMj6WV5?=
 =?us-ascii?Q?mjQ5vkbqLtTUeSfUu81WvLZMwgYY4CBb2y5iV8IR9ZaPH1ZvKc4KdW894gns?=
 =?us-ascii?Q?YlEFcTQTq+0Az6U/Jzs+pyZo6N2VJqphvas7f0QoMwsU4be0g8GJwczGeqGC?=
 =?us-ascii?Q?LGCYp9jZyY3UTUNsTFN08Gta5GnwB+H/0DOnJ0Ph60dCetas2bIZCcysWBl8?=
 =?us-ascii?Q?8Q7OaFGiS4RNkYhkXy1rifZiyUc+LyYhbaFQsblPFUg0TXUOEuq4ADP6iX2D?=
 =?us-ascii?Q?CYcHphcQY+9FT9JCxIRUly2dHUsZitCPWwy/+fxxoy68cP5GX1Wiq/pDMseT?=
 =?us-ascii?Q?TWjTh+C2Go7bKxW3zvoJTcIo/Urb2UbQrO0TB59chp57LINU9i/nkssHyWiL?=
 =?us-ascii?Q?YfvrrahdiZ+2FKAyWq4rjgKgj9f3k8tyoMHsc20uJbuIEnriXbZelx0p++yt?=
 =?us-ascii?Q?jyjSSu9m9XSKWpruEOraB4mUWc5j6JJYLi321xKg80NDVtQZgOVVQ5pOT9WO?=
 =?us-ascii?Q?9loElMmAP/JyDjfZJhtr1z7qiMPfQjK5+mo+v+4Z9dT7oEj6eVbrQon1f5Ou?=
 =?us-ascii?Q?ZsEzMAqlDLH3mX7f/f+HnqsrlEubU8jiBYCF+Ob/JUQFt2F6SynWkmnOsEaT?=
 =?us-ascii?Q?zFRmD3C3olxagM+aCf2+t1/Il+UBNzEU7XPXHa/MluzGpFYpqDvETHYbmN1g?=
 =?us-ascii?Q?mRx//WWVaZ2ZPQRHhr03ZvnUmosiErejQPXHxEGh5g0HNeHcrk3u6l+h6vIo?=
 =?us-ascii?Q?oGdpWc4xzsi8IPy2ZfUoi7unB0pFkHExqgyj2TiElU0FUgu4vBT/wrtaFWQ/?=
 =?us-ascii?Q?Nwi6zA1wg53Vyku2El1+ouzVY6P2XFHAqjBazw3C0T/p7WOQIDxfAk09pRMj?=
 =?us-ascii?Q?8Uh81R5q4wybG9Ul6CAus6TWx53GzRDYR2BynjIJE8wOSUUZg9veghPFeuf+?=
 =?us-ascii?Q?6v3m8n33xAVgKCsUsatlCWJO7ctYqw=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?3vG2yjDOzXNk5pSdOsbgIdljOL/A6MqDlSO1DZx3a+wde9g5OrnDAU6mVxpS?=
 =?us-ascii?Q?ulS5nReag07boP/YrIIQ9R2f0XbMHK5pIaUiv58IeQqyo15QR9TJdNNcDyC7?=
 =?us-ascii?Q?SpblnLXL3GA7uKz0ZH4YlmT12SxZrs5rDU2yHLzDHe9PXOyt7bizRfz0k/N+?=
 =?us-ascii?Q?VCxCMxjsRjf/yygUE3kWm8IXWkw2L/7Lcl6cTbtOFRQpRmWnYkU/MUEkHH26?=
 =?us-ascii?Q?73Uduo/Vh1D0eRQCMeSIz7q876yHQoeXzU6Cg1oT543sI7DSyYShbBipyH+h?=
 =?us-ascii?Q?FzsT737WKImXFjyrNesJQ58yZyk+RG/uqnnSLv+FYfNzjYSVFhmJv4rnFZAC?=
 =?us-ascii?Q?06e95LBzcO+VmYdCtXNQtxoYzIRJsX0nVW+W8ss1Omk+OKii5FV9UV6dVaOS?=
 =?us-ascii?Q?hG6VCLLnfzp6jaJ8E/6zkur9o/R8fzTkcRQ8LhtADk5Zw1QcdIR3fc43jKtE?=
 =?us-ascii?Q?56l5WLaHA/UdqBmT3hK5b4+r21gTH9KsVVGfRoss+Fvr0M+2Z74xH67EOvIA?=
 =?us-ascii?Q?ZZGEzQBPPpeATwScuD1ODqvzt6FPZ7iE0yDHCYcDcSiRzjDLAiFFJ3BJ45j6?=
 =?us-ascii?Q?mH4dh+di55FgMHCw2gm8QV50d/FvodUqKyHe5lxx3uJ7dnrkQJI/lCO9Hnnj?=
 =?us-ascii?Q?wg3lODYuK1Ry5DEh7+a4g7dzJhXah/w7kO7cRUJqdOjrrR0oTxC7EqIIDyOe?=
 =?us-ascii?Q?7rPSNqqZbFw3L4lBlzZJ+4SdyLUrao1MnQPvjgnnhn7CAvxxeyXHEWCYzNsq?=
 =?us-ascii?Q?/8kLRH57z5Ig7h9AkAA335oBwN8APps4WLMfoUI8zBWovMQERqpjEeouI6TI?=
 =?us-ascii?Q?Iuui7Cldn4fyJg3RvrJeRsoWt829YEZ0vO25Rt5uzHUaPaSQnB+XId2admV7?=
 =?us-ascii?Q?acss+Y40ikQhAWVhxQca8XFr/l9J3ubJf/s5X5PlpIwpzZ2A2QeZoIZdMFzH?=
 =?us-ascii?Q?gp4E0gC95lBZ+GEqLPmAoogtg/6KQQLrkBzg/xv+jiXfk/LEX1idrDgdirNZ?=
 =?us-ascii?Q?mlFRlObfpJvPYrgq4tUmKqOUxr6AiOkkzzySbtEp9G8q7jHitIVoT+FdeDgo?=
 =?us-ascii?Q?tcr/Og7Z93YhIet9tEqZx1h2FwQcKTKYoRURc1+9sBZvrrH6i774X+kunQ9F?=
 =?us-ascii?Q?cSZCwo3MzdMnyb/mBpz4lgPmRVQnf2obRNB6KYjExnAsc3wnt+KIITfbDTLl?=
 =?us-ascii?Q?dMiNwemol6+yrAqrA5HW1hwxPhs0lRR6D5ZW8GKcvA0qjjCe6fCSM66BDM8?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ac7d1d8-60da-4413-28dd-08dd3f56992b
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2025 04:45:32.5807
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8579

From: Wei Liu <wei.liu@kernel.org> Sent: Monday, January 27, 2025 8:10 PM
>=20
> On Mon, Jan 27, 2025 at 04:42:56PM -0500, Hamza Mahfooz wrote:
> > On Mon, Jan 27, 2025 at 09:02:22PM +0000, Michael Kelley wrote:
> > > From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com> Sent: Monday, =
January 27, 2025 10:10 AM
> > > >
> > > > We should select PCI_HYPERV here, otherwise it's possible for devic=
es to
> > > > not show up as expected, at least not in an orderly manner.
> > >
> > > The commit message needs more precision:  What does "not show up"
> > > mean, and what does "not in an orderly manner" mean?  And "it's possi=
ble"
> > > is vague -- can you be more specific about the conditions?  Also, avo=
id
> > > the use of personal pronouns like "we".
> > >
> > > But the commit message notwithstanding, I don't think this is change
> > > that should be made. CONFIG_PCI_HYPERV refers to the VMBus device
> > > driver for handling vPCI (a.k.a PCI pass-thru) devices. It's perfectl=
y
> > > possible and normal for a VM on Hyper-V to not have any such devices,
> > > in which case the driver isn't needed and should not be forced to be
> > > included. (See Documentation/virt/hyperv/vpci.rst for more on vPCI
> > > devices.)
> >
> > Ya, we ran into an issue where CONFIG_NVME_CORE=3Dy and
> > CONFIG_PCI_HYPERV=3Dm caused the passed-through SSDs not to show up (i.=
e.
> > they aren't visible to userspace). I guess it's cause PCI_HYPERV has
> > to load in before the nvme stuff for that workload. So, I thought it wa=
s
> > reasonable to select PCI_HYPERV here to prevent someone else from
> > shooting themselves in the foot. Though, I guess it really it on the
> > distro guys to get that right.
>=20
> Does inserting the PCI_HYPERV module trigger a (re)scanning of the
> (v)PCI bus? If so, the passed-through NVMe devices should show up just
> fine, I suppose.

vPCI devices are made available to a Hyper-V VM as VMBus offers of
class "vPCI". For such an offer, the Linux device subsystem tries to find
a matching VMBus driver. If the vPCI driver isn't available, the offer just
stays in the VMBus code waiting for a driver.  If the vPCI driver later sho=
ws
up, the Linux device subsystem does the match, and VMBus device
probing proceeds. The hv_pci_probe() function in the vPCI driver is called,
and all the normal steps are taken so that the vPCI device appears and is
functional in the VM. The details of "the normal steps" are in the
documentation in Documentation/virt/hyperv/vpci.rst. See Sections
"Device Presentation" and "PCI Device Setup". A key point is that each
vPCI device is modelled in Linux to be a separate PCI domain with its
own host bridge and root PCI bus.

So the outcome is as you describe and would expect, though the
mechanism is not a scan of the virtual PCI bus.=20

Michael

>=20
> I agree with Michael that we should not select PCI_HYPERV by default. In
> some environments, it is not needed at all.
>=20
> Thanks,
> Wei.

