Return-Path: <linux-hyperv+bounces-2479-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A8C913EC7
	for <lists+linux-hyperv@lfdr.de>; Mon, 24 Jun 2024 00:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D4311C209B6
	for <lists+linux-hyperv@lfdr.de>; Sun, 23 Jun 2024 22:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D7418508D;
	Sun, 23 Jun 2024 22:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="AzEjf3Bo"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2078.outbound.protection.outlook.com [40.92.20.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B4765C;
	Sun, 23 Jun 2024 22:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.20.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719180329; cv=fail; b=IJKKUDBkz+Ko9+XRMCh+quQ7jTvwuxEjmZ6RNCk7v9dA+r7gpvkcD9aU+kOwyfLQZvwn2SK8mzTcjP6d2Dj+YuUQTIRBx5aM1WDlh+iK5qV8/7IQ6zAuBbgPPk4jOyHd3J9KpAA4Fj+9rq7OwgMGS8RKCPjdbERux/5HgZlD4x8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719180329; c=relaxed/simple;
	bh=TMMN4LFgj9aP9rnpuqGp/1R5pfmdbpkrGenWuYjA/n4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XlmKeuuMRlxjQh6hLJi/+jU/4oUSOOkWMheZ203Ho74XXDlLMP3UAXVFN1A3RDFZ8IMj4n42OE+T8IGlAICcHwpUzHgUluEtDT6QO4fS/wL8nhVzoPDSWpgkDJuOCv/xCCFXh+TqDbzukjK+C3dvc/hRkbil8qCaWNd5jKFsOPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=AzEjf3Bo; arc=fail smtp.client-ip=40.92.20.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h/XW6bTsLhimS7Rr7l2DNJuDuJcmUFuSed9QcUIYaWG4isRKeOYyR0RY6O3xF5UVpL5ww+ahNVrnQVoGPJB8dWMHr8sKPwYNarKkGuv7dyA7i6By7IwAEBnfCIXwrx7gWWrkbjJqy91eVE3Sn/1ZF/YQo6SCwcSzqgqDc5VCew1ADuIBi2hM5ieWe+NAdvjaavVYaZBF+e9YTW7fJiF8Vtl4Z7Aki91qaZPmFFOj0VpyzZ0YLTFUekS/FYIIsbKK7jYfBLJ1IEH9FzBNS38WKSg0aaiy8lhMzqH2vQQAPCuaV/sJkPkuG3WuT3i21de6RT5xmoERJoQueIv8fOXkFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q2nrl7Xrq+DYfGdxwj9pMNi2PIfkOtj4d/FVtmU55UE=;
 b=CkvD3jGaWIKzdpOBjrtgjYWyVTYR/tZ/ARFzXRwaxbRawFm9v/abqtFRBxrr5GXcPtQcI9lzCh+sR0fsqGzoSLJodg6rrH7MyUNE3PFqC6ltuQY4FrdQfgZAkiwOmfNzPr3+o1QMAZ+WvNTkn8CFhFttd363ru3fkAXp5cgJ29tWpxEJ8wy2TUoQXv0TbeZ83/Zn8UJIvb4k05CI9xcscV/qX/uE1SiOyOGdR91BCS/yQ80zBOdNGtbLfJoA0qsTXiCOl9EpyqYpj3FsMdXk2Fdgm0C/fg9nkDT4MHdpoYwwpQDd8Foge+73cKbL83RbYoVThardkbk84xFVEH6wJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q2nrl7Xrq+DYfGdxwj9pMNi2PIfkOtj4d/FVtmU55UE=;
 b=AzEjf3Bo0/WNQLxRe0JkaqU0FNYK0hpuoBDnjJ6ejHydUQi+4NrpZKGschC/ycdUeZ+vw1lLGkU7crlJLtIcbS0AHo1CfAksoO9KFaNxAqMlrf6vtHT8CyC08ipuu+7pqjTU3WuafoxTXZ6zt0LkteKJrpf0RQDw+nE+litDrjo/VTRUBYhDEE74QkzXXX4R/MD8fHGb7SwpdwNhN95LqL63ss+vM5z0GbxElccQcpo2QEB25uHlnbL5OfF9m0xHS4GvNPzmt0GQqitpkIMfdT1uM/VZyQ2IDL1+pwqQ/F0PWh17a+zsA+DdPpBSBGU7S95aTVsvFJbAIkc0TOYPKw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by MW4PR02MB7395.namprd02.prod.outlook.com (2603:10b6:303:65::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.28; Sun, 23 Jun
 2024 22:05:25 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%2]) with mapi id 15.20.7698.025; Sun, 23 Jun 2024
 22:05:19 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Wei Liu <wei.liu@kernel.org>, Linux on Hyper-V List
	<linux-hyperv@vger.kernel.org>
