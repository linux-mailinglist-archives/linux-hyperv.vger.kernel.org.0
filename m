Return-Path: <linux-hyperv+bounces-5971-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51ADEAE1101
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Jun 2025 04:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF36F4A1F07
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Jun 2025 02:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80316137C37;
	Fri, 20 Jun 2025 02:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="frZOFPFD"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02olkn2045.outbound.protection.outlook.com [40.92.44.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E4C3987D;
	Fri, 20 Jun 2025 02:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.44.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750385829; cv=fail; b=ObHMLI5rz688W8RzEilKy+VfiRdJ+tPTsPO98HkSerBg+mev7F/TFJo6TP7OVTrW048CHUQo9eChb0KQSLhpoGTiS/9P0JN0aspf7Q0at7gLUiXR7CGg4SolJ5Iq3U0B0fmP+WE1fCF+nTXkjNdJlrXNQP6pAPUDc70THIKIKkE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750385829; c=relaxed/simple;
	bh=gRSNku5fNTChuXYHYLly/fLffDW0eDTHYD03YRSbeME=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XmsVBbxbgXKcnHd4h2tos8qM72wLqiik7hKzounfZM2v2RA7oUWWl7+uFrt/bQzuLDPRpfF0SytS6wYzAljLtYb9ZnhE68b9YVti+PPSmHJ0NXJsTHJfikMZXo1DUI4FRJXkQjPgheGKbvBIceARa3VcAC7DLQaOG6Z6u0+1+Es=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=frZOFPFD; arc=fail smtp.client-ip=40.92.44.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sdTNmykBle4syDrflo37KHlxn4hoyr1bbhUdL1A66H2ePXik7pEEuhqI37SET6bU7GMVrHx62tLOPa7Zg+y4vrj/gDmASGUtwCuDWjt8hbCYWb2AV8IKuk9RCio55VKUvkOeDhG+2sTZuNS8mkrcR+Jb4bkOYEIIeFKl6+29KqVFhMIaLLeP2J11VviufXzR/eOwy5cDxxQ/02l0zfga4vJhZ2smuQbfn62Jyzd14xcf7N6I/WLpGmDH8g/uVNhmAEpeTWOSm3EKVOou3nMDicBsDnPd5W0C3bp64QwvKw7kHFZo9pJei04r9ZakgQP/HYtRTXPpMbfI0mudD3/GZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PwxSqo3/02vWfiniOUL3q9BOR2aE7zeIdzvKQz6BDig=;
 b=op8nY2C0w9EwhB+kIaci7L1iJnH38Wq1IJIla8mLwEMxJzc+tNntIbFb1hFXna7HmDF3gmYBAF/0SVw8UmNbL3K8Q+yjZ79Bka79tyrMsKjUT3uf6xms3RLKJsUGZmdZJoPVbiLr/wr3kwyKzNiZFI0dAfCbCsu+TlVnFrLNHNMpK0CcLC0Na0J2Bpdm10NdqfaQkDz1BML5C4Gk1laGVJE8jy/3vMjgx6CxZ35ekIuLiXECmdXv9YYKYsSN+vMHYdC9dGvlVWpdVaQ/rv9zm1uKM9l0DYLos2SxaawVYx8gIVkzUsh2sqLbPy0856OwnWGH7LS7RO+tRjQ56J9J4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PwxSqo3/02vWfiniOUL3q9BOR2aE7zeIdzvKQz6BDig=;
 b=frZOFPFDPeG4Vy6yD8f6tMmRXkNyH8C6v1xb8hJpPJCGM+E57Z5I0SyLXT2YhTlqAf8ojv7CR/Jg+O1mDt03/AJorhXAJC3lnbQ9N3WA8+p2sHZrCKfJkZnF6a4FOo63hLpilaNjMmOXRxadGmgrKPu293XBb6HCip/0qQcczckcqCHEltJuvH7SAfP3Shc1NB8ceRmhhMTfslwf9PxVXVLP45NBTxPYBWqhr5fHBFUoKsWDLYt0xIhDYM7ZWM5GyBxuxWsxZZG9e12ygYZhGxMkrCAalZuekvw9pdjnym65j4S7h0UnmJ7Fd9nqWmvkTjbfvRmkkUXaIMlGjF3O1A==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BN0PR02MB8206.namprd02.prod.outlook.com (2603:10b6:408:151::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Fri, 20 Jun
 2025 02:17:04 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8835.027; Fri, 20 Jun 2025
 02:17:04 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Tianyu Lan <ltykernel@gmail.com>, "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "decui@microsoft.com" <decui@microsoft.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "kvijayab@amd.com"
	<kvijayab@amd.com>, "Neeraj.Upadhyay@amd.com" <Neeraj.Upadhyay@amd.com>
CC: Tianyu Lan <tiala@microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [RFC Patch v2 0/4] x86/Hyper-V: Add AMD Secure AVIC for Hyper-V
 platform
Thread-Topic: [RFC Patch v2 0/4] x86/Hyper-V: Add AMD Secure AVIC for Hyper-V
 platform
Thread-Index: AQHb3FOZXzx769qxrkKUE85JMWIMbLQLVoWw
Date: Fri, 20 Jun 2025 02:17:04 +0000
Message-ID:
 <SN6PR02MB41579BCC56F6C966E3E2499CD47CA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250613110829.122371-1-ltykernel@gmail.com>
In-Reply-To: <20250613110829.122371-1-ltykernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BN0PR02MB8206:EE_
x-ms-office365-filtering-correlation-id: bf62d66b-a916-450d-48a3-08ddafa08cae
x-ms-exchange-slblob-mailprops:
 RlF2DIMZ1qWGA1cFVzfxq/3fypSHC+ht87gEiqwpp2GtuhOv400acT0M6zbN45do3/Eks0Bd8uYJOTN5kC8XhemlFvgiknTiw14PuUmhBrvBbaHdOip0i4fv3CrRMWnjCKHNeaf+Fk3jI6HO3F9MsXjwcJKp1U/xaKZVwCtfzqHIoeR5kFUIBuTutZazep1Jg91IRl0JVKscTTzIcBWDakAIFq1v3UBROGgzBLwexAq0WDf+iII5aZMJKmPAT74/lCfRgFl7sx7lI0tpcd/BXoVupJb9XTuA4LNp9qaABHsT3hv1FxQyz3llqZtINB3I8jJiWk6DInzsS0WVtwu+AA4C0L9KtGAYH7ndbPcSqnmES/auCDOPK+QeC+bZsxWMuf65l3+R91Syd3UwqKnahz5zGxBxwhla58XaHIA8hMzRQxFwlKRfJcqgSUL1YzgyT81FwEOaDwPGXswWZhhNu1aDK3ktUH6K20iqmQzeI27I9XoNbjkx4/VPznR1Z0daSnjesHT8WI26Gz31YjC0vM52nukmCyIURjDLxcGPh78BcU2M1ZlA31LZQrcLJA2uSdIOmqZ6CjKB0DFVhGnnilOq7da09PYFJ1wiPGZsArKSvR7fIPCRO68wvbp6l/4j1Q00WHTRmjWxU92dfQ/v1E5uptNX6nM56Zxqo4iVwt3KoLvA+W9ce4J6D/9J96sA1CT0C4OOO3evlCyJki+ApdINzGAAhSeYcctqSy/NiUIE7jdngE9dgwi6RKNquWxkmZzxskkf9xdsZkb7PjGGpjBSOFwh9YHOAljG6iUpfX0RI/FpzdhlqixfiRczeVJibHn5kkAFIOOE+VUAEkY69kHUA3ZwDfrR
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799009|15080799009|461199028|19110799006|8062599006|1602099012|102099032|3412199025|51005399003|4302099013|40105399003|440099028|10035399007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?RszRLJiSAOO4L8Dbw0VYlvKnxCePbDJ82DTBKiCROGqT8gz2hK4LpoKZeoee?=
 =?us-ascii?Q?EzJUdTkRg9Kstqli2eST0VC4y2p0b5CCHSI8Dh3BvByOF7vvEKC6MYjYVbdt?=
 =?us-ascii?Q?zHvNH3W8dhMPIkyu9rkIgHbww4s4O2UMIkApbpArSuTI2WhSEJ5P5XmUuBP6?=
 =?us-ascii?Q?sctiToQ0Ftot6ID5I+ZKBvFPedZggNSkgO6gb2kAiHel8hvsvMSfVwjRUOCR?=
 =?us-ascii?Q?onhTQOPJUyKtjnAFNelMzsC/AtqdR3KQ9TLvmpBbOypcuEm7zxxop64l+R8T?=
 =?us-ascii?Q?0rAQeOqsHogRaws6VKAxhplo6y4kC7Ri3DgZ6ByM58R5ubQI7m4+FzlLcUOC?=
 =?us-ascii?Q?CHw5aSzzepPvr2LcThJ1ge7dkYxa6e8nhRej8rGkgxoGy4P7GlosnOQQfM6n?=
 =?us-ascii?Q?exHz4V7KZM6V9cm9nUCi4YsOAeiCbSCeEOEmIJnrZORDaPLtae3RgGSBdXei?=
 =?us-ascii?Q?/M4yARQam+v38LtZTpFlW/ji64JIwQ0L9bu595mYxOiggd7wkvlefBtNim5r?=
 =?us-ascii?Q?7rKWwOBHbsdknIEZASmpjmmMGE0ZNAB6CWcz3HZ82oC3SjhLPIoDzW9U+iyC?=
 =?us-ascii?Q?HCVSc4VmlS1A82Ly+wLR17ixNXxOF8nOEY2SVfbwbmtD1StzSsRzdfOeQJIF?=
 =?us-ascii?Q?sFm1W78SAsnqfj2DRtyfZLIBKRcxDudErb0rnxd2QhB8y9nSK8tjeGu5CDHA?=
 =?us-ascii?Q?O/fpWi7aoYkZyh9yjpahrYwRZDYhjP6CAFYdJDRbqUQqjLbtvzhZHno9lkeh?=
 =?us-ascii?Q?73mc+oBWiMbe/iTQEcuGGu4XUitoZovLQJUEFFeVeoVYXYk620cPFANYxBVd?=
 =?us-ascii?Q?5TWc3n5ZnDWQFR/SYoP8LMgc7G2i+mwh31e/wUScmI08OzZsK5EQ68JajCpd?=
 =?us-ascii?Q?s6HpwF2FlSHYSge6PGrumx9ooJItcIN36U3keq+czVGN+ZfA6t1MkbQ1On75?=
 =?us-ascii?Q?snwq2J2O7p/Y7haHc65B6T2yWgktgGoJdw+CVShdNtc6qBMkBxS4WHQzr6RG?=
 =?us-ascii?Q?MpwfsWlo8lgVZamSVCLtONq1y5p7NbV7OLDhHYMWECeLpOlVN3MUW3QBo6Zk?=
 =?us-ascii?Q?cN/js114chN6Ak5JnZBYGdihHrbW1K0cT3MwBVz2AGPpjy8SlUOsLtiILaTh?=
 =?us-ascii?Q?l2pGi0f5aozlOhI33LJogCul6bIg6+2h2Qhg32djq/pnGaqrVEA/m1n2YQGP?=
 =?us-ascii?Q?V4Xtn6T695CG42epsmfYtvcAQ1bxJ/KHBhK3cJqcqSrB3AbdipeDjjoyDAd2?=
 =?us-ascii?Q?f01o4XGmw4p1bUVNSxb6?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?l4jTIVreUKwbwjTbR6pep0huK6MtsT7YTZpf8Il1XbmzUnfVuUytyCIo8CP9?=
 =?us-ascii?Q?s1qyr30hW1ztkNeFOqhwVSFD2RFZGJW1erGGkHAnyqpuZeHNKVMioBY7/03L?=
 =?us-ascii?Q?4vsaFek3VHP3xpTN/FzMuhE2JQc2ZkAh5az7dcoGlpTR1kIgFMr8dsmaMdT4?=
 =?us-ascii?Q?iSBoa2i3MSPadCIvzfCc7ALHLAkFcpLqjUyl57rn4dzbE7moXdTqPb9v4FkL?=
 =?us-ascii?Q?tJHdzh4b7VycAm21Wk9A1st5e+HzB3SuM987YmhBI5pPeTCVjh+CsyEunUfg?=
 =?us-ascii?Q?kyQsBovR7PrSazab2/lMjCsX+NGX9IiSYk6AB0FJREFHxgxfAI/l2kmNRKlO?=
 =?us-ascii?Q?rOVWi6Y02TnhmscREhMg/6U1vAGj9sOkYO+82xmm2qilM4qxDY8iBYAkWSiX?=
 =?us-ascii?Q?s1+wZSAuTUBdYcVowRgoTC4L7xBrPVDOufZ+EZVHNIt22b1qGzSMrV2XYUp6?=
 =?us-ascii?Q?qc2nntOMl0UPz+bnAhMDZ3K7Ab8iI6GnRnez8pCwVzZLSR8kvGqD8HQORlpU?=
 =?us-ascii?Q?ekX8NFFXdsa4yiqZoVcMscIEXIsWY6qSFhD3+bPeEOtMjcV0Lf1HUInSkNR2?=
 =?us-ascii?Q?wdQi8bl3m7enObn5YK7HKjuzmd7B3wv8fszoF+be5CjwM17F/VqCD+bYoiOr?=
 =?us-ascii?Q?CQEniT54Ub2TYUfbrqdhRkOcCoBXy7vrnvXQrwMV748ZdBlrNMqdtDp1vrHY?=
 =?us-ascii?Q?7Z2pLAX9Mei25lb/7zcYt6PeDpdk7mZO4XkfSA7DJcqfu8HYYFoGn8rwLe7O?=
 =?us-ascii?Q?fM8kRNxhtvMPbw48KFoP7ZRcAw7bP4+e2ZQXqXnP7CF0GNQITRAyFU+pWB9q?=
 =?us-ascii?Q?0qPSTKIlPvreZZK+Ll0n0JcoIOC6KN8ZpXUSUmbI8ecahSrXDF8vmbJagUp7?=
 =?us-ascii?Q?3+7mK4/SrUlqVhF/roFJ4NHhTIQY8hLYAwOdlR2kFQU2rLJy5GBugNeUXNe4?=
 =?us-ascii?Q?fu6ml9ZT7cRo07MiKFTvQiADKGeztcVWsVfpXDPBU7Q+w/6kH3Wh8FDe+hp4?=
 =?us-ascii?Q?lAnKwsQay39kRibhl3TesE82jnTu+X36ik+4V2VBUBTPsIXPTcX6qYlsbBbA?=
 =?us-ascii?Q?cvNz6fenrVPW1DLAeuWc8g8wNoxPTAmST4feNd1WQ+E9SEyePO2P/X9VuDND?=
 =?us-ascii?Q?qs1JCq4nLENmnBmghOQUwg+NIkftGAE2TwKPdZJAG0RMmgQcZfREIaymK7VJ?=
 =?us-ascii?Q?oRrB3M3uJzfQoNb1BOX7SDaxbcQGkDxNHQddFM/EGK9t/Ncl8W074eC70OU?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bf62d66b-a916-450d-48a3-08ddafa08cae
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2025 02:17:04.6017
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8206

From: Tianyu Lan <ltykernel@gmail.com> Sent: Friday, June 13, 2025 4:08 AM
>=20
> Secure AVIC is a new hardware feature in the AMD64
> architecture to allow SEV-SNP guests to prevent the
> hypervisor from generating unexpected interrupts to
> a vCPU or otherwise violate architectural assumptions
> around APIC behavior.
>=20
> Each vCPU has a guest-allocated APIC backing page of
> size 4K, which maintains APIC state for that vCPU.
> APIC backing page's ALLOWED_IRR field indicates the
> interrupt vectors which the guest allows the hypervisor
> to send.
>=20
> This patchset is to enable the feature for Hyper-V
> platform. Patch "Expose x2apic_savic_update_vector()"
> is to expose new fucntion and device driver and arch
> code may update AVIC backing page ALLOWED_IRR field to
> allow Hyper-V inject associated vector.

The last sentence above seems to be leftover from v1 of the
patch set and is no longer accurate. Please update.

Additional observation:  These patches depend on=20
CC_ATTR_SNP_SECURE_AVIC, which is not set when operating
in VTOM mode (i.e., a paravisor is present). So evidently Linux
on Hyper-V must handle the Secure AVIC only when Linux is=20
running as the paravisor in VTL2 (CONFIG_HYPERV_VTL_MODE=3Dy),
or when running as an SEV-SNP guest with no paravisor. Is
that correct?

>=20
> This patchset is based on the AMD patchset "AMD: Add
> Secure AVIC Guest Support" https://lkml.org/lkml/2025/6/10/1579
>=20
> Change since v1:
>        - Remove the check of Secure AVIC when set APIC backing page
>        - Use apic_update_vector() instead of exposing new interface
>        from Secure AVIC driver to update APIC backing page and allow
>        associated interrupt to be injected by hypervisor.
>=20
> Tianyu Lan (4):
>   x86/Hyper-V: Not use hv apic driver when Secure AVIC is available
>   drivers/hv: Allow vmbus message synic interrupt injected from Hyper-V
>   x86/Hyper-V: Not use auto-eoi when Secure AVIC is available
>   x86/Hyper-V: Allow Hyper-V to inject Hyper-V vectors
>=20
>  arch/x86/hyperv/hv_apic.c      | 3 +++
>  arch/x86/hyperv/hv_init.c      | 4 ++++
>  arch/x86/kernel/cpu/mshyperv.c | 2 ++
>  drivers/hv/hv.c                | 2 ++
>  4 files changed, 11 insertions(+)
>=20
> --
> 2.25.1


