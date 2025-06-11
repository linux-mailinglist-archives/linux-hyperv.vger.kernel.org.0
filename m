Return-Path: <linux-hyperv+bounces-5879-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A85FAD6399
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Jun 2025 01:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 109A07A71AC
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Jun 2025 23:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C46246BB9;
	Wed, 11 Jun 2025 23:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="gXrB+rKs"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazolkn19010013.outbound.protection.outlook.com [52.103.20.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E590185B61;
	Wed, 11 Jun 2025 23:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749683190; cv=fail; b=j/3YYdFLKwDmJK8nq0Ds1GBw4UNnqSTt8Pd4BCX91kJe8blmxCANNa1VnfeUyenWLdu0p98sMzqB1WFq9QSTiKvombh0+xpdE+j5QLA/s6DclPTK9tOIgXB27Mlm1djjcUIARZi5cxzRnw8DZufmltDCvv3PH+A9+AzH/1+zMTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749683190; c=relaxed/simple;
	bh=eXxAMpu63RKObhhAsda9lGKys48XGJ5eIBi87bTS2ZY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ovcku8clvbgCQN1yfQxBWEsmadVfZhh3+HvU+P0QYCc4s/5SiiDbT69fpN3OID7dB4hAguBu9zZ2rN951DYur5l60Ri4FNCaBwtrVOWl3H2ThFHfKhAwQRk0DKJ8ctdMYSgvqj0V5ZIxNkVK9OoIgmP0U3pFNUk+Ythn1phv31I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=gXrB+rKs; arc=fail smtp.client-ip=52.103.20.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oz7qQ+Dc5+sWZ/GRNYrateKWsIP6cv/qBOKVrLMWSoC/PVDMc0GlWBB5029TPpWHkDM0mg+oStlWWiPW3AlOR3IUO8zVeTOxSXXnabhQFb0m0WJUkD3WswI/zkvEiPjV1XsNXir6WCp6qCJ1g0J0e8fMzTk1vQ3GldyFPxs4SWwPzS57u7CdJM98rCpYAMZfk0gHaczMtMPqaiO3B1nbyAlvtuW9XVKgHRZrS3pvBlCvYNGJWB5zSElPqgmH7Jq2Xl0EVTLRRVx02Kmj71Z1lHrMOyAgSJxV69VwjZRt/CO5UhnYCaYXVoRkKg9CVezejZu5j/g4OAriTbjgOM8RKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0QHtX1cddaqH3j/8skVF2/ggDdvjPFWaFsy8Q+t/4e4=;
 b=ZSLr1hYWlFl9p8kQfW7qjnVHCAOa8hJsVDSz4JnEDSHgQ5AfFguV1hivzC68yglqAi2q+ftQympiuxEf+NmwaeBaDv8ZcbZjoO+c35QWtpXGuCRdx0gCxcw0eczkRJE4yZYmYisQ9il7RNMFgVrDUV++cSJO6GWyeB7HlcQXEoXYTS8zXioFQQfOqGClODlVincavKo2t6hTBApQ6cCjce5RDdZPPhjSljMHuhJp854Zwr+kYl4UTNxnFLnR7GE7ZlVVrkgRC44m2x7p1Qe0jRZqk4xucOaq8gQdMV0oIJgo1bG1TCCFyfqrpoDTjybIufvtdO0UJxAzXTP9kZKbMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0QHtX1cddaqH3j/8skVF2/ggDdvjPFWaFsy8Q+t/4e4=;
 b=gXrB+rKsVTCSpHWoNhzJu44I+eTmw4Ql8Hk+rpa3HB1d2ltZ1j3Le0o7k8zkadIt+ATYCKqRWtH/Rjw9xoJehsIa8f3d7kuv/28OJDvMXSFODwGMVouB0c4VHhGSdEhGCZpcfMeCDZ+NTOeaTn2yTdASyBihkezTbqA5HYp6FPR7g8sxPhCuuXx3R/0D0/iw1RiwAoeG3Lc4fKFPNTCB88jDHoxysCgfkSxTeGTN0b7IyFv6zotv0yCxgPi89vrUQrUeSXdfWTpRRKAsQ1POSlyFn5ZlmfTmi5M85DNvy92qx8pllVNoyJUTEIKJWGewi5te8H7u6nraOgpaNZ/NDw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH0PR02MB8488.namprd02.prod.outlook.com (2603:10b6:510:105::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.20; Wed, 11 Jun
 2025 23:06:24 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8835.018; Wed, 11 Jun 2025
 23:06:24 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>, "manivannan.sadhasivam@linaro.org"
	<manivannan.sadhasivam@linaro.org>, "robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "jinankjain@linux.microsoft.com"
	<jinankjain@linux.microsoft.com>, "skinsburskii@linux.microsoft.com"
	<skinsburskii@linux.microsoft.com>, "mrathor@linux.microsoft.com"
	<mrathor@linux.microsoft.com>, "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH 1/4] PCI: hv: Do not do vmbus initialization on baremetal
Thread-Topic: [PATCH 1/4] PCI: hv: Do not do vmbus initialization on baremetal
Thread-Index: AQHb2mKwkhWK8nhiHEutwLk7bVwxgLP9adOw
Date: Wed, 11 Jun 2025 23:06:23 +0000
Message-ID:
 <SN6PR02MB41574163515870DB8E430C56D475A@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1749599526-19963-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1749599526-19963-2-git-send-email-nunodasneves@linux.microsoft.com>
In-Reply-To:
 <1749599526-19963-2-git-send-email-nunodasneves@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH0PR02MB8488:EE_
x-ms-office365-filtering-correlation-id: ac4aec50-39d9-4f48-f1fc-08dda93c9647
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799006|461199028|41001999006|8060799009|15080799009|8062599006|3412199025|440099028|52005399003|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Wucyl29bX7aANrNgMMz47a6mvey6mO2tVjiJjl+ggBbvybK6Ktbu+RdId1vK?=
 =?us-ascii?Q?FJ1w3Ew2oKHGpS798uJc4TGJxTOV48Tunj9r+hENrBU4aJHtmpoIYYS/Z9ph?=
 =?us-ascii?Q?XgInTkVTkCk8b3W5px5xwonMHwjuX7fV7ecss346DGLqbZ14Kwp2jkUfkfCW?=
 =?us-ascii?Q?ZAurX18K2YzEttsuDsHuytsYCoIadamESovssg8Z4kCNGdV80ls707gD1sWH?=
 =?us-ascii?Q?wTkhaBk7r8vBNZzlEMNJKu7ecyivPKdGqTfU9fthgo4xIYJao/flE8k0hsBb?=
 =?us-ascii?Q?JR1+ihcn120qk256EXq0/4XDBxtOj/XWX6zbc2GUfgvAFEZWzQm1/I7dqBEa?=
 =?us-ascii?Q?ERRZlUk9dh1lZZ9y9Fz9LXH/ZmKgWzh5Of7IrvUuGsrr6i/Ul+kOY8oRRnYE?=
 =?us-ascii?Q?EMruZRgP25Jip8MZjv5WM/BvLy8dGRf5NVEifmD4RMhqx7vKvQkRiVFWAPGe?=
 =?us-ascii?Q?InJXKn/zAvAwDRWvOZpsrUxYCEtWfjCLAaz5ZXZhKKEWiRgdNukaECH/DKQp?=
 =?us-ascii?Q?W/0UFIaJpWr1UsQdflZ+/OFoIPkKye1Y5XSRpA6GMpN8zFo20sy1bpFS4GuC?=
 =?us-ascii?Q?2YKOUExRDpLbey5DwDMAZu/4THOII3AzJVp0c1ijO3+aa7+rcOUwID+IARmg?=
 =?us-ascii?Q?hZoLsZNCy6J/Jn5vRQoJYCQZK54OnCVR3uo/gegZ/P+5rYSNTcVqtjFBpIQq?=
 =?us-ascii?Q?u2hgEKgKkmuWJ1RiA3SqZ5zcffb4Z+9MH0nWUcx4pGfwm+5lfSiPTVlRs01i?=
 =?us-ascii?Q?H4bte/1mmyqSLY0cRtuWVBViPyrcDMha/mjkX68DSb5WMJB13DWidvgaiHvT?=
 =?us-ascii?Q?coP6hWx7LqiHcSVooi4fEwaM5K2e+IaWp8bX6Q+nVUx9bLZNwlxEURx0A3Bm?=
 =?us-ascii?Q?LRuJxtOoiLFfd8zh8pJhc2Ss5KD8+E9yWO7hpv++cxYFXqQG3HZJ74WcYfXq?=
 =?us-ascii?Q?MUUt3wXRxkjCRd0t7ge/fRaFpo/ECpYGQXoWAyarrsbRoPO+j8Fg3F05pP1j?=
 =?us-ascii?Q?utcJrAfqjaotpP+J8lzhsLPDCJXdJthZp7dazjshJkmQAugti6loyj4f7jlF?=
 =?us-ascii?Q?fVnpD4YPJ54ZV88169bjNpgSydR9E44irlzwiHX2Kp/ZbNksvtddoTBtecOO?=
 =?us-ascii?Q?lPKOIl10Wp5oyHt1LgI+cs7vLUx78SiKbg=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?tfjsxlNIurCJO+0F9M/OufRkv9J1WQ0tay7vpKKVEJK7j1fbJqHU8672cmHX?=
 =?us-ascii?Q?i8amx8VPAxU3VfxacV6j9uGEAFArr8exF5V81OWiUt5E1HiZ39b6SKUH6mFr?=
 =?us-ascii?Q?1BJzXz6ckhNPpR7GKg/Evzcqspb2XXFi50sWFzVXEJFixOWt6fQvK5VjH/so?=
 =?us-ascii?Q?1RVUF+Nb2r3Q0gA9bqmEv00eF4HEiwfStF5ZLIdniWNM1VmkGdwvk5+pvvZ+?=
 =?us-ascii?Q?vOXtNCND0QM2EYPV+Ha4+NEJGQGK0bpeGRP/t4OT6It83MLhG3ESJ7tVLMIr?=
 =?us-ascii?Q?iblXT/pQuueSIFSW5BDsu4GczeBEWo3eGNzlV2ccuP0uVsJkHZYxU1l4NrJs?=
 =?us-ascii?Q?4lyHnrUqFzc7l3W5Wa3ssNgpfxoI9uc0CnbNd8rHUJwm35gj0G438r0NNRWI?=
 =?us-ascii?Q?ccZEyuRExN7NXGroTB6Yvo6m5c+b1XMrhROHXhhMXoreuoF+3quK9Z8s542/?=
 =?us-ascii?Q?d3mZ0OurAZn8nwcoG4Zzm2OdeJUKGx5niHpXUb8l9L0ZN2J9biZg0BOr75in?=
 =?us-ascii?Q?enJRNsljJYSI5aFbNqiMkulwrM9Pwl/w7frlb7YclgYQWRmFx4EwkpjS8MnA?=
 =?us-ascii?Q?kOTdEkdQ5iKPQQzZ+ZYgjePwEnnQ+jXpyZRsmJ3+dGpE8oCOnVpFzj18Rc9z?=
 =?us-ascii?Q?GbmktvOvLYFv5ZbTKjVYYsnXeAOJ7R1BML2yZ/qk3rzcZwZO+UitGM1KTPT9?=
 =?us-ascii?Q?ZwUqIWp+KF51YKGyXJtINiwqvlOaPBbFp2CJGRK9DjUZ/6i2/7jLt4n5vx1P?=
 =?us-ascii?Q?Os+1liv87LgUoPcG39TLSlqBOrwMWaxRbEl+um3Y763AxTLI94d0W7ZTlT5V?=
 =?us-ascii?Q?hP0pokvjGE2JQnrz8FvpGJw96/gyhPqul0x32nKO9nSAHEnkgxaIAAeu5HvR?=
 =?us-ascii?Q?M66RC5veCX53W7nsDIdF7gGqtWxyfk9wk4hpMQr0rFeQWqoMD0mjeel5V8Ui?=
 =?us-ascii?Q?9LmVV8p2TcGAZUJ687Sz57kMD+G21SOWi1/SF99aFXgBLzWU2KZCtkqu97Qa?=
 =?us-ascii?Q?P+T1u+Ug71uti9QS+pr+UKyj7pKbR2A1gd4ZJXLGErO3rsPZKacZMFKCnkUL?=
 =?us-ascii?Q?2uJwjI8R55+2m484SWHnrDAwpAU4DdUHtQ0EfyyS08/bPQIft2Std0aOR1g+?=
 =?us-ascii?Q?20TiRri3iEp5osGT3cXMj4jTKdzqULdY7I4mrgEhIoi2CxOH7n41IBmQmS8D?=
 =?us-ascii?Q?KKrEodb0Q43vU9wYxPBgIIhdAAFWXqphXNf1BrOQrWTiUZbymJ7XkWk+UwE?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ac4aec50-39d9-4f48-f1fc-08dda93c9647
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2025 23:06:24.0533
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8488

From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Tuesday, June=
 10, 2025 4:52 PM
>=20
> From: Mukesh Rathor <mrathor@linux.microsoft.com>

The patch Subject line is confusing to me. Perhaps this better captures
the intent:

 "PCI: hv: Don't load the driver for the root partition on a bare-metal hyp=
ervisor"

>=20
> init_hv_pci_drv() is not relevant for root partition on baremetal as ther=
e
> is no vmbus. On nested (with a Windows L1 root), vmbus is present.

This needs more precision. init_hv_pci_drv() isn't what is
"not relevant". It's the entire driver that doesn't need to be loaded
because the root partition on a bare-metal hypervisor doesn't use
VMBus. It's only when the root partition is running on a nested
hypervisor that it uses VMBus, and hence may need the Hyper-V
PCI driver to be loaded.

>=20
> Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
>  drivers/pci/controller/pci-hyperv.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-hyperv.c
> index b4f29ee75848..4d25754dfe2f 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -4150,6 +4150,9 @@ static int __init init_hv_pci_drv(void)
>  	if (!hv_is_hyperv_initialized())
>  		return -ENODEV;
>=20
> +	if (hv_root_partition() && !hv_nested)
> +		return -ENODEV;
> +
>  	ret =3D hv_pci_irqchip_init();
>  	if (ret)
>  		return ret;
> --
> 2.34.1