CC: "stable@kernel.org" <stable@kernel.org>, "K. Y. Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Dexuan Cui
	<decui@microsoft.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, Rob Herring
	<robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Jake Oshins
	<jakeo@microsoft.com>, "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT
 DRIVERS" <linux-pci@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] PCI: hv: fix reading of PCI_INTERRUPT_PIN
Thread-Topic: [PATCH v2] PCI: hv: fix reading of PCI_INTERRUPT_PIN
Thread-Index: AQHaxB4UADugxPO6qUmNkOLfUig9oLHV6nUg
Date: Sun, 23 Jun 2024 22:05:19 +0000
Message-ID:
 <SN6PR02MB415732C96E9AECB6B3A75852D4CB2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240621210018.350429-1-wei.liu@kernel.org>
In-Reply-To: <20240621210018.350429-1-wei.liu@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [FvjTu9ytwNb8zdHXM7Bl99PWOy2MO11q]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|MW4PR02MB7395:EE_
x-ms-office365-filtering-correlation-id: b168900e-f86a-4dbe-355d-08dc93d0923b
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199025|3412199022|440099025|102099029;
x-microsoft-antispam-message-info:
 N2YDMUPoApAOMDnplv4LLvKnT+JEg6413VzYNmEkdKNpqY/EnClYDMx/Iyf/aXb++i5NkvczeQX46LLvVgV5yMfRrDlQgpGseNT6BC8vBmK0ARcH88uV+LTwRAIem06ak4FFaHFRrG1LdtzDMET68gBNfjn+GBXs5U5b9bjmo0qyhCHXOYt/a2C1ySPNvfjid+hVoHWOfuP8t8tMPjHxsUsmUaFYQvk3dI/MZds7dRyA9SzzTpqPUx5xMPReDK19nDreAPvjqP5KaD/9Z/Ntj/S0xdYx7eJ07hIjdfHhgT3G8UJb+nOSGkLSa8xkvSGDC7cu19Gpabc3WCN5iMACHyzaHzhAMQvAMx7VADrDc1eQLwb4WVuFn5panwisyuDGibZ8gdP/yKBJpZAv9GQCqQ1sMV5ODo5nF3Bp5x7JyRvtH5vdFQKEHtA5QBYFSaeOqHSd+MRYORr5QNUC2PP2TRx5/CEGTEr6NM3JXgn20PLMgBXf8OL6q7dfA7rZMtgsvlqaIjSg2L91FVTmmRxMNb5WBM+Oqj6tZP64p1gdSUF2TRXQHpAof/exOlQTWOvZ
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?jNQJsrEuT1KUSItKpZX09bE2heJ+FTTHuHBvbe3Ou7nObXD+/lAiSAmELa?=
 =?iso-8859-2?Q?Mrl1nhABbR3/QAgYCxA2jXhfVUQX4a4VAOI4yNzpLofhCu0fQyXTGrJaLZ?=
 =?iso-8859-2?Q?eTWN5L6so2m81/VesUc/SkMLJyrmN0s0U64IltOWHWooveYLbVDvuMBS/c?=
 =?iso-8859-2?Q?ixysV1OPa352PMDfyke3C/WerGJEnYFmg3KtJlU+B8+zSB4WILo9vRGxy/?=
 =?iso-8859-2?Q?k1fhjQ6H2GoK6PMzi5+W1rUDT40qVa3AsaB99+/FKu/TSLM6P5AKXzne8U?=
 =?iso-8859-2?Q?G0QhZe4SYdyujMphW9S94TXfRu/N4o9ysBH/mFDMcTXmR7yIpTxD4QGHTi?=
 =?iso-8859-2?Q?EVg5Hx8GmvE8e/5ASRWREWkMjfJFd4bHrvhkWyLUjpWLk9EKVcdcT2o3XX?=
 =?iso-8859-2?Q?3uV8KK66O9Cgzv1Xui3/tx09Wf+UJ0UyBFPL8FYDEHlCamzixQkKFfZYYR?=
 =?iso-8859-2?Q?PXU6yr5G4DPaXP5edi3o/6zTpPui9mNdbelwBTStK00PB3hKFA+2bddXWA?=
 =?iso-8859-2?Q?B9FMLnmccJ0PlGmF5iAisboqe9Ice1POfTb1UiF0M8ZbWQT59wF/Ea8E3z?=
 =?iso-8859-2?Q?RkOWP6ShvHAPKAFaLmop4U3YV/QuUKYookQrCGaUbywElgGOACLfpvI1N4?=
 =?iso-8859-2?Q?VnkV9JPVo3FcYhaSdwKX8IQiCAmXGbi/OZGsF8WuW05HlhBvjgT1S8GrGs?=
 =?iso-8859-2?Q?iKp92GQ7Tdx8BKGinvNnwna7lA/HKY9fRR+S+wDIWEJvPquN3EOMhHwl9f?=
 =?iso-8859-2?Q?cfmdRvAYFMdFt9L+McEfBdbYqCKGc6073+uLrirsrAjEWni8ulcWCc326n?=
 =?iso-8859-2?Q?HXrJFcv3pfzMGYqZ2i/c6FpBp/k14nBEevzGB8MtcfEHII3g/DQys5qKNB?=
 =?iso-8859-2?Q?sf3z4vZtLR10gaBBHQZs52ndt4SZ0tVerH7Jf28EYb2Ta38PUZfvrzqzpP?=
 =?iso-8859-2?Q?vrwC+H2qtoOLCn50NUS9oGz30+/7+GkVYSr5t6zZLFTmvNmnLQEiu9rc1p?=
 =?iso-8859-2?Q?RXkqYkrpTKkLVM2jKFJSOmPYibeVzBsc3UJt/po+hmnAoRC7K4TKf8bWU7?=
 =?iso-8859-2?Q?J7dLEhqvXreEKCorL/wyMTbFO0L8PW7+/rh7b4G85dzj7shFqOnmGXUI1r?=
 =?iso-8859-2?Q?YbZObo54RukHFuXxwi0Ssn0E7LVhR4DnBEuPGN/rx17MhUE12YwgF4xcxY?=
 =?iso-8859-2?Q?JidgvotHMYOKkoTIT6LiLxPb7vfM+J5ZC4+TCf1PCNDNNKBcMwY6B1RRvq?=
 =?iso-8859-2?Q?K4/8u/9i2iuLboa1IJy1ExbIde8klV8b1TDsCpqNg=3D?=
Content-Type: text/plain; charset="iso-8859-2"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b168900e-f86a-4dbe-355d-08dc93d0923b
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2024 22:05:19.5177
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR02MB7395

From: Wei Liu <wei.liu@kernel.org> Sent: Friday, June 21, 2024 2:00 PM
>=20
> The intent of the code snippet is to always return 0 for both
> PCI_INTERRUPT_LINE and PCI_INTERRUPT_PIN.
>=20
> The check misses PCI_INTERRUPT_PIN. This patch fixes that.
>=20
> This is discovered by this call in VFIO:
>=20
>     pci_read_config_byte(vdev->pdev, PCI_INTERRUPT_PIN, &pin);
>=20
> The old code does not set *val to 0 because it misses the check for
> PCI_INTERRUPT_PIN.
>=20
> Fixes: 4daace0d8ce8 ("PCI: hv: Add paravirtual PCI front-end for Microsof=
t Hyper-V
> VMs")
> Cc: stable@kernel.org
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
> v2:
> * Change the commit subject line and message
> * Change the code according to feedback
> ---
>  drivers/pci/controller/pci-hyperv.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-hyperv.c
> index 5992280e8110..cdd5be16021d 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -1130,8 +1130,8 @@ static void _hv_pcifront_read_config(struct hv_pci_=
dev
> *hpdev, int where,
>  		   PCI_CAPABILITY_LIST) {
>  		/* ROM BARs are unimplemented */
>  		*val =3D 0;
> -	} else if (where >=3D PCI_INTERRUPT_LINE && where + size <=3D
> -		   PCI_INTERRUPT_PIN) {
> +	} else if ((where >=3D PCI_INTERRUPT_LINE && where + size <=3D
> PCI_INTERRUPT_PIN) ||
> +		   (where >=3D PCI_INTERRUPT_PIN && where + size <=3D PCI_MIN_GNT)) {
>  		/*
>  		 * Interrupt Line and Interrupt PIN are hard-wired to zero
>  		 * because this front-end only supports message-signaled
> --
> 2.43.0
>=20

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

